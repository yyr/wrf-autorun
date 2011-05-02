#!/bin/bash
. DirNames.env
Date=`date "+%y%m%d%H%M"`     # for logging
ulimit -s unlimited

#PBS -q short
#PBS -l ncpus=32
#PBS -N ${Run_name:-wrf.exe}
#PBS -o log.${Run_nam:-NoName}.$Date.wrf
#PBS -j oe

echo $WRF_run_dir
cd $WRF_run_dir
pwd

# specify the number of cpus 
# mpirun -np 32 dplace -s1 ./wrf.exe 

# run_wrf.sh ends here
