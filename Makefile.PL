#!/usr/bin/perl 
# Toby Thurston --- 2011-11-28
#
# 

use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME    => 'Agenda',
    VERSION => 0.1,
    AUTHOR  => 'Toby Thurston',
    EXE_FILES => [ qw(a-week.pl a-month.pl) ],
);


