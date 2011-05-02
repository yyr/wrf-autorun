#!/usr/bin/env perl
#
# Copyright (C) Yagnesh Raghava Yakkala. www.yagnesh.org
#    File: rem_hgt.pl
#  Author: Yagnesh Raghava Yakkala <yagnesh@live.com>
# Created: Monday, May  2 2011
# Licence: GPL v3 or later. You should get a copy from <http://www.gnu.org/licenses/gpl.html>
#

# Description:
#

use strict;
use warnings;

sub compile_ifort {
  `ifort $_[0] -L/usr/local/netcdf/lib -lnetcdf -lm -I/usr/local/netcdf/include/ -free -o $_[0].o` eq 0 and print "...successfully compiled $_[0]"

}

sub run_read_wrf_nc_f {         # edit for each variable
  my ($prog_l,$files_l,$vars_l)=@_;
  for my $i (0 .. @$files_l) {
      foreach my $vars (@$vars_l,) {
	print "./@$prog_l[$i].o -EditData $vars @$files_l[$i] \n";
	`./@$prog_l[$i].o -EditData $vars @$files_l[$i] <<EOF; yes
EOF`;
      }
  }
}

sub remove_height {             #
  my ( $prog, $files, $vars) = @_;
  foreach (@$prog) {
    print "compiling: $_ \n ";
    # compile_ifort($_);
  }
  run_read_wrf_nc_f(\@$prog,\@$files,\@$vars); # array ref
}


# -------------------------------------------
my $PWD = `pwd`;
chomp($PWD);

my @Vars = ("HGT_M",
            "HGT_U",
            "HGT_V"
           );


my @Prog = ("read_wrf_nc_1.f",
            "read_wrf_nc_2.f",
            "read_wrf_nc_3.f"
           );

my @Files = ("geo_em.d01.nc",
             "geo_em.d02.nc",
             "geo_em.d03.nc",
            );


foreach (@Files) {
  print "";
}

remove_height(\@Prog,\@Files,\@Vars,)

  # rem_hgt.pl ends here
