#! /usr/bin/perl -w
#
# Toby Thurston -- 19 Feb 2016 
#
# Make a weekly calendar                                                   
#                                                                          
# (c) Copyright 1999-2016.  All rights reserved.
#

use strict;
use warnings;
use feature "switch";

use DateTime;
use Agenda::Events;
use Agenda::PostScript;
use Agenda::Profile;
use Agenda::Astro qw(Sun Moon Phase set_location);
use Agenda::Fortune qw(apothegm);

use Getopt::Std;
use POSIX;

my $opts = { h => 0, m => 0, z => 0 , d => 0, a => 0, p => 'agenda.cfg' };
getopts('acdhmzp:', $opts);
my $profile     = $opts->{p};
my $want_astro  = $opts->{a};
my $want_motto  = $opts->{m};
my $want_duplex = $opts->{d};
my $need_help   = $opts->{h};
my $dump_events = $opts->{z};

# load the configuration file
my $cfg = Agenda::Profile->new(file => $profile);
DateTime->DefaultLocale($cfg->locale);

# assume we start today
my $first_day = DateTime->today;

my $start_option = shift;
given ($start_option) {
    when (undef)    {}
    when ("today")  {}
    when (".")      {}
    when ("=")      { $first_day->subtract(weeks => 1) }
    when (/\A([12]\d\d\d)\D?(\d\d)\D?(\d\d)\Z/) { 
        $first_day->set(year => $1, month => $2, day => $3);
    }
    default { $need_help++ }
}

# Set to Monday following (either following today or given date)
$first_day->add(days => 8 - $first_day->day_of_week);
die "Not Monday\n" unless 1 == $first_day->day_of_week;

die <<"USAGE" if $need_help;

$0 -- make a PostScript weekly calendar

Usage: $0 [options] [date [weeks [weeks-per-page [event-files...]]]]

date defaults to today.  The calendar will start on the first Monday on or
  after the date you give.  To specify the date use yyyy-mm-dd or yyyymmdd
  form or just put "." to accept the default. Or put "=" to have it start on the Monday
  of the current week.

weeks defaults to 1 and is the whole number of weeks to print

weeks-per-page defaults to 1 and may be 1 or 4

events-files is a list of one or more files containing events to be printed
  on the calendar.  These files will be read in addition to any defined in your
  chosen cal profile.  Each file should contain a list of events in the form

     date [hh:mm] short event text on a single line

  date should be some form of date or repeating event code supported by Cal::Date
  Use option -z to dump the events actually used to STDERR.

The outout is written to STDOUT

Options:  -a        Include astronomical events     (default is don't include)
          -m        Print a random `fortune' on each page  (default is no msg)
          -p xxx    Use profile called xxx          (default is "agenda.cfg")

USAGE

my ($weeks, $weeks_per_page, @event_files) = @ARGV;

# sort out weeks and weeks_per_page
$weeks = 1 unless defined $weeks;
$weeks = 1 unless $weeks =~ /^\d+$/;
$weeks_per_page = 1 unless defined $weeks_per_page;
$weeks_per_page = 1 unless $weeks_per_page =~ /^\d+$/;

# let user give them the wrong way round
($weeks, $weeks_per_page) = ($weeks_per_page, $weeks) if $weeks < $weeks_per_page;
$weeks_per_page = 1 unless $weeks_per_page =~ /^[14]$/;
$weeks = 1 unless $weeks > 0;

# adjust $weeks up to a multiple of $weeks_per_page
$weeks += ($weeks_per_page - $weeks % $weeks_per_page) if $weeks % $weeks_per_page;

die "Be reasonable, that's too many weeks\n" if $weeks > 500;


my $last_day = $first_day->clone->add(weeks => $weeks)->subtract(days => 1);
die "Last day is not Sunday\n" unless 7 == $last_day->day_of_week;

my $f = $cfg->event_files;
if ( defined $f ) {
    push @event_files, ref $f ? @$f : $f;
}
my $cal = Agenda::Events->new(start => $first_day, end => $last_day, file_names => \@event_files); 
# Organize those events
my %want_rules_on = ();
my %banner_name_for = ();
my %durations_on = ();
my %travel_times_on = (); 
my %notes_for = ();
my %observations_on = ();

if ( $want_astro ) {
    set_location(latitude  => $cfg->location_latitude, longitude => $cfg->location_longitude, name => $cfg->location_name);
}

for ( my $day = $first_day->clone;  $day <= $last_day; $day->add(days => 1)) {
    my $d = $day->mjd;
    $want_rules_on{$d} = $day->day_of_week>5 ? 0 : 1;  # No point in using cfg item
    if ( $want_astro ) {
        my ($sr, $ss) = Sun($day);
        my ($mr, $ms) = Moon($day);
        $observations_on{$d} = {
            sunrise  => defined $sr ? $sr->strftime("%H:%M") : '-' ,
            sunset   => defined $ss ? $ss->strftime("%H:%M") : '-' ,
            moonrise => defined $mr ? $mr->strftime("%H:%M") : '-' ,
            moonset  => defined $ms ? $ms->strftime("%H:%M") : '-' ,
            moon_phase => Phase($day),
        };
    }
    next unless $cal->events_on($d);
    EVENT:
    for my $e ( @{$cal->events_on($d)} ) {
        my $colour = 'black';
        my $tag = '';
        my $text = '';

        if ( (($tag, $text) = $e->{text} =~ m{ \A (\S+:)\s+(\S.*) \Z }xismo) && exists $cfg->tag_hash->{lc $tag} ) {
            my $spec = $cfg->tag_hash->{lc $tag};
            next EVENT if $spec =~ m{ ignore }xismo;
            $colour              = $1    if $spec =~ m{ colou?r \s+ (\S+) }xismo;
            $want_rules_on{$d}   = 0     if $spec =~ m{ no_rules          }xismo;
            $banner_name_for{$d} = "$colour 0 ($text) rshow" if $spec =~ m{ set_day_name      }xismo;
        }
        else {
            $text = $e->{text};
        }
        if ( $want_rules_on{$d} == 0 ) {
            push @{$notes_for{$d}}, "$colour ($text)";
            next EVENT;
        }
        if ( $text =~ m{ \A (\d\d):(\d\d)\D(\d\d):(\d\d)\s+(\S.*) \Z }xismo ) {
            my $hash_ref = { start => $1*60+$2, end => $3*60+$4, desc => "$colour ($5)" };
            if ( $text =~ m{ $cfg->travel_words }xismo ) {
                push @{$travel_times_on{$d}}, $hash_ref; 
            }
            else {
                push @{$durations_on{$d}}, $hash_ref; 
            }
        }
        elsif ( $text =~ m{\A([012]\d):([012345]\d)\s+(\S.*)\Z }xmsio ) {
            push @{$durations_on{$d}}, { start => $1*60+$2, end => -1, desc => "$colour ($3)" };
        }
        else { 
            push @{$notes_for{$d}}, "$colour ($text)";
        }  
    }
}

# create the output
my $pages = $weeks / $weeks_per_page;
my $days_per_page = 7 * $weeks_per_page;

my $ps = Agenda::PostScript->new(
                title => "$weeks week planner starting Mon $first_day" ,
               config => $cfg ,
                pages => $pages );

$ps->begin_document($want_duplex);
my $page_alpha;
my $page_omega;
for my $p ( 1 .. $pages ) {

    $ps->begin_page(label => "Page $p");

    # put the title line(s) on the page
    $page_alpha = $first_day->clone->add(weeks => ($p-1)*$weeks_per_page);
    $page_omega = $page_alpha->clone->add(weeks => $weeks_per_page)->subtract(days=>1);

    # Month/Year title
    $ps->put(sprintf("%f %f moveto", $ps->{llx}, $ps->{ury}-10.89));
    $ps->put("Heading");

    if ( $page_alpha->month == $page_omega->month ) {
        $ps->put(sprintf "(%s) show", $page_alpha->strftime('%B %Y'));
    } 
    elsif ( $page_alpha->year == $page_omega->year ) {
        $ps->put(sprintf "(%s) show", $page_alpha->strftime('%B'));
        $ps->put("/emdash glyphshow");
        $ps->put(sprintf "(%s) show", $page_omega->strftime('%B %Y'));
    } 
    else {
        $ps->put(sprintf "(%s) show", $page_alpha->strftime('%B %Y'));
        $ps->put("/emdash glyphshow");
        $ps->put(sprintf "(%s) show", $page_omega->strftime('%B %Y'));
    }

    # ISO Week number (right aligned)
    $ps->put(sprintf("%f %f moveto", $ps->{urx}, $ps->{ury}-10.89));

    my $wa = _week($page_alpha);
    my $wo = _week($page_omega);
    $ps->put('gsave navy');
    $ps->put("0 ($wa)" . ( $wa eq $wo ? 'rshow' : "($wo) rrshow") );
    $ps->put('grestore');

    # draw a line under all this
    $ps->put(sprintf("%f %f moveto",        $ps->{llx}, $ps->{ury}-16));
    $ps->put(sprintf("%f %f lineto stroke", $ps->{urx}, $ps->{ury}-16));

    my $points_down = 16;
    # add PAYE month & week for UK users if 1 week per page
    if ( $ENV{LANG} =~ m{\Aen_GB}ioxms && $days_per_page == 7 ) {
        $points_down += 10;
        $ps->put(sprintf("%f %f moveto", $ps->{urx}, $ps->{ury}-$points_down));
        $ps->put("Words 0 (PAYE Month ". _UK_tax_month($page_alpha) ." Week ". _UK_tax_week($page_alpha) .") rshow");
    }
    #
    # and now add a few notes...
    if ( defined $observations_on{$page_alpha->mjd} ) {
        if ( $days_per_page == 7 ) {
            $points_down += 7;
            $ps->put(sprintf("%f %f moveto", $ps->{urx}, $ps->{ury}-$points_down));
        }
        else {
            $ps->put(sprintf("%f %f moveto", $ps->{urx}, $ps->{lly}));
        }
        $ps->put("Notes 0 (Sun & moon times for " . $cfg->location_name . ") rshow");
    }

    if ( $want_motto ) {
        my $x = $ps->{urx};
        my $y_position = 7==$days_per_page ? 240 : 58;
        my @motto_lines = apothegm();
        my $leading = 7;
        my $y = $y_position+$leading*@motto_lines;
        for (@motto_lines) {
            $y -= $leading;
            # escape backslash and parens, trim trailing & leading space
            s/([\(\)\\])/\\$1/g;
            s/^\s*//; s/\s*$//;
            s/--/-/g;
            $ps->put("$x $y moveto Notes 0 ($_) rshow");
        }
    }

    # put the weekly schedule on the page
    for my $w (1..$weeks_per_page) {
        put_schedule($w, $weeks_per_page);
    }

    # put the monthly calendar on too
    put_mini_calendar($weeks_per_page);

    $ps->end_page;
}
$ps->end_document;
$ps->print;
exit;

sub _week {
    return sprintf "%d-W%02d", $_[0]->week;
}

sub _UK_tax_week {
    my $dt = shift;
    my $april6 = DateTime->new( year => $dt->year, month => 4, day => 6);
    my $today  = DateTime->today;
    if ($april6 > $today ) { $april6->subtract(years => 1 ) }
    use integer;
    return sprintf "%d", ($today->mjd - $april6->mjd )/7+1;
}

sub _UK_tax_month {
    my $dt = shift;
    return sprintf "%d", ($dt->month+8-($dt->day<6))%12+1;
}

sub put_mini_calendar {
    my $weeks_per_page = shift;

    $ps->put("Words");

    my $wd = 3 * 2.6; # given that Words font is now 5.2 pt big
    my $dp = 7;
    my $dx = 9*$wd;
    my $dy = -9*$dp;

    my ($x, $y, $month_offset, $cols, $rows );

    if ( $weeks_per_page == 1 ) {
        $month_offset = 1;
        $x = $ps->{width}/2 + 24;
        $y = ($ps->{height}-$ps->{head_height})/5 + 9.4*$dp;
        $cols = int(($ps->{width}+14)/(2*$dx));
        $rows = 1;
    } else {
        $x = $ps->{margin} + 20;
        $y = $ps->{height} / 5 - 20;
        $month_offset = 2;
        $cols = 6;
        $rows = 2;
    }

    my $first = $page_alpha->clone->set(day => 1)->subtract(months => $month_offset+1);
    my $week_header; 
    my $d = $page_alpha->clone;
    for (1..7) {
        $week_header .= "$wd (" . substr($d->day_name, 0, 1) . ') cshow ';
        $d->add(days=>1);
    }

    for (my $i = 0 ; $i < $cols*$rows ; ++$i) {

        $first->add(months => 1);

        my $offx = $i % $cols * $dx;
        my $offy = int($i/$cols) * $dy ;

        $ps->put(sprintf "%g %g moveto %g (%s) (%d) splitshow",
                       $x+$offx, $y+$offy, 20/3*$wd, $first->month_name, $first->year);

        $ps->put(sprintf "%g %g moveto $week_header", $x+$offx, $y+$offy-$dp);

        my $days_in_month = $first->clone->add(months=>1)->mjd - $first->mjd;
        my $day_offset    = $first->day_of_week - 1; # 0 Monday 6 Sunday
        my $day_string    = q{   } x $day_offset; 
        for my $d (1..$days_in_month) {
            $day_string .= sprintf '%3d', $d;
        }
        for my $r (1..POSIX::ceil(($day_offset+$days_in_month)/7) ) {
            my $mon_mjd = $first->mjd-$day_offset-7+7*$r;
            my $want_red = ($page_alpha->mjd <= $mon_mjd) && ($mon_mjd <= $page_omega->mjd);
            $ps->put(sprintf '%g %g moveto ( ) stringwidth 8#040 (%s) gsave %s widthshow grestore', 
                             $x+$offx, 
                             $y+$offy-$dp-$dp*$r,
                             substr($day_string, 1+21*($r-1), 20),
                             $want_red ? 'red' : 'black')
        }
    }
}

sub put_schedule {
    my ($week_on_page, $weeks_per_page) = @_;

    # position and size of each daily box
    my ($x, $y, $wd, $dp);

    # depth of the box
    $dp = ($ps->{height}-$ps->{head_height})/5;

    # width and (x,y) position
    if ( $weeks_per_page == 1) {
        $wd = $ps->{width}/2+4;
        $x  = $ps->{margin};
    } 
    else {
        $wd = $ps->{width}/6-1;
        $y  = $ps->{ury} - $ps->{head_height} - $dp*($week_on_page-1);
    }

    # hour parameters (only apply to weekdays so no need to recalc when $dp changes for w/e)
    my $first_hour = $cfg->first_hour ||  8;
    my $last_hour  = $cfg->last_hour  || 18;
    my $hour_lines = $last_hour-$first_hour+4; # to allow space for event text at bottom
    my $hour_leading = $dp / $hour_lines;

    # Monday .. Friday
    for my $d (0..4) {
        # position for today
        if ( $weeks_per_page == 1) {
            $y  = $ps->{ury} - $ps->{head_height} - $dp*$d;
        } 
        else {
            $x  = $ps->{margin} + $wd*$d;
        }
        # today's object
        my $day = $page_alpha->clone->add(weeks => $week_on_page-1)->add(days => $d);
        my $dec31 = DateTime->new(year => $day->year, month=>12, day => 31)->day_of_year;

        # basic day data
        $ps->put(sprintf "%g %g moveto $wd 0 rlineto stroke " , $x, $y);
        $ps->put(sprintf "%g %g moveto Heading 16 (%s) cshow ", $x, $y-16, substr $day->day_name, 0, 1 );
        $ps->put(sprintf "%g %g moveto Numbers 16 (%d) cshow ", $x, $y-32, $day->day);
        $ps->put(sprintf "%g %g moveto Words   16 (%d) cshow ", $x, $y-44, $day->day_of_year);
        $ps->put(sprintf "%g %g moveto gsave 12 0 rlineto .2 setlinewidth stroke grestore", $x+2, $y-46);
        $ps->put(sprintf "%g %g moveto Words   16 (%d) cshow ", $x, $y-52, $dec31-$day->day_of_year);

        # names for special days
        if ( exists $banner_name_for{$day->mjd} ) {
            $ps->put(sprintf "%g %g moveto gsave Holiday %s grestore", $x+$wd, $y-16, $banner_name_for{$day->mjd});
        }

        # Sun and Moon
        if ( exists $observations_on{$day->mjd} ) {
            put_sun(  $x-1, $y-64, $observations_on{$day->mjd});
            put_moon( $x-1, $y-96, $observations_on{$day->mjd});
        }

        # hours
        if ( $want_rules_on{$day->mjd} ) {
            put_events($day->mjd, $x, $y, $first_hour, $last_hour, $hour_leading);
            my ($a, $b) = ($first_hour, $last_hour);
            $ps->put('gsave');
            for my $hour ($a .. $b) {
                $ps->put(sprintf "%g %g moveto (%02d) show %g %g moveto %g %g lineto" ,
                                       $x+15,   $y-16-($hour-$a)*$hour_leading,
                                       $hour,
                                       $x+21.5, $y-12-($hour-$a)*$hour_leading,
                                       $x+$wd,  $y-12-($hour-$a)*$hour_leading );

            }
            $ps->put('.4 setlinewidth .5 setgray stroke grestore');


            if ( $weeks_per_page == 1 ) {
                # draw gutters
                $ps->put('gsave 1 setgray 3 setlinewidth');
                $ps->put(sprintf '%g %g moveto 0 %g rlineto', $x+$wd-72, $y-10, -$dp);
                $ps->put(sprintf '%g %g moveto 0 %g rlineto', $x+$wd-16, $y-10, -$dp);
                $ps->put('stroke grestore');

                # draw currency symbol
                my $c = $cfg->currency_symbol;
                if ( defined $c ) {
                    if    ( $c eq 'euro'  ) { $c = 'gsave /Symbol 6 selectfont (\360) show grestore' }
                    elsif ( $c eq 'pound' ) { $c = '/sterling glyphshow' }
                    elsif ( $c eq 'dollar') { $c = 'Words ($) show' }
                    else                    { $c = 'Words (' . $c . ') show' }

                    $ps->put(sprintf "%g %g moveto $c", $x+$wd-68, $y-10);
                }

                # draw clock face
                $ps->put(sprintf '%g %g moveto',        $x+$wd-8, $y-8);
                $ps->put('gsave .2 setlinewidth');
                $ps->put(sprintf '%g %g 2.4 20 380 arc',$x+$wd-8, $y-8);
                $ps->put("-2.2 -0.9 rmoveto -1.4 2.8 rlineto stroke grestore");
            }

        }
        put_notes($day->mjd, $x, $y-$dp+3, 7);

    }

    # Adjust sizes for weekends
    if ( $weeks_per_page == 1) {
       $x = $ps->{margin} + $wd + 6;  # ie start with a 6pt gutter
       $wd = $ps->{width}/4 -6;       # now make $wd smaller
       # $dp, $y stay the same
    } else {
       $dp = $dp/2;
       $x  = $ps->{margin} + $wd*5 + 3.6;
       $wd += 3.2;
    }

    for my $d (5..6) {

        if ( $d == 6 ) {  # move for Sunday
            if ( $weeks_per_page == 1) {
                $x = $x + $wd;
            } else {
                $y = $y - $dp;
            }
        }

        # today's object
        my $day = $page_alpha->clone->add(weeks => $week_on_page-1)->add(days => $d);
        my $dec31 = DateTime->new(year => $day->year, month=>12, day => 31)->day_of_year;

        # basic day data
        my $day_name = substr $day->day_name, 0, $weeks_per_page == 1 ? 99 : 3;
        $ps->put(sprintf "%g %g moveto %g 0 rlineto stroke ", $x, $y,    $wd-15);
        $ps->put(sprintf "%g %g moveto Heading (%s) show ",   $x, $y-16, $day_name );
        $ps->put(sprintf "4 0 rmoveto Numbers (%d) show ", $day->day);
        $ps->put(sprintf "%g %g moveto Words (%d/%d) show", $x, $y-24, $day->day_of_year, $dec31-$day->day_of_year);

        # Sun and Moon
        if ( exists $observations_on{$day->mjd} ) {
            put_sun(  $x+$wd-50, $y-6, $observations_on{$day->mjd});
            put_moon( $x+$wd-30, $y-6, $observations_on{$day->mjd});
        }

        put_notes($day->mjd, $x-2, $y-32, -7);

    }
}

sub put_notes {
    my ($mjd, $x, $y, $leading) = @_;
    my $dy = 0;
    # Notes at the bottom
    $ps->put('gsave Words');
    for my $n ( @{$notes_for{$mjd}} ) {
        $ps->put("$x $y moveto 2 $dy rmoveto $n show");
        $dy += $leading;
    }
    $ps->put('grestore');
}
sub put_events {
    # Events with or without durations
    my ($mjd, $x, $y, $first_hour, $last_hour, $leading) = @_;
    $ps->put('gsave Words');
    for my $ref ( @{$durations_on{$mjd}} ) {
        my $first_min = $ref->{start};
        my $last_min  = $ref->{end};
        my $y_depth = $y-12-($first_min/60-$first_hour)*$leading;
        if ($last_min>0) {
            $ps->put(sprintf ".8 setgray %g %g %g %g rectfill", $x+21.5, $y_depth,
                                                            5, -($last_min-$first_min)/60*$leading);
        }
        my $min_part = sprintf "%02d ", $first_min%60;
        $ps->put("$x $y_depth moveto 22 -3.4 rmoveto gsave Tiny royal_blue ($min_part) show grestore");
        $ps->put("5 -1 rmoveto $ref->{desc} show");
    }
    $ps->put('grestore');
}

sub put_sun {
    my ($x, $y, $d) = @_;
    $ps->put(sprintf "%g %g moveto Astro 16 (%s) cshow"                          , $x   , $y    , $d->{sunrise}    ); 
    $ps->put(sprintf "%g %g moveto gsave currentpoint translate Sun grestore"    , $x+8 , $y-9                     ); 
    $ps->put(sprintf "%g %g moveto Astro 16 (%s) cshow"                          , $x   , $y-21 , $d->{sunset}     );      
}    
sub put_moon {
    my ($x, $y, $d) = @_;
    $ps->put(sprintf "%g %g moveto Astro 16 (%s) cshow"                          , $x   , $y    , $d->{moonrise}   );   
    $ps->put(sprintf "%g %g moveto gsave currentpoint translate %f Moon grestore", $x+8 , $y-9  , $d->{moon_phase} ); 
    $ps->put(sprintf "%g %g moveto Astro 16 (%s) cshow"                          , $x   , $y-21 , $d->{moonset}    );    
}

sub put_task_list {
    my @tasks = @_;
    
    return unless @tasks;

    # now set the tasks....
    my $x = $ps->{margin} + $ps->{width}/2 + 12;
    my $y = $ps->{ury} - $ps->{head_height} - 20;

    $ps->put("gsave .2 setlinewidth ");
    for my $t ( sort @tasks ) {
        my ($status, $text) = $t =~ m{
           \A Task:    \s+
           \[ (.*) \]  \s+
           (\S.*)
        }x;

        $y -= 11;
        if ( $status eq 'Done' ) {
            $ps->put("$x $y moveto 0 2 rmoveto 1 -2 rlineto 2 5 rlineto stroke");
            $ps->put("$x $y moveto 6 0 rmoveto Tasks ("._ps_proof($text).") show");
        }
        else {
            $status = substr($status,1); # remove number at start
            $ps->put("$x $y 4 4 rectstroke");
            $ps->put("$x $y moveto 6 0 rmoveto Tasks ("._ps_proof($text).") show");
            $ps->put("2 0 rmoveto Notes ("._ps_proof($status).") show");
        }

    }
    $ps->put("grestore");

}
