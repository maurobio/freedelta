BINDIR = .
OBJS = clib.o char.o chkd.o dir1.o dir4.o dir5.o dira.o dirg.o diru.o init.o\
 inou.o item.o main.o mess.o sent.o tdel.o tran.o wtps.o\
 tali.o tdis.o texi.o then.o tkey.o tnat.o tpau.o tpay.o\
 tnex.o tintc.o tinti.o tinti1.o tinti2.o tinti3.o tinti4.o\
 xggg.o

.SUFFIXES: .for

FC = gfortran
FFLAGS = -fno-backslash -O2 -finit-local-zero -static -static-libgfortran -w

all: confor
.PHONY: all

confor: $(OBJS)
	$(FC) $(FFLAGS) -o $@ $(OBJS) $(LDFLAGS)

.for.o:
	$(FC) -c $(FFLAGS) -o $@ $<

install: confor
	mv confor $(BINDIR)

clean:
	rm -f confor $(OBJS)
