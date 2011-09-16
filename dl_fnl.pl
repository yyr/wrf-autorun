#!/usr/bin/env perl
#
# Copyright (C) Yagnesh Raghava Yakkala. www.yagnesh.org
#    File: dl_fnl.pl
#  Author: Yagnesh Raghava Yakkala <yagnesh@live.com>
# Created: Saturday, April 30 2011
# Licence: GPL v3 or later. <http://www.gnu.org/licenses/gpl.html>
#

# Commentary
# This is originally download from ucar site.
# I just modified to put intial time and end time
#
# PROBLEMS
# right now it works only if start and end times are in the same month

# Code starts here
# ***** CHANGES NEEDED HERE *********
use strict;
my $stime = 20081226;
my $etime = 20081228;
my $email = 'yagneshraghava@gmail.com'; # your registered email ID


# ------- No need to change below -------
my(@filelist);
my $stime_prefix = substr $stime , 0, 6;
my $etime_prefix = substr $etime , 0, 6;
my $url_prefix = "grib1/2008/2008.12/fnl_",;

if ( $stime_prefix != $etime_prefix ) {
  print ("script works only when the month is same\n");
  exit 24;
}

my $sday = substr $stime , 6;
my $eday = substr $etime , 6;


foreach my $d ( $sday .. $eday ) {
  foreach my $h ('00','06','12','18') {
    @filelist[++$#filelist] = "$url_prefix"."$stime_prefix" . "$d" . "_" . "$h" . "_00_c";
  }
}

# --------------------------------------------
my ($syscmd, $vn, $opt, $i);
my $pswd = (@ARGV ? $ARGV[0] : $ENV{RDAPSWD});
if (!$pswd) {
  print "\n Usage: $0 YourPassword\n\n";
  exit 1;
}
open VN, "wget -V |" or die 'cannot find wget';
$vn = (<VN> =~ /^GNU Wget (\d+)\.(\d+)/) ? (100 * $1 + $2) : 109;
close(VN);
$syscmd = ($vn > 109 ? 'wget --no-check-certificate' : 'wget');
$syscmd .= ' -O /dev/null --save-cookies auth.dss_ucar_edu --post-data' .
 "='email=yagneshraghava\@gmail.com&passwd=$pswd&action=login' " .
  'https://dss.ucar.edu/cgi-bin/login';
system($syscmd);
$opt = 'wget -N';
$opt .= ' --no-check-certificate' if($vn > 109);
$opt .= ' --load-cookies auth.dss_ucar_edu ' .
  'http://dss.ucar.edu/dsszone/ds083.2/';

for ($i = 0; $i < @filelist; $i++) {
  $syscmd = $opt . $filelist[$i];
  print "$syscmd...\n";
  system($syscmd);
}
system('rm -f auth.dss_ucar_edu');
exit 0;

# dl_fnl.pl ends here
