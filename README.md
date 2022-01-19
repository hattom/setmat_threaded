# setmat_threaded

How best to accelerate (with threads) some matrix assembly code where the array access pattern is complicated.

Proxy application for assembling an FEM matrix with a Lapack general banded representation.


## Output
```
$ make; export OMP_NUM_THREADS=4; ./test_setmat
gfortran -c -o obj/band_data.o -O3 -fopenmp band_data.F90
gfortran -c -o obj/test_setmat.o -O3 -fopenmp test_setmat.F90
gfortran -o test_setmat -O3 -fopenmp  obj/test_setmat.o obj/band_data.o
 Early SINE
   10.319533966154633        20.054816200048663
   10.374677401430977        5.4544377999845892
   10.319533966154346        7.4213781000580639
   10.319533966154633        15.378228500019759
   10.319533966154633        25.649740899913013
 Late SINE
   10.319533966154633        24.450728600029834
   10.319533966154452        6.4496109999017790
   10.319533966154490        8.0782184000127017
   10.319533966154633        15.564078600029461
   10.319533966154633        15.605280900024809
```
The first column is the result, the second column is the time taken.
The 5 different rows in a section are 5 methods, the 2 sections are whether the intermediate results are calculated immediately, or in the inner loop.
