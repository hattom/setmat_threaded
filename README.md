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
  -26.958779532055757        8.5623601999832317
  -26.089577225413056        2.7279792999615893
  -26.958779532055800        3.6023933999822475
  -26.958779532055757        6.1092030999716371
  -26.958779532055757        10.531480300007388
 Late SINE
  -26.958779532055757        10.816243800043594
  -26.958779532055761        2.9414764000102878
  -26.958779532055711        3.5216670000227168
  -26.958779532055757        6.0641567000420764
  -26.958779532055757        7.7067743999650702
```
The first column is the result, the second column is the time taken.
The 5 different rows in a section are 5 methods, the 2 sections are whether the intermediate results are calculated immediately, or in the inner loop.
