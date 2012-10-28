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
    echo "which files"
    read datafile
    case $datafile in
        geo )
            read_wrf_nc_1.f.o -EditData HGT_M geo_em.d01.nc  < yes
            read_wrf_nc_1.f.o -EditData HGT_U geo_em.d01.nc < yes
            read_wrf_nc_1.f.o -EditData HGT_V geo_em.d01.nc < yes

            read_wrf_nc_2.f.o -EditData HGT_M geo_em.d02.nc < yes
            read_wrf_nc_2.f.o -EditData HGT_U geo_em.d02.nc < yes
            read_wrf_nc_2.f.o -EditData HGT_V geo_em.d02.nc < yes

            read_wrf_nc_3.f.o -EditData HGT_M geo_em.d03.nc < yes
            read_wrf_nc_3.f.o -EditData HGT_U geo_em.d03.nc < yes
            read_wrf_nc_3.f.o -EditData HGT_V geo_em.d03.nc < yes
            ;;
        wi )
            read_wrf_nc_1.f.o -EditData HGT wrfinput_d01 < yes
            read_wrf_nc_2.f.o -EditData HGT wrfinput_d02 < yes
            read_wrf_nc_3.f.o -EditData HGT wrfinput_d03 < yes

            ;;
    esac
}

function land2sea() {
    echo your input is: $1

    case $1 in
        d1|1|dom1 )
            echo "working on domain one"
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
            read_wrf_nc_1.f.o -EditData SNOWC    wrfinput_d01 < yes
            read_wrf_nc_1.f.o -EditData SNOW     wrfinput_d01 < yes
            ;;

        d2|2|dom2 )
            echo "working on domain two"
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
            read_wrf_nc_2.f.o -EditData SNOWC    wrfinput_d02 < yes
            read_wrf_nc_2.f.o -EditData SNOW     wrfinput_d02 < yes
            ;;

        d3|3|dom3 )
            echo "working on domain three"
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
            read_wrf_nc_3.f.o -EditData SNOWC    wrfinput_d03 < yes
            read_wrf_nc_3.f.o -EditData SNOW     wrfinput_d03 < yes
            ;;

        hgt )
            remove_height
            ;;

        all )
            land2sea 1
            land2sea 2
            land2sea 3
            ;;
    esac

}

land2sea $1

rm -f yes

# land2sea.sh ends here
