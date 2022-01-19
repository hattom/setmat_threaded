COMPILER = GCC

ifeq ($(COMPILER), GCC)
	FC = gfortran
	FFLAGS = -O3 -fopenmp -Jobj
	FFLAGS_PROPROC_ONLY = -E
else ifeq ($(COMPILER), NVHPC)
	FC=nvfortran
	FFLAGS=-O3 -mp -stdpar=multicore
else ifeq ($(COMPILER), Intel)
	FC=ifort
	FFLAGS=-O3 -qopenmp
endif

LDFLAGS = 

EXEC = test_setmat
OBJDIR=obj
F90SRC= test_setmat.F90 band_data.F90
F90OBJ  = $(addprefix $(OBJDIR)/,$(F90SRC:.F90=.o))

$(OBJDIR)/test_setmat.o: $(OBJDIR)/band_data.o test_nest.tpl

.DEFAULT_GOAL = all
.PHONY: all clean
all: $(EXEC)
preproc: $(OBJDIR)/test_setmat_preproced.f90

clean:
	-rm -rf $(OBJDIR)

$(EXEC): $(F90OBJ)
	$(FC) -o $@ $(FFLAGS) $(LDFLAGS) $^

$(OBJDIR)/%.o: %.F90
	@test -d $(@D) || mkdir -p $(@D)
	$(FC) -c -o $@ $(FFLAGS) $<

$(OBJDIR)/test_setmat_preproced.f90: test_setmat.F90 test_nest.tpl
	@test -d $(@D) || mkdir -p $(@D)
	$(FC) $(FFLAGS_PROPROC_ONLY) -o $@ $<
