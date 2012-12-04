#!/bin/bash
#
# Copyright (C) Yagnesh Raghava Yakkala. http://yagnesh.org
#    File: wrf-job.sh
# Created: Tuesday, May 10 2011
# Licence: GPL v3 or later.
#

# Description:
# create job script

envf_name=dirnames.sh

function usage() {		# tell the usage
        echo USAGE: "$1 <cpus> <short/mid/long> "
}


MINARGS=2
E_ARGCOUNT=65

if [ $# -lt $MINARGS ]
then
    echo "${#} arguments."
    usage $0
    exit $E_ARGCOUNT;
fi

# make sure env file is there
if [ ! $envf_name ]; then
    echo "No ENV file"
    exit 24
else
    . $envf_name
fi

echo wrf.exe dir is: $wrf_run_dir

# put some default cpus
cpus=$1
job_type=$2
# echo cpus: $cpus

echo '#!/bin/bash' > wrf.sh
chmod +x wrf.sh
echo "#PBS -q $job_type" >> wrf.sh
echo '#PBS -l ncpus='$cpus >> wrf.sh
echo "#PBS -N $run_name" >> wrf.sh
echo "#PBS -o log.wrf" >> wrf.sh
echo '#PBS -j oe' >> wrf.sh
echo '' >> wrf.sh
echo "cd $wrf_run_dir" >> wrf.sh
echo '' >> wrf.sh

echo "# No of Cpus: $cps" >> wrf.sh
echo "mpirun -np $cpus dplace -s1 $wrf_bin_dir/wrf.exe " >> wrf.sh

echo \"wrf.sh\" is Created
# qsub wrf.sh

# wrf-job.sh ends here
