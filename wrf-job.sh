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
jobfname="job.sh"

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

cat <<EOF > $jobfname
#!/bin/bash

#PBS -q $job_type
#PBS -l ncpus=$cpus
#PBS -N $run_name
#PBS -o log.wrf
#PBS -j oe

EOF

cat $run_dir_prefix/ld.source   >> $jobfname

cat <<EOF  >> $jobfname

cd $wrf_run_dir

echo "Job started at \$(date)"

t="\$(date "+%F %H:%M:%S")"
# No of Cpus:
mpirun -np $cpus dplace -s1 $wrf_bin_dir/wrf.exe.intel

t="\$((\$(date +%s)-t))"
echo "Job finished at \$(date "+%F %H:%M:%S")"
printf "\n Elapsed %02d:%02d\n" "\$((t/3600))" "\$((t%3600/60))"

EOF

chmod +x $jobfname

echo "Job script: \"$jobfname\" is created.

-------------------------------------------
$(cat $jobfname)
-------------------------------------------
"

# wrf-job.sh ends here
