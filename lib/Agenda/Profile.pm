package Agenda::Profile;

use strict;
use warnings;

use constant DEBUG => 0;
use Carp;


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
    currency_symbol     => '£',  
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
    weekend_days        => '6,7',
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

sub load {

    my $cfg  = shift;
    my $file = shift;

    warn "Trying to load $file\n" if DEBUG;

    die "Can't access $file" unless -f $file;

    open my $fh, '<', "$file" or die "Can't open $file\n";

    while (<$fh>) {
        chomp;
        next if /^#/;
        next if /^\*/;
        next if /^$/;
        s/=/ /g;
        my ($key, $val) = split ' ', $_, 2;
        $key = lc $key;
        warn "$key --> $val\n" if DEBUG;

        if ($key eq 'tag') {
            my ($tag, $spec) = split ' ', $val, 2;
            push @{ $cfg->{tag_list} }, { tag => $tag, spec => $spec }; 
            $cfg->{tag_hash}->{lc $tag} = $spec;
            next;
        }

        if ( ! exists $fields{$key} ) {
            confess "Unknown key '$key' found in $file\n";
        }

        $val = _strip_quotes($val);
        if ( $val =~ /,/ ) {
            $cfg->$key( [ split ',', $val ] );
        }
        else {
            $cfg->$key($val);
        }
    }
    close $fh;
    $cfg->{source_file} = $file;
    return $cfg;
}

sub _strip_quotes ($) {
    my $val = shift;
    return '' unless defined $val;
    $val =~ s/^(["'])(.*)\1/$2/;
    $val =~ s/^\s+//;
    $val =~ s/\s+$//;
    return $val;
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
        warn "Setting $key <- $val\n" if DEBUG;
        return $self->{$key} = $val;
    } else {
        carp "Reading $key ->", defined $self->{$key} ? $self->{$key} : 'undef', "\n" if DEBUG;
        return $self->{$key};
    }
}

sub DESTROY {
}
