# template
export run_name=weak1
export run_dir_prefix=/home/yagnesh/wrf/run
export tbls_dir=$run_dir_prefix/tbls
export wrf_bin_dir=$run_dir_prefix/bin

export wrf_run_dir=$run_dir_prefix/$run_name
export met_files_dir=$wrf_run_dir

# DATA directory
export data_dir_prefix=/home/yagnesh/DATA
export fnl_dir=$data_dir_prefix/FNL/weak1
export sst_dir=$data_dir_prefix/SST/weak1

# domain dir
export opt_output_from_geogrid_path=$wrf_run_dir
