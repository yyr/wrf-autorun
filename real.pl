#!/usr/bin/env perl
#
# Copyright (C) Yagnesh Raghava Yakkala. www.yagnesh.org
#    File: real.pl
#  Author: Yagnesh Raghava Yakkala <yagnesh@live.com>
# Created: Monday, May  2 2011
# Licence: GPL v3 or later. You should get a copy from <http://www.gnu.org/licenses/gpl.html>
#

# Description:
#

use strict;
use warnings;

my $Real.sh = "real.sh";	# real.sh going to be the script to be run if needed parallel

my $Pwd = $ENV{PWD};
print "$Pwd,\n";

# hard key command that will go into generated script
my $shebang = '#!/bin/bash';
my $job_attributes = <<EOF;
#PBS -q short
#PBS -l ncpus=1
#PBS -N ${Run_name:-wrf.exe}
#PBS -o log.${Run_nam:-NoName}.$Date.wrf
#PBS -j oe
EOF

print $shebang, "\n",


# . DirNames.env
#   ulimit -s unlimited
#   ;
# print localtime(time);

# echo $WRF_run_dir
#   cd $WRF_run_dir
#   pwd

#   # specify the number of cpus
#   # mpirun -np 32 dplace -s1 ./wrf.exe

#   # run_wrf.sh ends here

  # real.pl ends here
