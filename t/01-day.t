use Agenda::Day;
use DateTime;

use Test::Simple tests=>9;

my $d = Agenda::Day->new();
my $date = DateTime->today();
my $mjd  = $date->mjd;
my $yyyy = $date->year;
my $mm   = $date->month;
my $dd   = $date->day;
my $dow  = $date->dow;
my $doy  = $date->day_of_year;
my $dtg  = DateTime->new(year=>$yyyy, month=>12, day=>31)->mjd - $date->mjd;

ok($d->{yyyymmdd} eq $date->ymd  , 'YYYYMMDD');
ok($d->yyyymmdd eq $date->ymd    , "YYYYMMDD()");
ok($d->mjd      == $mjd     , "mjd           ");
ok($d->year     == $yyyy    , "year          ");
ok($d->month    == $mm      , "month         ");
ok($d->day      == $dd      , "day           ");
ok($d->day_of_year == $doy  , "day_of_year   ");
ok($d->days_to_go  == $dtg  , "days_to_go    ");
# ok($d->is_weekend           , "is_weekend    ");
# ok($d->is_holiday           , "is_holiday    ");
# ok($d->is_termtime          , "is_termtime   ");
#ok($d->ISO_sorted == $date  , "ISO_sorted    ");
# ok($d->ISO_hyphenated       , "ISO_hyphenated");
ok($d->ISO_day == $dow      , "ISO_day       ");
# ok($d->ISO_week             , "ISO_week      ");
# ok($d->ISO_week_day         , "ISO_week_day  ");
# ok($d->julian               , "julian        ");
# ok($d->roman                , "roman         ");
# ok($d->UK_tax_month         , "UK_tax_month  ");
# ok($d->UK_tax_week          , "UK_tax_week   ");
# ok($d->sunrise              , "sunrise       ");
# ok($d->sunset               , "sunset        ");
# ok($d->moon_phase           , "moon_phase    ");
# ok($d->moonrise             , "moonrise      ");
# ok($d->moonset              , "moonset       ");
# ok($d->location             , "location      ");
# ok($d->marker_list          , "marker_list   ");
# ok($d->event_list           , "event_list    ");

