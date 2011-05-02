#!/bin/bash

. DirNames.env

#PBS -q short
#PBS -l ncpus=4
#PBS -N wrf_real.exe
#PBS -o log.real
#PBS -j oe

cd /home/yagnesh/WRFMPI/WRFV3/test/em_20081226

# one proc is good for now
mpirun -np 1 dplace -s1 ./real.exe  > real.`date "+%y%m%d%H%M"`.log


# run_real.sh ends here
