#!/bin/bash
#
# Copyright (C) Yagnesh Raghava Yakkala. www.yagnesh.org
#    File: real.sh
#  Author: Yagnesh Raghava Yakkala <yagnesh@live.com>
# Created: Tuesday, May 10 2011
# Licence: GPL v3 or later. You should get a copy from <http://www.gnu.org/licenses/gpl.html>
#

# Description: 
if [ ! DirNames.sh ]; then
    echo "No ENV file"
    echo "trying to contine..."
else
    . DirNames.sh
fi

ln -sf $met_files_dir/met_em* .
echo `pwd`

#PBS -q short
#PBS -l ncpus=1
#PBS -N wrf_real.exe
#PBS -o log.real
#PBS -j oe

# one proc is good for now
echo Running real.sh
mpirun -np 1 dplace -s1 ./real.exe 2>&1 | tee log.real 

# real.sh ends here
