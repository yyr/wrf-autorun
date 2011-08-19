#!/usr/bin/perl -w

use strict;
use warnings;
use YAML::XS;

# sub get_pass {
#   my $pass_file = "~/git/wrf-autorun/passwords.yml";
#   my $passwdref = YAML::XS::LoadFile($pass_file);
#   print "passwd of gmail: " , $passwdref->{'fnl'},"\n";
#}

my ($syscmd, $vn, $opt, $i, @filelist);
my @hours=('00','06','12','18');
my @months;

# my $pswd = 'mypasswd' ; #(@ARGV ? $ARGV[0] : $ENV{RDAPSWD});

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


# "grib1/2006/2006.01/fnl_20060127_18_00",
@filelist = (
            );

for ($i = 0; $i < @filelist; $i++) {
  $syscmd = $opt . $filelist[$i];
  print "$syscmd...\n";
  system($syscmd);
}

system('rm -f auth.dss_ucar_edu');
exit 0;

foreach ( ) {
}
