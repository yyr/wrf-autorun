#!/bin/sh


if [ $# -lt 1 ]
then
    echo "please give args { hok|saka }"
    exit
fi

# copy files first
copy3.sh


case $1 in
    hok )
        /usr/bin/perl -p -i -e "s/\d{1,3}:\d{1,3},\d{1,3}:\d{1,3}/82:122,66:103/g" read_wrf_nc_1.f
        /usr/bin/perl -p -i -e "s/\d{1,3}:\d{1,3},\d{1,3}:\d{1,3}/83:216,14:118/g" read_wrf_nc_2.f
        /usr/bin/perl -p -i -e "s/\d{1,3}:\d{1,3},\d{1,3}:\d{1,3}/1:310,1:178/g" read_wrf_nc_3.f
        ;;
    saka )
        /usr/bin/perl -p -i -e "s/\d{1,3}:\d{1,3},\d{1,3}:\d{1,3}/95:116,106:158/g" read_wrf_nc_1.f
        /usr/bin/perl -p -i -e "s/\d{1,3}:\d{1,3},\d{1,3}:\d{1,3}/125:174,124:220/g" read_wrf_nc_2.f
        /usr/bin/perl -p -i -e "s/\d{1,3}:\d{1,3},\d{1,3}:\d{1,3}/60:201,180:250/g" read_wrf_nc_3.f
        ;;

    * )
        echo " no args"
        ;;

esac

# compile them
compile_read_wrf_nc.pl

# edit the vars
land2sea_points.sh
