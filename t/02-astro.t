print "1..3\n";
use DateTime;
use Agenda::Astro qw(Sun Moon Phase set_location);

print "ok 1\n";

my $now = DateTime->new(year => 2001, month => 4, day => 7);
my $place = 'London';
set_location(name => $place, latitude => 51.5, longitude => 0);

my $p = Phase(DateTime->today);
print "NOT " unless $p<1 && $p>=0;
print "ok 2\n";

open F, ">test.out";

for(1..8) {
    $now->add(days => 1);
    my ($rise, $set) = Sun($now);
    if ($rise) {
        printf F $rise->strftime("%Y%m%d %H:%M sunrise 1 $place\n");
    }
    if ($set) {
        printf F $set->strftime("%Y%m%d %H:%M sunset .  $place\n");
    }
}

$now->set(year=>2001, month => 4, day => 7);
for(1..8) {
    $now->add(days => 1);
    my ($moonrise, $moonset) = Moon($now);
    if ($moonrise) {
        my $phase = sprintf "%.4f", Phase($moonrise);
        printf F $moonrise->strftime("%Y%m%d %H:%M moonrise $phase $place\n");
    }
    if ($moonset) {
        printf F $moonset->strftime("%Y%m%d %H:%M moonset .  $place\n");
    }

}

close F;

print "ok 3\n";

