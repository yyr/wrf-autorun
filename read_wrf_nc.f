!  Special program to only read netCDF files, and write some
!  file information on the screen
!  Can read input/output and static files
!
!=================================Make Executable============================
!  Make executable:
!    DEC Alpha
!      f90 read_wrf_nc.f -L/usr/local/netcdf/lib -lnetcdf -lm  \
!      -I/usr/local/netcdf/include  -free  -o read_wrf_nc
!
!   linux flags
!      ifort read_wrf_nc.f -L/usr/local/netcdf/lib -lnetcdf -lm  \
!      -I/usr/local/netcdf/include  -Mfree  -o read_wrf_nc
!
!   Sun flags
!      f90 read_wrf_nc.f -L/usr/local/netcdf/lib -lnetcdf -lm  \
!      -I/usr/local/netcdf/include  -free  -o read_wrf_nc
!
!   SGI flags
!      f90 read_wrf_nc.f -L/usr/local/netcdf/lib -lnetcdf -lm  \
!      -I/usr/local/netcdf/include  -freeform  -o read_wrf_nc
!
!   IBM flags
!      xlf read_wrf_nc.f -L/usr/local/lib32/r4i4 -lnetcdf -lm  \
!      -I/usr/local/include  -qfree=f90  -o read_wrf_nc
!
!   If you extra compile flags for other computers - please send along
!
!=================================Run Program================================
!  Run program:
!      read_wrf_nc   wrf_data_file_name  [-options]
!      options : [-help] [-head] [-m] [-M z] [-s] [-S x y z]
!                            [-t] [-v VAL] [-V VAL] [-w VAL]
!                            [-EditData]
!  Cannot use any of the options together

!=================================Options====================================
!
!  -help     : Print help information
!  -head     : Print header information only
!  -m        : Print list of fields available for each time,
!              plus the min and max values for each field
!              Also print the header information
!  -M  z     : Print list of fields available for each time,
!              plus the min and max values for each field
!              The min max values for 3d fields will be for
!              the z level of the field
!              Also print the header information
!  -s        : Print list of fields available for each time,
!              plus a sample value for each field
!              Sample value is in middle of domain
!              Also print the header information
!              Default if no options are given
!  -S  x y z : Print list of fields available for each time,
!              plus a sample value for each field
!              Sample value is at point x y z in domain
!              Also print the header information
!  -t        : Print only the times in the file
!  -v VAR    : Print basic information about field VAR
!  -V VAR    : Print basic information about field VAR
!              And dump the full field out to the screen
!  -w VAR    : Write the full field out to a file VAR.out
!
!=================================Special Option=============================
!  -EditData VAR
!
!  This options will allow a user to READ a WRF netDFC file, CHANGE a
!  specific field and RE-WRITE it BACK into the WRF netCDF file
!
!  This options will CHANGE your CURRENT WRF netCDF file so PLEASE
!  TAKE CARE when using this option
!
!  ONLY one field at a time can be changed. So if you need 3 fields changed,
!  you will need to run this program 3 times, each with a different "VAR"
!
!  IF you have multiple times in your WRF netCDF file - ALL times for
!  variable "VAR" WILL be changed.
!
!  HOW TO USE THIS OPTION:
!
!  1. Make a COPY of your WRF netCDF file BEFORE using this option
!
!  2. EDIT the SUBROUTINE USER_CODE
!     - ADD an IF-statement block for the variable you want to change
!            For REAL data work with array "data_real" and
!            for INTEGER data work with the array "data_int"
!       This is to prevent a variable getting overwritten by mistake
!     - Example 1: If you want to change all (all time periods too)
!                  values of U to a constant 10.0 m/s, you would add
!                  the following IF_statement
!       elseif ( var == 'U') then
!           data_real = 10.0
!       Example 2: If you want to change some of the LANDMASK data
!       elseif ( var == 'LANDMASK') then
!           data_real(10:15,20:25,1) = 0   ! will change all land points
                                           ! in the box i=10 to 15 and
                                           ! i=20 to 25 to SEA point
!       Example 3: Change ALL ISLTYP category 3 into category 7
!                  NOTE this is an INTEGER field
!       elseif ( var == 'ISLTYP') then
!           where (data_int == 3 )
!             data_int = 7
!           endwhere
!
!  3. Compile and run program
!     You will be prompted if this is really waht you want to do.
!     ONLY the answer "yes" will allow the change to take effect
!
!============================================================================
!
!  May 2004
!  Cindy Bruyere
!

  program read_wrf_nc

  implicit none
  character (len=80)    :: input_file
  character (len=3)     :: option
  character (len=10)    :: plot_var
  integer :: length_input, length_option
  integer :: plot_dim(3)


! Find out what we need to do first
  call read_args(input_file,length_input,option,plot_var,plot_dim)
  print*,"INPUT FILE IS: ",trim(input_file)
  print*," "


! Now read the file
  call get_info_from_cdf (input_file,length_input,option,   &
                          plot_var,plot_dim)


  end program read_wrf_nc

!------------------------------------------------------------------------------

  subroutine help_info

  print*," "
  print*," read_wrf_nc   wrf_data_file_name  [-options] "
  print*," "
  print*," Current options available are:"
  print*," -help     : Print this information"
  print*," -head     : Print header information only"
  print*," -m        : Print list of fields available for each time, "
  print*,"             plus the min and max values for each field"
  print*,"             Also print the header information"
  print*," -M  z     : Print list of fields available for each time, "
  print*,"             plus the min and max values for each field"
  print*,"             The min max values for 3d fields will be for"
  print*,"             the z level of the field"
  print*,"             Also print the header information"
  print*," -s        : Print list of fields available for each time, "
  print*,"             plus a sample value for each field"
  print*,"             Sample value is in middle of domain"
  print*,"             Also print the header information"
  print*,"             Default if no options are given"
  print*," -S  x y z : Print list of fields available for each time, "
  print*,"             plus a sample value for each field"
  print*,"             Sample value is at point x y z in domain"
  print*,"             Also print the header information"
  print*," -t        : Print only the times in the file"
  print*," -v VAR    : Print basic information about field VAR"
  print*," -V VAR    : Print basic information about field VAR"
  print*,"             And dump the full field out to the screen"
  print*," -w VAR    : Write the full field out to a file VAR.out"
  print*," "

  STOP

  end subroutine help_info

!------------------------------------------------------------------------------

  subroutine read_args(input_file,length_input,option,plot_var,plot_dim)

  implicit none
  character (len=80)    :: input_file
  character (len=3)     :: option
  character (len=10)    :: plot_var
  integer :: length_input, plot_dim(3)

  integer :: numarg, i, idummy
  integer, external :: iargc
  character (len=80)    :: dummy

  input_file = " "
  option = "-s"
  plot_dim = 0
  plot_var = " "
  numarg = iargc()
  i = 1

  if (numarg == 0) call help_info

  do while (i <= numarg)
    call getarg(i,dummy)

    if (dummy(1:1) == "-") then
      if (dummy(2:2) == "h") then
        if (dummy(3:3) == " " ) call help_info
        if (dummy(2:5) == "help" ) call help_info
        if (dummy(2:5) == "head" ) option = "-h"
      elseif (dummy(2:2) == "m") then
        option = dummy
      elseif (dummy(2:2) == "M") then
        option = dummy
        i = i+1
        call getarg(i,dummy)
        read(dummy,'(i3)')idummy
        plot_dim(3) = idummy
      elseif (dummy(2:9) == "EditData") then
        option = '-n'
        i = i+1
        call getarg(i,plot_var)
      elseif (dummy(2:2) == "s") then
        option = dummy
      elseif (dummy(2:2) == "S") then
        option = dummy
        i = i+1
        call getarg(i,dummy)
        read(dummy,'(i3)')idummy
        plot_dim(1) = idummy
        i = i+1
        call getarg(i,dummy)
        read(dummy,'(i3)')idummy
        plot_dim(2) = idummy
        i = i+1
        call getarg(i,dummy)
        read(dummy,'(i3)')idummy
        plot_dim(3) = idummy
      elseif (dummy(2:2) == "t") then
        option = dummy
      elseif (dummy(2:2) == "v") then
        option = dummy
        i = i+1
        call getarg(i,plot_var)
        if (plot_var == " ") call help_info
      elseif (dummy(2:2) == "V") then
        option = dummy
        i = i+1
        call getarg(i,plot_var)
        if (plot_var == " ") call help_info
      elseif (dummy(2:2) == "w") then
        option = dummy
        i = i+1
        call getarg(i,plot_var)
        if (plot_var == " ") call help_info
      else
        call help_info
      endif
    else
      input_file = dummy
      length_input = len_trim(input_file)
    endif

      i = i+1

  enddo

  if (input_file == " ") call help_info

  end subroutine read_args
!------------------------------------------------------------------------------
  subroutine get_info_from_cdf( file,length_input,option,   &
                                plot_var,plot_dim )

  implicit none

  include 'netcdf.inc'

  character (len=80), intent(in) :: file
  character (len=80)             :: file_out
  character (len=3)              :: option
  character (len=3)              :: go_change
  character (len=10), intent(in) :: plot_var
  integer :: i,j,k,ivtype, length,length_input
  integer :: plot_dim(3), get_x, get_y, get_z

  character (len=80) :: varnam, att_name, value_chr, print_time
  character (len=80) :: att_sav(10)
  integer :: dimids(10)

  integer cdfid, rcode, id_var, id_att,attlen
  integer nDims, nVars, nAtts, unlimDimID, dims(4),unit_place,order_place
  integer type_to_get, dims3, id_time, n_times, itimes, iatt

  double precision,  allocatable, dimension(:,:,:) :: data_dp_r
  real,    allocatable, dimension(:,:,:) :: data_r
  integer, allocatable, dimension(:,:,:) :: data_i
  character (len=80) :: times(100)
  integer istart(4), iend(4), middel(4)
  integer istart_t(2), iend_t(2)
  real    sample_value_r, minvalue_r, maxvalue_r
  real, allocatable, dimension(:) :: value_real
  integer sample_value_i, minvalue_i, maxvalue_i, value_int

  if ( option == "-n") then
    rcode = nf_open(file(1:length_input), NF_WRITE, cdfid )
    print*,"Attempting to open netCDF file with write access"
  else
    rcode = nf_open(file(1:length_input), NF_NOWRITE, cdfid )
  endif
!  cdfid = ncopn(file(1:length_input), NCNOWRIT, rcode )
  length = max(1,index(file,' ')-1)
  if( rcode == 0) then
    write(6,*) ' '
  else
    write(6,*) ' error opening netcdf file ',file(1:length)
    stop
  end if

! Get the times first:

  rcode = nf_inq_varid ( cdfid, 'Times', id_var )
    if (rcode .ne. 0) then
      print*,"This looks like a static file"
      print*,"We only print out sample value for this file at the moment"
      print*,"Also only real and integer fields are printed out"
      print*,""
      option = "-c"
      go to 10
    else
      id_time = ncvid( cdfid, 'Times', rcode )
    endif

  rcode = nf_inq_var( cdfid, id_time, varnam, ivtype, ndims, dimids, natts )
  do i=1,ndims
    rcode = nf_inq_dimlen( cdfid, dimids(i), dims(i) )
  enddo

  n_times = dims(2)
  do i=1,dims(2)
    istart_t(1) = 1
    iend_t(1) = dims(1)
    istart_t(2) = i
    iend_t(2) = 1
    rcode = NF_GET_VARA_TEXT  ( cdfid, id_time,  &
                                istart_t, iend_t,    &
                                times(i)          )
  enddo

! If we only want information about time
  if ( option == "-t" ) then
    print*,"TIMES in file"
    do itimes = 1,n_times
      print_time = times(itimes)
      print*,print_time(1:30)
    enddo
    STOP
  endif

 10 continue          ! come here direct for some static files

  rcode = nf_inq(cdfid, nDims, nVars, nAtts, unlimDimID)

! Get some header information
  if ( option .ne. "-v" .and. option .ne. "-V" .and.  &
       option .ne. "-w" .and. option .ne. "-n" ) then
    print*,"HEADER INFORMATION:"
    print*," "
!    do iatt = 1,nDims
!      rcode = nf_inq_dim(cdfid,iatt,att_name,attlen)
!      print*,att_name
!      rcode = nf_inq_att( cdfid,nf_global,att_name,ivtype,attlen )
!      if (ivtype == 2) then
!        rcode = NF_GET_ATT_TEXT(cdfid, nf_global, att_name, value_chr )
!        write(6,'(A," : ",A)') att_name(1:40),value_chr(1:attlen)
!      elseif (ivtype == 4) then
!        rcode = NF_GET_ATT_INT(cdfid, nf_global, att_name, value_int )
!        write(6,'(A," : ",i5)') att_name(1:40),value_int
!      elseif (ivtype == 5) then
!        rcode = NF_GET_ATT_REAL(cdfid, nf_global, att_name, value_real )
!        write(6,'(A," : ",f12.4)') att_name(1:40),value_real
!      endif
!    enddo
!    print*," "
    do iatt = 1,nAtts
      rcode = nf_inq_attname(cdfid,nf_global,iatt,att_name)
      rcode = nf_inq_att( cdfid,nf_global,att_name,ivtype,attlen )
      if (ivtype == 2) then
        rcode = NF_GET_ATT_TEXT(cdfid, nf_global, att_name, value_chr )
        write(6,'(A," : ",A)') att_name(1:40),value_chr(1:attlen)
      elseif (ivtype == 4) then
        rcode = NF_GET_ATT_INT(cdfid, nf_global, att_name, value_int )
        write(6,'(A," : ",i5)') att_name(1:40),value_int
      elseif (ivtype == 5) then
        allocate (value_real(attlen))
        rcode = NF_GET_ATT_REAL(cdfid, nf_global, att_name, value_real )
        if (attlen .gt. 1) then
          print*,att_name(1:40),": ",value_real
        else
          write(6,'(A," : ",f12.4)') att_name(1:40),value_real(1)
        endif
        deallocate (value_real)
      endif
    enddo
    if ( option == "-h") STOP
    print*," "
    print*,"--------------------------------------------------------------------- "
    print*," "
  endif


!===========================================================================================
! Option -s  :  Write out all field names and a sample value of each field
  if      ( option == "-s" ) then

    do itimes = 1,n_times
      print*,"  "
      print_time = times(itimes)
      print*,"TIME: ",print_time(1:30)
      do id_var = 1,nVars

        dims = 1
        rcode = nf_inq_var( cdfid, id_var, varnam, ivtype, nDims, dimids, nAtts )
        type_to_get = ivtype

        do i=1,ndims
          rcode = nf_inq_dimlen( cdfid, dimids(i), dims(i) )
        enddo

        do id_att = 1,nAtts
          rcode = nf_inq_attname( cdfid,id_var,id_att,att_name )
          rcode = nf_inq_att( cdfid,id_var,att_name,ivtype,attlen )
           if ( ivtype == 4 ) then
             rcode = NF_GET_ATT_INT(cdfid, id_var, att_name, value_int )
           endif
          if ( ivtype == 2 ) then
            rcode = NF_GET_ATT_TEXT(cdfid, id_var, att_name, value_chr )
            att_sav(id_att) = value_chr(1:attlen)
            if (att_name(1:4) == "unit") unit_place = id_att
            if (att_name(1:11) == "MemoryOrder") order_place = id_att
          endif
        enddo

        middel        = 1
        istart        = 1
        istart(nDims) = itimes
        iend          = 1
        do i = 1,nDims-1
          iend(i)     = dims(i)
          middel(i)   = iend(i)/2
        enddo
        if (middel(1) == 0) middel(1) = 1

        if (type_to_get .eq. 5)  then   !get_real
          allocate (data_r(iend(1),iend(2),iend(3)))
          call ncvgt( cdfid,id_var,istart,iend,data_r,rcode)
          sample_value_r = data_r(middel(1),middel(2),middel(3))
          write(*,301)varnam,nDims-1,trim(att_sav(order_place)),      &
                      iend(1),iend(2),iend(3),                        &
                      sample_value_r,trim(att_sav(unit_place))
          deallocate (data_r)
        elseif (type_to_get .eq. 6)  then   !get_real_double
          allocate (data_dp_r(iend(1),iend(2),iend(3)))
          call ncvgt( cdfid,id_var,istart,iend,data_dp_r,rcode)
          sample_value_r = data_dp_r(middel(1),middel(2),middel(3))
          write(*,301)varnam,nDims-1,trim(att_sav(order_place)),      &
                      iend(1),iend(2),iend(3),                        &
                      sample_value_r,trim(att_sav(unit_place))
          deallocate (data_dp_r)
        elseif (type_to_get .eq. 4) then   !get_int
          allocate (data_i(iend(1),iend(2),iend(3)))
          call ncvgt( cdfid,id_var,istart,iend,data_i,rcode)
          sample_value_i = data_i(middel(1),middel(2),middel(3))
          write(*,302)varnam,nDims-1,trim(att_sav(order_place)),      &
                      iend(1),iend(2),iend(3),                        &
                      sample_value_i,trim(att_sav(unit_place))
          deallocate (data_i)
        endif

      enddo
    enddo

 301 format(A17,"  ",i2,"  ",A3,"  ",3(x,i4),"  ",G18.10E2,"  ",A)
! 301 format(A17,"  ",i2,"  ",A3,"  ",3(x,i3),"  ",f14.6,"  ",A)
 302 format(A17,"  ",i2,"  ",A3,"  ",3(x,i4),"  ",i14,"  ",A)

!===========================================================================================
! Option -S  [x y z]  :  Write out all field names and a sample value of each field
!                     : Sample value at location x y z
  elseif  ( option == "-S" ) then

    do itimes = 1,n_times
      print*,"  "
      print_time = times(itimes)
      print*,"TIME: ",print_time(1:30)
      do id_var = 1,nVars

        dims = 1
        rcode = nf_inq_var( cdfid, id_var, varnam, ivtype, nDims, dimids, nAtts )
        type_to_get = ivtype

        do i=1,ndims
          rcode = nf_inq_dimlen( cdfid, dimids(i), dims(i) )
        enddo

        do id_att = 1,nAtts
          rcode = nf_inq_attname( cdfid,id_var,id_att,att_name )
          rcode = nf_inq_att( cdfid,id_var,att_name,ivtype,attlen )
           if ( ivtype == 4 ) then
             rcode = NF_GET_ATT_INT(cdfid, id_var, att_name, value_int )
           endif
          if ( ivtype == 2 ) then
            rcode = NF_GET_ATT_TEXT(cdfid, id_var, att_name, value_chr )
            att_sav(id_att) = value_chr(1:attlen)
            if (att_name(1:4) == "unit") unit_place = id_att
            if (att_name(1:11) == "MemoryOrder") order_place = id_att
          endif
        enddo

        middel        = 1
        istart        = 1
        istart(nDims) = itimes
        iend          = 1
        do i = 1,nDims-1
          iend(i)     = dims(i)
           middel(i) = plot_dim(i)
          if ( middel(i) .le. 0  .or. middel(i) .gt. dims(i) ) then
            middel(i) = dims(i)/2
            if (middel(i) == 0) middel(i) = 1
          endif
        enddo

        if (type_to_get .eq. 5)  then   !get_real
          allocate (data_r(iend(1),iend(2),iend(3)))
          call ncvgt( cdfid,id_var,istart,iend,data_r,rcode)
          sample_value_r = data_r(middel(1),middel(2),middel(3))
          write(*,309)varnam,nDims-1,trim(att_sav(order_place)),      &
                      iend(1),iend(2),iend(3),                        &
                      middel(1),middel(2),middel(3),                  &
                      sample_value_r,trim(att_sav(unit_place))
          deallocate (data_r)
        elseif (type_to_get .eq. 6)  then   !get_real_double
          allocate (data_dp_r(iend(1),iend(2),iend(3)))
          call ncvgt( cdfid,id_var,istart,iend,data_dp_r,rcode)
          sample_value_r = data_dp_r(middel(1),middel(2),middel(3))
          write(*,301)varnam,nDims-1,trim(att_sav(order_place)),      &
                      iend(1),iend(2),iend(3),                        &
                      sample_value_r,trim(att_sav(unit_place))
          deallocate (data_dp_r)
        elseif (type_to_get .eq. 4) then   !get_int
          allocate (data_i(iend(1),iend(2),iend(3)))
          call ncvgt( cdfid,id_var,istart,iend,data_i,rcode)
          sample_value_i = data_i(middel(1),middel(2),middel(3))
          write(*,310)varnam,nDims-1,trim(att_sav(order_place)),      &
                      iend(1),iend(2),iend(3),                        &
                      middel(1),middel(2),middel(3),                  &
                      sample_value_i,trim(att_sav(unit_place))
          deallocate (data_i)
        endif

      enddo
    enddo

 309 format(A10,"  ",i2,"  ",A3,3(x,i4),"   (x=",i4," y=",i4," z=",i4,")  ",G18.10E2,"  ",A)
 310 format(A10,"  ",i2,"  ",A3,3(x,i4),"   (x=",i4," y=",i4," z=",i4,")  ",i14,"  ",A)

!===========================================================================================
! Option -m   :  Write out all field names and a the min/max value of each field
  elseif  ( option == "-m" ) then

    do itimes = 1,n_times
      print*,"  "
      print_time = times(itimes)
      print*,"TIME: ",print_time(1:30)
      do id_var = 1,nVars

        dims = 1
        rcode = nf_inq_var( cdfid, id_var, varnam, ivtype, nDims, dimids, nAtts )
        type_to_get = ivtype

        do i=1,ndims
          rcode = nf_inq_dimlen( cdfid, dimids(i), dims(i) )
        enddo

        do id_att = 1,nAtts
          rcode = nf_inq_attname( cdfid,id_var,id_att,att_name )
          rcode = nf_inq_att( cdfid,id_var,att_name,ivtype,attlen )
           if ( ivtype == 4 ) then
             rcode = NF_GET_ATT_INT(cdfid, id_var, att_name, value_int )
           endif
          if ( ivtype == 2 ) then
            rcode = NF_GET_ATT_TEXT(cdfid, id_var, att_name, value_chr )
            att_sav(id_att) = value_chr(1:attlen)
            if (att_name(1:4) == "unit") unit_place = id_att
            if (att_name(1:11) == "MemoryOrder") order_place = id_att
          endif
        enddo

        istart        = 1
        istart(nDims) = itimes
        iend          = 1
        do i = 1,nDims-1
          iend(i)     = dims(i)
        enddo

        if (type_to_get .eq. 5)  then   !get_real
          allocate (data_r(iend(1),iend(2),iend(3)))
          call ncvgt( cdfid,id_var,istart,iend,data_r,rcode)
          minvalue_r =  MINVAL(data_r)
          maxvalue_r =  MAXVAL(data_r)
          write(*,303)varnam,nDims-1,trim(att_sav(order_place)),      &
                      iend(1),iend(2),iend(3),                        &
                      minvalue_r,maxvalue_r,trim(att_sav(unit_place))
          deallocate (data_r)
        elseif (type_to_get .eq. 6)  then   !get_real_double
          allocate (data_dp_r(iend(1),iend(2),iend(3)))
          call ncvgt( cdfid,id_var,istart,iend,data_dp_r,rcode)
          minvalue_r =  MINVAL(data_dp_r)
          maxvalue_r =  MAXVAL(data_dp_r)
          write(*,303)varnam,nDims-1,trim(att_sav(order_place)),      &
                      iend(1),iend(2),iend(3),                        &
                      minvalue_r,maxvalue_r,trim(att_sav(unit_place))
          deallocate (data_dp_r)
        elseif (type_to_get .eq. 4) then   !get_int
          allocate (data_i(iend(1),iend(2),iend(3)))
          call ncvgt( cdfid,id_var,istart,iend,data_i,rcode)
          minvalue_i =  MINVAL(data_i)
          maxvalue_i =  MAXVAL(data_i)
          write(*,304)varnam,nDims-1,trim(att_sav(order_place)),      &
                      iend(1),iend(2),iend(3),                        &
                      minvalue_i,maxvalue_i,trim(att_sav(unit_place))
          deallocate (data_i)
        endif

      enddo
    enddo

 303 format(A10,"  ",i2,"  ",A3,"  ",3(x,i4),"  ",G18.10E2," - ",G18.10E2,"  ",A)
 304 format(A10,"  ",i2,"  ",A3,"  ",3(x,i4),"  ",i14," - ",i14,"  ",A)

!===========================================================================================
! Option -M [z]  :  Write out all field names and a the min/max value of each field
!                   For 3D fields the min/max value will be calucalted for field
!                   z only
  elseif  ( option == "-M" ) then

    do itimes = 1,n_times
      print*,"  "
      print_time = times(itimes)
      print*,"TIME: ",print_time(1:30)
      do id_var = 1,nVars

        dims = 1
        rcode = nf_inq_var( cdfid, id_var, varnam, ivtype, nDims, dimids, nAtts )
        type_to_get = ivtype

        do i=1,ndims
          rcode = nf_inq_dimlen( cdfid, dimids(i), dims(i) )
        enddo

        do id_att = 1,nAtts
          rcode = nf_inq_attname( cdfid,id_var,id_att,att_name )
          rcode = nf_inq_att( cdfid,id_var,att_name,ivtype,attlen )
           if ( ivtype == 4 ) then
             rcode = NF_GET_ATT_INT(cdfid, id_var, att_name, value_int )
           endif
          if ( ivtype == 2 ) then
            rcode = NF_GET_ATT_TEXT(cdfid, id_var, att_name, value_chr )
            att_sav(id_att) = value_chr(1:attlen)
            if (att_name(1:4) == "unit") unit_place = id_att
            if (att_name(1:11) == "MemoryOrder") order_place = id_att
          endif
        enddo

        middel        = 1
        istart        = 1
        istart(nDims) = itimes
        iend          = 1
        do i = 1,nDims-1
          iend(i)     = dims(i)
          middel(i) = plot_dim(i)
          if ( middel(i) .le. 0  .or. middel(i) .gt. dims(i) ) then
            middel(i) = dims(i)/2
            if (middel(i) == 0) middel(i) = 1
          endif
        enddo

        if (type_to_get .eq. 5)  then   !get_real
          allocate (data_r(iend(1),iend(2),iend(3)))
          call ncvgt( cdfid,id_var,istart,iend,data_r,rcode)
          minvalue_r =  MINVAL (MINVAL(data_r(:,:,middel(3)),DIM=1) ,DIM=1)
          maxvalue_r =  MAXVAL (MAXVAL(data_r(:,:,middel(3)),DIM=1) ,DIM=1)
          write(*,305)varnam,nDims-1,trim(att_sav(order_place)),      &
                      iend(1),iend(2),iend(3),middel(3),              &
                      minvalue_r,maxvalue_r,trim(att_sav(unit_place))
          deallocate (data_r)
        elseif (type_to_get .eq. 6)  then   !get_real_double
          allocate (data_dp_r(iend(1),iend(2),iend(3)))
          call ncvgt( cdfid,id_var,istart,iend,data_dp_r,rcode)
          minvalue_r =  MINVAL (MINVAL(data_dp_r(:,:,middel(3)),DIM=1) ,DIM=1)
          maxvalue_r =  MAXVAL (MAXVAL(data_dp_r(:,:,middel(3)),DIM=1) ,DIM=1)
          write(*,305)varnam,nDims-1,trim(att_sav(order_place)),      &
                      iend(1),iend(2),iend(3),middel(3),              &
                      minvalue_r,maxvalue_r,trim(att_sav(unit_place))
          deallocate (data_dp_r)
        elseif (type_to_get .eq. 4) then   !get_int
          allocate (data_i(iend(1),iend(2),iend(3)))
          call ncvgt( cdfid,id_var,istart,iend,data_i,rcode)
          minvalue_i =  MINVAL (MINVAL(data_i(:,:,middel(3)),DIM=1) ,DIM=1)
          maxvalue_i =  MAXVAL (MAXVAL(data_i(:,:,middel(3)),DIM=1) ,DIM=1)
          write(*,306)varnam,nDims-1,trim(att_sav(order_place)),      &
                      iend(1),iend(2),iend(3),middel(3),              &
                      minvalue_i,maxvalue_i,trim(att_sav(unit_place))
          deallocate (data_i)
        endif

      enddo
    enddo

 305 format(A10,"  ",i2,"  ",A3,"  ",3(x,i4),"   (z=",i3,") ",G18.10E2," - ",G18.10E2,"  ",A)
 306 format(A10,"  ",i2,"  ",A3,"  ",3(x,i4),"   (z=",i3,") ",i14," - ",i14,"  ",A)
 307 format(A10,"  ",i2,"  ",A3,"  ",3(x,i4),"           ",G18.10E2," - ",G18.10E2,"  ",A)
 308 format(A10,"  ",i2,"  ",A3,"  ",3(x,i4),"           ",i14," - ",i14,"  ",A)

!===========================================================================================
! Option -v VAR  : Get some brief details about field VAR, including min/max
!                  values for each time
  elseif  ( option == "-v" ) then

    rcode = nf_inq_varid ( cdfid, plot_var, id_var )
    if (rcode .ne. 0) then
      print*,plot_var," is not available in the input file"
      STOP
    endif

    print*,"Attributes and min/max values for the variable: ",plot_var
    print*," "

    do itimes = 1,n_times
      dims = 1
      print_time = times(itimes)

      rcode = nf_inq_var( cdfid, id_var, plot_var, ivtype, nDims, dimids, nAtts )
      type_to_get = ivtype

      do i=1,ndims
        rcode = nf_inq_dimlen( cdfid, dimids(i), dims(i) )
      enddo

      do id_att = 1,nAtts
        rcode = nf_inq_attname( cdfid,id_var,id_att,att_name )
        rcode = nf_inq_att( cdfid,id_var,att_name,ivtype,attlen )
         if ( ivtype == 4 ) then
           rcode = NF_GET_ATT_INT(cdfid, id_var, att_name, value_int )
           if ( itimes == 1 ) then
             if ( type_to_get == 6 ) print*,att_name(1:24)," : ",value_int," (double)"
             if ( type_to_get == 5 ) print*,att_name(1:24)," : ",value_int," (float)"
             if ( type_to_get == 4 ) print*,att_name(1:24)," : ",value_int," (integer)"
           endif
         endif
        if ( ivtype == 2 ) then
          rcode = NF_GET_ATT_TEXT(cdfid, id_var, att_name, value_chr )
          att_sav(id_att) = value_chr(1:attlen)
          if (att_name(1:4) == "unit") unit_place = id_att
          if (att_name(1:11) == "MemoryOrder") order_place = id_att
          if ( itimes == 1 ) print*,att_name(1:24)," : ",value_chr(1:attlen)
        endif
      enddo

        istart        = 1
        istart(nDims) = itimes
        iend          = 1
        do i = 1,nDims-1
          iend(i)     = dims(i)
        enddo

        if (type_to_get .eq. 5)  then   !get_real
          if ( itimes == 1)  write(6,'(" Dimensions               : ",             &
                          i4," (t) ",i4," (x) ",i4, " (y) ",i4, " (z) ")')         &
                          n_times,iend(1),iend(2),iend(3)
          allocate (data_r(iend(1),iend(2),iend(3)))
          call ncvgt( cdfid,id_var,istart,iend,data_r,rcode)
          minvalue_r =  MINVAL(data_r)
          maxvalue_r =  MAXVAL(data_r)
          write(6,'(" Time",A,"  :   MIN =",G18.10E2,"    MAX =",G18.10E2)')print_time(1:30),  &
                   minvalue_r,maxvalue_r
          deallocate (data_r)
        elseif (type_to_get .eq. 6)  then   !get_real_double
          if ( itimes == 1)  write(6,'(" Dimensions               : ",             &
                          i4," (t) ",i4," (x) ",i4, " (y) ",i4, " (z) ")')         &
                          n_times,iend(1),iend(2),iend(3)
          allocate (data_dp_r(iend(1),iend(2),iend(3)))
          call ncvgt( cdfid,id_var,istart,iend,data_dp_r,rcode)
          minvalue_r =  MINVAL(data_dp_r)
          maxvalue_r =  MAXVAL(data_dp_r)
          write(6,'(" Time",A,"  :   MIN =",G18.10E2,"    MAX =",G18.10E2)')print_time(1:30),  &
                   minvalue_r,maxvalue_r
          deallocate (data_dp_r)
        elseif (type_to_get .eq. 4) then   !get_int
          if ( itimes == 1)  write(6,'(" Dimensions               : ",             &
                          i4," (t) ",i4," (x) ",i4, " (y) ",i4, " (z) ")')         &
                          n_times,iend(1),iend(2),iend(3)
          allocate (data_i(iend(1),iend(2),iend(3)))
          call ncvgt( cdfid,id_var,istart,iend,data_i,rcode)
          minvalue_i =  MINVAL(data_i)
          maxvalue_i =  MAXVAL(data_i)
          write(6,'(" Time",A,"  :   MIN =",i12,"    MAX =",i12)')print_time(1:30),  &
                     minvalue_i,maxvalue_i
          deallocate (data_i)
        endif

    enddo

!===========================================================================================
! Option -V VAR  : Get some brief details about field VAR, and dump full field on
!                  screen
  elseif  ( option == "-V" ) then

    rcode = nf_inq_varid ( cdfid, plot_var, id_var )
    if (rcode .ne. 0) then
      print*,plot_var," is not available in the input file"
      STOP
    endif

    print*,"Dumping all output for the variable: ",plot_var
    print*," "

    do itimes = 1,n_times

      dims = 1
      rcode = nf_inq_var( cdfid, id_var, plot_var, ivtype, nDims, dimids, nAtts )
      type_to_get = ivtype

      do i=1,ndims
        rcode = nf_inq_dimlen( cdfid, dimids(i), dims(i) )
      enddo

      do id_att = 1,nAtts
        rcode = nf_inq_attname( cdfid,id_var,id_att,att_name )
        rcode = nf_inq_att( cdfid,id_var,att_name,ivtype,attlen )
         if ( ivtype == 4 ) then
           rcode = NF_GET_ATT_INT(cdfid, id_var, att_name, value_int )
!           if ( itimes == 1 ) then
!             if ( type_to_get == 6 ) print*,att_name(1:24)," : ",value_int," (double)"
!             if ( type_to_get == 5 ) print*,att_name(1:24)," : ",value_int," (float)"
!             if ( type_to_get == 4 ) print*,att_name(1:24)," : ",value_int," (integer)"
!           endif
         endif
        if ( ivtype == 2 ) then
          rcode = NF_GET_ATT_TEXT(cdfid, id_var, att_name, value_chr )
          att_sav(id_att) = value_chr(1:attlen)
          if (att_name(1:4) == "unit") unit_place = id_att
          if (att_name(1:11) == "MemoryOrder") order_place = id_att
!          if ( itimes == 1 ) print*,att_name(1:24)," : ",value_chr(1:attlen)
        endif
      enddo

      print_time = times(itimes)
      print*," "
      print*,"TIME: ",print_time(1:30)

        istart        = 1
        istart(nDims) = itimes
        iend          = 1
        do i = 1,nDims-1
          iend(i)     = dims(i)
        enddo

        if (type_to_get .eq. 5)  then   !get_real
          if ( itimes == 1)  write(6,'(" Dimensions               : ",             &
                          i4," (t) ",i4," (x) ",i4, " (y) ",i4, " (z) ")')         &
                          n_times,iend(1),iend(2),iend(3)
          allocate (data_r(iend(1),iend(2),iend(3)))
          call ncvgt( cdfid,id_var,istart,iend,data_r,rcode)
          print*,data_r
          deallocate (data_r)
        elseif (type_to_get .eq. 6)  then   !get_real_double
          if ( itimes == 1)  write(6,'(" Dimensions               : ",             &
                          i4," (t) ",i4," (x) ",i4, " (y) ",i4, " (z) ")')         &
                          n_times,iend(1),iend(2),iend(3)
          allocate (data_dp_r(iend(1),iend(2),iend(3)))
          call ncvgt( cdfid,id_var,istart,iend,data_dp_r,rcode)
          print*,data_dp_r
          deallocate (data_dp_r)
        elseif (type_to_get .eq. 4) then   !get_int
          if ( itimes == 1)  write(6,'(" Dimensions               : ",             &
                          i4," (t) ",i4," (x) ",i4, " (y) ",i4, " (z) ")')         &
                          n_times,iend(1),iend(2),iend(3)
          allocate (data_i(iend(1),iend(2),iend(3)))
          call ncvgt( cdfid,id_var,istart,iend,data_i,rcode)
          print*,data_i
          deallocate (data_i)
        endif

    enddo

!===========================================================================================
! Option -n VAR  : Alter a variable - CHANGE subroutine USER_CODE to reflect
!                  how you want to change a field
  elseif  ( option == "-n" ) then

    rcode = nf_inq_varid ( cdfid, plot_var, id_var )
    if (rcode .ne. 0) then
      print*,plot_var," is not available in the input file"
      STOP
    endif

    print*,"CAUTION variable ",plot_var," is about to change. Continue? (yes/no)"
    read(*,*)go_change
    if ( go_change .ne. "yes") STOP "USER controlled stop"

    print*,"Changing a variable: ",plot_var

    do itimes = 1,n_times

      dims = 1
      rcode = nf_inq_var( cdfid, id_var, plot_var, ivtype, nDims, dimids, nAtts )
      type_to_get = ivtype

      do i=1,ndims
        rcode = nf_inq_dimlen( cdfid, dimids(i), dims(i) )
      enddo

      do id_att = 1,nAtts
        rcode = nf_inq_attname( cdfid,id_var,id_att,att_name )
        rcode = nf_inq_att( cdfid,id_var,att_name,ivtype,attlen )
         if ( ivtype == 4 ) then
           rcode = NF_GET_ATT_INT(cdfid, id_var, att_name, value_int )
         endif
        if ( ivtype == 2 ) then
          rcode = NF_GET_ATT_TEXT(cdfid, id_var, att_name, value_chr )
          att_sav(id_att) = value_chr(1:attlen)
          if (att_name(1:4) == "unit") unit_place = id_att
          if (att_name(1:11) == "MemoryOrder") order_place = id_att
        endif
      enddo

      print_time = times(itimes)
      print*," "
      print*,"TIME: ",print_time(1:30)

        istart        = 1
        istart(nDims) = itimes
        iend          = 1
        do i = 1,nDims-1
          iend(i)     = dims(i)
        enddo

        if (type_to_get .eq. 5)  then   !get_real
          if ( itimes == 1)  write(6,'(" Dimensions               : ",             &
                          i4," (t) ",i4," (x) ",i4, " (y) ",i4, " (z) ")')         &
                          n_times,iend(1),iend(2),iend(3)
          allocate (data_r(iend(1),iend(2),iend(3)))
          call ncvgt( cdfid,id_var,istart,iend,data_r,rcode)
          CALL USER_CODE(data_r,data_dp_r,data_i,iend(1),iend(2),iend(3),plot_var)
          call ncvpt( cdfid,id_var,istart,iend,data_r,rcode)
          deallocate (data_r)
        elseif (type_to_get .eq. 6)  then   !get_real_double
          if ( itimes == 1)  write(6,'(" Dimensions               : ",             &
                          i4," (t) ",i4," (x) ",i4, " (y) ",i4, " (z) ")')         &
                          n_times,iend(1),iend(2),iend(3)
          allocate (data_dp_r(iend(1),iend(2),iend(3)))
          call ncvgt( cdfid,id_var,istart,iend,data_dp_r,rcode)
          CALL USER_CODE(data_dp_r,data_dp_r,data_i,iend(1),iend(2),iend(3),plot_var)
          call ncvpt( cdfid,id_var,istart,iend,data_dp_r,rcode)
          deallocate (data_dp_r)
        elseif (type_to_get .eq. 4) then   !get_int
          if ( itimes == 1)  write(6,'(" Dimensions               : ",             &
                          i4," (t) ",i4," (x) ",i4, " (y) ",i4, " (z) ")')         &
                          n_times,iend(1),iend(2),iend(3)
          allocate (data_i(iend(1),iend(2),iend(3)))
          call ncvgt( cdfid,id_var,istart,iend,data_i,rcode)
          CALL USER_CODE(data_r,data_dp_r,data_i,iend(1),iend(2),iend(3),plot_var)
          call ncvpt( cdfid,id_var,istart,iend,data_i,rcode)
          deallocate (data_i)
        endif

    enddo

!===========================================================================================
! Option -w VAR : Write field VAL to file VAR.out
  elseif  ( option == "-w" ) then

    rcode = nf_inq_varid ( cdfid, plot_var, id_var )
    if (rcode .ne. 0) then
      print*,plot_var," is not available in the input file"
      STOP
    endif

    write(file_out,'(A,".out")')trim(plot_var)
    open ( 13 , file=file_out )

!    do itimes = 1,n_times

    dims = 1
    rcode = nf_inq_var( cdfid, id_var, plot_var, ivtype, nDims, dimids, nAtts )
    type_to_get = ivtype

    do i=1,ndims
      rcode = nf_inq_dimlen( cdfid, dimids(i), dims(i) )
    enddo
    write ( 13,'("VAR : ",A)')trim(plot_var)
    write ( 13,'("format: ")')
    do i=ndims,2,-1
      if (i-1.eq.3) write ( 13,'("        do k=1,",i4)')dims(3)
      if (i-1.eq.2) write ( 13,'("          do j=1,",i4)')dims(2)
      if (i-1.eq.1) write ( 13,'("            VAR(i,j,k),i=1,",i4)')dims(1)
    enddo
    write ( 13,'(" ")')

      do id_att = 1,nAtts
        rcode = nf_inq_attname( cdfid,id_var,id_att,att_name )
        rcode = nf_inq_att( cdfid,id_var,att_name,ivtype,attlen )
         if ( ivtype == 4 ) then
           rcode = NF_GET_ATT_INT(cdfid, id_var, att_name, value_int )
!           if ( itimes == 1 ) then
!             if ( type_to_get == 5 ) print*,att_name(1:24)," : ",value_int," (float)"
!             if ( type_to_get == 4 ) print*,att_name(1:24)," : ",value_int," (integer)"
!           endif
         endif
        if ( ivtype == 2 ) then
          rcode = NF_GET_ATT_TEXT(cdfid, id_var, att_name, value_chr )
          att_sav(id_att) = value_chr(1:attlen)
          if (att_name(1:4) == "unit") unit_place = id_att
          if (att_name(1:11) == "MemoryOrder") order_place = id_att
!          if ( itimes == 1 ) print*,att_name(1:24)," : ",value_chr(1:attlen)
        endif
      enddo

    do itimes = 1,n_times
      print_time = times(itimes)
      write ( 13, '("TIME: ",A)')print_time(1:30)

        istart        = 1
        istart(nDims) = itimes
        iend          = 1
        do i = 1,nDims-1
          iend(i)     = dims(i)
        enddo

        if (type_to_get .eq. 5)  then   !get_real
          allocate (data_r(iend(1),iend(2),iend(3)))
          call ncvgt( cdfid,id_var,istart,iend,data_r,rcode)
          do k=1,iend(3)
            do j=1,iend(2)
              write ( 13, * ) (data_r(i,j,k),i=1,iend(1))
            enddo
          enddo
          deallocate (data_r)
        elseif (type_to_get .eq. 6)  then   !get_real_double
          if ( itimes == 1)  write(6,'(" Dimensions               : ",             &
                          i4," (t) ",i4," (x) ",i4, " (y) ",i4, " (z) ")')         &
                          n_times,iend(1),iend(2),iend(3)
          allocate (data_dp_r(iend(1),iend(2),iend(3)))
          call ncvgt( cdfid,id_var,istart,iend,data_dp_r,rcode)
          do k=1,iend(3)
            do j=1,iend(2)
              write ( 13, * ) (data_dp_r(i,j,k),i=1,iend(1))
            enddo
          enddo
          deallocate (data_dp_r)
        elseif (type_to_get .eq. 4) then   !get_int
          if ( itimes == 1)  write(6,'(" Dimensions               : ",             &
                          i4," (t) ",i4," (x) ",i4, " (y) ",i4, " (z) ")')         &
                          n_times,iend(1),iend(2),iend(3)
          allocate (data_i(iend(1),iend(2),iend(3)))
          call ncvgt( cdfid,id_var,istart,iend,data_i,rcode)
          do k=1,iend(3)
            do j=1,iend(2)
              write ( 13, * ) (data_i(i,j,k),i=1,iend(1))
            enddo
          enddo
          deallocate (data_i)
        endif

      write ( 13 , '(" ")')
    enddo

    print*,"Full field of variable:",plot_var," has been written to file:",file_out
    close (13)

!===========================================================================================
! Option -c          static files come here
  elseif  ( option == "-c" ) then

      do id_var = 1,nVars
        unit_place = 0

        dims = 1
        rcode = nf_inq_var( cdfid, id_var, varnam, ivtype, nDims, dimids, nAtts )
        type_to_get = ivtype

        do i=1,ndims
          rcode = nf_inq_dimlen( cdfid, dimids(i), dims(i) )
        enddo

        do id_att = 1,nAtts
          rcode = nf_inq_attname( cdfid,id_var,id_att,att_name )
          rcode = nf_inq_att( cdfid,id_var,att_name,ivtype,attlen )
           if ( ivtype == 4 ) then
             rcode = NF_GET_ATT_INT(cdfid, id_var, att_name, value_int )
!             print*,att_name(1:40)," : ",value_int
           endif
          if ( ivtype == 2 ) then
            rcode = NF_GET_ATT_TEXT(cdfid, id_var, att_name, value_chr )
            att_sav(id_att) = value_chr(1:attlen)
            if (att_name(1:4) == "unit") unit_place = id_att
!            print*,att_name(1:40)," : ",value_chr(1:attlen)
          elseif (ivtype == 5) then
            allocate (value_real(attlen))
            rcode = NF_GET_ATT_REAL(cdfid, id_var, att_name, value_real )
!            if (attlen .gt. 1) then
!              print*,att_name(1:40),": ",value_real
!            else
!              write(6,'(A," : ",f12.4)') att_name(1:40),value_real(1)
!            endif
            deallocate (value_real)
          endif
        enddo

        middel        = 1
        istart        = 1
        istart(nDims) = itimes
        iend          = 1
        do i = 1,nDims-1
          iend(i)     = dims(i)
          middel(i)   = iend(i)/2
        enddo
        if (middel(1) == 0) middel(1) = 1

        if (type_to_get .eq. 5)  then   !get_real
          allocate (data_r(iend(1),iend(2),iend(3)))
          call ncvgt( cdfid,id_var,istart,iend,data_r,rcode)
          sample_value_r = data_r(middel(1),middel(2),middel(3))
          write(*,301)varnam,nDims-1,trim(att_sav(order_place)),      &
                      iend(1),iend(2),iend(3),                        &
                      sample_value_r,trim(att_sav(unit_place))
          deallocate (data_r)
        elseif (type_to_get .eq. 6)  then   !get_real_double
          allocate (data_dp_r(iend(1),iend(2),iend(3)))
          call ncvgt( cdfid,id_var,istart,iend,data_dp_r,rcode)
          sample_value_r = data_dp_r(middel(1),middel(2),middel(3))
          write(*,301)varnam,nDims-1,trim(att_sav(order_place)),      &
                      iend(1),iend(2),iend(3),                        &
                      sample_value_r,trim(att_sav(unit_place))
          deallocate (data_dp_r)
        elseif (type_to_get .eq. 4) then   !get_int
          allocate (data_i(iend(1),iend(2),iend(3)))
          call ncvgt( cdfid,id_var,istart,iend,data_i,rcode)
          sample_value_i = data_i(middel(1),middel(2),middel(3))
          write(*,302)varnam,nDims-1,trim(att_sav(order_place)),      &
                      iend(1),iend(2),iend(3),                        &
                      sample_value_i,trim(att_sav(unit_place))
          deallocate (data_i)
        endif

      enddo

!===========================================================================================
  endif                ! end of options



  call ncclos(cdfid,rcode)

  print*,"  "
  print*,"   --- End of input file ---   "

  end subroutine get_info_from_cdf
!------------------------------------------------------------------------------

  subroutine USER_CODE (data_real,data_dp_real,        &
       data_int,dim1,dim2,dim3,var)

  implicit none
  integer  ::  dim1,dim2,dim3
  integer  ::  i
  double precision,  dimension(dim1,dim2,dim3) ::  data_dp_real
  real,    dimension(dim1,dim2,dim3)           ::  data_real
  integer, dimension(dim1,dim2,dim3)           ::  data_int
  character (len=10)    :: var


!------------------------------READ FIRST-------------------------------------
!
! USER MUST KNOW WHICH VARIABLE WILL BE COMING IN, INCLUDING IF VARIABLE
! WILL BE REAL OR INTEGER
! IF YOU PLAN ON CHANGING THE VALUE OF "TSK", WORK WITH THE "data_real"
! ARRAY, AND IGNORE 'data_int"

! IT IS THE USER RESPONSABILITY TO ENSURE THIS CODE IS CORRECT
! REMEMBER THAT THE netCDF FILE YOU READ WILL ALSO BE THE ONE THAT
! GETS CHANGED, SO MAKE A COPY OF YOUR netCDF FILE BEFORE USING
! THE "-EditData  VAR" OPTION
!-----------------------------------------------------------------------------

! Add and if block for the variable you want to change - this will
! prevent the overwriting of a variable by mistake

  if ( var == 'TSK') then                 ! will turn all TSK values to 100.00
    data_real = 100.00
  elseif ( var == 'SOILHGT') then         ! raise soil height by 30%
    where (data_real .gt. 0.0)
      data_real = data_real + .3*data_real
    endwhere
  elseif ( var == 'ISLTYP') then          ! change all 1's in this field with 2's
    where (data_int == 1 )
      data_int = 2
    endwhere
  elseif ( var == 'TH2') then             ! change TH2 to 273.00  - this is for 3dvar
                                          !                 double precision fields
                                          ! Kawashima
      data_dp_real = 273.0

  elseif ( var == 'LU_INDEX') then             !
     data_real(60:201,180:250,1)=16

  elseif ( var == 'SOILTEMP') then             !
     data_real(60:201,180:250,1)=0.0

  elseif ( var == 'SCT_DOM') then             !
     data_real(60:201,180:250,1)=14

  elseif ( var == 'SCB_DOM') then             !
     data_real(60:201,180:250,1)=14

  elseif ( var == 'OA1') then             !
     data_real(60:201,180:250,1)=0.0

  elseif ( var == 'OA2') then             !
     data_real(60:201,180:250,1)=0.

  elseif ( var == 'OA3') then             !
     data_real(60:201,180:250,1)=0.

  elseif ( var == 'OA4') then             !
     data_real(60:201,180:250,1)=0.

  elseif ( var == 'OL1') then             !
     data_real(60:201,180:250,1)=0.

  elseif ( var == 'OL2') then             !
     data_real(60:201,180:250,1)=0.

  elseif ( var == 'OL3') then             !
     data_real(60:201,180:250,1)=0.

  elseif ( var == 'OL4') then             !
     data_real(60:201,180:250,1)=0.

  elseif ( var == 'CON') then             !
     data_real(60:201,180:250,1)=0.

  elseif ( var == 'VAR') then             !
     data_real(60:201,180:250,1)=0.

     ! 3d vars

  elseif ( var == 'ALBEDO12M') then             !
     data_real(60:201,180:250,:)=8.

  elseif ( var == 'GREENFRAC') then             !
     data_real(60:201,180:250,:)=0.
     data_real(60:201,180:250,2:12)=0.

  elseif ( var == 'LANDUSEF') then             !
     data_real(60:201,180:250,:)=0.
     data_real(60:201,180:250,16)=0.


  elseif ( var == 'SOILCTOP') then             !
     data_real(60:201,180:250,:)=0.
     data_real(60:201,180:250,14)=1.

  elseif ( var == 'SOILCBOT') then             !
     data_real(60:201,180:250,:)=0.
     data_real(60:201,180:250,14)=1.

     ! ----------------------------
     ! wrfinput
     !---------------------------
     !     land points to sea points
     ! LANDMASK =0
     ! XLAND    =2
     ! LU_INDEX =16
     ! IVGTYP   =16
     ! ISLTYP   =14
     ! HGT      =0
     ! VEGFRA   =0
     ! ALBBCK   =0.08
     ! SHDMAX   =0
     ! SHDMIN   =0
     ! SNOALB   =0.08
     ! TMN      =SST
  elseif ( var == 'LANDMASK' ) then
     data_real(60:201,180:250,1)=0.0

  elseif ( var == 'XLAND' ) then
     data_real(60:201,180:250,1)=2.0

  elseif ( var == 'LU_INDEX' ) then
     data_real(60:201,180:250,1)=16.0

  elseif ( var == 'IVGTYP' ) then
     data_int(60:201,180:250,1)=16

  elseif ( var == 'ISLTYP' ) then
     data_int(60:201,180:250,1)=14

  elseif ( var == 'VEGFRA' ) then
     data_real(60:201,180:250,1)=0.0

  elseif ( var == 'ALBBCK' ) then
     data_real(60:201,180:250,1)=0.08

  elseif ( var == 'SHDMAX' ) then
     data_real(60:201,180:250,1)=0.0

  elseif ( var == 'SHDMIN' ) then
     data_real(60:201,180:250,1)=0.0

  elseif ( var == 'SNOALB' ) then
     data_real(60:201,180:250,1)=0.08
!-------------------------------------------------


  elseif ( var == 'SST') then             !
!      data_real(60:201,180:250,1)=271.0
      do i=65,99
      write (6,*) data_real(i,80,1)
      end do
  elseif ( var == 'SKINTEMP') then             !
      data_real(60:201,180:250,1)=260.0
      do i=65,99
      write (6,*) data_real(i,80,1)
      end do
  elseif ( var == 'SEAICE') then             !
      data_real(60:201,180:250,1)=1.0
      do i=65,99
      write (6,*) data_real(i,80,1)
      end do
  elseif ( var == 'HGT_U') then             !
!     data_real(1:310,1:178,1)=0.0
      data_real(60:201,180:250,1)=0.0
  elseif ( var == 'HGT_V') then             !
      data_real(60:201,180:250,1)=0.0
  elseif ( var == 'HGT_M') then             !
      data_real(60:201,180:250,1)=0.0
  else
    print*,"Variable given was not one of above - so no change will be"
    print*,"  made to any variables"
  endif

  print*,"Changes has been made to variable ",var

  end subroutine USER_CODE

!------------------------------------------------------------------------------

! Local Variables:
! mode: f90
! End:
