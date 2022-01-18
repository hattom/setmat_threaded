module band_data
  use iso_fortran_env, only : r8 => REAL64
  implicit none

  private
  public :: band_data_type, band, init_band, reset_band

  type band_data_type
    real(kind=r8), allocatable, dimension(:,:) :: data
    integer :: dim1, dim2
  end type band_data_type
  type(band_data_type) :: band

  contains

  subroutine init_band(dim1, dim2)
    integer, intent(in) :: dim1, dim2
    band%dim1 = dim1
    band%dim2 = dim2
    allocate(band%data(dim1, dim2))
    band%data(:,:) = 0.0
  end subroutine init_band

  subroutine reset_band
    band%data(:,:) = 0.0
  end subroutine reset_band
end module band_data
