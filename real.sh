#!/bin/bash
#
# Copyright (C) Yagnesh Raghava Yakkala. http://yagnesh.org
#    File: real.sh
# Created: Tuesday, May 10 2011
# Licence: GPL v3 or later.
#

# Description:
if [ ! -f DirNames.sh ]; then
    echo "No ENV file"
    exit 24
else
    . DirNames.sh
fi

ln -s "$met_files_dir/met_em*" .
echo `pwd`

#PBS -q short
#PBS -l ncpus=1
#PBS -N wrf_real.exe
#PBS -o log.real
#PBS -j oe

# one proc is good for now
echo "Running real.sh"
mpirun -np 1 dplace -s1 ./real.exe  2>&1 | tee log.real

# real.sh ends here
