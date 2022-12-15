BINDIR = .
OBJS = inou.o main.o xggg.o

.SUFFIXES: .for

FC = gfortran
FFLAGS = -fno-backslash -O2 -finit-local-zero -static -static-libgfortran -w

all: dist
.PHONY: all

dist: $(OBJS)
	$(FC) $(FFLAGS) -o $@ $(OBJS) $(LDFLAGS)

.for.o:
	$(FC) -c $(FFLAGS) -o $@ $<

install: dist
	mv -f dist.exe $(BINDIR)

clean:
	rm -f dist.exe $(OBJS)
