# test calendar.pm

use strict;
use warnings;

use Test::More tests => 4;                      # last test to print

use Agenda::Calendar;

my $cal = Agenda::Calendar->new(first_mjd => 55000, duration => 30);
ok('2009-06-19' eq $cal->day(1)->dt->ymd);
ok(30 == 1 + $cal->last_day->mjd - $cal->first_day->mjd);

use DateTime;
my $dt = DateTime->today;
my $dtcal = Agenda::Calendar->new(first_dt => $dt, last_dt => $dt->clone->add(days => 7));
ok($dtcal->duration == 7);
ok($dtcal->first_day->mjd - $dtcal->last_day->mjd + $dtcal->duration == 1);
