#!/usr/bin/env perl
#
# Copyright (C) Yagnesh Raghava Yakkala. http://yagnesh.org
#    File: dl_fnl.pl
# Created: Saturday, April 30 2011
# Licence: GPL v3 or later.
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
use warnings;

my $stime = 20080214;
my $etime = 20080216;
my $email = 'yagneshraghava@gmail.com'; # your registered email ID

# ------- No need to change below -------
my $y =  substr $stime , 0, 4;
my $smon =  substr $stime , 4, 2;
my $emon =  substr $etime , 4, 2;

my(@filelist);
my $stime_prefix = substr $stime , 0, 6;
my $etime_prefix = substr $etime , 0, 6;

if ( $stime_prefix != $etime_prefix ) {
    print ("script works only when the month is same\n");
    exit 24;
}

my $sday = substr $stime , 6;
my $eday = substr $etime , 6;


foreach my $m ($smon .. $emon) {
    my $url_prefix = "grib2/$y/${y}.${m}/fnl_";
    foreach my $d ( $sday .. $eday ) {
        foreach my $h ('00','06','12','18') {
            $filelist[++$#filelist] = "$url_prefix"."$stime_prefix" . "$d" . "_" . "$h" . "_00" . ".grib2";
        }
    }

}

# foreach my $file (@filelist) {
#     print($file);
# }
# exit

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
$syscmd .= ' -O /dev/null --save-cookies auth.rda_ucar_edu --post-data' .
    "=\"email=$email&passwd=$pswd&action=login\" " .
    'https://rda.ucar.edu/cgi-bin/login';
system($syscmd);
$opt = 'wget -N';
$opt .= ' --no-check-certificate' if($vn > 109);
$opt .= ' --load-cookies auth.rda_ucar_edu ' .
    'http://rda.ucar.edu/data/ds083.2/';

for ($i = 0; $i < @filelist; $i++) {
    $syscmd = $opt . $filelist[$i];
    print "$syscmd...\n";
    system($syscmd);
}
system('rm -f auth.rda_ucar_edu');
exit 0;

# dl_fnl.pl ends here
