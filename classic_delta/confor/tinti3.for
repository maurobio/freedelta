      SUBROUTINE RDMUL (IDAT, IWRD, IBIT, NS, IW, IB, ITPTR)                TINT
 
C  REVISED 24-OCT-88.
C  READS AND OUTPUTS NEXT MULTISTATE.
 
C  IDAT RECEIVES THE DATA BUFFER.
C  IWRD RECEIVES A POINTER TO THE WORD POSITION IN THE ITEM.
C  IBIT RECEIVES A POINTER TO THE BIT OFFSET IN THE ITEM.
C  NS RECEIVES THE NUMBER OF BITS TO TRANSFER.
C  IW RETURNS THE CURRENT WORD POSITION.
C  IB RETURNS THE CURRENT BIT POSITION.
C  ITPTR RECEIVES AND RETURNS A POINTER TO THE ITEM ON THE INPUT FILE.
 
      COMMON /DAOXXX/ IWOUT,IBOUT,IOUT(32)
      COMMON /LUNDAX/ LRECDA,IRECDA
      COMMON /LUNXXX/ LUNE,LUNL,LUNO,LUNP,LUNS1,LUNBO,LUNBI,LUNI,LUNDA,
     * LUNS2,LUNS3,LUNS4,LUNS5,LUNS6,LUNS7
      COMMON /SCR4XX/ LRECS4,IRECS4
      COMMON /WRDSIZ/ NBITS,NCHRWD
 
      DIMENSION IDAT(LRECS4)
      LOGICAL BITTST,IFSET
 
      IW = IWRD
      IB = IBIT
      IF (IB.GE.NBITS)  THEN
        IB = 0
        IW = IW + 1
      ENDIF
      IF (IW.GT.LRECS4)  THEN
        CALL RDSCRI (IDAT, ITPTR)
        IW = 1
      ENDIF
      JBIT = 1
 
  100 CONTINUE
        IF (IBOUT.GE.NBITS)  THEN
          IF (IWOUT.GE.LRECDA)  THEN
            CALL WRDAI (IOUT, IWOUT, LUNDA, LRECDA, IRECDA)
            CALL SETIA (IOUT, LRECDA, 0)
            IWOUT = 0
          ENDIF
          IWOUT = IWOUT + 1
          IBOUT = 0
        ENDIF
        IBOUT = IBOUT + 1
        IFSET = BITTST(IB+1, IDAT(IW), NBITS)
        IF (BITTST(IB+1, IDAT(IW), NBITS))
     *   CALL SETBIT (IBOUT, IOUT(IWOUT), NBITS)
        IF (JBIT.GE.NS) GOTO 200
        JBIT = JBIT + 1
        IB = IB + 1
        IF (IB.GE.NBITS)  THEN
          IB = 0
          IW = IW + 1
          IF (IW.GT.LRECS4)  THEN
            CALL RDSCRI (IDAT, ITPTR)
            IW = 1
          ENDIF
        ENDIF
      GOTO 100
 
  200 RETURN
      END
      SUBROUTINE RDTXTC (IT, IDAT, ITMPTR, ITPTR, LWD, NAFLG, LFLG)         TINT
 
C  REVISED 3-JUL-89.
C  READS AND OUTPUTS NEXT TEXT CHARACTER.
 
C  IT RECEIVES THE ITEM NUMBER.
C  IDAT RECEIVES THE DATA BUFFER.
C  ITMPTR RECEIVES AND RETURNS POINTERS TO THE ITEMS IN IDAT.
C  ITPTR RECEIVES AND RETURNS POINTERS TO THE ITEMS ON THE SCRATCH FILE.
C  LWD RETURNS THE NUMBER OF CHARACTERS OUTPUT.
C  NAFLG RECEIVES WORKING SPACE TO STORE BIT FLAGS FOR INAPPLICABLE
C   CHARACTERS.
 
      COMMON /DAOXXX/ IWOUT,IBOUT,IOUT(32)
      COMMON /LUNDAX/ LRECDA,IRECDA
      COMMON /LUNXXX/ LUNE,LUNL,LUNO,LUNP,LUNS1,LUNBO,LUNBI,LUNI,LUNDA,
     * LUNS2,LUNS3,LUNS4,LUNS5,LUNS6,LUNS7
      COMMON /SCR4XX/ LRECS4,IRECS4
      COMMON /TXOXXX/ OUTTXT
        CHARACTER*128 OUTTXT
      COMMON /WRDSIZ/ NBITS,NCHRWD
 
      DIMENSION IDAT(LRECS4),NAFLG(LFLG)
 
      IPTR = ITMPTR
 
      IF (IPTR.GT.LRECS4)  THEN
        CALL RDSCRI (IDAT, ITPTR)
        IPTR = 1
      ENDIF
 
      LITM = IDAT(IPTR)
      IPTR = IPTR + 1
 
      L = 0
      LWD = 0
   20 IF (L.GE.LITM)  GOTO 200
        IF (IPTR.GT.LRECS4)  THEN
          CALL RDSCRI (IDAT, ITPTR)
          IPTR = 1
        ENDIF
        NWD = IDAT(IPTR)
        IPTR = IPTR + 1
        LWD = LWD + NWD
        DO 100 I = 1, NWD
          IF (IPTR.GT.LRECS4)  THEN
            CALL RDSCRI (IDAT, ITPTR)
            IPTR = 1
          ENDIF
          IF (NWD.EQ.1.AND.IDAT(IPTR).LE.0)  THEN
            LWD = LWD - 1
            IF (IDAT(IPTR).LT.0)  CALL SETBIT (IT, NAFLG, NBITS)
          ELSE
            IWOUT = IWOUT + 1
            OUTTXT(IWOUT:IWOUT) = CHAR(IDAT(IPTR))
            IF (IWOUT.GE.LRECDA*NCHRWD)  THEN
              CALL WRTXT (OUTTXT(1:IWOUT), LUNDA, LRECDA, IRECDA)
              IWOUT = 0
            ENDIF
          ENDIF
          IPTR = IPTR + 1
  100   CONTINUE
        L = L + NWD + 1
        GOTO 20
 
  200 ITMPTR = IPTR
 
      RETURN
      END
