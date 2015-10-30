package Agenda::Day;
use strict;

use DateTime;
use DateTime::Format::Epoch::MJD;
use Carp;
use vars qw($AUTOLOAD);  # it's a package global

my %fields = (
    dt             => undef ,
    mjd            => undef ,
    yyyymmdd       => undef ,
    year           => undef ,
    month          => undef ,
    day            => undef ,
    day_of_week    => undef ,
    day_of_year    => undef ,
    days_to_go     => undef ,
    is_weekend     => undef ,
    is_holiday     => undef ,
    is_termtime    => undef ,
    ISO_sorted     => undef ,
    ISO_hyphenated => undef ,
    ISO_day        => undef ,
    ISO_week       => undef ,
    ISO_week_day   => undef ,
    julian         => undef ,
    roman          => undef ,
    UK_tax_month   => undef ,
    UK_tax_week    => undef ,
    sunrise        => undef ,
    sunset         => undef ,
    moon_phase     => undef ,
    moonrise       => undef ,
    moonset        => undef ,
    location       => undef ,
    marker_list    => undef ,
    event_list     => undef
);


sub new {
    my $that  = shift;
    my $class = ref($that) || $that;
    my $self  = {
        _permitted => \%fields,
        %fields,
        @_
    };
    bless $self, $class;
    if ( @_ ) {
        $self->_init()
    } else {
        $self->_init_today();
    }
    return $self;
}

sub _init {
    my $self = shift;

    if ( defined $self->{yyyymmdd} ) {

        my ($y, $m, $d) = $self->{yyyymmdd} =~ m{\A(\d\d\d\d)(\d\d)(\d\d)\Z};
        $self->{dt} = DateTime->new(year => $y, month => $m, day => $d);
        $self->{mjd}   = $self->{dt}->mjd;
        $self->{year}  = $self->{dt}->year; 
        $self->{month} = $self->{dt}->month; 
        $self->{day}   = $self->{dt}->day; 

    } 
    elsif ( defined $self->{year} && defined $self->{month} && defined $self->{day} ) {

        $self->{dt} = DateTime->new(year => $self->{year}, month => $self->{month}, day => $self->{day});
        $self->{mjd} = $self->{dt}->mjd;
        $self->{yyyymmdd} = $self->{dt}->ymd;
    }
    elsif ( defined $self->{mjd} ) {

        $self->{dt} = DateTime::Format::Epoch::MJD->parse_datetime($self->{mjd});
        $self->{year}  = $self->{dt}->year; 
        $self->{month} = $self->{dt}->month; 
        $self->{day}   = $self->{dt}->day; 
        $self->{yyyymmdd} = $self->{dt}->ymd;

    } 
    elsif ( defined $self->{dt} ) {
        $self->{year}  = $self->{dt}->year; 
        $self->{month} = $self->{dt}->month; 
        $self->{day}   = $self->{dt}->day; 
        $self->{yyyymmdd} = $self->{dt}->ymd;
        $self->{mjd}   = $self->{dt}->mjd;
    }
    else {
        croak 'Bad call to Agenda::Date constructor';
    }

    $self->{event_list} = [];

}

sub _init_today {
    my $self = shift;

    $self->{dt} = DateTime->today;
    $self->{year}  = $self->{dt}->year; 
    $self->{month} = $self->{dt}->month; 
    $self->{day}   = $self->{dt}->day; 
    $self->{yyyymmdd} = $self->{dt}->ymd;
    $self->{mjd}   = $self->{dt}->mjd;
    $self->{event_list} = [];
}

sub AUTOLOAD {
    my $self = shift;
    my $type = ref($self)
                or croak '$self is not an object';

    my $name = $AUTOLOAD;
    $name =~ s/.*://;   # strip fully-qualified portion

    unless (exists $self->{_permitted}->{$name} ) {
        croak "Can't access `$name' field in class $type";
    }

    if (@_) {
        return $self->{$name} = shift;
    } else {
        if ( defined $self->{$name} ) {
            return $self->{$name}
        }
        else {
            if ( $name eq 'ISO_week' ) {
                $self->ISO_week(sprintf "%d-W%02d", $self->{dt}->week);
            }
            elsif ( $name eq 'ISO_day' ) {
                $self->ISO_day($self->{dt}->day_of_week);
            }
            elsif ( $name eq 'day_of_year' ) {
                $self->day_of_year($self->{dt}->day_of_year);
            }
            elsif ( $name eq 'days_to_go' ) {
                my $dec31 = DateTime->new(year => $self->{year}, month => 12, day => 31);
                $self->days_to_go($dec31->mjd - $self->mjd);
            }
            elsif ( $name eq 'UK_tax_week' ) {
                my $apr6 = DateTime->new(year => $self->{year}, month => 4, day => 6);
                if ( $apr6->mjd > $self->mjd ) {
                    $apr6->subtract(years => 1);
                }
                $self->UK_tax_week(int(1+($self->mjd - $apr6->mjd)/7));
            }
            elsif ( $name eq 'UK_tax_month' ) {
                $self->UK_tax_month(1+($self->month+8-($self->day<6))%12);
            }
            else {
                return
            }
        }
    }
}

sub next_day {
    my $self = shift;
    return $self->new($self->mjd + 1);
}

sub add_event {


    my $self = shift;
    push @{$self->{event_list}}, {
        text  => undef,
        start => undef,
        end   => undef,
        @_,
    };
}

sub event_list {
    my $self = shift;
    return $self->{event_list}
}

sub add_marker {
    my $self = shift;
    push @{$self->{marker_list}}, {
        style => undef,
        colour => undef,
        @_,
    };
    return scalar @{$self->{marker_list}}-1
}

sub delete_marker {
    my $self = shift;
    my $i = shift;
    return delete @{$self->{marker_list}}[$i];
    }

sub marker_list {
    my $self = shift;
    return $self->{marker_list}
    }

sub DESTROY {
    # null method to keep AUTOLOAD happy
}

1;

=head1 NAME

Agenda::Day - class to represent a day in a calendar.
Toby Thurston --- 16 Nov 2004

=head1 SYNOPSIS

 use Agenda::Day;

 #################
 # class methods #
 #################
 $day = Agenda::Day->new(); # means today
 $day = Agenda::Day->new(mjd => $mjd );
 $day = Agenda::Day->new(yyyymmdd => $yyyymmdd );
 $day = Agenda::Day->new(year => $year, month => $month, day => $day );


 #######################
 # object data methods #
 #######################

 ### get versions ###

 $day->mjd
 $day->yyyymmdd
 $day->year
 $day->month
 $day->day
 $day->day_of_year
 $day->days_to_go
 $day->is_weekend
 $day->is_holiday
 $day->ISO_sorted
 $day->ISO_hyphenated
 $day->ISO_day_of_week
 $day->ISO_week
 $day->ISO_week_and_day
 $day->julian
 $day->roman

 ########################
 # other object methods #
 ########################

 $day->days_delta($other_day)

=head1 DESCRIPTION

The Agenda::Day provides an object to represent days.

=cut
