#!/usr/bin/env perl
#
# Copyright (C) Yagnesh Raghava Yakkala. www.yagnesh.org
#    File: compile_read_wrf_nc.pl
#  Author: Yagnesh Raghava Yakkala <yagnesh@live.com>
# Created: Tuesday, May 10 2011
# Licence: GPL v3 or later. You should get a copy from <http://www.gnu.org/licenses/gpl.html>
#

# Description:
#

use strict;
use warnings;

# ------------------------------------------------
# complie the program in amur with
sub complie_ifort {
  my $scrip_name = $_[0];
  my $ifort_cmd = "ifort";
  my @ifort_flags = qw(-L/usr/local/netcdf/lib -lnetcdf -lm -I/usr/local/netcdf/include -free -o );
  print("\n","compiling..","\n", $ifort_cmd," ", $scrip_name, @ifort_flags,"$scrip_name.o","\n" );
  system($ifort_cmd,$scrip_name, @ifort_flags,"$scrip_name.o" );
}

sub complie_prog {        # compile_prog(@programlist , compiler_name)
  my ($Prog,$complier) = @_;
  if ( $complier eq "ifort") {
    foreach my $x (@$Prog) {
      complie_ifort($x);
    }
  }
}
# ------------------------------------------------

my @Prog = ("read_wrf_nc_1.f",
            "read_wrf_nc_2.f",
            "read_wrf_nc_3.f"
           );

complie_prog(\@Prog,"ifort");

# compile_read_wrf_nc.pl ends here
