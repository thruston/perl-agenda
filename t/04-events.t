use strict;
use warnings;

use Test::More tests => 2;                      # last test to print

use Agenda::Events;
use Agenda::Profile;
use DateTime;

my $start = DateTime->today->subtract(days=>90);
my $stop  = $start->clone->add(days=>180);

my $cal = Agenda::Events->new(start => $start, end => $stop);
ok($cal->duration->seconds == 180*24*3600, "duration");

my $cfg = Agenda::Profile->new(file => 'sample.cfg');

my $f = $cfg->event_files;
my @event_files;
if ( defined $f ) {
    push @event_files, ref $f ? @$f : $f;
}

$start = DateTime->new(year => 2014, month => 5, day => 1);
$stop  = $start->clone->add(days=>40);

my $cal2 = Agenda::Events->new(start => $start, end => $stop, file_names => \@event_files);
my $xmas = DateTime->new(year => 2014, month => 5, day => 28)->mjd;

ok(2 == @{$cal2->events_on($xmas)}, "events"); 

