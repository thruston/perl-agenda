# Toby Thurston -- 08 Dec 2011 
use strict;
use warnings;

use Test::More tests => 3;                

use Agenda::Profile;

my $cfg = Agenda::Profile->new(file => 'sample.cfg');
ok(ref $cfg eq 'Agenda::Profile');
ok($cfg->location_name eq 'London');
ok($cfg->weekend_days->[1] == 7);
