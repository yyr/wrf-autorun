#!/bin/bash
#
# Copyright (C) Yagnesh Raghava Yakkala. http://yagnesh.org
#    File: wps.sh
# Created: Monday, May  2 2011
# Licence: GPL v3 or later.

# Description:
# run the wps program automatically

function usage() {
    echo USAGE: " $1 <GEO|UNGRIB|MET|ALL>"
}
function message() {
    echo  "$@"
    echo ''
}

function run_geogrid() {
    message running: GEOGRID.EXE
    ./geogrid.exe | tee log.geogrid
    check_error $0 Geogrid.exe
}

function run_ungrib () {
    # run_ungrib <Vtable.???> <data dir to link> <data_prefix to link>
    ln -sf ./ungrib/Variable_Tables/$1 Vtable
    message linking data from $2
    ./link_grib.csh $2/$3 &&
    message running: ungrib.exe &&
    ./ungrib.exe | tee log.ungrib
    check_error $0 Ungrib.exe
}

function run_metgrid() {
    ./metgrid.exe | tee log.metgrid
    check_error $0 Metgrid.exe
}

function check_error() {
    if [ ! $0 == $1 ]; then
        echo Something Gone Wrong: $1;
        exit $Error_exe
    fi
}


########################################################################
cd `pwd`                        # go to the working directory possibly WPS dir
. DirNames.sh                  # few dir names IMP to edit

Error_Args=64
Error_exe=128
MINARGS=1
Arg=$1

# teach usage
if [ $# -lt $MINARGS ]
then
    echo "${#} arguments."
    usage $0
    exit $Error_Args;
fi

# Vtables
FNL_Vtable_Name=Vtable.GFS
SST_Vtable_Name=Vtable.SST
namelist=namelist.wps
# --------------------------------

########################################################################
case $Arg in

# geogrid
    geo*|GE*|Geo* )
# name list options
# opt_output_from_geogrid_path=${opt_output_from_geogrid_path:`pwd`}
#--------------
        echo "opt_output_from_geogrid_path::---->" $opt_output_from_geogrid_path
        if [ `ls $opt_output_from_geogrid_path/geo_* | wc -l` == 0 ]; then
            change-option.pl $namelist opt_output_from_geogrid_path \'$opt_output_from_geogrid_path\' &&
            run_geogrid
        else
            message skipping geogrid.exe
        fi
        ;;


# ungrib
    ung*|Ung*|UNG* )
# FNL
# name list options
        prefix=\'FILE\'
        interval_seconds=21600
        data_prefix=fnl
#--------------
        if [ `ls FILE* | wc -l` == 0  ]; then
            change-option.pl  $namelist prefix $prefix &&
            change-option.pl $namelist interval_seconds $interval_seconds &&
            run_ungrib $FNL_Vtable_Name $fnl_dir $data_prefix
        else
            message skipping ungrib for FNL DATA
        fi

# SST
# ----------------
# name list options
        prefix=\'SST\'
        interval_seconds=86400
        data_prefix=rtg
#--------------
        if [  `ls SST* | wc -l` == 0 ] ; then
            change-option.pl  $namelist prefix $prefix &&
            change-option.pl  $namelist interval_seconds $interval_seconds &&
            run_ungrib $SST_Vtable_Name $sst_dir $data_prefix
        else
            message skipping ungrib for FNL DATA
        fi
        ;;


# metgrid
    met*|Met*|MET* )
# name list options
        interval_seconds=21600
#--------------
        if [  `ls met_em* | wc -l` == 0 ] ; then
            change-option.pl $namelist interval_seconds $interval_seconds &&
            run_metgrid
        else
            message Do you ALREADY INPUT data???
        fi
        ;;
    All*|ALL*|all* )
        wps.sh geo
        wps.sh ungrib
        wps.sh met
        ;;
    * )
        usage $0
        ;;
esac
########################################################################

exit 0;

# wps.sh ends here
