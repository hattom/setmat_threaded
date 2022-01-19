#ifndef LATE_SINE
#define RI1 ri=sin(real(ii, kind=r8))
#define RJ1 rj=sin(real(ij, kind=r8))
#define RK1 rk=sin(real(ik, kind=r8))
#define RL1 rl=sin(real(il, kind=r8))
#define RI2 !
#define RJ2 !
#define RK2 !
#define RL2 !
#else
#define RI1 !
#define RJ1 !
#define RK1 !
#define RL1 !
#define RI2 ri=sin(real(ii, kind=r8))
#define RJ2 rj=sin(real(ij, kind=r8))
#define RK2 rk=sin(real(ik, kind=r8))
#define RL2 rl=sin(real(il, kind=r8))
#endif

  
  subroutine TEST_SUBROUTINE_NAME
#ifdef _OPENMP
    use omp_lib, only : omp_get_wtime, omp_get_num_threads, omp_get_thread_num
#endif
    use iso_fortran_env, only : r8=>REAL64
    integer :: ii, ij, ik, il, irow, jcol
#if defined(PAR_METHOD3) || defined(PAR_METHOD4)
    integer :: tid, jcol_thread_min, jcol_thread_max, nthreads
    integer :: ipass
    integer, parameter :: npasses=2
#endif
    integer, parameter :: ni=100, nj=100, nk=200, nl=100
    real(kind=r8) :: ri, rj, rk, rl
    real(kind=r8) :: contrib
#ifdef _OPENMP
    real(kind=r8) :: time_start
    time_start = omp_get_wtime()
#else
    print *, 'Compiled without OpenMP support, no timer activated'
#endif
#if defined(PAR_METHOD1) || defined(PAR_METHOD2)
    !$omp parallel do private(irow, jcol, contrib, ri, rj, rk, rl)
#endif
#if defined(PAR_METHOD3) || defined(PAR_METHOD4)
!$omp parallel private(ii, ij, ik, il, irow, jcol, contrib, tid, nthreads, ri, rj, rk, rl, ipass)
#ifdef PAR_METHOD4
do ipass=0,npasses-1
#endif
#ifdef _OPENMP
    tid = omp_get_thread_num()
    nthreads = omp_get_num_threads()
#else
    tid = 0
    nthreads = 1
#endif
#ifdef PAR_METHOD3
    jcol_thread_min = ncols*tid/nthreads + 1
    jcol_thread_max = ncols*(tid+1)/nthreads
#else
    jcol_thread_min = ncols*(tid + nthreads*ipass)/(nthreads*npasses) + 1
    jcol_thread_max = ncols*(tid + nthreads*ipass + 1)/(nthreads*npasses)
#endif
#endif
    do ii = 1,ni
    RI1
    do ij = 1,nj
    RJ1
    do ik = 1,nk
    RK1
    do il = 1,nl
    RL1
      irow = mod( 2*ii +  3*ij +  5*ik +  7*il, nrows) + 1
      jcol = mod(11*ii + 13*ij + 17*ik + 23*il, ncols) + 1
#if defined(PAR_METHOD3) || defined(PAR_METHOD4)
      if(jcol >= jcol_thread_min .and. jcol <= jcol_thread_max) then
#endif
      RI2
      RJ2
      RK2
      RL2
      contrib = sin(ri + rj + rk + rl)
#ifdef PAR_METHOD2
      !$omp atomic update
#endif
      band%data(irow, jcol) = band%data(irow, jcol) + contrib
      !band%data(irow, jcol) = band%data(irow, jcol) + 1.
#if defined(PAR_METHOD3) || defined(PAR_METHOD4)
      endif
#endif
    enddo
    enddo
    enddo
    enddo
#if defined(PAR_METHOD1) || defined(PAR_METHOD2)
    !$omp end parallel do
#endif
#if defined(PAR_METHOD3) || defined(PAR_METHOD4)
#ifdef PAR_METHOD4
end do
#endif
    !$omp end parallel
#endif
#ifdef _OPENMP
    print *, band%data(30,30), omp_get_wtime() - time_start
#endif
  end subroutine TEST_SUBROUTINE_NAME

#undef RI1
#undef RJ1
#undef RK1
#undef RL1
#undef RI2
#undef RJ2
#undef RK2
#undef RL2