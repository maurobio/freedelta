      SUBROUTINE INVDEP (ICDEP, INVLST, LIDAT, IMC, NSTAT, NC, LLST)        TINT
 
C  REVISED 16-JAN-89.
C  GENERATES INVERTED DEPENDENCY LIST.
 
C  ICDEP RECEIVES THE ORIGINAL DEPENDENCIES.
C  INVLST RETURNS THE INVERTED DEPENDENCY LIST.
C  LIDAT RECEIVES THE LENGTH OF ICDEP, INVLST.
C  IMC RECEIVES THE CHARACTER MASK.
C  NSTAT RECEIVES THE NUMBERS OF STATES.
C  NC RECEIVES THE NUMBER OF CHARACTERS.
C  LLST RETURNS THE LENGTH OF INVLST UTILISED.
 
      DIMENSION ICDEP(LIDAT),INVLST(LIDAT),IMC(NC),NSTAT(NC)
 
      NCM = NONZER (IMC, NC)
      CALL SETIA (INVLST, NCM, 0)
      NXT = NCM + 1
      ICM = 0
 
      DO 500 IC = 1, NC
        IF (IMC(IC).EQ.0)  GOTO 500
        ICM = ICM + 1
        IFIRST = 1
        KCM = 0
        DO 200 KC = 1, NC
          IF (IMC(KC).EQ.0)  GOTO 200
          KCM = KCM + 1
          IF (KC.EQ.IC)  GOTO 200
          IPTR = ICDEP(KC)
          IF (IPTR.EQ.0)  GOTO 200
          NS = NSTAT(KC)
          DO 100 IS = 1, NS
            ICNTRL = ICDEP(IPTR+IS-1)
            IF (ICNTRL.EQ.0)  GOTO 100
            NR = ICDEP(ICNTRL)
            DO 50 IR = 1, NR
              IB = ICDEP(ICNTRL+2*IR-1)
              IE = ICDEP(ICNTRL+2*IR)
              IF (IC.GE.IB.AND.IC.LE.IE)  THEN
                INVLST(NXT) = KCM
                IF (IFIRST.NE.0)  THEN
                  INVLST(ICM) = NXT
                  IFIRST = 0
                ENDIF
                NXT = NXT + 1
                GOTO 200
              ENDIF
   50       CONTINUE
  100     CONTINUE
  200   CONTINUE
  500 CONTINUE
 
      LLST = NXT - 1
 
      RETURN
      END
      SUBROUTINE MSKDEP (ICDEP, KCDEP, LIDAT, IMC, NSTAT, NC, LDEP)         TINT
 
C  REVISED 23-JAN-89.
C  COPIES DEPENDENCY DATA FOR MASKED-IN CHARACTERS.
 
C  ICDEP RECEIVES THE ORIGINAL DEPENDENCIES.
C  KCDEP RETURNS THE NEW DEPENDENCIES.
C  LIDAT RECEIVES THE LENGTH OF ICDEP, KCDEP.
C  IMC RECEIVES THE CHARACTER MASK.
C  NSTAT RECEIVES THE NUMBERS OF STATES.
C  NC RECEIVES THE NUMBER OF CHARACTERS.
C  LDEP RETURNS THE LENGTH OF KCDEP UTILISED.
 
      DIMENSION ICDEP(LIDAT),KCDEP(LIDAT),IMC(NC),NSTAT(NC)
 
      NEWCHN(I) = NONZER (IMC,I-1) + 1
 
C     LENGTH OF NEW DEPENDENCY ARRAY.
      LDEP = NONZER(IMC, NC)
 
      ICM = 0
      DO 500 IC = 1, NC
        IF (IMC(IC).EQ.0)  GOTO 500
        ICM = ICM + 1
        KCDEP(ICM) = 0
        IF (ICDEP(IC).EQ.0)  GOTO 500
        KCDEP(ICM) = LDEP + 1
        ICDPTR = ICDEP(IC)
        NS = NSTAT(IC)
 
C       COPY DEPENDENCIES TO NEW ARRAY.
        NXT = LDEP + NS
        DO 100 IS = 1, NS
          IF (ICDEP(ICDPTR+IS-1).EQ.0)  THEN
            KCDEP(LDEP+IS) = 0
          ELSE
            ICNTRL = ICDEP(ICDPTR+IS-1)
            NR = ICDEP(ICNTRL)
            KCDEP(LDEP+IS) = NXT + 1
            NRPTR = NXT + 1
            NXT = NXT + 1
C           COPY AND MASK DEPENDENCY RANGES.
            NRM = 0
            DO 50 IR = 1, NR
              IB = ICDEP(ICNTRL+2*IR-1)
              IE = ICDEP(ICNTRL+2*IR)
              IBM = 0
              IEM = 0
              DO 40 KC = IB, IE
                IF(IMC(KC).NE.0)  THEN
                  IF (IBM.EQ.0)  IBM = NEWCHN (KC)
                  IEM = NEWCHN (KC)
                  IF (KC.NE.IE)  GOTO 40
                ENDIF
                IF (IBM.EQ.0)  GOTO 40
                NRM = NRM + 1
                KCDEP(NXT+1) = IBM
                KCDEP(NXT+2) = IEM
                NXT = NXT + 2
                IBM = 0
                IEM = 0
   40         CONTINUE
   50       CONTINUE
            KCDEP(NRPTR) = NRM
            IF (NRM.EQ.0)  KCDEP(LDEP+IS) = 0
          ENDIF
  100   CONTINUE
 
C       ALL DEPENDENCIES MASKED OUT?
        IF (NONZER(KCDEP(LDEP+1),NS).EQ.0)  THEN
          KCDEP(ICM) = 0
        ELSE
          LDEP = NXT
        ENDIF
 
  500   CONTINUE
 
      RETURN
      END
