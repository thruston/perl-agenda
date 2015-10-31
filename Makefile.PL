use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'Agenda',                     
    VERSION_FROM  => 'lib/Agenda/Profile.pm',      
    AUTHOR        => 'Toby Thurston',              
    EXE_FILES     => [ qw(a-week.pl a-month.pl) ], 
    dist          => {TARFLAGS => '-cvf'},         
);

