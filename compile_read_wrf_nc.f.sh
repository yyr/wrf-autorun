#!/bin/bash
#
# Copyright (C) Yagnesh Raghava Yakkala. www.yagnesh.org
#    File: ifort_compile.sh
#  Author: Yagnesh Raghava Yakkala <yagnesh@live.com>
# Created: Monday, May  2 2011
# Licence: GPL v3 or later. You should get a copy from <http://www.gnu.org/licenses/gpl.html>
#

# Description: 
ifort $1 -L/usr/local/netcdf/lib -lnetcdf -lm -I/usr/local/netcdf/include/ -free -o $1.o

# ifort_compile.sh ends here
