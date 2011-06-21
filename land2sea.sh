#!/bin/bash
#
# Copyright (C) Yagnesh Raghava Yakkala. www.yagnesh.org
#    File: land2sea.sh
#  Author: Yagnesh Raghava Yakkala <yagnesh@live.com>
# Created: Tuesday, June 21 2011
# Licence: GPL v3 or later. You should get a copy from <http://www.gnu.org/licenses/gpl.html>
#

# Description:

echo "yes" > yes

function remove_height() {
    ./read_wrf_nc_1.f.o -EditData HGT_M geo_em.d01.nc  < yes
    ./read_wrf_nc_1.f.o -EditData HGT_U geo_em.d01.nc < yes
    ./read_wrf_nc_1.f.o -EditData HGT_V geo_em.d01.nc < yes

    ./read_wrf_nc_2.f.o -EditData HGT_M geo_em.d02.nc < yes
    ./read_wrf_nc_2.f.o -EditData HGT_U geo_em.d02.nc < yes
    ./read_wrf_nc_2.f.o -EditData HGT_V geo_em.d02.nc < yes

    ./read_wrf_nc_3.f.o -EditData HGT_M geo_em.d03.nc < yes
    ./read_wrf_nc_3.f.o -EditData HGT_U geo_em.d03.nc < yes
    ./read_wrf_nc_3.f.o -EditData HGT_V geo_em.d03.nc < yes
}

function land2sea() {
    case $1 in
        d1|1|dom1 )
            read_wrf_nc_1.f.o -EditData LANDMASK wrfinput_d01 < yes
            read_wrf_nc_1.f.o -EditData XLAND    wrfinput_d01 < yes
            read_wrf_nc_1.f.o -EditData LU_INDEX wrfinput_d01 < yes
            read_wrf_nc_1.f.o -EditData IVGTYP   wrfinput_d01 < yes
            read_wrf_nc_1.f.o -EditData ISLTYP   wrfinput_d01 < yes
            read_wrf_nc_1.f.o -EditData HGT      wrfinput_d01 < yes
            read_wrf_nc_1.f.o -EditData VEGFRA   wrfinput_d01 < yes
            read_wrf_nc_1.f.o -EditData ALBBCK   wrfinput_d01 < yes
            read_wrf_nc_1.f.o -EditData SHDMAX   wrfinput_d01 < yes
            read_wrf_nc_1.f.o -EditData SHDMIN   wrfinput_d01 < yes
            read_wrf_nc_1.f.o -EditData SST      wrfinput_d01 < yes
            read_wrf_nc_1.f.o -EditData TMN      wrfinput_d01 < yes
            ;;

        d2|2|dom2 )
            read_wrf_nc_2.f.o -EditData LANDMASK wrfinput_d02 < yes
            read_wrf_nc_2.f.o -EditData XLAND    wrfinput_d02 < yes
            read_wrf_nc_2.f.o -EditData LU_INDEX wrfinput_d02 < yes
            read_wrf_nc_2.f.o -EditData IVGTYP   wrfinput_d02 < yes
            read_wrf_nc_2.f.o -EditData ISLTYP   wrfinput_d02 < yes
            read_wrf_nc_2.f.o -EditData HGT      wrfinput_d02 < yes
            read_wrf_nc_2.f.o -EditData VEGFRA   wrfinput_d02 < yes
            read_wrf_nc_2.f.o -EditData ALBBCK   wrfinput_d02 < yes
            read_wrf_nc_2.f.o -EditData SHDMAX   wrfinput_d02 < yes
            read_wrf_nc_2.f.o -EditData SHDMIN   wrfinput_d02 < yes
            read_wrf_nc_2.f.o -EditData SST      wrfinput_d02 < yes
            read_wrf_nc_2.f.o -EditData TMN      wrfinput_d02 < yes
            ;;

        d3|3|dom3 )
            read_wrf_nc_3.f.o -EditData LANDMASK wrfinput_d03 < yes
            read_wrf_nc_3.f.o -EditData XLAND    wrfinput_d03 < yes
            read_wrf_nc_3.f.o -EditData LU_INDEX wrfinput_d03 < yes
            read_wrf_nc_3.f.o -EditData IVGTYP   wrfinput_d03 < yes
            read_wrf_nc_3.f.o -EditData ISLTYP   wrfinput_d03 < yes
            read_wrf_nc_3.f.o -EditData HGT      wrfinput_d03 < yes
            read_wrf_nc_3.f.o -EditData VEGFRA   wrfinput_d03 < yes
            read_wrf_nc_3.f.o -EditData ALBBCK   wrfinput_d03 < yes
            read_wrf_nc_3.f.o -EditData SHDMAX   wrfinput_d03 < yes
            read_wrf_nc_3.f.o -EditData SHDMIN   wrfinput_d03 < yes
            read_wrf_nc_3.f.o -EditData SST      wrfinput_d03 < yes
            read_wrf_nc_3.f.o -EditData TMN      wrfinput_d03 < yes
            ;;
    esac

}

land2sea

rm -f yes

# land2sea.sh ends here
