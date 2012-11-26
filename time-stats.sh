#!/bin/bash
#
# Description:
# http://www.mmm.ucar.edu/wrf/WG2/bench/

grep 'Timing for main' rsl.error.0000  | awk '{print $9}' | awk -f $(cd `dirname $BASH_SOURCE`; pwd)/stats.awk

# wrf_bench.sh ends here
