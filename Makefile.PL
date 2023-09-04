use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'Agenda',                     
    VERSION_FROM  => 'lib/Agenda/Profile.pm',      
    AUTHOR        => 'Toby Thurston',              
    EXE_FILES     => [ qw(a-week.pl a-month.pl) ], 
    dist          => {TARFLAGS => '-cvf'},         
    PREREQ_PM => {
        'DateTime::Set' => 0.3900,
        'DateTime::Format::Epoch' => 0.16,
    }
);

