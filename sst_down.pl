#!/usr/bin/env perl
#
# Copyright (C) Yagnesh Raghava Yakkala. www.yagnesh.org
#    File: sst_down.pl
#  Author: Yagnesh Raghava Yakkala <yagnesh@live.com>
# Created: Tuesday, July 26 2011
# Licence: GPL v3 or later. You should get a copy from <http://www.gnu.org/licenses/gpl.html>
#

# Description:
# this is modified to download fnl data for given start date and end date

use strict;
use warnings;

my $url_prefix = "ftp://polar.ncep.noaa.gov/pub/history/sst/rtg_sst_grb_0.5.";

my @year;
my @month= ('01','02','03','04','05','06','07','08','09','10','11','12');

# --------------------------------
sub wget_down {
  my ($url) = @_;
  my $er_log_file = "log.error.$$";
  print "started downloading.. $url\n";
  my $er_code = system("wget", "--timeout=90","$url");
  if ($er_code != 0 ) {
    open(my $fh_e, ">>",$er_log_file) or die "cant open logfile $!";
    print $fh_e  "$url";        # put in log for later downloading
  } else {
    print "finished downloading.. $url\n";
  }
}


# body ---------------
foreach my $y (@year) {
  foreach my $m (@month) {
    foreach my $d (1 .. Days_in_Month($y,$m)) {
      if ($d < 10) {
        $d="0$d";
      }
      foreach my $t ('00','06','12','18') {
        wget_down("$url_head/$y/$y$m/$y$m$d/CFSR_$y$m$d$t.grb2");
      }
    }
  }
}

# sst_down.pl ends here
