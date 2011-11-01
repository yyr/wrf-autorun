#!/bin/bash -x
#
# Copyright (C) Yagnesh Raghava Yakkala. http://yagnesh.org
#    File: remove_topo.sh
#  Author: Yagnesh Raghava Yakkala <yagnesh@NOSPAM.live.com>
# Created: Friday, October 28 2011
# License: GPL v3 or later.  <http://www.gnu.org/licenses/gpl.html>
#

# Description:

echo "yes" > yes

./read_wrf_nc_1.f.o -EditData HGT_M geo_em.d01.nc  < yes
./read_wrf_nc_1.f.o -EditData HGT_U geo_em.d01.nc < yes
./read_wrf_nc_1.f.o -EditData HGT_V geo_em.d01.nc < yes
./read_wrf_nc_1.f.o -EditData LANDMASK geo_em.d01.nc < yes
./read_wrf_nc_1.f.o -EditData LU_INDEX geo_em.d01.nc < yes
./read_wrf_nc_1.f.o -EditData SOILTEMP geo_em.d01.nc < yes
./read_wrf_nc_1.f.o -EditData SCT_DOM geo_em.d01.nc < yes
./read_wrf_nc_1.f.o -EditData SCB_DOM geo_em.d01.nc < yes
./read_wrf_nc_1.f.o -EditData OA1 geo_em.d01.nc < yes
./read_wrf_nc_1.f.o -EditData OA2 geo_em.d01.nc < yes
./read_wrf_nc_1.f.o -EditData OA3 geo_em.d01.nc < yes
./read_wrf_nc_1.f.o -EditData OA4 geo_em.d01.nc < yes
./read_wrf_nc_1.f.o -EditData OL1 geo_em.d01.nc < yes
./read_wrf_nc_1.f.o -EditData OL2 geo_em.d01.nc < yes
./read_wrf_nc_1.f.o -EditData OL3 geo_em.d01.nc < yes
./read_wrf_nc_1.f.o -EditData OL4 geo_em.d01.nc < yes
./read_wrf_nc_1.f.o -EditData VAR geo_em.d01.nc < yes
./read_wrf_nc_1.f.o -EditData CON geo_em.d01.nc < yes
./read_wrf_nc_1.f.o -EditData ALBEDO12M geo_em.d01.nc < yes
./read_wrf_nc_1.f.o -EditData GREENFRAC geo_em.d01.nc < yes
./read_wrf_nc_1.f.o -EditData LANDUSEF  geo_em.d01.nc < yes
./read_wrf_nc_1.f.o -EditData SOILCTOP geo_em.d01.nc < yes
./read_wrf_nc_1.f.o -EditData SOILCBOT geo_em.d01.nc < yes

./read_wrf_nc_2.f.o -EditData HGT_M geo_em.d02.nc  < yes
./read_wrf_nc_2.f.o -EditData HGT_U geo_em.d02.nc < yes
./read_wrf_nc_2.f.o -EditData HGT_V geo_em.d02.nc < yes
./read_wrf_nc_2.f.o -EditData LANDMASK geo_em.d02.nc < yes
./read_wrf_nc_2.f.o -EditData LU_INDEX geo_em.d02.nc < yes
./read_wrf_nc_2.f.o -EditData SOILTEMP geo_em.d02.nc < yes
./read_wrf_nc_2.f.o -EditData SCT_DOM geo_em.d02.nc < yes
./read_wrf_nc_2.f.o -EditData SCB_DOM geo_em.d02.nc < yes
./read_wrf_nc_2.f.o -EditData OA1 geo_em.d02.nc < yes
./read_wrf_nc_2.f.o -EditData OA2 geo_em.d02.nc < yes
./read_wrf_nc_2.f.o -EditData OA3 geo_em.d02.nc < yes
./read_wrf_nc_2.f.o -EditData OA4 geo_em.d02.nc < yes
./read_wrf_nc_2.f.o -EditData OL1 geo_em.d02.nc < yes
./read_wrf_nc_2.f.o -EditData OL2 geo_em.d02.nc < yes
./read_wrf_nc_2.f.o -EditData OL3 geo_em.d02.nc < yes
./read_wrf_nc_2.f.o -EditData OL4 geo_em.d02.nc < yes
./read_wrf_nc_2.f.o -EditData VAR geo_em.d02.nc < yes
./read_wrf_nc_2.f.o -EditData CON geo_em.d02.nc < yes
./read_wrf_nc_2.f.o -EditData ALBEDO12M geo_em.d02.nc < yes
./read_wrf_nc_2.f.o -EditData GREENFRAC geo_em.d02.nc < yes
./read_wrf_nc_2.f.o -EditData LANDUSEF  geo_em.d02.nc < yes
./read_wrf_nc_2.f.o -EditData SOILCTOP geo_em.d02.nc < yes
./read_wrf_nc_2.f.o -EditData SOILCBOT geo_em.d02.nc < yes

./read_wrf_nc_3.f.o -EditData HGT_M geo_em.d03.nc  < yes
./read_wrf_nc_3.f.o -EditData HGT_U geo_em.d03.nc < yes
./read_wrf_nc_3.f.o -EditData HGT_V geo_em.d03.nc < yes
./read_wrf_nc_3.f.o -EditData LANDMASK geo_em.d03.nc < yes
./read_wrf_nc_3.f.o -EditData LU_INDEX geo_em.d03.nc < yes
./read_wrf_nc_3.f.o -EditData SOILTEMP geo_em.d03.nc < yes
./read_wrf_nc_3.f.o -EditData SCT_DOM geo_em.d03.nc < yes
./read_wrf_nc_3.f.o -EditData SCB_DOM geo_em.d03.nc < yes
./read_wrf_nc_3.f.o -EditData OA1 geo_em.d03.nc < yes
./read_wrf_nc_3.f.o -EditData OA2 geo_em.d03.nc < yes
./read_wrf_nc_3.f.o -EditData OA3 geo_em.d03.nc < yes
./read_wrf_nc_3.f.o -EditData OA4 geo_em.d03.nc < yes
./read_wrf_nc_3.f.o -EditData OL1 geo_em.d03.nc < yes
./read_wrf_nc_3.f.o -EditData OL2 geo_em.d03.nc < yes
./read_wrf_nc_3.f.o -EditData OL3 geo_em.d03.nc < yes
./read_wrf_nc_3.f.o -EditData OL4 geo_em.d03.nc < yes
./read_wrf_nc_3.f.o -EditData VAR geo_em.d03.nc < yes
./read_wrf_nc_3.f.o -EditData CON geo_em.d03.nc < yes
./read_wrf_nc_3.f.o -EditData ALBEDO12M geo_em.d03.nc < yes
./read_wrf_nc_3.f.o -EditData GREENFRAC geo_em.d03.nc < yes
./read_wrf_nc_3.f.o -EditData LANDUSEF  geo_em.d03.nc < yes
./read_wrf_nc_3.f.o -EditData SOILCTOP geo_em.d03.nc < yes
./read_wrf_nc_3.f.o -EditData SOILCBOT geo_em.d03.nc < yes


# remove_topo.sh ends here
