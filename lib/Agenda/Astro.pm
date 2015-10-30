package Agenda::Astro;

use strict;
use vars qw($VERSION @ISA @EXPORT @EXPORT_OK %EXPORT_TAGS
            $long $clat $slat $place_name);
use Carp;
use DateTime;
use POSIX qw(fmod floor);

use constant PI     => 4 * atan2 1, 1;
use constant TWOPI  => PI * 2;
use constant RAD    => PI / 180;
use constant ARC    => 360 * 60 * 60 / TWOPI;
use constant COS_EO => 0.91748;        #cos(obliquity ecliptic)
use constant SIN_EO => 0.39778;        #sin(obliquity ecliptic)
use constant SINH0  => { sun => sin(RAD*(-50/60)), moon => sin(RAD*(8/60))};
use constant D1 => 1236.853086;  #rate of change dD/dT of the mean elongation
                                # of the Moon from the Sun (in rev/century)
use constant D0 => 0.827361;      #mean elongation D of the Moon from the sun
                                # for the epoch J2000 in units of 1rev=360deg

require Exporter;
@ISA = qw(Exporter);

$VERSION = '0.04';

=head1 NAME

Agenda::Astro - a simple set of astronomical functions useful when making
calendars with Perl

(yes, yes, I know about L<Astro::xxxx> but mine is simpler, and nicer :-).

=head1 SYNOPSIS

  use Agenda::Astro qw(Phase Sun Moon);

  ($sunrise,$sunset) = Sun($date, 'Greenwich')

=head1 DESCRIPTION

A simple compact interface to some simple calendar routines.
Implemented purely in Perl, no need for external C code etc.

=head1 FUNCTIONS

No functions are exported by default.

=cut

@EXPORT = qw();

=pod

The following functions can be exported from the C<Agenda::Astro> module:

    Phase
    Sun
    Moon

=cut

@EXPORT_OK = qw(
    Phase
    Sun
    Moon
    set_location
);

=pod

You can import all of them at once with
  C<use Agenda::Astro qw{:all};>

=cut

%EXPORT_TAGS = (all => [@EXPORT_OK]);

=over 4

=item Phase(DateTime)

This function returns the phase of the moon for a given DateTime object.
The phase is returned as a real number between 0 and 1.
New moon is 0, first quarter is 0.25, full moon is 0.5 and thrid quarter
is 0.75.  The algorithm is from I<Astronomy on the PC>.

=cut

sub Phase {
    my $dt = shift;
    confess "Please pass a DateTime object\n" unless "DateTime" eq ref $dt;
    my $t = T_from_mjd($dt->mjd);
    # mean elements l,ls,d,f of the lunar orbit
    my $l  = anomaly_moon($t);         # mean anomaly of the moon
    my $ls = anomaly_sun($t);          # mean anomaly of the sun
    my $e  = elongation($t);           # mean elongation moon-sun
    my $f  = diff_asc_node($t);        # long.moon-long.asc.node
    # periodic perturbations of the lunar and solar longitude (in")
    my $dls = pert_sun($ls);
    my $dlm = pert_moon($l,$ls,$f,$e*TWOPI);
    return fmod($e + ($dlm-$dls)/1296000,1);
}

sub T_from_mjd    { my $mjd = shift; return ($mjd     - 51544.5)/36525 }    #time in centuries from J2000

=item Sun(DateTime)

Returns a list of two DateTime objects indicating the rising and setting times of
the Sun on the date of the given DateTime at the location you have previously defined with set_place().

The returned objects are calculated in UTC, so adjust the time zone as you need. 

Beware that if you are using a location in the high latitudes in the
middle of summer, the sun may never rise or set on day you choose.  In that
case the returned values will be undef. 

=item Moon(DateTime)

This function behaves exactly as Sun(), but returns data for the Moon
instead.

Note that the moon does not set on at least one day per month, so you
will often get undef returned as a value.  (If this seems odd to you think
that the moon may set at say 23:00 on one day, rise at 10:00 the next
day and then not set until 00:30 on the following day).  Note also that
for approximately half of each month, moonrise on a given day will be
after moonset.

=cut


sub Sun  { return _ephemerides('sun', shift) }
sub Moon { return _ephemerides('moon', shift) }

sub _ephemerides {
    my $object = shift;
    my $dt = shift->clone->set_time_zone('local')->set(hour => 0, minute => 0, second => 0)->set_time_zone('UTC');

    my $rise;
    my $set;
    
    my $y_minus = sin_alt($object,$dt) - SINH0->{$object};
    # loop over search intervals from [0h-2h] to [22h-24h]
    SEARCH: 
    for (1..12) {
        my $y      = sin_alt($object, $dt->add(hours => 1)) - SINH0->{$object};
        my $y_plus = sin_alt($object, $dt->add(hours => 1)) - SINH0->{$object};

        # find parabola through three values ym,y0,yp
        my @roots = find_roots_in_minutes($y_minus, $y, $y_plus);
        if (@roots == 1) {
            if ($y_minus < 0) {
                ($rise) = adjust_time($dt, @roots);
            }
            else {
                ($set) = adjust_time($dt, @roots);
            }
        }
        elsif (@roots == 2) {
            ($rise, $set) = adjust_time($dt, @roots);
        }
        last SEARCH if ( defined $rise && defined $set);
        # prepare for next interval
        $y_minus = $y_plus;
    }
    return ($rise, $set);
}

sub adjust_time {
    my ($dt, @minutes) = @_;
    my @out = ();
    for (@minutes) {
        push @out, $dt->clone->add(minutes => $_ - 60 )->set_time_zone('local');
    }
    return @out;
}

BEGIN {
    $long = 0;
    $clat = cos(PI * 103/360);         #ie 51o 30' N
    $slat = sin(PI * 103/360);
    $place_name = 'Greenwich';
}

# set the place vars
sub set_location {
    my %args = ( name => 'Greenwich', latitude => 51.5, longitude => 0, @_ );
    $long = $args{longitude};
    $clat = cos(RAD*$args{latitude});
    $slat = sin(RAD*$args{latitude});
    $place_name = $args{name};
}


sub pos_moon {                         #approx position of moon
    my $t  = shift;
    # mean elements of lunar orbit
    my $l0 = fmod(0.606433+1336.855225*$t,1);    # mean longitude moon (in rev)
    my $l  = anomaly_moon($t);         # mean anomaly of the moon
    my $ls = anomaly_sun($t);          # mean anomaly of the sun
    my $d  = TWOPI * elongation($t);   # diff. longitude moon-sun
    my $f  = diff_asc_node($t);        # long.moon-long.asc.node
    my $dl = pert_moon($l,$ls,$f,$d);
    my $s = $f + ($dl+412*sin(2*$f) + 541*sin($ls)) / ARC;
    my $h = $f-2*$d;
    my $n = -526*sin($h) + 44*sin($l+$h) - 31*sin(-$l+$h) - 23*sin($ls+$h) + 11*sin(-$ls+$h) -25*sin(-2*$l+$f) + 21*sin(-$l+$f);

    my $l_moon = TWOPI * fmod($l0 + $dl/1296000,1);
    my $b_moon = ( 18520.0*sin($s) + $n ) / ARC;

    my $x=cos($b_moon)*cos($l_moon);
    my $v=cos($b_moon)*sin($l_moon);
    my $w=sin($b_moon);
    return ($x, $v*COS_EO - $w*SIN_EO, $v*SIN_EO + $w*COS_EO)
}

sub pert_moon {
    my ($l,$ls,$f,$e) = @_;
    return 22640*sin($l)
          - 4586*sin($l-2*$e)
          + 2370*sin(2*$e)
           + 769*sin(2*$l)
           - 668*sin($ls)
           - 412*sin(2*$f)
           - 212*sin(2*$l-2*$e)
           - 206*sin($l+$ls-2*$e)
           + 192*sin($l+2*$e)
           - 165*sin($ls-2*$e)
           - 125*sin($e)
           - 110*sin($l+$ls)
           + 148*sin($l-$ls)
            - 55*sin(2*$f-2*$e);
}

sub pos_sun {                                         # approx postion of sun
    my $t  = shift;
    my $m  = anomaly_sun($t);
    my $dl = pert_sun($m);
    my $l  = TWOPI*fmod(0.7859453 + $m/TWOPI + (6191.2*$t+$dl)/1296000,1);
    return (cos($l),COS_EO*sin($l),SIN_EO*sin($l));
}

sub pert_sun {
    my $ls = shift;
    return 6893*sin($ls) + 72*sin(2*$ls);
}

sub anomaly_moon  { return TWOPI*fmod(0.374897+1325.552410*shift,1) }
sub anomaly_sun   { return TWOPI*fmod(0.993133+  99.997361*shift,1) }
sub elongation    { return       fmod(D0      +  D1       *shift,1) }
sub diff_asc_node { return TWOPI*fmod(0.259086+1342.227825*shift,1) }

sub sin_alt {
    my ($object, $dt) = @_;
    my $t = T_from_mjd($dt->mjd);
    my ($x,$y,$z) = $object eq 'sun'  ? pos_sun($t) 
                                      : pos_moon($t);
    my $rho = sqrt(1 - $z*$z);
    my $dec = atan2($z,$rho);
    my $ra  = ( 24/PI)*atan2($y,($x+$rho)); $ra+=24 if $ra < 0;

    my $ut = $dt->mjd - int($dt->mjd);
    my $t0 = T_from_mjd(int($dt->mjd));
    my $st_greenwich = 6.697374558 + 24.0657098232*$ut + (8640184.812866+(0.093104-0.0000062*$t0)*$t0)*$t0/3600;
    my $st_local = fmod($st_greenwich+$long/15,24);
    
    return $slat*sin($dec) + $clat*cos($dec)*cos(RAD*15*($st_local-$ra));
}

sub find_roots_in_minutes {
    my ($y_neg,$y,$y_pos) = @_;
    # find coefficients
    my $a = ($y_pos+$y_neg)/2-$y;
    my $b = ($y_pos-$y_neg)/2;
    my $c = $y;
    # coordinates of the extremum
    my $xe  = -$b/(2*$a);
    my $ye  =  $a*$xe**2 + $b*$xe + $c;
    # discriminant of y = axx+bx+c
    my $dis =  $b**2 - 4*$a*$c;
    # results
    my @roots = ();
    if ($dis >= 0) {                             # parabola intersects x-axis
        my $dx = 0.5*sqrt($dis)/abs($a);
        my $x1 = $xe-$dx;
        my $x2 = $xe+$dx;
        if (abs($x1)<=1) {
            push @roots, floor(0.5+60*$x1);
        }
        if (abs($x2)<=1) {
            push @roots, floor(0.5+60*$x2);
        }
        if ( @roots == 2 && $ye < 0 ) {
            @roots = reverse @roots;
        }
    }
    return @roots;
}

=head1 SEE ALSO

=head1 AUTHOR

Toby Thurston

email: see web site for current address

=cut
1;
