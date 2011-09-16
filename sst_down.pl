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

my $stime = 20081223;
my $etime = 20081225;

# ------- No need to change below -------
my(@filelist);
my $stime_prefix = substr $stime , 0, 6;
my $etime_prefix = substr $etime , 0, 6;
my $url_prefix = "ftp://polar.ncep.noaa.gov/pub/history/sst/rtg_sst_grb_0.5.";

if ( $stime_prefix != $etime_prefix ) {
  print ("script works only when the month is same\n");
  exit 24;
}

my $sday = substr $stime , 6;
my $eday = substr $etime , 6;


foreach my $d ( $sday .. $eday ) {
    $filelist[++$#filelist] = "$url_prefix" . "$stime_prefix" . "$d";
}

# print(@filelist, "\n");

# --------------------------------
sub wget_down {
  my ($url) = @_;
  my $er_log_file = "log.error.$$";
  print "started downloading.. $url\n";
  my $er_code = system("wget", "-N", "--timeout=90","$url");
  if ($er_code != 0 ) {
    open(my $fh_e, ">>",$er_log_file) or die "cant open logfile $!";
    print $fh_e  "$url";        # put in log for later downloading
  } else {
    print "finished downloading.. $url\n";
  }
}


# body ---------------
foreach my $file (@filelist) {
        wget_down($file);
}

# sst_down.pl ends here
