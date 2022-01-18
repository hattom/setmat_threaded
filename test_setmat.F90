program setmat
  use band_data, only: init_band, band, band_data_type, reset_band
  implicit none
  integer, parameter :: nrows=511, ncols=199
  call init_band(nrows, ncols)
  print *, 'Early SINE'
  call test_nest1()
  call reset_band()
  call test_nest2()
  call reset_band()
  call test_nest3()
  call reset_band()
  call test_nest4()
  call reset_band()
  call test_nest5()
  call reset_band()

  print *, 'Late SINE'
  call test_nest1l()
  call reset_band()
  call test_nest2l()
  call reset_band()
  call test_nest3l()
  call reset_band()
  call test_nest4l()
  call reset_band()
  call test_nest5l()
  call reset_band()

  contains


#define TEST_SUBROUTINE_NAME test_nest1
#include "test_nest.tpl"
#undef TEST_SUBROUTINE_NAME

#define PAR_METHOD1
#define TEST_SUBROUTINE_NAME test_nest2
#include "test_nest.tpl"
#undef PAR_METHOD1
#undef TEST_SUBROUTINE_NAME

#define PAR_METHOD2
#define TEST_SUBROUTINE_NAME test_nest3
#include "test_nest.tpl"
#undef PAR_METHOD2
#undef TEST_SUBROUTINE_NAME

#define PAR_METHOD3
#define TEST_SUBROUTINE_NAME test_nest4
#include "test_nest.tpl"
#undef PAR_METHOD3
#undef TEST_SUBROUTINE_NAME

#define PAR_METHOD4
#define TEST_SUBROUTINE_NAME test_nest5
#include "test_nest.tpl"
#undef PAR_METHOD4
#undef TEST_SUBROUTINE_NAME

#define LATE_SINE

#define TEST_SUBROUTINE_NAME test_nest1l
#include "test_nest.tpl"
#undef TEST_SUBROUTINE_NAME

#define PAR_METHOD1
#define TEST_SUBROUTINE_NAME test_nest2l
#include "test_nest.tpl"
#undef PAR_METHOD1
#undef TEST_SUBROUTINE_NAME

#define PAR_METHOD2
#define TEST_SUBROUTINE_NAME test_nest3l
#include "test_nest.tpl"
#undef PAR_METHOD2
#undef TEST_SUBROUTINE_NAME

#define PAR_METHOD3
#define TEST_SUBROUTINE_NAME test_nest4l
#include "test_nest.tpl"
#undef PAR_METHOD3
#undef TEST_SUBROUTINE_NAME

#define PAR_METHOD4
#define TEST_SUBROUTINE_NAME test_nest5l
#include "test_nest.tpl"
#undef PAR_METHOD4
#undef TEST_SUBROUTINE_NAME
end program setmat