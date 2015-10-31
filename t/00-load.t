#
BEGIN { $| = 1; print "1..1\n"; $loaded = 0 }
END {print "not ok 1\n" unless $loaded;}
use Agenda::Events;
use Agenda::Astro;
use Agenda::PostScript;
use Agenda::Profile;
use Agenda::Fortune;
$loaded = 1;
print "ok 1\n";

