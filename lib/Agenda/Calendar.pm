package Agenda::Calendar;
use DateTime;
use DateTime::Format::Epoch::MJD;
use Agenda::Day;
use strict;
use constant VERBOSE => 0;

=head1 NAME

Agenda::Calendar - class to represent an array of Agenda::Day objects.
Toby Thurston -- 28 Nov 2011 

=head1 SYNOPSIS

 use Agenda::Calendar;

 # constructors 

 $mjd = 52345; 
 $cal = Agenda::Calendar->new(config => $cfg, first_mjd => $mjd , last_mjd => $mjd+$days);
 $cal = Agenda::Calendar->new(config => $cfg, first_mjd => $mjd , duration => $days);

 $dt = DateTime->whenever;
 $cal = Agenda::Calendar->new(config => $cfg, first_dt => $dt , last_dt => $dt->clone->add(days => $days) );
 $cal = Agenda::Calendar->new(config => $cfg, first_dt => $dt , duration => $days);

 #######################
 # object data methods #
 #######################

 $day = $cal->first_day;
 $day = $cal->last_day;
 $number_of_days = $cal->duration;

 @days = $cal->slice(start => $offset, duration => $length);

 $cal->set_config($cfg);
 $cal->read_events;
 $cal->add_moon_quarters;
 $cal->add_sun_moon_rise_events;


=head1 DESCRIPTION

Agenda::Calendar provides an object to represent a collection of Agenda::Day objects

One feature of note is the list of `marks'.  These identify on going periods,
such as term-time, or Lent.  We need to keep a separate record of them as they
apply to days that might otherwise have no events, and they need to be propagated
to slices of a calendar.

marks
    n style_code periods
        on/off
        on/off



=cut

use Carp;

sub new {
    my $that  = shift;
    my $class = ref($that) || $that;
    my $self  = {
        config    => undef ,
        first_mjd => undef ,  # MJD
        last_mjd  => undef ,  # MJD
        first_dt  => undef ,
        last_dt   => undef ,
        duration  => undef ,  # days
        day_list  => undef ,
        mark_list => undef ,
        emit_events => 0,
        @_
    };
    bless $self, $class;

    if ( defined $self->{first_mjd} && ( defined $self->{last_mjd} xor defined $self->{duration} ) ) {
        $self->_init_mjd()
    }
    elsif ( defined $self->{first_dt} && ( defined $self->{last_dt} xor defined $self->{duration} )) {
        $self->_init_dt()
    }
    else {
        croak 'Bad call to Agenda::Calendar constructor';
    }
    return $self;
}

sub _init_mjd {
    my $self = shift;

    if ( defined $self->{last_mjd} ) { $self->{duration} = 1 + $self->{last_mjd} - $self->{first_mjd} }
    if ( defined $self->{duration} ) { $self->{last_mjd} = $self->{first_mjd} + $self->{duration} - 1 }

    $self->{first_dt} = DateTime::Format::Epoch::MJD->parse_datetime($self->{first_mjd});
    $self->{last_dt}  = DateTime::Format::Epoch::MJD->parse_datetime($self->{last_mjd});

    for (my $i=0; $i<$self->{duration}; ++$i) {
        $self->{day_list}->[$i] = Agenda::Day->new(mjd => $self->{first_mjd}+$i)
    }
}

sub _init_dt {
    my $self = shift;

    if ( defined $self->{last_dt} ) { $self->{duration} = $self->{last_dt}->delta_days($self->{first_dt})->delta_days }
    if ( defined $self->{duration} ) { $self->{last_dt} = $self->{first_dt}->clone->add(days => $self->{duration}) }

    $self->{first_mjd} = DateTime::Format::Epoch::MJD->format_datetime($self->{first_dt});
    $self->{last_mjd}  = DateTime::Format::Epoch::MJD->format_datetime($self->{last_dt});

    for (my $i=0; $i<$self->{duration}; ++$i) {
        $self->{day_list}->[$i] = Agenda::Day->new(dt => $self->{first_dt}->clone->add(days=>$i))
    }
}

sub slice {
    my $parent = shift;
    my %args = @_;
    my $new_slice;
    my $day_offset = $args{offset};
    if ( defined $args{month_offset} ) {
        my $dt = DateTime::Format::Epoch::MJD->parse_datetime($parent->{first_mjd})->add(months=>$args{month_offset});
        my $first_mjd = DateTime->new( day=>1,       month=> $dt->month, year => $dt->year )->mjd;
        my $last_mjd  = DateTime->last_day_of_month( month=> $dt->month, year => $dt->year )->mjd;
        $new_slice = $parent->new(config    => $parent->{config},
                                  first_mjd => $first_mjd, 
                                  last_mjd  => $last_mjd);
        $day_offset = $new_slice->{first_mjd} - $parent->{first_mjd};
    }
    else {
        $new_slice = $parent->new(config    => $parent->{config},
                                  first_mjd => $parent->{first_mjd}+$day_offset,
                                  duration  => $args{duration})
    }

    for (my $i=0; $i<$new_slice->{duration}; ++$i) {
        $new_slice->{day_list}->[$i] = $parent->{day_list}->[$i+$day_offset];
    }

  return $new_slice;
}

sub day {
    my $self = shift;
    my $i = shift;
    croak "Please give an integer argument to day()" unless defined $i && $i=~/^[-+]?\d+$/;
    croak "Day index is off the end of the list" unless abs($i) < $self->{duration};
    return $self->{day_list}->[$i];
}

sub first_day {
    my $self = shift;
    return $self->{day_list}->[0];
}

sub last_day {
    my $self = shift;
    return $self->{day_list}->[-1];
}

sub day_list {
    my $self = shift;
    return $self->{day_list};
}

sub duration {
    my $self = shift;
    return $self->{duration};
}

sub mark_list {
    my $self = shift;
    return $self->{mark_list};
}

# read all the events and store them in each relevant day
use File::Basename;
use File::Spec;
sub read_events {
    my $self = shift;
    my @event_files = @_;

    my $cfg = $self->{config};

    my @hol_tags = split ' ', $cfg->non_working_tags  ;
    my @day_tags = split ' ', $cfg->all_day_tags      ;

    # get extra files from the config
    my $config_file_count = $cfg->{event_files}; # must be a number 0-9
    for (1..$config_file_count) {
        push @event_files, $cfg->{"event_file_$_"} if defined $cfg->{"event_file_$_"};
    }

    # now (try to) read each file
    my @good_event_lines = ();
    for my $file (@event_files) {
        next unless defined $file;
        warn 'Agenda::Calendar>> Reading ' . $file . "\n" if VERBOSE;
        open my $event_file_handle, '<', $file or die "Failed to open $file: $!\n";
        while (<$event_file_handle>) {
            chomp;
            next unless my ($y, $m, $d, $text) = $_ =~ m{
                \A
                (20\d\d)\D?(0[1-9]|1[012])\D?([012]\d|3[01])
                \s+
                (\S.*)
                \Z
            }xmsio;

            my $dt = DateTime->new(year => $y, month => $m, day => $d);
            warn "Agenda::Calendar>> Split: $dt |$text|\n" if VERBOSE;

            push @good_event_lines, sprintf "%s %s", $dt->mjd, $text;
        }
        close $event_file_handle;

    }

    my $marks = $cfg->marks;
    my @marks = ();
    for (1..$marks) {
        next unless $cfg->{"mark_$_"} =~ /^(\S+)\s(\S+)\s(text|tag)\/(.*?)\/(.*)\/$/;
        my ($start,$stop,$remove_tag);

        if ( $3 eq 'tag') {
            $start = qr/^$4:/;
            $stop  = qr/^$5:/;
            $remove_tag = 1;
        } else {
            $start = qr/$4/;
            $stop  = qr/$5/;
            $remove_tag = 0;
        }
        push @marks, { colour => $1, style => $2, detag => $remove_tag,
                       start => $start, stop => $stop, periods => undef };
    }

    for my $e (sort @good_event_lines) {
        my ($mjd, $text) = split ' ', $e, 2;
        for my $m (@marks) {
            if ( $text =~ $m->{start} ) {
                push @{$m->{periods}}, { state=>'on',  mjd=>$mjd+1 };
                if ( $m->{detag} ) { $text =~ s/^[^:]+://; $e = "$mjd $text" }
            }
            elsif ( $text =~ $m->{stop} ) {
                push @{$m->{periods}}, { state=>'off',  mjd=>$mjd };
                if ( $m->{detag} ) { $text =~ s/^[^:]+://; $e = "$mjd $text" }
            }
        }
    }

    my $m_counter = 0;
    for my $m (@marks) {
        next unless $m->{periods};
        $m_counter++;

        # initial off implies ON at start of calendar
        if ( $m->{periods}->[0]->{state} eq 'off' ) {
            unshift @{$m->{periods}}, { state=>'on', mjd=>$self->{first_mjd} };
        }

        # close any open mark at end of calendar
        if ( $m->{periods}->[-1]->{state} eq 'on' ) {
            push @{$m->{periods}}, { state=>'off', mjd=>$self->{last_mjd} };
        }

        # generate the mark events
        while ( @{$m->{periods}} ) {
            my ($p,$q) = splice(@{$m->{periods}},0,2);

            unless ( $p->{state} eq 'on' && $q->{state} eq 'off' ) {
                warn "%s %s mark has two 'on' markers in a row at %s\n",
                     $m->{colour}, $m->{style}, DateTime::Format::Epoch::MJD->parse_date($q->{mjd})->ymd
                     if $q->{state} eq 'on';
                warn "%s %s mark has two 'off' markers in a row at %s\n",
                     $m->{colour}, $m->{style}, DateTime::Format::Epoch::MJD->parse_date($p->{mjd})->ymd
                     if $p->{state} eq 'off';
                next;
            }

            for my $mjd ($p->{mjd} .. $q->{mjd}) {
                push @good_event_lines, "$mjd !Mark$m_counter: $m->{colour} $m->{style}";
            }
        }

    }

    my %had = ();
    my $hhmm = '(2[0123]|[01]?[0-9]):?([0-5][0-9])';
    for (sort @good_event_lines) {

        next if $had{uc($_)}++;

        warn 'Agenda::Calendar>> Good: ' . $_ . "\n" if VERBOSE;
        my ($mjd, $range, @text) = split;

        next if $mjd < $self->{first_mjd};
        last if $mjd >= $self->{last_mjd};

        warn 'Agenda::Calendar>> In range: ' . $_ . "\n" if VERBOSE;
        my ($s_time, $e_time);
        if ( $range =~ /^$hhmm$/ ) {
            $s_time = $e_time = $1+$2/100;
        } elsif ( $range =~ /^$hhmm-$hhmm$/ ) {
            $s_time = $1+$2/100;
            $e_time = $3+$4/100;
        } else {
            for (@day_tags) {
                if ( $range eq $_ ) {
                    $s_time = $cfg->first_hour;
                    $e_time = $cfg->last_hour;
                    last;
                }
            }
        }

        # if we failed to read a time from $range it must have been text
        unshift @text, $range unless defined $s_time;
        my $text = "@text";

        # find the index of the day in the list
        my $day = $mjd - $self->{first_mjd};

        # and push each remaining event into appropriate day's events hash
        push @{$self->{day_list}->[$day]->event_list}, {
            text  => $text,
            start => $s_time,
            end   => $e_time,
        };

        if ( $self->{emit_events} ) {
            my $out = "d:$day :";
               $out .= "s:$s_time" if $s_time;
               $out .= "e:$e_time" if $e_time;
            warn "$out t:$text\n";
        }

        # mark day as a holiday if text starts with a non-working tag
        for (@hol_tags) {
            $self->{day_list}->[$day]->is_holiday(1) if lc $_ eq lc $text[0];
        }
    }
}

1;

__END__

