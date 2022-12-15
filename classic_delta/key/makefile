BINDIR = .
OBJS = clib.o main.o inou.o util.o genr.o outp.o wtps.o xggg.o

.SUFFIXES: .for

FC = gfortran
FFLAGS = -fno-backslash -O2 -finit-local-zero -static -static-libgfortran -w

all: key
.PHONY: all

key: $(OBJS)
	$(FC) $(FFLAGS) -o $@ $(OBJS) $(LDFLAGS)

.for.o:
	$(FC) -c $(FFLAGS) -o $@ $<

install: key
	mv -f key.exe $(BINDIR)

clean:
	rm -f key.exe $(OBJS)
