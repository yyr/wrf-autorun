#!/bin/bash

. DirNames.env

#PBS -q short
#PBS -l ncpus=1
#PBS -N wrf_real.exe
#PBS -o log.real
#PBS -j oe

echo $WRF_run_dir
cd  $WRF_run_dir

# one proc is good for now
mpirun -np 1 dplace -s1 ./real.exe  > real.`date "+%y%m%d%H%M"`.log


# run_real.sh ends here
