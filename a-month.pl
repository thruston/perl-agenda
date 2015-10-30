#! /usr/bin/perl -w
# Toby Thurston -- 15 Dec 2011 
# Make a monthly calendar 

use strict;
use warnings;

use DateTime;
use File::Basename;
use File::Spec;
use Getopt::Std;
use Carp;

use Agenda::Events;
use Agenda::PostScript;
use Agenda::Profile;
use Agenda::Astro qw(Phase);
use Games::Fortune qw(apothegm);

my $opts = { h => 0, c => 0, d => 0, f => 0, m => 0, w => 0, q => 0, p => 'agenda.cfg', l => 0, g => 0, t => 0 };
getopts('cdfghlmqtp:w', $opts);
my $profile     = $opts->{p} ;
my $want_colour = $opts->{c};
my $want_duplex = $opts->{d};
my $want_motto  = $opts->{t};
my $want_weekno = $opts->{w};
my $need_help   = $opts->{h};
my $orientation = $opts->{l} ? 'landscape'
                :              'portrait';
my $moon_mode   = $opts->{f} ? 'full'
                : $opts->{q} ? 'quarters'
                : $opts->{m} ? 'daily'
                : undef;

my ($start_year, $start_month, $months, $months_per_page, @event_files) = @ARGV;


if ( not defined $start_year) {
    my $today = DateTime->today;
    if ($today->month > 6) {
        $start_year = $today->year + 1;
    }
    else {
        $start_year = $today->year;
    }
}

if ( not defined $start_month ) {
    $start_month = 1;
}

if ( not defined $months ) {
    $months = 12;
}

if ( not defined $months_per_page ) {
    $months_per_page = ($orientation eq 'landscape') ? 6 : 3;
}

die <<"USAGE" if ($need_help or not DateTime->new(year=>$start_year, month=>$start_month, day=>1));

 Usage: $0 [options] [start_year [start_month [months_duration [months_per_page [event_files...]]]]]

 Options:  -c       use some colour
           -d       ask the postscript printer to print duplex (default print simplex)
           -m       show phase of the moon on every day
           -q       show moon quarters
           -f       show full moons only
           -l       make landscape output (as opposed to the default portrait)
           -t       add a cheerful tag to the bottom of each page
           -p XXXX  use profile XXXX (defaults to agenda.cfg in this directory)
           -w       show week numbers and days

 start_year defaults to the current year in Jan-June or next year in July-Dec

 start_month defaults to 1 (ie January)

 months defaults to 12

 months_per_page defaults to 12 or 6 depending on the orientation you have chosen

 events-files is a list of one or more files containing events to be printed
 on the calendar.  These files will be read in addition to any defined in your
 chosen agenda profile.  Each file should contain a list of events in the form

     date short event text on a single line

 date should be some form of date or repeating event code supported by Agenda::Date.
 Lines with precise times (ie in this format) will be ignored

     date hh:mm short event text on a single line

 The outout is written to STDOUT

USAGE

# adjust $months up to a multiple of $months_per_page
$months += ($months_per_page - $months%$months_per_page) if $months % $months_per_page;

die "Be reasonable, that's too many months\n" if $months > 500;

my $first_day = DateTime->new(day => 1,year=>$start_year, month=>$start_month);
my $last_day  = $first_day->clone->add(months => $months+1)->subtract(days=>1);

my $cfg = Agenda::Profile->new(file => $profile);
my $f = $cfg->event_files;
if ( defined $f ) {
    push @event_files, ref $f ? @$f : $f;
}
my $cal = Agenda::Events->new(start => $first_day, end => $last_day, file_names => \@event_files); 

# create the output
my $pages = $months / $months_per_page;

my $ps = Agenda::PostScript->new(
                title => "$months month calendar starting $start_month $start_year" ,
               config => $cfg ,
          orientation => $orientation ,
               colour => $want_colour ,
                marks => 1 ,
               margin => 24 , 
                pages => $pages );

$ps->begin_document($want_duplex);

# read things from the config
my $page_margin  = $cfg->page_margin || 0;
my $col_gutter   = $cfg->col_gutter  || 0;
my $grid_col     = $cfg->grid_colour || 'black';

my $text_linedepth = 6.2;
my $text_font = 'Words';

my %weekend_on = ();
for my $d (@{$cfg->weekend_days}) {
    $weekend_on{$d}++;
}

my %active_marks = ();
my %mark_pattern_for = (
    dashed => '[6 6] 0',
    dotted => '[2 2] 0',
);

my $x_offset = -10;
my $first_of_month = $first_day->clone; 
for my $p (1..$pages) {
    $ps->begin_page(label => $p );
    for my $m (1..$months_per_page) {

        my ($x, $y, $wd, $dp);

        $wd = (($ps->{width}-$ps->{margin}-$page_margin)/$months_per_page) - $col_gutter;
        $x = $x_offset + $ps->{margin} + $page_margin + $col_gutter + ($wd+$col_gutter) * ($m-1);

        $dp = $ps->{height} / 32;
        $y = $ps->{height};

        my $point_size = sqrt(($wd*$dp)-$dp/8)/5;
        $point_size = 12 if $point_size > 12;
        $point_size =  6 if $point_size < 6;

        $ps->put("$x 2 add $y moveto");

        # shorten month name if width/mpp < xxx
        # shorten year name if width/mpp < yyy
        my $date_fmt = $wd>65 ? "%B %Y"
                     : $wd>45 ? "%b %Y"
                     :          "%b %y";
        $ps->put(sprintf "/Roman %f selectfont (%s) show", 
                 $point_size+1, 
                 $first_of_month->strftime($date_fmt)
                );

        my $dy = $dp - $point_size + 1.667;
        my $dx = 2;

        my $phase_today = Phase($first_of_month);
        my $phase_tomorrow;

        $y -= 6;

        my $last_of_month = DateTime->last_day_of_month(year => $first_of_month->year, month => $first_of_month->month );
        DAY:
        for (my $d = $first_of_month->clone; $d <= $last_of_month; $d->add(days=>1) ) {
            # move y-position down by box depth 
            $y = $y - $dp;

            # read event details
            my $shade = undef;
            if ( $weekend_on{$d->dow} && $cfg->weekend_style =~ m{ shade \s+ (\S+) }xismo ) {
                $shade = $1;
                # warn $d->dow, $shade, $cfg->weekend_style, "\n";
            }; 
            my @text_lines = ();
            # save the current mark details, so that any changes today take effect from tomorrow
            # This really is generally what you want, trust me. 
            my @marks = ();  
            for (sort keys %active_marks) {
                push @marks, $active_marks{$_}
            }

            if ( @{$cal->events_on($d->mjd)} ) {
                for my $e ( @{$cal->events_on($d->mjd)} ) {
                    if ( my ($tag, $text) = $e->{text} =~ m{ \A (\S+:)\s+(\S.*) \Z }xismo ) {
                        $tag = lc $tag;
                        if ( ! exists $cfg->tag_hash->{$tag} ) {
                            push @text_lines, "black ($tag $text)";
                        }
                        else {
                            my $spec = $cfg->tag_hash->{$tag};
                            if ( $spec =~ m{ colou?r \s+ (\S+) }xismo ) {
                                push @text_lines, "$1 ($text)";
                            }
                            else {
                                push @text_lines, "black ($text)";
                            }
                            if ( $spec =~ m{ shade \s+ (\S+) }xismo ) {
                                $shade = $1;
                            }
                            if ( $spec =~ m{ mark \s+ (\S+) \s+ off }xismo ) {
                                if ( exists $active_marks{$1} ) {
                                    delete $active_marks{$1}
                                }
                            }
                            if ( $spec =~ m{ mark \s+ (\S+) \s+ (solid|wavy|dashed|dotted) \s+ (\S+) }xismo ) {
                                $active_marks{$1} = { type => $2, colour => $3 };
                            }
                        }
                    }
                    else {
                        push @text_lines, "black ($e->{text})";
                    }
                }
            }
            
            # apply background shade
            if (defined $shade) { 
                $ps->put("gsave $shade $x $y $wd $dp rectfill grestore");
            }
            # apply marks
            if (@marks) {
                my $mark_offset = 1.6;
                for my $m (@marks) {
                    $ps->put("gsave $x $wd add $mark_offset sub $y moveto");
                    if ( $m->{type} eq 'wavy' ) {
                        $ps->put("0.4 setlinewidth 2 6 0 $dp wavylineto");
                    } else {
                        $ps->put("2.1 setlinewidth 0 $dp rlineto");
                        if ( defined $mark_pattern_for{$m->{type}} ) {
                            $ps->put(sprintf "%s setdash", $mark_pattern_for{$m->{type}});
                        }
                    }
                    $ps->put("$m->{colour} stroke grestore");
                    $mark_offset += 2;
                }
            }
            
            # write events
            if (@text_lines) {
                my $text_dy = 2.14; 
                $ps->put("gsave $text_font");
                for my $line (@text_lines) {
                    $ps->put(sprintf "%f %f moveto gsave %s show grestore", $x+2, $y+$text_dy, $line);
                    $text_dy += $text_linedepth;
                }
                $ps->put("grestore");
            }

            # write day and date
            $ps->put(sprintf "%f %f moveto /Roman %f selectfont", $x+$dx, $y+$dy, $point_size);
            $ps->put(sprintf "(%s) [%f] xshow", substr($d->strftime("%a"), 0, 1), $point_size);
            $ps->put(sprintf "%f (%s) rshow", $point_size, $d->day);

            if ( $want_weekno && $d->day_of_week == 1) {
                my ($w_year, $w_number) = $d->week;
                my $s = "W$w_number";
                if ($w_year != $d->year) {
                    $s = "$w_year-$s";
                }
                my $w_xpos = $wd-2;
                my $w_point_size = $point_size * 0.8;
                $ps->put("gsave /Roman $w_point_size selectfont $x $y moveto $w_xpos $dy rmoveto 0 ($s) rshow grestore");
            }


            # show moon?
            if ( $moon_mode ) { 
                $phase_tomorrow = Phase($d->clone->add(days => 1));
                
                my $show_moon = 1;
                if ($moon_mode eq 'full') {
                    $show_moon = 0 unless $phase_today <= 0.5 && 0.5 < $phase_tomorrow;
                }
                elsif ($moon_mode eq 'quarters') {
                    $show_moon = 0 unless $phase_today < 0.25 && 0.25 < $phase_tomorrow
                                       or $phase_today < 0.50 && 0.50 < $phase_tomorrow
                                       or $phase_today < 0.75 && 0.75 < $phase_tomorrow
                                       or $phase_today > $phase_tomorrow;
                }
                if ($show_moon) {
                    my $moon_xpos = $wd-10;
                    my $moon_ypos = $dp/2;
                    $ps->put("gsave $x $y moveto $moon_xpos $moon_ypos rmoveto currentpoint translate $phase_today Moon grestore");
                }
                $phase_today = $phase_tomorrow;
            }

            # draw box
            $ps->put("gsave $x $y $wd $dp $grid_col rectstroke grestore");

        }

        if ( $want_motto && $m > 1 && $last_of_month->day < 31 ) {
            my @motto_lines = apothegm();
            my $leading = 7;
            $x+=2;
            for (@motto_lines) {
                $y -= $leading;
                $ps->put("$x $y moveto Notes 0 (");
                $ps->put_proof($_);
                $ps->put(") show");
            }
        }
        
        $first_of_month->add(months=>1);

    }
    $ps->end_page;
}
$ps->end_document;
$ps->print;
exit;
