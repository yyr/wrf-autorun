#!/usr/bin/env perl
#
# Copyright (C) Yagnesh Raghava Yakkala. http://yagnesh.org
#    File: change-option.pl
# Created: Monday, May  2 2011
# Licence: GPL v3 or later.
#

# Description:
#

use strict;
use warnings;
use File::Copy;

if (@ARGV != 3) {
  print "Usage: $0 <input file> <option> <value>\n";
  exit;
}

(my $Conffile, my $Option, my $Val) = @ARGV;

open(my $IN ,"<","$Conffile") or die "cannot open $Conffile: $!";
my @contents = <$IN>;

open(my $OUT, ">", $Conffile) or die "cannot open $Conffile: $!";

foreach (@contents) {
  chomp();
  if (/($Option.*)=(.*)/) {
    $_ =~ s/$2/ $Val,/;
    # print $_,"\n";
    print $OUT $_ ,"\n";
  } else {
    # print $_,"\n";
    print $OUT $_, "\n";
  }
}

close($IN);
close($OUT);

# change-option.pl ends here
