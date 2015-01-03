#!/bin/bash
#
#    File: prepare_run.sh

# Description:
# make a folder for named run

minargs=1

# teach usage
if [ $# -lt $minargs ]
then
    echo "${#} arguments."
    echo USAGE: " $(basename ${0}) <run_name>"
    exit
fi

export SCRIPTS_DIR=$(cd `dirname $BASH_SOURCE`; pwd)
export run_name=$1

# template
export wrf_build_dir=/home/yagnesh/wrf/intel/WRFV3
export data_dir_prefix=/home/yagnesh/DATA

export run_dir_prefix=$(pwd)
export wrf_run_dir=$run_dir_prefix/$run_name

cd $run_dir_prefix
mkdir -p $run_name
mkdir -p $data_dir_prefix/FNL/$run_name
mkdir -p $data_dir_prefix/SST/$run_name

cd $run_name

cat  <<EOF > dirnames.sh
export run_name=$run_name
export run_dir_prefix=$run_dir_prefix
export tbls_dir=\$run_dir_prefix/tbls
export wrf_bin_dir=\$run_dir_prefix/bin

export wrf_run_dir=\$run_dir_prefix/\$run_name
export met_files_dir=\$wrf_run_dir

export data_dir_prefix=$data_dir_prefix
export fnl_dir=\$data_dir_prefix/FNL/\$run_name
export sst_dir=\$data_dir_prefix/SST/\$run_name

export opt_output_from_geogrid_path=\$wrf_run_dir
EOF

ln -sf $wrf_build_dir/run/*TBL* .
ln -sf $wrf_build_dir/run/*DATA* .
cp $run_dir_prefix/nl/namelist* .

echo "prepared $run_dir_prefix/$run_name for wrf run named \"$run_name\""
# prepare_run.sh ends here
