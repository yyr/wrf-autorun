#!/bin/bash
#
# Copyright (C) Yagnesh Raghava Yakkala. http://yagnesh.org
#    File: copy3.sh
#  Author: Yagnesh Raghava Yakkala <yagnesh@NOSPAM.live.com>
# Created: Tuesday, November  1 2011
# License: GPL v3 or later.  <http://www.gnu.org/licenses/gpl.html>
#

# Description:

dir=~/git/wrf-autorun
cp $dir/read_wrf_nc.f .

cp read_wrf_nc.f read_wrf_nc_1.f
cp read_wrf_nc.f read_wrf_nc_2.f
cp read_wrf_nc.f read_wrf_nc_3.f

chmod 755 read*

# copy3.sh ends here
