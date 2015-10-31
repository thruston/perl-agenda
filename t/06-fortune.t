# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test;
BEGIN { plan tests => 5 };
use Agenda::Fortune qw(fortune apothegm dictum);
ok(1); # If we made it this far, we're ok.

#########################

# Insert your test code below, the Test module is use()ed here so read
# its man page ( perldoc Test ) for help writing this test script.

ok(length(fortune()) > 0 );
ok(length(apothegm())<=160);
ok(length(dictum())  >=160);

@text = ();
ok(@text=fortune());

