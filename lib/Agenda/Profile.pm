package Agenda::Profile;

use strict;
use warnings;

use constant DEBUG => 0;
use Carp;
use utf8;

our $VERSION = 0.3;

=head1 NAME

Agenda::Profile - class to hold calendar configuration data.
Toby Thurston -- 08 Dec 2011 

=head1 SYNOPSIS

 use Agenda::Profile;

 #################
 # class methods #
 #################
 $cfg = Agenda::Profile->new(file => 'filename');

=head1 DESCRIPTION

The Agenda::Profile provides an interface to a simple text-based calendar
configuration file.

=cut

use Carp;
use vars qw($AUTOLOAD);  # it's a package global

my %fields = (
    event_files         => undef,    
    to_do_file          => undef,
    tag_hash            => undef,
    tag_list            => undef,    
    week_starts_on_day  => 1,        
    paper_size          => 'a4',     
    travel_words        => 'travel',    
    first_hour          => 8,
    last_hour           => 18,
    location_name       => 'London', 
    location_latitude   => 51.5,     
    location_longitude  => 0,        
    locale              => 'en_GB',
    grid_colour         => 'black',
    source_file         => undef,
    page_margin         => 15,
    col_gutter          => 0,
    col_sizes           => '15 4 1',
    col_heads           => 'None pound clock',
    weekend_days        => [6, 7],
    weekend_style       => 'shade gainsboro colour navy rules none',
);

sub new {
    my $that  = shift;
    my %args  = @_;
    my $class = ref($that) || $that;
    my $self  = {
        _permitted => \%fields,
        %fields,
    };
    bless $self, $class;
    if ( defined $args{file} ) {
        $self->load($args{file})
    }
    return $self;
}

sub _set_value {
    my ($self, $key, $val) = @_;

    $key = lc $key;
    $key = lc $key;
    warn "$key --> $val\n" if DEBUG;

    if ($key eq 'tag') {
        my ($tag, $spec) = split ' ', $val, 2;
        push @{ $self->{tag_list} }, { tag => $tag, spec => $spec }; 
        return $self->{tag_hash}->{lc $tag} = $spec;
    }

    if ( ! exists $fields{$key} ) {
        confess "Unknown key: $key\n";
    }

    $val =~ s/^(["'])(.*)\1/$2/;
    $val =~ s/^\s*//;
    $val =~ s/\s*$//;
    if ( $val =~ /,/ ) {
        return $self->{$key} = [ split ',', $val ];
    }
    else {
        return $self->{$key} = $val;
    }
}

sub load {

    my $cfg  = shift;
    my $file = shift;

    warn "Trying to load $file\n" if DEBUG;

    if (! -f $file) {
        warn "Can't access $file" if DEBUG;
    }
    elsif (! open my $fh, '<', $file ) {
        warn "Can't open $file" if DEBUG;
    }
    else {
        while (<$fh>) {
            chomp;
            next if /^#/;
            next if /^\*/;
            next if /^$/;
            s/=/ /g;
            my ($key, $val) = split ' ', $_, 2;
            $cfg->_set_value($key, $val);
        }
        close $fh;
        $cfg->{source_file} = $file;
    }
    return;
}


sub AUTOLOAD {
    my $self = shift;
    my $val  = shift;
    my $type = ref($self)
                or croak '$self is not an object';

    my $key = $AUTOLOAD;
    $key =~ s/.*://;   # strip fully-qualified portion

    unless (exists $self->{_permitted}->{$key} ) {
        croak "Can't access `$key' field in class $type";
    }

    if (defined $val) {
        return $self->_set_value($key, $val);
    } else {
        carp "Reading $key ->", defined $self->{$key} ? $self->{$key} : 'undef', "\n" if DEBUG;
        return $self->{$key};
    }
}

sub DESTROY {
}
