#!/usr/bin/env perl
#
# Copyright (C) Yagnesh Raghava Yakkala. www.yagnesh.org
#    File: change-option.pl
#  Author: Yagnesh Raghava Yakkala <yagnesh@live.com>
# Created: Monday, May  2 2011
# Licence: GPL v3 or later. You should get a copy from <http://www.gnu.org/licenses/gpl.html>
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
my $bak = `date "+%y%m%d%H%M%S"`;
chomp($bak);

copy("$Conffile","$Conffile.$bak") or die "cann't backup: $!";
open(my $IN ,"<","$Conffile.$bak") or die "cannot open $Conffile: $!";

open(my $OUT, ">", $Conffile) or die "cannot open $Conffile: $!";

while (<$IN>) {
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
