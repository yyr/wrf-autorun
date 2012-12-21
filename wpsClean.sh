#!/bin/bash
#
# Copyright (C) Yagnesh Raghava Yakkala. http://yagnesh.org
#    File: wps_clean.sh
# Created: Monday, May  2 2011
# Licence: GPL v3 or later.

# Description:

rm -f met_em.*
rm -f FILE*
rm -f SST*
rm -f geo_em*
rm -f PFILE*
rm -f namelist.wps.1*
rm -f GRIBFILE.*

if [ $1 ] && [ $1 == "-a" ]; then
    rm *.log
    rm log.*
fi

# wps_clean.sh ends here
