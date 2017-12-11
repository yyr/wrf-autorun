#!/bin/bash
#
# Copyright (C) Yagnesh Raghava Yakkala. http://yagnesh.org
#    File: wrf-job.sh

# Description:
# Create a job script IITM aditya HPC.

envf_name=dirnames.sh
jobfname="job.sh"

function usage() {		# tell the usage
        echo USAGE: "$1 <cpus>"
}

MINARGS=1
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

#BSUB -J ${run_name}_yag
#BSUB -W 40:00
#BSUB -n $cpus
#BSUB -R "span[ptile=16]"
#BSUB -q cccr
#BSUB -e rsl.error.%J
#BSUB -o rsl.out.%J
#BSUB -x

EOF

cat $run_dir_prefix/ld.source   >> $jobfname

cat <<EOF  >> $jobfname

cd $wrf_run_dir

rm -f hostfile
cat $LSB_DJOB_HOSTFILE > hostfile

/usr/bin/time -p mpirun -f \
              ./hostfile -perhost 16 -np $cpus \
              -genvall $wrf_bin_dir/wrf.exe

t="\$((\$(date +%s)-t))"
echo "Job finished at \$(date "+%F %H:%M:%S")"
printf "\n Elapsed %02dH:%02dM\n" "\$((t/3600))" "\$((t%3600/60))"
echo \$t
EOF

chmod +x $jobfname

echo "Job script: \"$jobfname\" is created.

-------------------------------------------
$(cat $jobfname)
-------------------------------------------
"

# wrf-job.sh ends here
