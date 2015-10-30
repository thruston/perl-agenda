# Toby Thurston -- 06 Dec 2011 
package Agenda::Events;

use strict;
use warnings;
use Carp;

use DateTime;
use DateTime::Span;
our @ISA = qw(DateTime::Span);           

my $VERSION = "0.1";
my $COPYRIGHT = "(c) Toby Thurston - 2002-2012";


sub new {
    my $class  = shift;
    my %args = ( 
        start      => undef , 
        end        => undef , 
        file_names => undef ,  
        @_ 
    );
    my $self = $class->SUPER::from_datetimes(start => $args{start}, end => $args{end});
    $self->{events_on} = undef;  

    bless $self, $class;

    if ( $args{file_names} ) {
        $self->parse_events(file_names => $args{file_names});
    }

    return $self;
}

sub parse_events {
    my $self = shift;
    my %args = @_;
    
    return unless $args{file_names};

    for my $file ( @{$args{file_names}} ) {
        next unless -f $file;
        open my $fh, '<', $file or confess "Failed to open $file: $!\n";
        while ( <$fh> ) {
            chomp;
            next unless my ($y, $m, $d, $text) = $_ =~ m{ 
                \A
                (20\d\d)\D?(0[1-9]|1[012])\D?([012]\d|3[01])
                \s+
                (\S.*)
                \Z 
            }xmsio; 
            
            my $dt = DateTime->new(year=>$y, month=>$m, day=>$d);
            next unless $self->contains($dt);

            push @{$self->{events_on}->{$dt->mjd}}, { dt => $dt,  text => _ps_proof($text) }
        }
        close $fh;
    }
}

sub _ps_proof {
    my $s = shift;
    # remove any parentheses incase we drop a trailing one
    $s =~ s/\(//gioms;
    $s =~ s/\)//gioms;
    return $s;
}

sub events_on {
    my $self = shift;
    my $mjd = shift;
    return unless defined wantarray;
    if (wantarray) {
        return defined $self->{events_on}->{$mjd} ? @{$self->{events_on}->{$mjd}} : ();
    }
    else {
        return defined $self->{events_on}->{$mjd} ? $self->{events_on}->{$mjd} : [];
    }
}

1;
