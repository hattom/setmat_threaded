COMPILER = GCC

lc = $(subst A,a,$(subst B,b,$(subst C,c,$(subst D,d,$(subst E,e,$(subst F,f,$(subst G,g,$(subst H,h,$(subst I,i,$(subst J,j,$(subst K,k,$(subst L,l,$(subst M,m,$(subst N,n,$(subst O,o,$(subst P,p,$(subst Q,q,$(subst R,r,$(subst S,s,$(subst T,t,$(subst U,u,$(subst V,v,$(subst W,w,$(subst X,x,$(subst Y,y,$(subst Z,z,$1))))))))))))))))))))))))))


ifeq ($(call lc,$(COMPILER)), gcc)
	FC = gfortran
	FFLAGS = -O3 -fopenmp -Jobj
	# FFLAGS_PROPROC_ONLY = -E
else ifeq ($(call lc,$(COMPILER)), nvhpc)
	FC = nvfortran
	FFLAGS=-O3 -mp -stdpar=multicore -module obj
	# FFLAGS_PROPROC_ONLY = -E
else ifeq ($(call lc,$(COMPILER)), intel)
	FC = ifort
	FFLAGS=-O3 -qopenmp -module obj
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

# Hard-code gfortran for fpp, since Intel has no "-E" flag, and Intel's fpp works differently
# Revisit if we add compiler dependent preprocessing
$(OBJDIR)/test_setmat_preproced.f90: test_setmat.F90 test_nest.tpl
	@test -d $(@D) || mkdir -p $(@D)
	gfortran -E -fopenmp -o $@ $<
