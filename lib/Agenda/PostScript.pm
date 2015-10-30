package Agenda::PostScript;

use strict;
use Carp;
use DateTime;

my $VERSION = '0.3';
my $COPYRIGHT = '(c) Toby Thurston 2002--2012';

use constant VERBOSE => 0;

use constant ROMAN  => 'Palatino-Roman';
use constant ITALIC => 'Palatino-Italic';

=head1 NAME

Agenda::PostScript - some routines to help you create PostScript calendars.

=head1 SYNOPSIS

  use Agenda::PostScript;

=head1 DESCRIPTION


=head1 FUNCTIONS

No functions are exported by default.

=head1 SEE ALSO

=head1 AUTHOR

Toby Thurston -- 16 Nov 2011 

toby@cpan.org

=cut

our %paper_size = (
        a3      => [ 843, 1192 ] ,
        a4      => [ 596, 843  ] ,
        a5      => [ 421, 596  ] ,
        letter  => [ 612, 792 ]);


sub new {
    my $that  = shift;
    my $class = ref($that) || $that;
    my $self  = {
        config      => undef,
        margin      => 14 ,
        orientation => 'portrait' ,
        title       => 'Agenda::Postscript output' ,
        motto       => 0 ,
        pages       => 1 ,
        marks       => 0 ,
        @_               , # override with user values....
        _lines      => undef,
        _folio      => 0,
    };

    croak "Can't construct a Agenda::PostScript object without a profile\n"
                                                            unless defined $self->{config};

    if ( $self->{motto} ) {
        use Games::Fortune qw(apothegm fortune);
    }

    $self->{llx} = $self->{margin};
    $self->{lly} = $self->{margin};

    my $paper_name = lc $self->{config}->paper_size;

    if    ( lc $self->{orientation} eq 'portrait' ) {
        $self->{urx} = $paper_size{$paper_name}[0] - $self->{margin};
        $self->{ury} = $paper_size{$paper_name}[1] - $self->{margin};
    }
    elsif ( lc $self->{orientation} eq 'landscape' ) {
        $self->{urx} = $paper_size{$paper_name}[1] - $self->{margin};
        $self->{ury} = $paper_size{$paper_name}[0] - $self->{margin};
    }
    else {
        croak "$self->{orientation} should be 'landscape' or 'portrait'"
    }

    $self->{width}       = $self->{urx};# $self->{margin};
    $self->{height}      = $self->{ury};# - $self->{margin};
    $self->{head_height} = 16;

    $self->{bbox} = "$self->{llx} $self->{lly} $self->{urx} $self->{ury}";

    bless $self, $class;
    return $self;
}

sub _add_up_bb { # for setpagedevice
    my ($a, $b, $c, $d) = split /\s+/, $_[0];
    sprintf "[%d %d]", $a+$c, $b+$d;
}

sub begin_document {
    my $self = shift;
    my $duplex = shift;

    $self->put("%!PS-Adobe-3.0");
    $self->put("%%Creator: Agenda::PostScript Version $VERSION");
    $self->put("%%Copyright: $COPYRIGHT");
    $self->put("%%Title: ($self->{title})");
    $self->put("%%CreationDate: (" . DateTime->now .')');
    $self->put("%%BoundingBox: $self->{bbox}");
    $self->put("%%Pages: $self->{pages}");
    $self->put("%%EndComments");

    if ( $duplex ) {
        if ( $self->{orientation} eq 'portrait' ) {
            $self->put('<< /Duplex true ');
        } else {
            $self->put('<< /Duplex true /Tumble true ');
        }
    } else {
        $self->put('<< /Duplex false');
    }
    $self->put('/MediaType (plain) /PageSize ', _add_up_bb($self->{bbox}) ,'>> setpagedevice');

    $self->put("%%BeginSetup");

    $self->put('/' . ROMAN . ' findfont');
    $self->put("dup length dict begin { 1 index /FID ne {def} {pop pop} ifelse } forall");
    $self->put("/Encoding ISOLatin1Encoding def");
    $self->put("currentdict end /Roman exch definefont pop");

    $self->put('/' . ITALIC . ' findfont');
    $self->put("dup length dict begin { 1 index /FID ne {def} {pop pop} ifelse } forall");
    $self->put("/Encoding ISOLatin1Encoding def");
    $self->put("currentdict end /Italic exch definefont pop");

    $self->put("/Heading { /Roman  12 selectfont } def");
    $self->put("/Numbers { /Roman  12 selectfont } def");
    $self->put("/Holiday { /Italic 10 selectfont } def");
    $self->put("/Tasks   { /Roman   8 selectfont } def");
    $self->put("/Words   { /Roman 5.2 selectfont } def");
    $self->put("/Astro   { /Roman 4.5 selectfont } def");
    $self->put("/Notes   { /Italic  5 selectfont } def");
    $self->put("/Tiny    { /Roman   4 selectfont } def");

    $self->put("/alice_blue               { 0.9412  0.9725  1.0000 setrgbcolor } def");
    $self->put("/antique_white            { 0.9804  0.9216  0.8431 setrgbcolor } def");
    $self->put("/aquamarine               { 0.4980  1.0000  0.8314 setrgbcolor } def");
    $self->put("/azure                    { 0.9412  1.0000  1.0000 setrgbcolor } def");
    $self->put("/beige                    { 0.9608  0.9608  0.8627 setrgbcolor } def");
    $self->put("/bisque                   { 1.0000  0.8941  0.7686 setrgbcolor } def");
    $self->put("/black                    { 0.0000  0.0000  0.0000 setrgbcolor } def");
    $self->put("/blanched_almond          { 1.0000  0.9216  0.8039 setrgbcolor } def");
    $self->put("/blue                     { 0.0000  0.0000  1.0000 setrgbcolor } def");
    $self->put("/blue_violet              { 0.5412  0.1686  0.8863 setrgbcolor } def");
    $self->put("/brown                    { 0.6471  0.1647  0.1647 setrgbcolor } def");
    $self->put("/burlywood                { 1.0000  0.8275  0.6078 setrgbcolor } def");
    $self->put("/cadet_blue               { 0.3725  0.6196  0.6275 setrgbcolor } def");
    $self->put("/chartreuse               { 0.4980  1.0000  0.0000 setrgbcolor } def");
    $self->put("/chocolate                { 0.8235  0.4118  0.1176 setrgbcolor } def");
    $self->put("/coral                    { 1.0000  0.4471  0.3373 setrgbcolor } def");
    $self->put("/cornflower_blue          { 0.3922  0.5843  0.9294 setrgbcolor } def");
    $self->put("/cornsilk                 { 1.0000  0.9725  0.8627 setrgbcolor } def");
    $self->put("/cyan                     { 0.0000  1.0000  1.0000 setrgbcolor } def");
    $self->put("/dark_blue                { 0.0000  0.0000  0.5451 setrgbcolor } def");
    $self->put("/dark_cyan                { 0.0000  0.5451  0.5451 setrgbcolor } def");
    $self->put("/dark_goldenrod           { 0.7216  0.5255  0.0431 setrgbcolor } def");
    $self->put("/dark_green               { 0.0000  0.3922  0.0000 setrgbcolor } def");
    $self->put("/dark_grey                { 0.6627  0.6627  0.6627 setrgbcolor } def");
    $self->put("/dark_khaki               { 0.7412  0.7176  0.4196 setrgbcolor } def");
    $self->put("/dark_magenta             { 0.5451  0.0000  0.5451 setrgbcolor } def");
    $self->put("/dark_olive_green         { 0.3333  0.4196  0.1843 setrgbcolor } def");
    $self->put("/dark_orange              { 1.0000  0.5490  0.0000 setrgbcolor } def");
    $self->put("/dark_orchid              { 0.6000  0.1961  0.8000 setrgbcolor } def");
    $self->put("/dark_red                 { 0.5451  0.0000  0.0000 setrgbcolor } def");
    $self->put("/dark_salmon              { 0.9137  0.5882  0.4784 setrgbcolor } def");
    $self->put("/dark_sea_green           { 0.5608  0.7373  0.5608 setrgbcolor } def");
    $self->put("/dark_slate_blue          { 0.2824  0.2392  0.5451 setrgbcolor } def");
    $self->put("/dark_slate_grey          { 0.1843  0.3098  0.3098 setrgbcolor } def");
    $self->put("/dark_turquoise           { 0.0000  0.8078  0.8196 setrgbcolor } def");
    $self->put("/dark_violet              { 0.5804  0.0000  0.8275 setrgbcolor } def");
    $self->put("/deep_pink                { 1.0000  0.0784  0.5765 setrgbcolor } def");
    $self->put("/deep_sky_blue            { 0.0000  0.7490  1.0000 setrgbcolor } def");
    $self->put("/dim_grey                 { 0.4118  0.4118  0.4118 setrgbcolor } def");
    $self->put("/dodger_blue              { 0.1176  0.5647  1.0000 setrgbcolor } def");
    $self->put("/eton_blue                { 0.5882  0.7843  0.6353 setrgbcolor } def");
    $self->put("/firebrick                { 0.6980  0.1333  0.1333 setrgbcolor } def");
    $self->put("/floral_white             { 1.0000  0.9804  0.9412 setrgbcolor } def");
    $self->put("/forest_green             { 0.1333  0.5451  0.1333 setrgbcolor } def");
    $self->put("/gainsboro                { 0.8627  0.8627  0.8627 setrgbcolor } def");
    $self->put("/ghost_white              { 0.9725  0.9725  1.0000 setrgbcolor } def");
    $self->put("/gold                     { 1.0000  0.8431  0.0000 setrgbcolor } def");
    $self->put("/goldenrod                { 0.8549  0.6471  0.1255 setrgbcolor } def");
    $self->put("/green                    { 0.0000  1.0000  0.0000 setrgbcolor } def");
    $self->put("/green_yellow             { 0.6784  1.0000  0.1843 setrgbcolor } def");
    $self->put("/dark_grey                { 0.0118  0.0118  0.0118 setrgbcolor } def");
    $self->put("/grey                     { 0.7451  0.7451  0.7451 setrgbcolor } def");
    $self->put("/honeydew                 { 0.9412  1.0000  0.9412 setrgbcolor } def");
    $self->put("/hot_pink                 { 1.0000  0.4118  0.7059 setrgbcolor } def");
    $self->put("/indian_red               { 0.8039  0.3608  0.3608 setrgbcolor } def");
    $self->put("/ivory                    { 1.0000  1.0000  0.9412 setrgbcolor } def");
    $self->put("/khaki                    { 0.9412  0.9020  0.5490 setrgbcolor } def");
    $self->put("/khaki                    { 1.0000  0.9647  0.5608 setrgbcolor } def");
    $self->put("/lavender                 { 0.9020  0.9020  0.9804 setrgbcolor } def");
    $self->put("/lavender_blush           { 1.0000  0.9412  0.9608 setrgbcolor } def");
    $self->put("/lawn_green               { 0.4863  0.9882  0.0000 setrgbcolor } def");
    $self->put("/lemon_chiffon            { 1.0000  0.9804  0.8039 setrgbcolor } def");
    $self->put("/light_blue               { 0.6784  0.8471  0.9020 setrgbcolor } def");
    $self->put("/light_coral              { 0.9412  0.5020  0.5020 setrgbcolor } def");
    $self->put("/light_cyan               { 0.8784  1.0000  1.0000 setrgbcolor } def");
    $self->put("/light_goldenrod          { 0.9333  0.8667  0.5098 setrgbcolor } def");
    $self->put("/light_goldenrod_yellow   { 0.9804  0.9804  0.8235 setrgbcolor } def");
    $self->put("/light_green              { 0.5647  0.9333  0.5647 setrgbcolor } def");
    $self->put("/light_grey               { 0.8275  0.8275  0.8275 setrgbcolor } def");
    $self->put("/light_pink               { 1.0000  0.7137  0.7569 setrgbcolor } def");
    $self->put("/light_salmon             { 1.0000  0.6275  0.4784 setrgbcolor } def");
    $self->put("/light_sea_green          { 0.1255  0.6980  0.6667 setrgbcolor } def");
    $self->put("/light_sky_blue           { 0.5294  0.8078  0.9804 setrgbcolor } def");
    $self->put("/light_slate_blue         { 0.5176  0.4392  1.0000 setrgbcolor } def");
    $self->put("/light_slate_grey         { 0.4667  0.5333  0.6000 setrgbcolor } def");
    $self->put("/light_steel_blue         { 0.6902  0.7686  0.8706 setrgbcolor } def");
    $self->put("/light_yellow             { 1.0000  1.0000  0.8784 setrgbcolor } def");
    $self->put("/lime_green               { 0.1961  0.8039  0.1961 setrgbcolor } def");
    $self->put("/linen                    { 0.9804  0.9412  0.9020 setrgbcolor } def");
    $self->put("/magenta                  { 1.0000  0.0000  1.0000 setrgbcolor } def");
    $self->put("/maroon                   { 0.6510  0.1608  0.2235 setrgbcolor } def");
    $self->put("/medium_aquamarine        { 0.4000  0.8039  0.6667 setrgbcolor } def");
    $self->put("/medium_blue              { 0.0000  0.0000  0.8039 setrgbcolor } def");
    $self->put("/medium_orchid            { 0.7294  0.3333  0.8275 setrgbcolor } def");
    $self->put("/medium_purple            { 0.5765  0.4392  0.8588 setrgbcolor } def");
    $self->put("/medium_sea_green         { 0.2353  0.7020  0.4431 setrgbcolor } def");
    $self->put("/medium_slate_blue        { 0.4824  0.4078  0.9333 setrgbcolor } def");
    $self->put("/medium_spring_green      { 0.0000  0.9804  0.6039 setrgbcolor } def");
    $self->put("/medium_turquoise         { 0.2824  0.8196  0.8000 setrgbcolor } def");
    $self->put("/medium_violet_red        { 0.7804  0.0824  0.5216 setrgbcolor } def");
    $self->put("/midnight_blue            { 0.0980  0.0980  0.4392 setrgbcolor } def");
    $self->put("/mint_cream               { 0.9608  1.0000  0.9804 setrgbcolor } def");
    $self->put("/misty_rose               { 1.0000  0.8941  0.8824 setrgbcolor } def");
    $self->put("/moccasin                 { 1.0000  0.8941  0.7098 setrgbcolor } def");
    $self->put("/navajo_white             { 1.0000  0.8706  0.6784 setrgbcolor } def");
    $self->put("/navy                     { 0.0000  0.0000  0.5020 setrgbcolor } def");
    $self->put("/navy_blue                { 0.0000  0.0000  0.5020 setrgbcolor } def");
    $self->put("/old_lace                 { 0.9922  0.9608  0.9020 setrgbcolor } def");
    $self->put("/olive_drab               { 0.4196  0.5569  0.1373 setrgbcolor } def");
    $self->put("/orange                   { 1.0000  0.6471  0.0000 setrgbcolor } def");
    $self->put("/orange_red               { 1.0000  0.2706  0.0000 setrgbcolor } def");
    $self->put("/orchid                   { 0.8549  0.4392  0.8392 setrgbcolor } def");
    $self->put("/pale_goldenrod           { 0.9333  0.9098  0.6667 setrgbcolor } def");
    $self->put("/pale_green               { 0.5961  0.9843  0.5961 setrgbcolor } def");
    $self->put("/pale_turquoise           { 0.6863  0.9333  0.9333 setrgbcolor } def");
    $self->put("/pale_violet_red          { 0.8588  0.4392  0.5765 setrgbcolor } def");
    $self->put("/papaya_whip              { 1.0000  0.9373  0.8353 setrgbcolor } def");
    $self->put("/peach_puff               { 1.0000  0.8549  0.7255 setrgbcolor } def");
    $self->put("/peru                     { 0.8039  0.5216  0.2471 setrgbcolor } def");
    $self->put("/pink                     { 1.0000  0.7098  0.7725 setrgbcolor } def");
    $self->put("/plum                     { 1.0000  0.7333  1.0000 setrgbcolor } def");
    $self->put("/powder_blue              { 0.6902  0.8784  0.9020 setrgbcolor } def");
    $self->put("/purple                   { 0.6078  0.1882  1.0000 setrgbcolor } def");
    $self->put("/red                      { 1.0000  0.0000  0.0000 setrgbcolor } def");
    $self->put("/rosy_brown               { 0.7373  0.5608  0.5608 setrgbcolor } def");
    $self->put("/royal_blue               { 0.2549  0.4118  0.8824 setrgbcolor } def");
    $self->put("/saddle_brown             { 0.5451  0.2706  0.0745 setrgbcolor } def");
    $self->put("/salmon                   { 1.0000  0.5490  0.4118 setrgbcolor } def");
    $self->put("/sandy_brown              { 0.9569  0.6431  0.3765 setrgbcolor } def");
    $self->put("/sea_green                { 0.1804  0.5451  0.3412 setrgbcolor } def");
    $self->put("/seashell                 { 1.0000  0.9608  0.9333 setrgbcolor } def");
    $self->put("/sienna                   { 1.0000  0.5098  0.2784 setrgbcolor } def");
    $self->put("/sky_blue                 { 0.5294  0.8078  0.9216 setrgbcolor } def");
    $self->put("/slate_blue               { 0.4157  0.3529  0.8039 setrgbcolor } def");
    $self->put("/slate_grey               { 0.4392  0.5020  0.5647 setrgbcolor } def");
    $self->put("/snow                     { 1.0000  0.9804  0.9804 setrgbcolor } def");
    $self->put("/spring_green             { 0.0000  1.0000  0.4980 setrgbcolor } def");
    $self->put("/steel_blue               { 0.2745  0.5098  0.7059 setrgbcolor } def");
    $self->put("/tan                      { 1.0000  0.6471  0.3098 setrgbcolor } def");
    $self->put("/thistle                  { 0.8471  0.7490  0.8471 setrgbcolor } def");
    $self->put("/tomato                   { 1.0000  0.3882  0.2784 setrgbcolor } def");
    $self->put("/turquoise                { 0.2510  0.8784  0.8157 setrgbcolor } def");
    $self->put("/violet                   { 0.9333  0.5098  0.9333 setrgbcolor } def");
    $self->put("/violet_red               { 0.8157  0.1255  0.5647 setrgbcolor } def");
    $self->put("/wheat                    { 0.9608  0.8706  0.7020 setrgbcolor } def");
    $self->put("/white                    { 1.0000  1.0000  1.0000 setrgbcolor } def");
    $self->put("/white_smoke              { 0.9608  0.9608  0.9608 setrgbcolor } def");
    $self->put("/yellow                   { 1.0000  1.0000  0.0000 setrgbcolor } def");
    $self->put("/yellow_green             { 0.6039  0.8039  0.1961 setrgbcolor } def");

    $self->put("/Sun { newpath gsave  0 0 5 0 360 arc");
    $self->put("gsave 1 1 .8 setrgbcolor fill grestore");
    $self->put(".2 setlinewidth stroke");
    $self->put("0 22.5 360 { rotate 6 0 moveto 8 0 lineto stroke } for grestore} bind def");

    $self->put("/Moon { /phase exch def");
    $self->put("  phase 0.5 lt");
    $self->put("    { /flip -1 def /r 160 def /s {-1 phase 4 mul add } def }");
    $self->put("    { /flip  1 def /r 200 def /s { 3 phase 4 mul sub } def }");
    $self->put("  ifelse");
    $self->put("  newpath");
    $self->put("  gsave 0 0 6 0 360 arc .4 setgray fill grestore");
    $self->put("  gsave r rotate");
    $self->put("    0 0 6 flip -90 mul flip 90 mul arc");
    $self->put("    s 1 scale");
    $self->put("    0 0 6 flip 90 mul flip -90 mul arc");
    $self->put("    1 setgray fill");
    $self->put("  grestore");
    $self->put("  gsave 0 0 6 0 360 arc .2 setlinewidth stroke");
    $self->put("grestore} bind def");

    $self->put("/rshow { /s exch def s stringwidth pop sub 0 rmoveto s show } def");
    $self->put("/rrshow { /t exch def /s exch def s stringwidth pop sub t stringwidth pop sub 18 sub 0 rmoveto s show /space glyphshow /ellipsis glyphshow /space glyphshow t show } def");
    $self->put("/cshow { /s exch def s stringwidth pop sub 2 div dup 0 exch 0 rmoveto s show rmoveto } def");
    $self->put("/splitshow { /t exch def /s exch def s show s stringwidth pop t stringwidth pop add sub 0 rmoveto t show} def");

    $self->put("/wavylineto { 5 dict begin /y exch def /x exch def /freq exch def /pitch exch def /s { x x mul y y mul add sqrt 3 div freq div } bind def y x atan rotate freq { s pitch neg s 2 mul pitch s 3 mul 0 rcurveto } repeat y x atan neg rotate end } bind def ");

    $self->put("/travelineto { 3 dict begin");
    $self->put("  /dist exch def");
    $self->put("  /freq { dist 2 sub 2.4 div 1 sub cvi } bind def");
    $self->put("  /tail { dist 2 sub freq 2.4 mul sub } bind def");
    $self->put("  -90 rotate freq { 0.8 2 neg 1.6 2 2.4 0 rcurveto } repeat");
    $self->put("  tail 4 div 1 neg tail 4 div 0 tail 0 rcurveto 2 0 rmoveto");
    $self->put("  -2 .5 rlineto 0 -1 rlineto 2 .5 rlineto 90 rotate");
    $self->put("end } bind def");

    $self->put("%%EndSetup");
}

sub begin_page {
    my $self = shift;

    $self->{_folio}++;
    my $attributes = {
        label => '',
        @_
    };
    $self->put("%%Page: $attributes->{label} $self->{_folio}");
    $self->put('%%BeginPageSetup');
    $self->put("/pgsave save def");
    $self->put("%%EndPageSetup");
}


sub end_page {
    my $self = shift;

    if ( defined $self->{config}->to_do_file && open my $f, '<', $self->{config}->to_do_file ) {
        my @lines = <$f>;
        close $f;
        chomp(@lines);
        my $x = $self->{width}/2 + 52;
        my $y = $self->{height} - 30;
        for ( sort @lines ) {
            $y -= 10;
            $self->put("$x 8 sub $y 6 6 rectstroke $x $y moveto Words ($_) show");
        }
    }

    $self->put("pgsave restore");
    $self->put("showpage");
}
sub end_document {
    my $self = shift;
    $self->put("%%EOF");
}
sub put_proof {
    my $self = shift;
    my @strings = @_;
    $self->put(_ps_proof(@strings));
}
sub show_chopped {
    my $self = shift;
    my $s = shift;
    my $max_chars = shift;
    if ( length($s) <= $max_chars+2 ) {
        $self->put('(' . _ps_proof($s) . ') show')
    } else {
        $self->put('(' . _ps_proof(substr($s,0,$max_chars)) . ') show /ellipsis glyphshow')
    }
}

sub put {
    my $self = shift;
    push @{$self->{_lines}}, @_;
}

sub _ps_proof {
    for (@_) {  # escape parens and escapes
        s/([\(\)\\])/\\$1/g;
    }
    return "@_";
}



sub _h2hhmm {
    my $t = shift;
  # return '99:99' unless $t =~ /^\d+.\d\d$/;
    return sprintf '%02d:%02d', int($t), $t*100%100; # yes 100 not 60
}


sub print {
    my $self = shift;
    local $, = "\n";
    print @{$self->{_lines}};
}

1;
