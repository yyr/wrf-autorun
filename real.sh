#!/bin/bash
#
# Copyright (C) Yagnesh Raghava Yakkala. http://yagnesh.org
#    File: real.sh
# Created: Tuesday, May 10 2011
# Licence: GPL v3 or later.
#

real_exe="real.exe.gcc"

# Description:
# make sure env file is there
envf_name=dirnames.sh

if [ ! $envf_name ]; then
    echo "No ENV file"
    exit 24
else
    . $envf_name
fi

#ln -s "$met_files_dir/met_em*" .
echo `pwd`
nocpu=10

ulimit -s unlimited
# one proc is good for now
echo "Running real.sh"
mpirun -np $nocpu dplace -s1 $wrf_bin_dir/$real_exe  2>&1 | tee log.real

# real.sh ends here
