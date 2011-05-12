#!/bin/bash
#
# Copyright (C) Yagnesh Raghava Yakkala. www.yagnesh.org
#    File: height_remove.sh
#  Author: Yagnesh Raghava Yakkala <yagnesh@live.com>
# Created: Tuesday, May 10 2011
# Licence: GPL v3 or later. You should get a copy from <http://www.gnu.org/licenses/gpl.html>
#

# Description: 
# brain dead program
# put yes in a heredocument
echo "yes" > yes

# 
./read_wrf_nc_1.f.o -EditData HGT_M geo_em.d01.nc  < yes
./read_wrf_nc_1.f.o -EditData HGT_U geo_em.d01.nc < yes
./read_wrf_nc_1.f.o -EditData HGT_V geo_em.d01.nc < yes

./read_wrf_nc_2.f.o -EditData HGT_M geo_em.d02.nc < yes
./read_wrf_nc_2.f.o -EditData HGT_U geo_em.d02.nc < yes
./read_wrf_nc_2.f.o -EditData HGT_V geo_em.d02.nc < yes

./read_wrf_nc_3.f.o -EditData HGT_M geo_em.d03.nc < yes
./read_wrf_nc_3.f.o -EditData HGT_U geo_em.d03.nc < yes
./read_wrf_nc_3.f.o -EditData HGT_V geo_em.d03.nc < yes

rm -f yes

# height_remove.sh ends here
