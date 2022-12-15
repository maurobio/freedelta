      SUBROUTINE BLKLIN (NLINES)                                            OUTP
 
C* REVISED 6/8/87.
C* FINISHES THE CURRENT LINE, AND OUTPUTS BLANK LINES.
 
C  NLINES RECEIVES THE NUMBER OF BLANK LINES TO BE OUTPUT.
 
      COMMON /IOBUFX/ IOUT
      CHARACTER*200 IOUT
      COMMON /IOPARX/ JOUT,IENDWD,IBINARY
      COMMON /LUUXXX/ LUNOUT
      COMMON /SYMXXX/ BLANK,STOP,SEMIC,LBRAC,RBRAC,RANGE,STAR,UPAROW,
     *            COMMA,COLON,NUMERO,LABRAC,RABRAC,LBRACE,RBRACE,BSLSH
      CHARACTER*1 BLANK,STOP,SEMIC,LBRAC,RBRAC,RANGE,STAR,UPAROW,
     *            COMMA,COLON,NUMERO,LABRAC,RABRAC,LBRACE,RBRACE,BSLSH
 
 
      IF (JOUT.GT.0)  CALL WRTREC (IOUT(1:JOUT), LUNOUT)
 
      IF (NLINES.GT.0)  THEN
        DO 10 L = 1, NLINES
          CALL WRTREC (BLANK, LUNOUT)
   10   CONTINUE
      ENDIF
 
      JOUT = 0
      IENDWD = -1
 
      RETURN
      END
      SUBROUTINE CAP (C, ICAP)                                              OUTP
 
C* REVISED 1-NOV-88.
C* CHANGES NEXT SUITABLE SYMBOL TO UPPER CASE.
 
C  C RECEIVES AND RETURNS THE SYMBOL, IN ASCII CODE.
C  ICAP RETURNS 0 IF A SYMBOL WAS CHANGED, OR IF A SUITABLE SYMBOL
C    WAS ALREADY UPPER CASE OR NUMERIC. OTHERWISE, ICAP IS UNALTERED.
 
      CHARACTER*1 C
      DIMENSION KCAP(0:255)
 
      DATA KCAP/ 32*0,
     N  16*0,48,49,50,51,52,53,54,55,56,57,6*0,
     A  0,65,66,67,68,69,70,71, 72,73,74,75,76,77,78,79,
     P  80,81,82,83,84,85,86,87, 88,89,90,5*0,
     G  0,65,66,67,68,69,70,71, 72,73,74,75,76,77,78,79,
     P  80,81,82,83,84,85,86,87, 88,89,90,5*0,
     C  128,154,144,65,142,65,143,128, 69,69,69,73,73,73,142,143,
     E  144,146,146,79,153,79,85,85, 89,153,154,5*0,
     A  65,73,79,85,165,165,2*0, 8*0,  80*0/
 
      IF (IGNOR(C).NE.0) GOTO 100
 
      I = ICHAR(C)
C     I = I - 128                                                             1*
      IF (KCAP(I).NE.0) THEN
        K = KCAP(I)
C       K = K + 128                                                           1*
        C = CHAR(K)
        ICAP = 0
      ENDIF
 
  100 RETURN
      END
      SUBROUTINE DESTND (ND, NODEND)                                        OUTP
 
C  REVISED 24/2/86.
C  OUTPUTS DESTINATION NODE.
 
C  ND RECEIVES THE NODE NUMBER.
C  NODEND RECEIVES WHETHER THIS IS THE LAST BRANCH IN THE NODE.
 
      COMMON /IOPARX/ JOUT,IENDWD,IBINARY
      COMMON /FMTXXX/ ITAB,LFOUT,LTXOUT,KCOLS,MAXWID
      COMMON /SYMXXX/ BLANK,STOP,SEMIC,LBRAC,RBRAC,RANGE,STAR,UPAROW,
     *            COMMA,COLON,NUMERO,LABRAC,RABRAC,LBRACE,RBRACE,BSLSH
      CHARACTER*1 BLANK,STOP,SEMIC,LBRAC,RBRAC,RANGE,STAR,UPAROW,
     *            COMMA,COLON,NUMERO,LABRAC,RABRAC,LBRACE,RBRACE,BSLSH
      COMMON /TPSXXX/ ITPSET,MAXTYPMK,NTYPMK,LTYPMK,INTYPMKS
 
C    FINISH FEATURE DESCRIPTION WITH A FULL STOP.
      CALL JSTOUT (STOP, 1, -1, LFOUT)
 
C    FIND THE LENGTH OF ND.
      L = NUMDIG(ND)
 
C      IF (ITPSET.GT.0)  THEN
C 
C        CALL JSTOUT (BLANK, 1, -1, LFOUT)
C        CALL JSTTPS (15, -1, LFOUT)
C        CALL JSTI (ND, -1, LFOUT)
C        CALL JSTTPS (20, -1, LFOUT)
C        IF (NODEND.NE.0)  THEN
C          CALL JSTOUT (BLANK, 1, 0, LFOUT)
C          CALL JSTTPS (11, -1, LFOUT)
C        ENDIF
C 
C      ELSE
 
        IF (JOUT+L+1.GT.LFOUT)  THEN
          CALL DOTFIL (LFOUT)
          CALL ENDLN
          CALL INDEN (ITAB+3)
        ENDIF
        IFILL = LFOUT - L - 1
        CALL DOTFIL (IFILL)
        CALL JSTOUT (BLANK, 1, -1, LFOUT)
        CALL JSTI (ND, 0, LFOUT)
 
C      ENDIF
 
      CALL ENDLN
 
      RETURN
      END
      SUBROUTINE DOTFIL (ICOL)                                              OUTP
 
C  REVISED 14/2/86.
C  DOT FILLS THE CURRENT LINE UP TO COLUMN ICOL.
 
      COMMON /IOBUFX/ IOUT
      CHARACTER*200 IOUT
      COMMON /IOPARX/ JOUT,IENDWD,IBINARY
      COMMON /SYMXXX/ BLANK,STOP,SEMIC,LBRAC,RBRAC,RANGE,STAR,UPAROW,
     *            COMMA,COLON,NUMERO,LABRAC,RABRAC,LBRACE,RBRACE,BSLSH
      CHARACTER*1 BLANK,STOP,SEMIC,LBRAC,RBRAC,RANGE,STAR,UPAROW,
     *            COMMA,COLON,NUMERO,LABRAC,RABRAC,LBRACE,RBRACE,BSLSH
 
 
   10 IF (JOUT+1.GT.ICOL)  GOTO 20
        JOUT = JOUT + 1
        IOUT(JOUT:JOUT) = STOP
        GOTO 10
 
   20 RETURN
      END
      SUBROUTINE ENDLN                                                      OUTP
 
C  REVISED 26-MAR-99.
C  FINISHES THE CURRENT LINE.
 
      COMMON /LUOXXX/ NUN,LPRINT,LTOP,LUNCOM(10),LUNPRE(10),
     *  LUNUSE(13),LUNREC(13),LUNPAG(13)
      COMMON /LUUXXX/ LUNOUT
 
      CHARACTER*2 STR
      PARAMETER (ICR=13, LF=10)
 
      CALL BLKLIN (0)
 
C     Terminate binary record.
      IF (LUNUSE(LUNOUT).EQ.10) THEN
        STR(1:1) = CHAR(ICR)
        STR(2:2) = CHAR(LF)
        CALL WRECB (STR, LUNOUT)
      ENDIF
 
      RETURN
      END
      SUBROUTINE GETFS (JF, FBUF, LFBUF, FREC, FMEM, FLADDR, NSTAT, NF,     OUTP
     * IFL, NDESC)
 
C  REVISED 24/5/85.
C  READS FEATURE/STATE DESCRIPTION FROM DIRECT-ACCESS FILE.
 
C  JF RECEIVES THE FEATURE NUMBER.
C  FBUF RECEIVES THE BUFFER FOR STORING THE DESCRIPTION.
C  LFBUF RECEIVES THE LENGTH OF FBUF.
C  FREC RECEIVES THE FEATURE RECORD ADDRESSES.
C  FMEM RECEIVES THE FEATURE MEMORY ADDRESSES.
C  FLADDR RECEIVES POINTERS TO DESCRIPTION LENGTHS.
C  NSTAT RECEIVES THE NUMBERS OF STATES.
C  NF RECEIVES THE NUMBER OF FEATURES.
C  IFL RECEIVES THE DESCRIPTION LENGTHS.
C  NDESC RECEIVES THE NUMBER OF DESCRIPTIONS.
 
      COMMON /FBUFXX/ NEXT
      COMMON /LUNXXX/ LUNI,LUNC,LUNT,LUNO,LUNP,LUNS,LUNS1,LUNE,LUNL,LUNB
 
      CHARACTER*1 FBUF(LFBUF)
      INTEGER FREC(NF),FMEM(NF),FLADDR(NF),NSTAT(NF),IFL(NDESC)
 
C     CHECK IF ALREADY IN MEMORY.
      IF (FMEM(JF).NE.0)  GOTO 100
 
      IPTR = FLADDR(JF)
      NSTR = NSTAT(JF) + 1
 
C     CALCULATE THE TOTAL LENGTH OF THE DESCRIPTION.
      LEN = 0
      DO 10 IS = 1, NSTR
        LEN = LEN + IFL(IPTR)
        IPTR = IPTR + 1
   10   CONTINUE
 
C     CHECK IF ENOUGH SPACE IN BUFFER.
      IF (LEN.GT.LFBUF)  GOTO 200
      IF (LEN.GT.LFBUF-NEXT+1)  NEXT = 1
 
C     NOTE ANY DESCRIPTIONS THAT WILL BE OVERWRITTEN.
      IEND = NEXT + LEN - 1
      DO 20 IF = 1, NF
        IF (FMEM(IF).LE.IEND .AND. FMEM(IF).GE.NEXT)  FMEM(IF) = 0
   20   CONTINUE
 
      IREC = FREC(JF) + 1
      FMEM(JF) = NEXT
      CALL RDCSTR (FBUF(NEXT), LEN, IREC, LUNC)
 
  100 IPTR = FLADDR(JF)
      RETURN
 
  200 CALL FERROR('Insufficient space to store character description.%')
      END
      SUBROUTINE GETTPS (NW, ITYPMK, IB, LEN)                               OUTP
 
C  REVISED 11-MAR-99.
C  RETURNS THE LOCATION AND LENGTH OF A SPECIFIED TYPESETTING MARK
C   WITHIN ITYPMK.
 
C  NW RECEIVES THE NUMBER OF THE TYPESETTING MARK.
C  ITYPMK RECEIVES THE TYPESETTING MARKS.
C  LTYPMK RECEIVES THE LENGTH OF ITYPMK.
C  IB RETURNS THE LOCATION OF THE START OF THE TYPESETTING MARK.
C  LEN RETURNS THE LENGTH OF THE START OF THE TYPESETTING MARK.
 
      COMMON /TPSXXX/ ITPSET,MAXTYPMK,NTYPMK,LTYPMK,INTYPMKS
 
      DIMENSION ITYPMK(LTYPMK)
 
      LEN = 0
      IF (NW.LE.0.OR.NW.GT.NTYPMK)  THEN
        CALL ERROR(0, 'Undefined typesetting mark.%')
      ELSE
        IF (ITYPMK(NW).GT.0)  THEN
          IB = ITYPMK(NW)
          LEN = ITYPMK(IB) - 3
        ENDIF
      ENDIF

      RETURN
      END
      FUNCTION   IGNOR (C)                                                  OUTP
 
C* REVISED 22-JAN-99.
C* DETERMINES WHETHER SYMBOL IS PART OF AN RTF CONTROL WORD.
 
C  THE FUNC. RETURNS 1 IF K IS PART OF A CONTROL WORD, 0 OTHERWISE.
C  K RECEIVES THE CHARACTER.
C  ICMD IN COMMON BLOCK IGNXXX MUST BE SET TO 0 BEFORE THE FIRST CALL.

      COMMON /SYMXXX/ BLANK,STOP,SEMIC,LBRAC,RBRAC,RANGE,STAR,UPAROW,
     *            COMMA,COLON,NUMERO,LABRAC,RABRAC,LBRACE,RBRACE,BSLSH
      CHARACTER*1 BLANK,STOP,SEMIC,LBRAC,RBRAC,RANGE,STAR,UPAROW,
     *            COMMA,COLON,NUMERO,LABRAC,RABRAC,LBRACE,RBRACE,BSLSH
 
      CHARACTER*1 C
 
      IGNOR = 0
      IF (ICMD.NE.0)  THEN
        IGNOR = 1
        IF (ICMD.EQ.1.AND.C.EQ.BSLSH) THEN
C       \\ i.e. a simple backslash
          ICMD = 0
          IGNOR = 0
        ELSE IF (C.EQ.BSLSH) THEN
C         Start of new RTF command.
          ICMD = 1
        ELSE IF (C.EQ.LBRACE) THEN
C       {
          CONTINUE
        ELSE IF (C.EQ.' '.OR.
     *           (ISNUM(C).EQ.0.AND.ISALPHA(C).EQ.0)) THEN
C       Terminator found.
          ICMD = 0
        ELSE
C       Within control word.
          ICMD = 2
        ENDIF
      ELSE IF (C.EQ.BSLSH)  THEN 
        ICMD = 1
        IGNOR = 1
      ENDIF
 
      RETURN
      END
C      FUNCTION   IGNOR(C)                                                   OUTP
C 
CC* REVISED 1-NOV-88.
CC* DETERMINES WHETHER SYMBOL IS PART OF TYPESETTING CODE.
C 
CC  THE FUNC. RETURNS 1 IF C IS TYPESETTING CODE, 0 OTHERWISE.
CC  C RECEIVES THE CHARACTER.
CC  ICMD IN COMMON BLOCK IGNXXX MUST BE SET TO 0 BEFORE THE FIRST CALL.
C 
C      CHARACTER*1 C
C      DIMENSION IGTYPE(0:255)
C 
C      COMMON /IGNXXX/ ICMD
C 
CC     IGTYPE VALUES (SEE PROG. TYPSET, BY M.J. DALLWITZ).
CC       1 - OPENING BRACKET. 2 - BACKSLASH OR CLOSING BRACKET.
CC       3 - COMMANDS. 4 - OTHER SYMBOLS.
C      DATA IGTYPE/ 32*4, 3,3,26*4,3,4,3,4, 4,26*3,1,2,2,3,3,
C     *  4,26*3,4,3,4,4,4, 128*4/
C 
C      IGNOR = 0
C 
C      K = ICHAR(C)
CC     K = K - 128                                                             1*
C      IF (ICMD.EQ.0.AND.IGTYPE(K).GE.3)  RETURN
C 
C      J = IGTYPE(K)
C      GO TO (10,20,20,40), J
C 
C   10 ICMD = 1
C      GO TO 90
C 
C   20 ICMD = 0
C      GO TO 90
C 
C   40 IF (ICMD.EQ.0)  GO TO 100
C 
C   90 IGNOR = 1
C 
C  100 RETURN
C      END
      SUBROUTINE INDEN (ICOL)                                               OUTP
 
C  REVISED 14/2/86.
C  BLANK FILLS TO COLUMN ICOL.
 
 
      COMMON /IOBUFX/ IOUT
      CHARACTER*200 IOUT
      COMMON /IOPARX/ JOUT,IENDWD,IBINARY
      COMMON /SYMXXX/ BLANK,STOP,SEMIC,LBRAC,RBRAC,RANGE,STAR,UPAROW,
     *            COMMA,COLON,NUMERO,LABRAC,RABRAC,LBRACE,RBRACE,BSLSH
      CHARACTER*1 BLANK,STOP,SEMIC,LBRAC,RBRAC,RANGE,STAR,UPAROW,
     *            COMMA,COLON,NUMERO,LABRAC,RABRAC,LBRACE,RBRACE,BSLSH
 
   10 IF (JOUT+1.GT.ICOL)  GOTO 20
        JOUT = JOUT + 1
        IOUT(JOUT:JOUT) = BLANK
        GOTO 10
 
   20 RETURN
      END
      SUBROUTINE INKOD (INT, CSTR, LOUT)                                    OUTP
 
C  REVISED 25/6/86.
C  ENCODES AN INTEGER, LEFT-JUSTIFIED, IN A CHARACTER STRING.
 
C  INT RECEIVES THE INTEGER.
C  CSTR RECEIVES THE CHARACTER STRING.
C  LOUT RETURNS THE ACTUAL LENGTH OF THE ENCODED INTEGER.
 
      CHARACTER*(*) CSTR
 
      COMMON /SYMXXX/ BLANK,STOP,SEMIC,LBRAC,RBRAC,RANGE,STAR,UPAROW,
     *            COMMA,COLON,NUMERO,LABRAC,RABRAC,LBRACE,RBRACE,BSLSH
      CHARACTER*1 BLANK,STOP,SEMIC,LBRAC,RBRAC,RANGE,STAR,UPAROW,
     *            COMMA,COLON,NUMERO,LABRAC,RABRAC,LBRACE,RBRACE,BSLSH
 
      CHARACTER*10 TMP                                                        =*
      PARAMETER (MAXDIG=10)                                                   =*
 
      LSTR = LEN (CSTR)
 
      WRITE(TMP,10)INT
   10 FORMAT(I10)
 
      DO 20 I = MAXDIG, 1, -1
        IF (TMP(I:I).EQ.BLANK)  GOTO 30
   20   CONTINUE
      I = 0
 
   30 LOUT = MAXDIG - I
      IF (LOUT.GT.LSTR)
     * CALL FERROR ('Integer too large for output field.%')
      CSTR(1:LOUT) = TMP(I+1:MAXDIG)
 
  100 RETURN
      END
      FUNCTION ISALPHA (CHAR)                                               OUTP
 
C* REVISED 08-MAR-99.
C* CHECKS TO SEE IF A CHARACTER IS ALPHABETIC.

      INTEGER ALPHATBL(0:255)
      CHARACTER*1 CHAR
 
C     ALPHATBL was generated using the Windows API function IsCharAlpha
      DATA ALPHATBL/
     * 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
     * 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
     * 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
     * 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
     * 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1,
     * 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
     * 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0,
     * 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1,
     * 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
     * 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1,
     * 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1,
     * 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
     * 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1/
 
      ISALPHA = 0
      IF (ALPHATBL(ICHAR(CHAR)).NE.0)  ISALPHA = 1
      RETURN
      END
      FUNCTION   ISNUM (CHAR)                                               OUTP
 
C* REVISED 27/5/85.
C* CHECKS TO SEE IF A CHARACTER IS NUMERIC.
 
C  CHAR RECEIVES THE CHARACTER.
C  ISNUM RETURNS 0 IF NOT NUMERIC, 1 IF NUMERIC.
 
      CHARACTER*1 NUM(10),CHAR
      DATA NUM /'0','1','2','3','4','5','6','7','8','9'/
 
      ISNUM = 0
      DO 10 K = 1, 10
        IF (CHAR.EQ.NUM(K))  GO TO 20
   10   CONTINUE
      GO TO 30
 
   20 ISNUM = 1
 
   30 RETURN
      END
      SUBROUTINE JSTI (INT, IE, LWIDTH)                                     OUTP
 
C  REVISED 17/11/86.
C  OUTPUTS AN INTEGER.
 
      COMMON /CWRKXX/ CTMP
      CHARACTER*10 CTMP
 
      CALL INKOD (INT, CTMP, LOUT)
      CALL JSTSTR (CTMP(1:LOUT), IE, LWIDTH)
 
      RETURN
      END
      SUBROUTINE JSTOTP (IBF, LBF, IE, LWIDTH)                              OUTP
 
C* REVISED 21-APR-99.
C* PRODUCES JUSTIFIED OUTPUT, OMITTING TYPESETTING INSTRUCTIONS,
C    IF REQUIRED.
 
C  PARAMETERS AS FOR JSTOUT.
 
C     DIMENSION OF IWRK MUST BE SAME AS LENGTH OF IOUT IN /IOBUFX/.
      CHARACTER*1 IBF(LBF),TMP(2048),IWRK(200)                                          =*
      PARAMETER (LTMP=2048)
 
      COMMON /CAPXXX/ ICAP
      COMMON /TPSXXX/ ITPSET,MAXTYPMK,NTYPMK,LTYPMK,INTYPMKS
      COMMON /SYMXXX/ BLANK,STOP,SEMIC,LBRAC,RBRAC,RANGE,STAR,UPAROW,
     *            COMMA,COLON,NUMERO,LABRAC,RABRAC,LBRACE,RBRACE,BSLSH
      CHARACTER*1 BLANK,STOP,SEMIC,LBRAC,RBRAC,RANGE,STAR,UPAROW,
     *            COMMA,COLON,NUMERO,LABRAC,RABRAC,LBRACE,RBRACE,BSLSH
 
      IF (ITPSET.EQ.0)  GO TO 400
C      IF (ITPSET.GT.0)  GO TO 200
 
C     Will it fit?
      IF (LBF.GT.LTMP)  GOTO 400
 
C     Work on a copy.
      CALL COPSA (IBF, TMP, LBF)
      LNEW = LBF
      CALL REMTYP (TMP, LNEW)

      J = 0
      DO 100 I = 1, LNEW
        J = J + 1
        IWRK(J) = TMP(I)
        IF (IWRK(J).NE.BLANK)  GO TO 100
        CALL JSTOUT (IWRK, J, 0, LWIDTH)
        J = 0
  100   CONTINUE
      GO TO 310
 
C     CHECK FOR "-" BETWEEN NUMERICS AND INSERT EN DASH.
C 
C  200 J = 0
C      DO 300 I = 1, LBF
C      IF (IBF(I).NE.RANGE)  GO TO 290
C        K = I - 1
C  210   IF (K.LE.0)  GO TO 290
C        IF (IBF(K).NE.BLANK)  GO TO 220
C          K = K - 1
C          GO TO 210
C 
C  220   IF (ISNUM(IBF(K)).EQ.0)  GO TO 290
C 
C        K = I + 1
C  230   IF (K.GT.LBF)  GO TO 290
C        IF (IBF(K).NE.BLANK)  GO TO 240
C          K = K + 1
C          GO TO 230
C 
C  240   IF (ISNUM(IBF(K)).EQ.0)  GO TO 290
C        IF (J.GT.0)  CALL JSTOUT (IWRK, J, -1, LWIDTH)
C        J = 0
C        CALL JSTTPS (6, -1, LWIDTH)
C        GO TO 300
C 
C  290 J = J+1
C      IWRK(J) = IBF(I)
C      IF (IWRK(J).NE.BLANK)  GO TO 300
C      CALL JSTOUT (IWRK, J, 0, LWIDTH)
C      J = 0
C 
C  300 CONTINUE
C 
  310 IF (J.GT.0)  CALL JSTOUT (IWRK, J, -1, LWIDTH)
      IF (IE.GE.0)  THEN
        CALL JSTOUT (BLANK, 1, IE, LWIDTH)
      ENDIF
      GO TO 500
 
  400 CALL JSTOUT (IBF, LBF, IE, LWIDTH)
 
  500 RETURN
      END
      SUBROUTINE JSTOUT (STR, LSTR, IE, LWIDTH)                             OUTP
 
C* REVISED 30-MAR-99.
C* PRODUCES JUSTIFIED OUTPUT.
 
 
C  STR RECEIVES THE CHARACTER STRING TO BE OUTPUT.
C  LSTR RECEIVES THE NUMBER OF CHARACTERS TO BE OUTPUT.
C  IE RECEIVES A FLAG SPECIFYING THE ACTION TO BE TAKEN AFTER LSTR
C   CHARACTERS HAVE BEEN OUTPUT.
C   IF IE.LT.0, THE LAST WORD IS LEFT UNFINISHED.
C   IF IE.EQ.0, THE LAST WORD IS FINISHED.
C   IF IE.GT.0, THE LINE IS FINISHED AND (IE-1) BLANK LINES ARE OUTPUT.
C  LWIDTH RECEIVES THE OUTPUT WIDTH.
 
 
      COMMON /CAPXXX/ ICAP
      COMMON /FMTXXX/ ITAB,LFOUT,LTXOUT,KCOLS,MAXWID
      COMMON /IGNXXX/ ICMD
      COMMON /IOBUFX/ IOUT
      CHARACTER*200 IOUT
      COMMON /IOPARX/ JOUT,IENDWD,IBINARY
      COMMON /LUNXXX/ LUNI,LUNC,LUNT,LUNO,LUNP,LUNS,LUNS1,LUNE,LUNL,LUNB
      COMMON /LUUXXX/ LUNOUT
      COMMON /PARXXX/ NFB,NFE,JFB,NVAR,NEWLN,NT,NTD,NTA,NO,KN,NUSED,
     *                INCOMP,VARW,NTR,RBASE,ABASE,REUSE,VARYWT,NCONF,
     *                NSET,RES,ITUNKV,IADCNO,ITCHV,IRTF,IHTML
      COMMON /SYMXXX/ BLANK,STOP,SEMIC,LBRAC,RBRAC,RANGE,STAR,UPAROW,
     *            COMMA,COLON,NUMERO,LABRAC,RABRAC,LBRACE,RBRACE,BSLSH
      CHARACTER*1 BLANK,STOP,SEMIC,LBRAC,RBRAC,RANGE,STAR,UPAROW,
     *            COMMA,COLON,NUMERO,LABRAC,RABRAC,LBRACE,RBRACE,BSLSH
 
      CHARACTER*8 HTML(32:255)
      CHARACTER*256 REPLSTR
      PARAMETER (MAXHTML=8)
      CHARACTER*1 STR(LSTR),CHAR
 
      DATA (HTML(I),I=32,100)
C  32    
     * /'        ',
C  33 !  
     * '        ',
C  34 "  
     * '        ',
C  35 #  
     * '        ',
C  36 $  
     * '        ',
C  37 %  
     * '        ',
C  38 & (&amp;)  
     * '&amp;   ',
C  39 '  
     * '&#146;  ',
C  40 (  
     * '        ',
C  41 )  
     * '        ',
C  42 *  
     * '        ',
C  43 +  
     * '        ',
C  44 ,  
     * '        ',
C  45 -  
     * '        ',
C  46 .  
     * '        ',
C  47 /  
     * '        ',
C  48 0  
     * '        ',
C  49 1  
     * '        ',
C  50 2  
     * '        ',
C  51 3  
     * '        ',
C  52 4  
     * '        ',
C  53 5  
     * '        ',
C  54 6  
     * '        ',
C  55 7  
     * '        ',
C  56 8  
     * '        ',
C  57 9  
     * '        ',
C  58 :  
     * '        ',
C  59 ;  
     * '        ',
C  60 < (&lt;)  
     * '        ',
C  61 =  
     * '        ',
C  62 > (&gt;)
     * '        ',
C  63 ?  
     * '        ',
C  64 @  
     * '        ',
C  65 A  
     * '        ',
C  66 B  
     * '        ',
C  67 C  
     * '        ',
C  68 D  
     * '        ',
C  69 E  
     * '        ',
C  70 F  
     * '        ',
C  71 G  
     * '        ',
C  72 H  
     * '        ',
C  73 I  
     * '        ',
C  74 J  
     * '        ',
C  75 K  
     * '        ',
C  76 L  
     * '        ',
C  77 M  
     * '        ',
C  78 N  
     * '        ',
C  79 O  
     * '        ',
C  80 P  
     * '        ',
C  81 Q  
     * '        ',
C  82 R  
     * '        ',
C  83 S  
     * '        ',
C  84 T  
     * '        ',
C  85 U  
     * '        ',
C  86 V  
     * '        ',
C  87 W  
     * '        ',
C  88 X  
     * '        ',
C  89 Y  
     * '        ',
C  90 Z  
     * '        ',
C  91 [  
     * '        ',
C  92 \  
     * '\       ',
C  93 ]  
     * '        ',
C  94 ^  
     * '        ',
C  95 _  
     * '        ',
C  96 `  
     * '&#145;  ',
C  97 a  
     * '        ',
C  98 b  
     * '        ',
C  99 c  
     * '        ',
C  100 d 
     * '        '/
      DATA (HTML(I),I=101,200)
C  101 e 
     */'        ',
C  102 f 
     * '        ',
C  103 g 
     * '        ',
C  104 h 
     * '        ',
C  105 i 
     * '        ',
C  106 j 
     * '        ',
C  107 k 
     * '        ',
C  108 l 
     * '        ',
C  109 m 
     * '        ',
C  110 n 
     * '        ',
C  111 o 
     * '        ',
C  112 p 
     * '        ',
C  113 q 
     * '        ',
C  114 r 
     * '        ',
C  115 s 
     * '        ',
C  116 t 
     * '        ',
C  117 u 
     * '        ',
C  118 v 
     * '        ',
C  119 w 
     * '        ',
C  120 x 
     * '        ',
C  121 y 
     * '        ',
C  122 z 
     * '        ',
C  123 { 
     * '        ',
C  124 | 
     * '        ',
C  125 } 
     * '        ',
C  126 ~ 
     * '        ',
C  127 (ox7f)
     * '&#127;  ',
C  128 (ox80)
     * '&#127;  ',
C  129 (ox81)
     * '&#127;  ',
C  130 (ox82)
     * '&#130;  ',
C  131 (ox83)
     * '&#131;  ',
C  132 (ox84)
     * '&#132;  ',
C  133 (ox85)
     * '&#133;  ',
C  134 (ox86)
     * '&#134;  ',
C  135 (ox87)
     * '&#135;  ',
C  136 (ox88)
     * '&#136;  ',
C  137 (ox89)
     * '&#137;  ',
C  138 (ox8a)
     * '&#138;  ',
C  139 (ox8b)
     * '&#139;  ',
C  140 (ox8c)
     * '&#140;  ',
C  141 (ox8d)
     * '&#127;  ',
C  142 (ox8e)
     * '&#127;  ',
C  143 (ox8f)
     * '&#127;  ',
C  144 (ox90)
     * '&#127;  ',
C  145 (ox91)
     * '&#145;  ',
C  146 (ox92)
     * '&#146;  ',
C  147 (ox93)
     * '&#147;  ',
C  148 (ox94)
     * '&#148;  ',
C  149 (ox95)
     * '&#149;  ',
C  150 (ox96)
     * '&#150;  ',
C  151 (ox97)
     * '&#151;  ',
C  152 (ox98)
     * '&#152;  ',
C  153 (ox99)
     * '&#153;  ',
C  154 (ox9a)
     * '&#154;  ',
C  155 (ox9b)
     * '&#155;  ',
C  156 (ox9c)
     * '&#156;  ',
C  157 (ox9d)
     * '&#127;  ',
C  158 (ox9e)
     * '&#127;  ',
C  159 (ox9f)
     * '&#159;  ',
C  160 (oxa0)
     * '&nbsp;  ',
C  161 (oxa1)
     * '&#161;  ',
C  162 (oxa2)
     * '&#162;  ',
C  163 (oxa3)
     * '&#163;  ',
C  164 (oxa4)
     * '&#164;  ',
C  165 (oxa5)
     * '&#165;  ',
C  166 (oxa6)
     * '&#166;  ',
C  167 (oxa7)
     * '&#167;  ',
C  168 (oxa8)
     * '&#168;  ',
C  169 (oxa9)
     * '&#169;  ',
C  170 (oxaa)
     * '&#170;  ',
C  171 (oxab)
     * '&#171;  ',
C  172 (oxac)
     * '&#172;  ',
C  173 (oxad)
     * '&#173;  ',
C  174 (oxae)
     * '&#174;  ',
C  175 (oxaf)
     * '&#175;  ',
C  176 (oxb0)
     * '&#176;  ',
C  177 (oxb1)
     * '&#177;  ',
C  178 (oxb2)
     * '&#178;  ',
C  179 (oxb3)
     * '&#179;  ',
C  180 (oxb4)
     * '&#180;  ',
C  181 (oxb5)
     * '&#181;  ',
C  182 (oxb6)
     * '&#182;  ',
C  183 (oxb7)
     * '&#183;  ',
C  184 (oxb8)
     * '&#184;  ',
C  185 (oxb9)
     * '&#185;  ',
C  186 (oxba)
     * '&#186;  ',
C  187 (oxbb)
     * '&#187;  ',
C  188 (oxbc)
     * '&#188;  ',
C  189 (oxbd)
     * '&#189;  ',
C  190 (oxbe)
     * '&#190;  ',
C  191 (oxbf)
     * '&#191;  ',
C  192 (oxc0)
     * '&Agrave;',
C  193 (oxc1)
     * '&Aacute;',
C  194 (oxc2)
     * '&acirc; ',
C  195 (oxc3)
     * '&Atilde;',
C  196 (oxc4)
     * '&Auml;  ',
C  197 (oxc5)
     * '&Aring; ',
C  198 (oxc6)
     * '&AElig; ',
C  199 (oxc7)
     * '&Ccedil;',
C  200 (oxc8)
     * '&Egrave;'/
      DATA (HTML(I),I=201,255)
C  201 (oxc9)
     */'&Eacute;',
C  202 (oxca)
     * '&Ecirc; ',
C  203 (oxcb)
     * '&Euml;  ',
C  204 (oxcc)
     * '&Igrave;',
C  205 (oxcd)
     * '&Iacute;',
C  206 (oxce)
     * '&Icirc; ',
C  207 (oxcf)
     * '&Iuml;  ',
C  208 (oxd0)
     * '&ETH;   ',
C  209 (oxd1)
     * '&Ntilde;',
C  210 (oxd2)
     * '&Ograve;',
C  211 (oxd3)
     * '&Oacute;',
C  212 (oxd4)
     * '&Ocirc; ',
C  213 (oxd5)
     * '&Otilde;',
C  214 (oxd6)
     * '&Ouml;  ',
C  215 (oxd7)
     * '&#215;  ',
C  216 (oxd8)
     * '&Oslash;',
C  217 (oxd9)
     * '&Ugrave;',
C  218 (oxda)
     * '&Uacute;',
C  219 (oxdb)
     * '&Ucirc; ',
C  220 (oxdc)
     * '&Uuml;  ',
C  221 (oxdd)
     * '&Yacute;',
C  222 (oxde)
     * '&THORN; ',
C  223 (oxdf)
     * '&szlig; ',
C  224 (oxe0)
     * '&agrave;',
C  225 (oxe1)
     * '&aacute;',
C  226 (oxe2)
     * '&acirc; ',
C  227 (oxe3)
     * '&atilde;',
C  228 (oxe4)
     * '&auml;  ',
C  229 (oxe5)
     * '&aring; ',
C  230 (oxe6)
     * '&aelig; ',
C  231 (oxe7)
     * '&ccedil;',
C  232 (oxe8)
     * '&egrave;',
C  233 (oxe9)
     * '&eacute;',
C  234 (oxea)
     * '&ecirc; ',
C  235 (oxeb)
     * '&euml;  ',
C  236 (oxec)
     * '&igrave;',
C  237 (oxed)
     * '&iacute;',
C  238 (oxee)
     * '&icirc; ',
C  239 (oxef)
     * '&iuml;  ',
C  240 (oxf0)
     * '&ieth;  ',
C  241 (oxf1)
     * '&ntilde;',
C  242 (oxf2)
     * '&ograve;',
C  243 (oxf3)
     * '&oacute;',
C  244 (oxf4)
     * '&ocirc; ',
C  245 (oxf5)
     * '&otilde;',
C  246 (oxf6)
     * '&ouml;  ',
C  247 (oxf7)
     * '&#247;  ',
C  248 (oxf8)
     * '&oslash;',
C  249 (oxf9)
     * '&ugrave;',
C  250 (oxfa)
     * '&uacute;',
C  251 (oxfb)
     * '&ucirc; ',
C  252 (oxfc)
     * '&uuml;  ',
C  253 (oxfd)
     * '&yacute;',
C  254 (oxfe)
     * '&thorn; ',
C  255 (oxff)
     * '&yuml;  '/

      IN = 1
C     Whether inserting a replacement string into the output buffer.
      INREPL = 0
 
      IF (LSTR.EQ.1.AND.STR(1).EQ.BLANK)  GOTO 30
 
   10 IF (INREPL.NE.0)  THEN
        IF (JN.GT.LREPL)  THEN
          INREPL = 0
          GOTO 20
        ENDIF
        IF (REPLSTR(JN:JN).NE.BLANK)  GOTO 150
        JN = JN + 1
        GOTO 10
      ENDIF
 
   20 IF (IN.GT.LSTR)  GOTO 500
        IF (STR(IN).NE.BLANK)  GOTO 30
        IN = IN + 1
        GOTO 20
 
C     NEW WORD.
   30 IF (INREPL.EQ.0.AND.IN.GT.LSTR)  GOTO 500
        IF (INREPL.EQ.0.AND.IHTML.NE.0.AND.LUNOUT.EQ.LUNP)  THEN
C       Check for HTML conversions.
          LREPL = 0
          IF (STR(IN).EQ.BSLSH)  THEN
            CALL RTF2HTML (STR, LSTR, IN, REPLSTR, LREPL)
            IN = IN + 1
          ELSE
            KK = ICHAR(STR(IN))
            IF (KK.GE.32.AND.HTML(KK)(1:1).NE.' ')  THEN
              IF (KK.EQ.38)  THEN
C             Check for &... ; - this is already an HTML character code
                II = IN + 1
   50           IF (II.GT.LSTR)  GOTO 60
                  IF (STR(II).EQ.SEMIC)  GOTO 150
                  II = II + 1
                  GOTO 50
              ENDIF
   60         IN = IN + 1
              DO JJ = 1, MAXHTML
                IF (HTML(KK)(JJ:JJ).EQ.' ')  GOTO 100
                REPLSTR(JJ:JJ) = HTML(KK)(JJ:JJ)
                LREPL = LREPL + 1
              ENDDO
  100         CONTINUE
            ENDIF
          ENDIF
          IF (LREPL.GT.0)  THEN
            JN = 1
            INREPL = 1
          ENDIF
        ENDIF

  150   IF (INREPL.NE.0)  THEN
C         Get next character from replacemment string.
          CHAR = REPLSTR(JN:JN)
        ELSE
C         Get next character from input string.
          CHAR = STR(IN)
        ENDIF
 
        IF (CHAR.EQ.BLANK)  THEN
 
C         END OF WORD.
          IENDWD = JOUT
          IF (JOUT.LT.LWIDTH)  THEN
            JOUT = JOUT + 1
            IOUT(JOUT:JOUT) = BLANK
          ENDIF
          IF (INREPL.NE.0)  THEN
            JN = JN + 1
            IF (JN.GT.LREPL)  INREPL = 0
          ELSE
            IN = IN + 1
          ENDIF
          GOTO 10
 
        ELSE
 
C         WITHIN WORD - COPY NEXT CHARACTER.
          IF (JOUT.GE.LWIDTH)  THEN
 
C           WORD DOES NOT FIT.
            IF (IENDWD.LT.0)  IENDWD = LWIDTH
            CALL WRTREC (IOUT(1:IENDWD), LUNOUT)
            JE = JOUT
            I = IENDWD
            IENDWD = -1
            JOUT = 0
            IF (I.LT.LWIDTH)  THEN
              IF (IOUT(I+1:I+1).EQ.BLANK)  I = I + 1
            ENDIF
            CALL INDEN (ITAB+2)
  200       IF (I.LT.JE)  THEN
              I = I + 1
              JOUT = JOUT + 1
              IOUT(JOUT:JOUT) = IOUT(I:I)
              GOTO 200
            ENDIF
          ENDIF
 
          JOUT = JOUT + 1
          IOUT(JOUT:JOUT) = CHAR
 
C         CAPITAL LETTER REQUIRED?
          IF (ICAP.NE.0)  THEN
            CALL CAP(IOUT(JOUT:JOUT), ICAP)
          ENDIF
          IF (INREPL.NE.0)  THEN
            JN = JN + 1
            IF (JN.GT.LREPL)  INREPL = 0
          ELSE
            IN = IN + 1
          ENDIF
          GOTO 30
        ENDIF
 
C     END OF INPUT STRING.
  500 IF (IE.LT.0)  THEN
        CONTINUE
 
      ELSE IF (IE.EQ.0)  THEN
 
        IF (JOUT.EQ.0 .OR.IOUT(JOUT:JOUT).EQ.BLANK)  GOTO 600
        IENDWD = JOUT
        IF (JOUT.LT.LWIDTH)  THEN
          JOUT = JOUT + 1
          IOUT(JOUT:JOUT) = BLANK
        ENDIF
  600   CONTINUE
 
      ELSE
 
        CALL BLKLIN (IE-1)
 
      ENDIF
 
      RETURN
      END
      SUBROUTINE JSTR (R, NDEC, IE, LWIDTH)                                 OUTP
 
C  REVISED 17/11/86.
C  OUTPUTS A REAL VALUE.
 
 
      COMMON /CWRKXX/ CTMP
      CHARACTER*10 CTMP
 
      CALL RNKOD (R, NDEC, CTMP, LOUT)
      CALL JSTSTR (CTMP(1:LOUT), IE, LWIDTH)
 
      RETURN
      END
      SUBROUTINE JSTSTR (STR1, IE, LWIDTH)                                  OUTP
 
C* REVISED 29-MAR-99.
C  CONVERTS CHARACTER STRING TO CHARACTER*1 ARRAY AND CALLS JSTOUT.
 
C  PARAMETERS SAME AS JSTOUT PARAMETERS 1, 3, AND 4.
 
      CHARACTER*(*) STR1
C     DIMENSION STR2 MUST BE SAME AS LENGTH OF IOUT IN /IOBUFX/
      CHARACTER*1 STR2(200)                                                   =*
 
 
      LSTR = LEN(STR1)
      LSTR2 = 200
      ISTART = 0
 
      DO WHILE (LSTR.GT.LSTR2)
        DO 5 I = 1, LSTR2
          STR2(I) = STR1(ISTART + I: ISTART + I)
    5   CONTINUE
        CALL JSTOUT (STR2, LSTR2, -1, LWIDTH)

        ISTART = ISTART + LSTR2
        LSTR = LSTR - LSTR2
      ENDDO
 
      DO 10 I = 1, LSTR
        STR2(I) = STR1(ISTART + I:ISTART + I)
   10 CONTINUE
      
      CALL JSTOUT (STR2, LSTR, IE, LWIDTH)
 
      RETURN
      END
C      SUBROUTINE JSTTPS (NW, IE, LWIDTH)                                    OUTP
C 
CC* REVISED 17/11/86.
CC* OUTPUTS TYPESETTING INSTRUCTIONS.
C 
CC  NW RECEIVES THE NUMBER OF THE INSTRUCTION IN THE LIST.
CC  IE RECEIVES THE ACTION TO BE TAKEN AT THE END OF THE WORD.
CC  LWIDTH RECEIVES THE OUTPUT WIDTH.
C 
C      DIMENSION LWD(30)
C      CHARACTER*15 K(30)
C 
CC     NWDS MUST EQUAL THE DIMENSION OF LWD AND K.                             =/
C      DATA NWDS/30/                                                           =*
CC     MWL MUST BE GREATER THAN OR EQUAL TO THE MAXIMUM NUMBER OF SYMBOLS      =/
CC       IN A WORD, AND MUST EQUAL THE DIMENSION OF IWORD.                     =/
C      DATA MWL/15/                                                            =*
CC     LWD MUST CONTAIN THE LENGTHS OF THE WORDS IN K.                         =/
C      DATA LWD(1),LWD(2),LWD(3),LWD(4),LWD(5)/3,3,3,4,6/
C      DATA LWD(6),LWD(7),LWD(8),LWD(9),LWD(10)/4,4,7,3,3/
C      DATA LWD(11),LWD(12),LWD(13),LWD(14),LWD(15)/3,4,5,2,3/
C      DATA LWD(16),LWD(17),LWD(18),LWD(19),LWD(20)/2,2,4,4,1/
C      DATA LWD(21),LWD(22),LWD(23),LWD(24),LWD(25)/1,4,4,3,14/
C      DATA LWD(26),LWD(27),LWD(28),LWD(29),LWD(30)/5,5,6,4,2/
C 
CC     INSTRUCTION LIST.
C 
CC  1 NEW LINE.
C      DATA K(1) /'[n]'/
CC  2 NEW PARAGRAPH.
C      DATA K(2) /'[p]'/
CC  3 NEW PAGE.
C      DATA K(3) /'[P]'/
CC  4 LEFT-TAB 1.
C      DATA K(4) /'[1<]'/
CC  5 NEW PARAGRAPH WITH ORDINARY INDENTATION AND ONE LINE EXTRA SPACE.
C      DATA K(5) /'[1~''p]'/
CC  6 EN DASH.
C      DATA K(6) /'[X-]'/
CC  7 NEW PARAGRAPH WITH ORDINARY INDENTATION.
C      DATA K(7) /'[''p]'/
CC  8 NEW PARAGRAPH WITH ORDINARY INDENTATION AND HALF LINE EXTRA SPACE.
C      DATA K(8) /'[.5~''p]'/
CC  9 ITALICS FONT.
C      DATA K(9) /'[I]'/
CC 10 NORMAL FONT.
C      DATA K(10) /'[N]'/
CC 11 UNGROUP LINES.
C      DATA K(11) /'[g]'/
CC 12 GROUP 3 LINES.
C      DATA K(12) /'[3g]'/
CC 13 NEW PARAGRAPH WITH 1 LINE EXTRA SPACE.
C      DATA K(13) /'[1~p]'/
CC 14 RIGHT TAB.
C      DATA K(14) /'[>'/
CC 15 RIGHT TAB WITH DOT LEADER.
C      DATA K(15) /'[">'/
CC 16 TWO CLOSING SQUARE BRACKETS.
C      DATA K(16) /']]'/
CC 17 BOLD FONT.
C      DATA K(17) /'[B'/
CC 18 FIRST TAB POSITION.
C      DATA K(18) /'[1<]'/
CC 19 GROUP 98 LINES.
C      DATA K(19) /'[4g]'/
CC 20 CLOSING SQUARE BRACKET.
C      DATA K(20) /']'/
CC 21 OPENING SQUARE BRACKET.
C      DATA K(21) /'['/
CC 22 CLEAR TABS.
C      DATA K(22) /'[''!]'/
CC 23 SET LEFT TAB.
C      DATA K(23) /'`''!]'/
CC 24 SET LEFT INDENTATION.
C      DATA K(24) /'`i]'/
CC 25 CLEAR INDENTATION SETTINGS.
C      DATA K(25) /'[0i][0''i][0"i]'/
Cc 26 NEW PARAGRAPH WITH 2 LINES OF EXTRA SPACE.
C      DATA K(26) /'[2~p]'/
CC 27 GROUP 99 LINES.
C      DATA K(27) /'[99g]'/
CC 28 NEW PARAGRAPH WITH HALF LINE EXTRA SPACE.
C      DATA K(28) /'[.5~p]'/
CC 29 NEW PARAGRAPH WITH ORDINARY INTER-LINE SPACING.
C      DATA K(29) /'["p]'/
CC 30 START OF LITERAL TEXT.
C      DATA K(30) /'[w'/
C 
C      IF (NW.LE.0.OR.NW.GT.NWDS)  THEN
C        CALL FERROR ('Invalid argument to JSTTPS.%')
C      ENDIF
C      L = LWD(NW)
C      CALL JSTSTR (K(NW)(1:L), IE, LWIDTH)
C      RETURN
C      END
      CHARACTER*1 FUNCTION LWRCASE (CHR)

C  REVISED 10-MAR-99.
C  CONVERTS SINGLE CHARACTER TO LOWER CASE.
C  (CRUDE IMPLEMENTATION - ONLY USED TO CONVERT KEYWORDS, WHICH ARE IN THE
C  LOWER ASCII SET)

      CHARACTER*1 CHR
      IF (CHR.GE.'A'.AND.CHR.LE.'Z') THEN
        LWRCASE = CHAR (ICHAR(CHR) + 32)
      ELSE
        LWRCASE = CHR
      ENDIF

      RETURN
      END
      SUBROUTINE NEWPAR                                                     OUTP
 
C  REVISED 25/10/85.
C  STARTS A NEW PARAGRAPH.
 
      COMMON /FMTXXX/ ITAB,LFOUT,LTXOUT,KCOLS,MAXWID
      COMMON /TPSXXX/ ITPSET,MAXTYPMK,NTYPMK,LTYPMK,INTYPMKS
 
      CALL ENDLN
 
C      IF (ITPSET.GT.0)  THEN
C        CALL JSTTPS (2, -1, LFOUT)
C        CALL JSTTPS (19, 0, LFOUT)
C      ELSE
        CALL  BLKLIN (1)
C      ENDIF
 
      RETURN
      END
      FUNCTION   NUMDIG (NUM)                                               OUTP
 
C  REVISED 29/5/85.
C  DETERMINES THE NUMBER OF CHARACTERS REQUIRED TO OUTPUT A NUMBER.
 
 
      NUMA = IABS(NUM)
      I = 1
   10 IF (NUMA.LT.10**I)  GOTO 20
        I = I + 1
        GOTO 10
 
   20 IF (NUM.LT.0)  I = I + 1
      NUMDIG = I
 
      RETURN
      END
      SUBROUTINE OUTF (JF, FBUF, LFBUF, FMEM, FLADDR, NF, FO, NFR,          OUTP
     * IFL, NDESC, IFIRST, NEWNOD)
 
C  REVISED 19-MAR-93.
C  OUTPUTS A FEATURE DESCRIPTION.
 
C  JF RECEIVES THE FEATURE NUMBER.
C  FBUF RECEIVES THE FEATURE DESCRIPTIONS.
C  LFBUF RECEIVES THE LENGTH OF FBUF.
C  FMEM RECEIVES THE FEATURE MEMORY ADDRESSES.
C  FLADDR RECEIVES POINTERS TO DESCRIPTION LENGTHS.
C  NF RECEIVES THE NUMBER OF MASKED-IN FEATURES.
C  FO RECEIVES THE OLD FEATURE NUMBERS.
C  NFR RECEIVES THE NUMBER OF FEATURES.
C  IFL RECEIVES THE DESCRIPTION LENGTHS.
C  NDESC RECEIVES THE NUMBER OF DESCRIPTIONS.
C  IFIRST RECEIVES 1 IF THIS IS THE FIRST FEATURE ON THE LINE.
C  NEWNOD RECEIVES 1 IF THIS IS THE START OF A NEW NODE.
 
 
      CHARACTER*1 FBUF(LFBUF)
      INTEGER FMEM(NF),FLADDR(NF),FO(NFR),IFL(NDESC)
 
      COMMON /CAPXXX/ ICAP
      COMMON /FMTXXX/ ITAB,LFOUT,LTXOUT,KCOLS,MAXWID
      COMMON /PARXXX/ NFB,NFE,JFB,NVAR,NEWLN,NT,NTD,NTA,NO,KN,NUSED,
     *                INCOMP,VARW,NTR,RBASE,ABASE,REUSE,VARYWT,NCONF,
     *                NSET,RES,ITUNKV,IADCNO,ITCHV,IRTF,IHTML
      COMMON /SYMXXX/ BLANK,STOP,SEMIC,LBRAC,RBRAC,RANGE,STAR,UPAROW,
     *            COMMA,COLON,NUMERO,LABRAC,RABRAC,LBRACE,RBRACE,BSLSH
      CHARACTER*1 BLANK,STOP,SEMIC,LBRAC,RBRAC,RANGE,STAR,UPAROW,
     *            COMMA,COLON,NUMERO,LABRAC,RABRAC,LBRACE,RBRACE,BSLSH
      COMMON /TPSXXX/ ITPSET,MAXTYPMK,NTYPMK,LTYPMK,INTYPMKS
 
 
C      IF (IFIRST.EQ.1 .AND. NEWNOD.EQ.0 .AND. ITPSET.GT.0)
C     * CALL JSTTPS (1, -1, LFOUT)
      IF (IFIRST.NE.0)  CALL TAB
 
      I = FLADDR(JF)
      LF = IFL(I)
      ISTART = FMEM(JF)
      ICAP = IFIRST
 
      IF (LF.GT.0)  THEN
C       INSERT CHARACTER NUMBER IF REQUIRED.
        IF (IADCNO.NE.0)  THEN
          CALL JSTOUT (LBRAC, 1, -1, LFOUT)
          CALL JSTI (FO(JF), -1, LFOUT)
          CALL JSTOUT (RBRAC, 1, 0, LFOUT)
        ENDIF
        IF (ITPSET.NE.0)  THEN
          CALL JSTOTP (FBUF(ISTART), LF, 0, LFOUT)
        ELSE
          CALL JSTOUT (FBUF(ISTART), LF, 0, LFOUT)
        ENDIF
      ENDIF
 
      RETURN
      END
      SUBROUTINE OUTHDR (FMSK, TMSK, RINDX, AINDX, JBSET, KOSET,            OUTP
     * NLSET, NSD, CSTAVG, CSTMAX, AVGL, LMAX, INSTPS)
 
C* REVISED 10-MAR-99.
C* OUTPUTS PARAMETER INFORMATION IN KEYS.
 
C  FMSK RECEIVES THE CHARACTER MASK.
C  TMSK RECEIVES THE CHARACTER MASK.
C  RINDX RECEIVES THE CHARACTER RELIABILITY INDICES.
C  AINDX RECEIVES THE ITEM ABUNDANCE INDICES.
C  JBSET RECEIVES RECEIVES THE CHARACTER NUMBERS OF PRESET CHARACTERS.
C  KOSET RECEIVES THE GROUP NUMBERS OF PRESET CHARACTERS.
C  NLSET RECEIVES THE COLUMN NUMBERS OF PRESET CHARACTERS.
C  NSD RECEIVES THE NUMBER OF PRESET CHARACTERS.
C  CSTAVG RECEIVES THE AVERAGE COST OF THE KEY.
C  CSTMAX RECEIVES THE MAXIMUM COST OF THE KEY.
C  AVGL RECEIVES THE AVERAGE LENGTH OF THE KEY.
C  LMAX RECEIVES THE MAXIMUM COST OF THE KEY.
C  INSTPS RECEIVES WHETHER TYPSETTING MARKS ARE REQUIRED.
 
      COMMON /DIMXXX/ LDM,NFR,NF,NTM,NTM1,NTU,NTH,NWORD,NDESC,LCDEP
      COMMON /FMTXXX/ ITAB,LFOUT,LTXOUT,KCOLS,MAXWID
      COMMON /LINEXX/ LINE
      CHARACTER*200 LINE
      COMMON /LUUXXX/ LUNOUT
      COMMON /PARXXX/ NFB,NFE,JFB,NVAR,NEWLN,NT,NTD,NTA,NO,KN,NUSED,
     *                INCOMP,VARW,NTR,RBASE,ABASE,REUSE,VARYWT,NCONF,
     *                NSET,RES,ITUNKV,IADCNO,ITCHV,IRTF,IHTML
      COMMON /SYMXXX/ BLANK,STOP,SEMIC,LBRAC,RBRAC,RANGE,STAR,UPAROW,
     *            COMMA,COLON,NUMERO,LABRAC,RABRAC,LBRACE,RBRACE,BSLSH
      CHARACTER*1 BLANK,STOP,SEMIC,LBRAC,RBRAC,RANGE,STAR,UPAROW,
     *            COMMA,COLON,NUMERO,LABRAC,RABRAC,LBRACE,RBRACE,BSLSH
      COMMON /TIMXXX/ TIM,DAT
      CHARACTER*10 TIM,DAT
C      COMMON /TPSXXX/ ITPSET,MAXTYPMK,NTYPMK,LTYPMK,INTYPMKS
 
      REAL RINDX(NFR),AINDX(NTR)
      INTEGER FMSK(NFR),TMSK(NTR),JBSET(NSD),KOSET(NSD),NLSET(NSD)
 
      DO 10 LTIM = 10, 1, -1
        IF (TIM(LTIM:LTIM).NE.BLANK)  GOTO 15
   10   CONTINUE
      LTIM = 1
 
   15 DO 20 LDAT = 10, 1, -1
        IF (DAT(LDAT:LDAT).NE.BLANK)  GOTO 30
   20   CONTINUE
      LDAT = 1
 
   30 IF (INSTPS.NE.0)  GOTO 1000
      CALL PRTHDR (INSTPS)
      ITAB = -1
 
      IF (INSTPS.EQ.0)  THEN
        DO 40 K = 1, LTXOUT
          LINE(K:K) = STAR
   40     CONTINUE
        CALL JSTSTR (LINE(1:LTXOUT), 1, LTXOUT)
 
        CALL PROGID (LUNOUT)
        WRITE (LINE, 41) TIM(:LTIM), DAT(:LDAT)
   41   FORMAT ('Run at ',A,' on ',A,'.%')
        L = LMESS (LINE)
        CALL JSTSTR (LINE(1:L), 2, LTXOUT)
      ENDIF
 
 
C      IF (INSTPS.NE.0)  THEN
C        CALL JSTTPS (13, 0, LTXOUT)
C        CALL JSTTPS (9, 0, LTXOUT)
C      ENDIF
      CALL JSTSTR ('Characters', 0, LTXOUT)
C      IF (INSTPS.EQ.0)  THEN
        CALL JSTOUT (RANGE, 1, 0, LTXOUT)
C      ELSE
C        CALL JSTTPS (10, 0, LTXOUT)
C        CALL JSTTPS (6, 0, LTXOUT)
C      ENDIF
      CALL JSTI (NFR, 0, LTXOUT)
      CALL JSTSTR ('in data,', 0, LTXOUT)
      CALL JSTI (NF, 0, LTXOUT)
      CALL JSTSTR ('included,', 0, LTXOUT)
      CALL JSTI (NUSED, 0, LTXOUT)
      CALL JSTSTR ('in key.', 1, LTXOUT)
 
C      IF (INSTPS.NE.0)  THEN
C        CALL JSTTPS (29, 0, LTXOUT)
C        CALL JSTTPS (9, 0, LTXOUT)
C      ENDIF
      CALL JSTSTR ('Items', 0, LTXOUT)
C      IF (INSTPS.EQ.0)  THEN
        CALL JSTOUT (RANGE, 1, 0, LTXOUT)
C      ELSE
C        CALL JSTTPS (10, 0, LTXOUT)
C        CALL JSTTPS (6, 0, LTXOUT)
C      ENDIF
      CALL JSTI (NTR, 0, LTXOUT)
      CALL JSTSTR ('in data,', 0, LTXOUT)
      CALL JSTI (NTM, 0, LTXOUT)
      CALL JSTSTR ('included,', 0, LTXOUT)
      CALL JSTI (NTA, 0, LTXOUT)
      CALL JSTSTR ('in key.', 2, LTXOUT)
 
C      IF (INSTPS.GT.0)  CALL JSTTPS (29, 0, LFOUT)
      CALL JSTSTR ('RBASE =', 0, LTXOUT)
      CALL JSTR (RBASE, 2, 0, LTXOUT)
      CALL JSTSTR ('ABASE =', 0, LTXOUT)
      CALL JSTR (ABASE, 2, 0, LTXOUT)
      CALL JSTSTR ('REUSE =', 0, LTXOUT)
      CALL JSTR (REUSE, 2, 0, LTXOUT)
      CALL JSTSTR ('VARYWT =', 0, LTXOUT)
      CALL JSTR (VARYWT, 2, 1, LTXOUT)
 
      IF (INSTPS.EQ.0)  THEN
        CALL JSTSTR ('Number of confirmatory characters =',
     *    0, LTXOUT)
        CALL JSTI (NCONF, 2, LTXOUT)
 
        CALL JSTSTR ('Average length of key =', 0, LTXOUT)
        CALL JSTR (AVGL, 1, 0, LTXOUT)
        CALL JSTSTR ('Average cost of key =', 0, LTXOUT)
        CALL JSTR (CSTAVG, 1, 1, LTXOUT)
 
        CALL JSTSTR ('Maximum length of key =', 0, LTXOUT)
        CALL JSTI (LMAX, 0, LTXOUT)
        CALL JSTSTR ('Maximum cost of key =', 0, LTXOUT)
        CALL JSTR (CSTMAX, 1, 2, LTXOUT)
      ENDIF
 
      IF (NSET.GT.0)  THEN
        CALL PRTPRE (JBSET, KOSET, NLSET, NSET, INSTPS)
        CALL BLKLIN (1)
      ENDIF
 
      CALL PRTMSK ('Characters', FMSK, NFR, INSTPS)
      CALL PRTWT ('Character reliabilities', RINDX, NFR, INSTPS)
      CALL PRTMSK ('Items', TMSK, NTR, INSTPS)
      CALL PRTWT ('Item abundances', AINDX, NTR, INSTPS)
 
C      IF (INSTPS.GT.0)  CALL JSTTPS (28, 0, LTXOUT)
      GOTO 1000
 
 1000 RETURN
      END
      SUBROUTINE OUTNOD (NODE)                                              OUTP
 
C  REVISED 24/7/85.
C  OUTPUTS NODE NUMBER.
 
      COMMON /FMTXXX/ ITAB,LFOUT,LTXOUT,KCOLS,MAXWID
 
      CALL NEWPAR
 
      CALL JSTI (NODE, -1, LFOUT)
 
      RETURN
      END
      SUBROUTINE OUTRNG (IB, IE, IEND, ITPSET)                              OUTP
 
C  REVISED 24/2/86.
C  OUTPUTS A RANGE.
 
C  IB RECEIVES THE BEGINNING OF THE RANGE.
C  IE RECEIVES THE END OF THE RANGE.
C  IEND RECEIVES THE ACTION TO BE TAKEN AT THE END OF THE WORD.
C  ITPSET RECEIVES WHETHER TYPESETTING MARKS ARE REQUIRED.
 
      COMMON /FMTXXX/ ITAB,LFOUT,LTXOUT,KCOLS,MAXWID
      COMMON /SYMXXX/ BLANK,STOP,SEMIC,LBRAC,RBRAC,RANGE,STAR,UPAROW,
     *            COMMA,COLON,NUMERO,LABRAC,RABRAC,LBRACE,RBRACE,BSLSH
      CHARACTER*1 BLANK,STOP,SEMIC,LBRAC,RBRAC,RANGE,STAR,UPAROW,
     *            COMMA,COLON,NUMERO,LABRAC,RABRAC,LBRACE,RBRACE,BSLSH
 
 
      IF (IB.GE.IE)  THEN
        CALL JSTI (IB, IEND, LFOUT)
      ELSE
        CALL JSTI (IB, -1, LFOUT)
C        IF (ITPSET.GT.0)  THEN
C          CALL JSTTPS (6, -1, LFOUT)
C        ELSE
          CALL JSTOUT (RANGE, 1, -1, LFOUT)
C        ENDIF
        CALL JSTI (IE, IEND, LFOUT)
      ENDIF
 
      RETURN
      END
      SUBROUTINE OUTST (JF, JS, FBUF, LFBUF, FMEM, FLADDR, NF,              OUTP
     * IFL, NDESC)
 
C  REVISED 1/8/85.
C  OUTPUTS A STATE DESCRIPTION.
 
C  JF RECEIVES THE FEATURE NUMBER.
C  JS RECEIVES THE STATE NUMBER.
C  FBUF RECEIVES THE FEATURE DESCRIPTIONS.
C  LFBUF RECEIVES THE LENGTH OF FBUF.
C  FMEM RECEIVES THE FEATURE MEMORY ADDRESSES.
C  FLADDR RECEIVES POINTERS TO DESCRIPTION LENGTHS.
C  NF RECEIVES THE NUMBER OF FEATURES.
C  IFL RECEIVES THE DESCRIPTION LENGTHS.
C  NDESC RECEIVES THE NUMBER OF DESCRIPTIONS.
 
      CHARACTER*1 FBUF(LFBUF)
      INTEGER FMEM(NF),FLADDR(NF),IFL(NDESC)
 
      COMMON /FMTXXX/ ITAB,LFOUT,LTXOUT,KCOLS,MAXWID
      COMMON /TPSXXX/ ITPSET,MAXTYPMK,NTYPMK,LTYPMK,INTYPMKS
 
 
      I = FLADDR(JF)
      LS = IFL(I+JS)
      ISTART = FMEM(JF)
      DO 10 IS = 1, JS
        ISTART = ISTART + IFL(I)
        I = I + 1
   10   CONTINUE
 
      IF (ITPSET.NE.0)  THEN
        CALL JSTOTP (FBUF(ISTART), LS, -1, LFOUT)
      ELSE
        CALL JSTOUT (FBUF(ISTART), LS, -1, LFOUT)
      ENDIF
 
      IFIRST = 0
 
      RETURN
      END
      SUBROUTINE OUTTAX (IT, TAXON, LTAXON, ITXNAM, NTM1, NTOUT, NODEND)    OUTP
 
C  REVISED 24/2/86.
C  OUTPUTS A TAXON NAME.
 
C  IT RECEIVES THE TAXON NUMBER.
C  TAXON RECEIVES THE TAXON NAMES.
C  LTAXON RECEIVES THE LENGTH OF TAXON.
C  ITXNAM RECEIVES POINTERS TO THE START OF TAXON NAMES.
C  NTM1 RECEIVES THE DIMENSION OF ITXNAM.
C  NTOUT RECEIVES A FLAG INDICATING WHETHER THIS IS THE FIRST NAME
C   AT THE END OF A BRANCH.
C  NODEND RECEIVES WHETHER THIS IS THE LAST BRANCH OF THE NODE.
 
 
      CHARACTER*1 TAXON(LTAXON)
      DIMENSION ITXNAM(NTM1)
 
      COMMON /FMTXXX/ ITAB,LFOUT,LTXOUT,KCOLS,MAXWID
      COMMON /IOPARX/ JOUT,IENDWD,IBINARY
      COMMON /SYMXXX/ BLANK,STOP,SEMIC,LBRAC,RBRAC,RANGE,STAR,UPAROW,
     *            COMMA,COLON,NUMERO,LABRAC,RABRAC,LBRACE,RBRACE,BSLSH
      CHARACTER*1 BLANK,STOP,SEMIC,LBRAC,RBRAC,RANGE,STAR,UPAROW,
     *            COMMA,COLON,NUMERO,LABRAC,RABRAC,LBRACE,RBRACE,BSLSH
      COMMON /TPSXXX/ ITPSET,MAXTYPMK,NTYPMK,LTYPMK,INTYPMKS
 
C    FINISH FEATURE DESCRIPTION WITH A FULL STOP.
      IF (NTOUT.LE.0)  THEN
        CALL JSTOUT (STOP, 1, -1, LFOUT)
      ENDIF
 
      ISTART = ITXNAM(IT)
      LT = ITXNAM(IT+1) - ITXNAM(IT)
 
C      IF (ITPSET.GT.0)  THEN
C 
CC       CHECK FOR BLANKS IN TAXON NAME.
C        NBLK = 0
C        DO 20 I = 1, LT
C          IF (TAXON(ISTART+I-1).EQ.BLANK)  THEN
C            NBLK = 1
C            GOTO 25
C          ENDIF
C   20     CONTINUE
C   25   CALL JSTOUT (BLANK, 1, -1, LTXOUT)
C        IF (NTOUT.GT.0)  THEN
C          CALL JSTTPS (1, -1, LTXOUT)
C          IF (NBLK.GT.0.AND.JOUT+LT+6.GT.LTXOUT)  THEN
C            CALL ENDLN
C            CALL INDEN (ITAB+2)
C          ENDIF
C          CALL JSTTPS (14, -1, LTXOUT)
C        ELSE
C          IF (NBLK.GT.0.AND.JOUT+LT+7.GT.LTXOUT)  THEN
C            CALL ENDLN
C            CALL INDEN (ITAB+2)
C          ENDIF
C          CALL JSTTPS (15, -1, LTXOUT)
C        ENDIF
C        CALL JSTTPS (17, -1, LTXOUT)
C        CALL JSTOUT (TAXON(ISTART), LT, -1, LTXOUT)
C        CALL JSTTPS (16, -1, LTXOUT)
C        IF (NODEND.NE.0)  THEN
C          CALL JSTOUT (BLANK, 1, 0, LTXOUT)
C          CALL JSTTPS (11, -1, LTXOUT)
C        ENDIF
C 
C      ELSE
 
        IF (JOUT+LT+1.GT.LTXOUT.AND.NTOUT.LE.0)  THEN
          CALL DOTFIL (LFOUT)
          CALL ENDLN
          CALL INDEN (ITAB+3)
        ENDIF
        IF (JOUT+LT+1.GT.LTXOUT)  THEN
          LT = LTXOUT - JOUT
          CALL JSTOUT (TAXON(ISTART), LT, -1, LTXOUT)
          GOTO 100
        ELSE
          IFILL = LTXOUT - LT - 1
          IF (NTOUT.LE.0)  THEN
            CALL DOTFIL (IFILL)
          ELSE
            CALL INDEN (IFILL)
          ENDIF
          CALL JSTOUT (BLANK, 1, -1, LTXOUT)
          CALL JSTOUT (TAXON(ISTART), LT, -1, LTXOUT)
        ENDIF
 
C      ENDIF
 
  100 CALL ENDLN
 
      RETURN
      END
      SUBROUTINE PRTHDR (ITPSET)                                            OUTP
 
C* REVISED 12-JUN-91.
C* OUTPUTS HEADER.
 
C  ITPSET RECEIVES WHETHER TYPESETTING MARKS ARE REQUIRED.
 
      COMMON /FMTXXX/ ITAB,LFOUT,LTXOUT,KCOLS,MAXWID
      COMMON /HEDXXX/ HEAD
      CHARACTER*200 HEAD
      COMMON /LHEADX/ LHEAD,MAXHDR
      COMMON /LTYXXX/ LSTYLE,MAXSTY,LTAB,MAXTAB
      COMMON /LUUXXX/ LUNOUT
      COMMON /LUOXXX/ NUN,LPRINT,LTOP,LUNCOM(10),LUNPRE(10),
     *  LUNUSE(13),LUNREC(13),LUNPAG(13)
      COMMON /STYXXX/ TSTYLE,TTAB
        CHARACTER TSTYLE*100,TTAB*30
 
      IF (LUNPAG(LUNOUT).GT.0)  THEN
        IF (LUNREC(LUNOUT).GT.0)  LUNREC(LUNOUT) = LPRINT
      ELSE
        IF (LUNREC(LUNOUT).GT.0)  CALL BLKLIN (2)
      ENDIF
 
      IF (ITPSET.GT.0)  THEN
        IF (LSTYLE.LE.0)  THEN
          CALL WRTREC ('[0i][0''i][0"i][2~p][99g]', LUNOUT)
        ELSE
          CALL WRTREC (TSTYLE(1:LSTYLE), LUNOUT)
        ENDIF
      ENDIF
 
C      IF (ITPSET.GT.0)  CALL JSTTPS (17, -1, LFOUT)
      CALL JSTSTR (HEAD(1:LHEAD), -1, LFOUT)
C      IF (ITPSET.GT.0)  CALL JSTTPS (20, -1, LFOUT)
      CALL ENDLN
 
      RETURN
      END
      SUBROUTINE PRTKEY (TAXON, LTAXON, ITXNAM, FBUF, LFBUF,                OUTP
     * FREC, FMEM, FLADDR, NSTAT, FN, FO, IFL,
     * BREC, LIST, MSTR, IDIGS, INODE, ITAXON)
 
C  REVISED 21-APR-99.
C  PRINTS CONVENTIONAL BRACKETED KEY WITHOUT TYPESETTING MARKS.
 
C  TAXON RECEIVES THE TAXON NAMES.
C  LTAXON RECEIVES THE LENGTH OF TAXON.
C  ITXNAM RECEIVES POINTERS TO THE START OF TAXON NAMES.
C  FBUF RECEIVES THE MEMORY BUFFER TO STORE THE FEATURE DESCRIPTIONS.
C  LFBUF RECEIVES THE LENGTH OF FBUF.
C  FREC RECEIVES THE DIRECT-ACCESS RECORD ADDRESSES OF THE FEATURE
C   DESCRIPTIONS.
C  FMEM RECEIVES SPACE TO STORE THE MEMORY ADDRESSES OF THE FEATURE
C   DESCRIPTIONS.
C  FLADDR RECEIVES POINTERS TO THE DESCRIPTION LENGTHS.
C  NSTAT RECEIVES THE NUMBERS OF FEATURE STATES.
C  FN RECEIVES THE NEW FEATURE NUMBERS.
C  FO RECEIVES THE OLD FEATURE NUMBERS.
C  IFL RECEIVES THE LENGTHS OF THE FEATURE/STATE DESCRIPTIONS.
C  BREC RECEIVES THE STARTING POINT (IN LIST) OF EACH GROUP.
C  LIST RECEIVES THE STRUCTURE OF THE KEY.
C  MSTR RECEIVES THE LENGTH OF LIST.
C  IDIGS RECEIVES THE NUMBER OF DIGITS ALLOWED FOR A STATE NUMBER.
C  INODE RECEIVES THE IDENTIFICATION OF A NODE IN THE STRUCTURE.
C  ITAXON RECEIVES THE IDENTIFICATION OF A TAXON IN THE STRUCTURE.
 
      COMMON /COSTXX/ CSTAVG,CSTMAX,AVGL,LMAX
      COMMON /DIMXXX/ LDM,NFR,NF,NTM,NTM1,NTU,NTH,NWORD,NDESC,LCDEP
      COMMON /FMTXXX/ ITAB,LFOUT,LTXOUT,KCOLS,MAXWID
      COMMON /IGNXXX/ ICMD
      COMMON /LUOXXX/ NUN,LPRINT,LTOP,LUNCOM(10),LUNPRE(10),
     *  LUNUSE(13),LUNREC(13),LUNPAG(13)
      COMMON /LUUXXX/ LUNOUT
      COMMON /MATXXX/ JU,JF,JS,I,J,NL,JB,NFP,NB,NE
      COMMON /PARXXX/ NFB,NFE,JFB,NVAR,NEWLN,NT,NTD,NTA,NO,KN,NUSED,
     *                INCOMP,VARW,NTR,RBASE,ABASE,REUSE,VARYWT,NCONF,
     *                NSET,RES,ITUNKV,IADCNO,ITCHV,IRTF,IHTML
      COMMON /SYMXXX/ BLANK,STOP,SEMIC,LBRAC,RBRAC,RANGE,STAR,UPAROW,
     *            COMMA,COLON,NUMERO,LABRAC,RABRAC,LBRACE,RBRACE,BSLSH
      CHARACTER*1 BLANK,STOP,SEMIC,LBRAC,RBRAC,RANGE,STAR,UPAROW,
     *            COMMA,COLON,NUMERO,LABRAC,RABRAC,LBRACE,RBRACE,BSLSH
C      COMMON /TPSXXX/ ITPSET,MAXTYPMK,NTYPMK,LTYPMK,INTYPMKS
 
      CHARACTER*1 TAXON(LTAXON),FBUF(LFBUF)
      INTEGER ITXNAM(NTM1),FREC(NF),FMEM(NF),FLADDR(NF),NSTAT(NF),
     * FN(NFR),FO(NFR),IFL(NDESC),BREC(NTU),LIST(MSTR)
 
C    CALCULATE THE TAB POSITION.
      L = NUMDIG(NO)
      ITAB = 2*L + 4
        
      DO 200 NL = 1, NO
        NB = BREC(NL)
        NE = BREC(NL+1) - 1
 
        NS = LIST(NB)
        CALL OUTNOD (NL)
        CALL SOURCE (NS)
        IFIRST = 1
        NEWNOD = 1
        IOUT = 0
 
   30   NB = NB + 1
          IF (NB.GT.NE)  GOTO 200
          IF (LIST(NB).GT.INODE)  GOTO 100
C         AVOID COUPLET STARTING ON LAST LINE OF PAGE.
C         IF (NEWNOD.NE.0.AND.LUNPAG(LUNOUT).NE.0.AND.
C    *     LUNREC(LUNOUT)+1.GE.LPRINT)  LUNREC(LUNOUT) = LPRINT
          IF (IOUT.GT.0.AND.IFIRST.NE.1)  THEN
            CALL JSTOUT (SEMIC, 1, 0, LFOUT)
          ENDIF
          JF = LIST(NB)/IDIGS
          JS = LIST(NB) - JF*IDIGS
          JFN = FN(JF)
          IOUT = 0
          CALL GETFS (JFN, FBUF, LFBUF, FREC, FMEM, FLADDR, NSTAT, NF,
     *     IFL, NDESC)
 
C       OUTPUT FEATURE DESCRIPTION.
          CALL OUTF (JFN, FBUF, LFBUF, FMEM, FLADDR, NF, FO, NFR,
     *     IFL, NDESC, IFIRST, NEWNOD )
          NEWNOD = 0
 
C       OUTPUT STATE DESCRIPTION.
          CALL OUTST (JFN, JS, FBUF, LFBUF, FMEM, FLADDR, NF,
     *     IFL, NDESC)
          IOUT = IOUT + 1
          IFIRST = 0
          GOTO 30
 
C       END OF BRANCH.
  100     LIST(NB) = LIST(NB) - INODE
          NODEND = 0
          IF (LIST(NB).GT.INODE)  THEN
 
C       TAXON NAME(S).
            IT = LIST(NB) - INODE
            ITOUT = 0
  110       IF (NB+1.GT.NE)  NODEND = 1
            CALL OUTTAX (IT, TAXON, LTAXON, ITXNAM, NTM1, ITOUT, NODEND)
            ITOUT = 1
 
C         CHECK FOR MORE TAXA.
            IF (NB+1.GT.NE)  GOTO 200
            NB = NB + 1
            IT = LIST(NB) - ITAXON
            IF (IT.GT.0)  GOTO 110
            NB = NB - 1
          ELSE
 
C         DESTINATION NODE NUMBER.
            ND = LIST(NB)
            IF (NB+1.GT.NE)  NODEND = 1
            CALL DESTND (ND, NODEND)
          ENDIF
 
          IFIRST = 1
 
          GOTO 30
 
  200   CONTINUE
 
      RETURN
      END
      SUBROUTINE PRTKEYT (TAXON, LTAXON, ITXNAM, FBUF, LFBUF,               OUTP
     * FREC, FMEM, FLADDR, NSTAT, FN, FO, IFL,
     * BREC, LIST, TYPMK, MSTR, IDIGS, INODE, ITAXON,
     * NLSET, KOSET, JBSET, NSD, FMSK, RINDX,
     * TMSK, AINDX, PRCMT)
 
C  REVISED 19-APR-99.
C  PRINTS CONVENTIONAL BRACKETED KEY WITH TYPESETTING MARKS.
 
C  TAXON RECEIVES THE TAXON NAMES.
C  LTAXON RECEIVES THE LENGTH OF TAXON.
C  ITXNAM RECEIVES POINTERS TO THE START OF TAXON NAMES.
C  FBUF RECEIVES THE MEMORY BUFFER TO STORE THE FEATURE DESCRIPTIONS.
C  LFBUF RECEIVES THE LENGTH OF FBUF.
C  FREC RECEIVES THE DIRECT-ACCESS RECORD ADDRESSES OF THE FEATURE
C   DESCRIPTIONS.
C  FMEM RECEIVES SPACE TO STORE THE MEMORY ADDRESSES OF THE FEATURE
C   DESCRIPTIONS.
C  FLADDR RECEIVES POINTERS TO THE DESCRIPTION LENGTHS.
C  NSTAT RECEIVES THE NUMBERS OF FEATURE STATES.
C  FN RECEIVES THE NEW FEATURE NUMBERS.
C  FO RECEIVES THE OLD FEATURE NUMBERS.
C  IFL RECEIVES THE LENGTHS OF THE FEATURE/STATE DESCRIPTIONS.
C  BREC RECEIVES THE STARTING POINT (IN LIST) OF EACH GROUP.
C  LIST RECEIVES THE STRUCTURE OF THE KEY.
C  TYPMK RECEIVES THE TYPESETTING MARKS.
C  MSTR RECEIVES THE LENGTH OF LIST.
C  IDIGS RECEIVES THE NUMBER OF DIGITS ALLOWED FOR A STATE NUMBER.
C  INODE RECEIVES THE IDENTIFICATION OF A NODE IN THE STRUCTURE.
C  ITAXON RECEIVES THE IDENTIFICATION OF A TAXON IN THE STRUCTURE.
C  PRCMT RECEIVES THE TEXT OF THE PRINT COMMENT DIRECTIVE.
 
      COMMON /CMTXXX/ LCMT
      COMMON /COSTXX/ CSTAVG,CSTMAX,AVGL,LMAX
      COMMON /DIMXXX/ LDM,NFR,NF,NTM,NTM1,NTU,NTH,NWORD,NDESC,LCDEP
      COMMON /FMTXXX/ ITAB,LFOUT,LTXOUT,KCOLS,MAXWID
      COMMON /IGNXXX/ ICMD
      COMMON /IOBUFX/ IOUT
      CHARACTER*200 IOUT
      COMMON /IOPARX/ JOUT,IENDWD,IBINARY
      COMMON /LUNXXX/ LUNI,LUNC,LUNT,LUNO,LUNP,LUNS,LUNS1,LUNE,LUNL,LUNB
      COMMON /LUOXXX/ NUN,LPRINT,LTOP,LUNCOM(10),LUNPRE(10),
     *  LUNUSE(13),LUNREC(13),LUNPAG(13)
      COMMON /LUUXXX/ LUNOUT
      COMMON /MATXXX/ JU,JF,JS,I,J,NL,JB,NFP,NB,NE
      COMMON /PARXXX/ NFB,NFE,JFB,NVAR,NEWLN,NT,NTD,NTA,NO,KN,NUSED,
     *                INCOMP,VARW,NTR,RBASE,ABASE,REUSE,VARYWT,NCONF,
     *                NSET,RES,ITUNKV,IADCNO,ITCHV,IRTF,IHTML
      COMMON /SYMXXX/ BLANK,STOP,SEMIC,LBRAC,RBRAC,RANGE,STAR,UPAROW,
     *            COMMA,COLON,NUMERO,LABRAC,RABRAC,LBRACE,RBRACE,BSLSH
      CHARACTER*1 BLANK,STOP,SEMIC,LBRAC,RBRAC,RANGE,STAR,UPAROW,
     *            COMMA,COLON,NUMERO,LABRAC,RABRAC,LBRACE,RBRACE,BSLSH
      COMMON /TPSXXX/ ITPSET,MAXTYPMK,NTYPMK,LTYPMK,INTYPMKS
 
      REAL RINDX(NFR),AINDX(NTR)
      CHARACTER*1 TAXON(LTAXON),FBUF(LFBUF),PRCMT(LCMT)
      INTEGER ITXNAM(NTM1),FREC(NF),FMEM(NF),FLADDR(NF),NSTAT(NF),
     * FN(NFR),FO(NFR),IFL(NDESC),BREC(NTU),LIST(MSTR),TYPMK(LTYPMK),
     * NLSET(NSD),KOSET(NSD),JBSET(NSD),FMSK(NFR),
     * TMSK(NTR)
 
      JOUT = 0
      NROW = 0
 
c     Output file header defined in TYPESETTING MARKS.
      CALL OUTTPS(28, TYPMK,
     * FMSK, TMSK, RINDX, AINDX, JBSET, KOSET, NLSET,
     * AVGL, CSTAVG, LMAX, CSTMAX,
     * TAXON, LTAXON, ITXNAM, FBUF, LFBUF,
     * FREC, FMEM, FLADDR, NSTAT, FN, FO, IFL,
     * LIST, MSTR, IDIGS, INODE,
     * NL, IFROM, NB, NE, NROW, ITOUT)
      CALL ENDLN
 
C     Output contents of PRINT COMMENT.
      IF (LCMT.GT.0)  THEN
C       Binary output?
        IF (LUNOUT.EQ.LUNB)  THEN
          L = LCMT
          J = 0
          DO WHILE (L.GT.0)
            JOUT = MIN (MAXWID, L)
            DO I = 1, JOUT
              IOUT(I:I) = PRCMT(J+I)
            ENDDO
            CALL WRTREC (IOUT(1:JOUT), LUNOUT)
            L = L - JOUT
            J = J + JOUT
          ENDDO
          JOUT = 0
        ELSE
          CALL JSTOUT (PRCMT, LCMT, 0, LFOUT)
        ENDIF
      ENDIF
 
C     Paramters record.
      CALL OUTTPS(41, TYPMK,
     * FMSK, TMSK, RINDX, AINDX, JBSET, KOSET, NLSET,
     * AVGL, CSTAVG, LMAX, CSTMAX,
     * TAXON, LTAXON, ITXNAM, FBUF, LFBUF,
     * FREC, FMEM, FLADDR, NSTAT, FN, FO, IFL,
     * LIST, MSTR, IDIGS, INODE,
     * NL, IFROM, NB, NE, NROW, ITOUT)
      CALL ENDLN
 
      DO 200 NL = 1, NO
        NB = BREC(NL)
        NE = BREC(NL+1) - 1
 
        NS = LIST(NB)
C       First node of key?
        IF (NL.EQ.1)  THEN
          NW = 42
          IFROM = 0
        ELSE
          NW = 43
          IFROM = NS
        ENDIF
 
C       Count number of "destinations" for this branch.
        NROW = 0
        MB = NB
    5   MB = MB + 1
        IF (MB.GT.NE)  GOTO 20
        IF (LIST(MB).GT.INODE)  GOTO 10
        GOTO 5
   10   NROW = NROW + 1
        IF (LIST(MB)-INODE.GT.INODE)  THEN
C         Taxon name.
   15     MB = MB + 1
          IF (LIST(MB)-ITAXON.GT.0)  THEN
            NROW = NROW + 1
            GOTO 15
          ENDIF
          MB = MB - 1
        ENDIF
        GOTO 5
 
C       First lead of node.
   20   CALL OUTTPS(NW, TYPMK,
     *   FMSK, TMSK, RINDX, AINDX, JBSET, KOSET, NLSET,
     *   AVGL, CSTAVG, LMAX, CSTMAX,
     *   TAXON, LTAXON, ITXNAM, FBUF, LFBUF,
     *   FREC, FMEM, FLADDR, NSTAT, FN, FO, IFL,
     *   LIST, MSTR, IDIGS, INODE,
     *   NL, IFROM, NB, NE, NROW, ITOUT)
        GOTO 100

C       Features and states.
   30   CALL OUTTPS(NW, TYPMK,
     *   FMSK, TMSK, RINDX, AINDX, JBSET, KOSET, NLSET,
     *   AVGL, CSTAVG, LMAX, CSTMAX,
     *   TAXON, LTAXON, ITXNAM, FBUF, LFBUF,
     *   FREC, FMEM, FLADDR, NSTAT, FN, FO, IFL,
     *   LIST, MSTR, IDIGS, INODE,
     *   NL, IFROM, NB, NE, NROW, ITOUT)
 
        IF (NB.GT.NE)  GOTO 190
        IF (LIST(NB).GT.INODE)  GOTO 100

C     END OF BRANCH.
  100   IF (LIST(NB)-INODE.GT.INODE) THEN
C         Taxon name.
          NW = 45
        ELSE
C         Node.
          NW = 48
        ENDIF
  110   CALL OUTTPS(NW, TYPMK,
     *   FMSK, TMSK, RINDX, AINDX, JBSET, KOSET, NLSET,
     *   AVGL, CSTAVG, LMAX, CSTMAX,
     *   TAXON, LTAXON, ITXNAM, FBUF, LFBUF,
     *   FREC, FMEM, FLADDR, NSTAT, FN, FO, IFL,
     *   LIST, MSTR, IDIGS, INODE,
     *   NL, IFROM, NB, NE, NROW, ITOUT)
        IF (NW.EQ.49)  CALL ENDLN
 
C       CHECK FOR MORE TAXA.
        IF (ITOUT.GT.0)  THEN
          IF (NB+1.GT.NE)  GOTO 190
          NB = NB + 1
          IT = LIST(NB) - ITAXON   
          IF (IT.GT.0)  THEN
            NW = 46
            GOTO 110
          ELSE
C           Terminate list of taxon names.
            CALL OUTTPS(47, TYPMK,
     *       FMSK, TMSK, RINDX, AINDX, JBSET, KOSET, NLSET,
     *       AVGL, CSTAVG, LMAX, CSTMAX,
     *       TAXON, LTAXON, ITXNAM, FBUF, LFBUF,
     *       FREC, FMEM, FLADDR, NSTAT, FN, FO, IFL,
     *       LIST, MSTR, IDIGS, INODE,
     *       NL, IFROM, NB, NE, NROW, ITOUT)
            CALL ENDLN
            NB = NB - 1
          ENDIF
        ENDIF
 
        IF (NB+1.GT.NE) GOTO 190
        NW = 44
        GOTO 30
 
  190   CALL OUTTPS (49, TYPMK,
     *   FMSK, TMSK, RINDX, AINDX, JBSET, KOSET, NLSET,
     *   AVGL, CSTAVG, LMAX, CSTMAX,
     *   TAXON, LTAXON, ITXNAM, FBUF, LFBUF,
     *   FREC, FMEM, FLADDR, NSTAT, FN, FO, IFL,
     *   LIST, MSTR, IDIGS, INODE,
     *   NL, IFROM, NB, NE, NROW, ITOUT)
        CALL ENDLN

  200   CONTINUE
 
      CALL OUTTPS(50, TYPMK,
     * FMSK, TMSK, RINDX, AINDX, JBSET, KOSET, NLSET,
     * AVGL, CSTAVG, LMAX, CSTMAX,
     * TAXON, LTAXON, ITXNAM, FBUF, LFBUF,
     * FREC, FMEM, FLADDR, NSTAT, FN, FO, IFL,
     * LIST, MSTR, IDIGS, INODE,
     * NL, IFROM, NB, NE, NROW, ITOUT)
 
      CALL OUTTPS(29, TYPMK,
     * FMSK, TMSK, RINDX, AINDX, JBSET, KOSET, NLSET,
     * AVGL, CSTAVG, LMAX, CSTMAX,
     * TAXON, LTAXON, ITXNAM, FBUF, LFBUF,
     * FREC, FMEM, FLADDR, NSTAT, FN, FO, IFL,
     * LIST, MSTR, IDIGS, INODE,
     * NL, IFROM, NB, NE, NROW, ITOUT)
 
      CALL ENDLN
 
      RETURN
      END
      SUBROUTINE PRTMSK (STR, MSK, LMSK, ITPSET)                            OUTP
 
C  REVISED 11/06/87.
C  OUTPUTS A MASK.
 
C  STR RECEIVES A CHARACTER STRING TO BE OUTPUT.
C  MSK RECEIVES THE MASK.
C  LMSK RECEIVES THE LENGTH OF MSK.
C  ITPSET RECEIVES WHETHER TYPESETTING MARKS ARE REQUIRED.
 
      CHARACTER*(*) STR
      DIMENSION MSK(LMSK)
 
      COMMON /FMTXXX/ ITAB,LFOUT,LTXOUT,KCOLS,MAXWID
 
      NINCL = NONZER (MSK, LMSK)
      IF (NINCL.EQ.LMSK)  GOTO 110
 
      NEXCL = LMSK - NINCL
      INCL = 1
      IF (NEXCL.GT.0.AND.NEXCL.LE.LMSK/10)  INCL = 0
 
C      IF (ITPSET.GT.0)  THEN
C        CALL JSTTPS (29, -1, LFOUT)
C        CALL JSTTPS (9, 0, LTXOUT)
C      ENDIF
      LSTR = LEN (STR)
      CALL JSTSTR (STR(1:LSTR), 0, LTXOUT)
 
      IF (INCL.EQ.1)  THEN
        CALL JSTSTR ('included', 0, LTXOUT)
      ELSE
        CALL JSTSTR ('excluded', 0, LTXOUT)
      ENDIF
C      IF (ITPSET.GT.0)  CALL JSTTPS (10, 0, LTXOUT)
 
      L = 0
   50 L = L + 1
      IF (L.GT.LMSK)  GOTO 100
        CALL RANGES (MSK, LMSK, L, IB, IE, INCL)
        IF (IB.EQ.0)  GOTO 100
        CALL OUTRNG (IB, IE, 0, ITPSET)
        L = IE
        GOTO 50
 
  100 CALL ENDLN
  110 RETURN
      END
      SUBROUTINE PRTPRE (JBSET, KOSET, NLSET, NSET, ITPSET)                 OUTP
 
C  REVISED 18/4/88.
C  PRINTS LIST OF PRESET CHARACTERS.
 
C  18/4/88. REMOVE TYPSET WORD INSTRUCTION.
C  8/10/86. ORDER OF GROUP AND COLUMN REVERSED IN OUTPUT.
 
C  JBSET RECEIVES THE PRESET CHARACTER NUMBERS.
C  KOSET RECEIVES THE PRESET GROUP NUMBERS.
C  NLSET RECEIVES THE PRESET COLUMN NUMBERS.
C  NSET RECEIVES THE NUMBER OF PRESET CHARACTERS.
C  ITPSET RECEIVES WHETHER TYPESETTING MARKS ARE REQUIRED.
 
 
      INTEGER JBSET(NSET),KOSET(NSET),NLSET(NSET)
 
      COMMON /FMTXXX/ ITAB,LFOUT,LTXOUT,KCOLS,MAXWID
      COMMON /SYMXXX/ BLANK,STOP,SEMIC,LBRAC,RBRAC,RANGE,STAR,UPAROW,
     *            COMMA,COLON,NUMERO,LABRAC,RABRAC,LBRACE,RBRACE,BSLSH
      CHARACTER*1 BLANK,STOP,SEMIC,LBRAC,RBRAC,RANGE,STAR,UPAROW,
     *            COMMA,COLON,NUMERO,LABRAC,RABRAC,LBRACE,RBRACE,BSLSH
 
      ITAB = -2
 
C      IF (ITPSET.GT.0)  THEN
C        CALL JSTTPS (29, 0, LTXOUT)
C        CALL JSTTPS (9, 0, LTXOUT)
C      ENDIF
      CALL JSTSTR ('Preset characters (character,column:group)',
     * 0, LTXOUT)
 
C      IF (ITPSET.GT.0)  THEN
C        CALL JSTTPS (10, -1, LTXOUT)
C      ENDIF
      DO 20 I = 1, NSET
        CALL JSTI (JBSET(I), -1, LTXOUT)
        CALL JSTOUT (COMMA, 1, -1, LTXOUT)
        CALL JSTI (NLSET(I), -1, LTXOUT)
        CALL JSTOUT (COLON, 1, -1, LTXOUT)
        CALL JSTI (KOSET(I), 0, LTXOUT)
   20   CONTINUE
      CALL ENDLN
 
      RETURN
      END
      SUBROUTINE PRTWT (STR, WT, LWT, ITPSET)                               OUTP
 
C  REVISED 16-OCT-91.
C  OUTPUTS WEIGHTS.
 
C  STR RECEIVES A CHARACTER STRING TO BE OUTPUT.
C  WT RECEIVES THE WEIGHTS.
C  LWT RECEIVES THE LENGTH OF WT.
C  ITPSET RECEIVES WHETHER TYPESETTING MARKS ARE REQUIRED.
 
      CHARACTER*(*) STR
      DIMENSION WT(LWT)
 
      COMMON /FMTXXX/ ITAB,LFOUT,LTXOUT,KCOLS,MAXWID
      COMMON /SYMXXX/ BLANK,STOP,SEMIC,LBRAC,RBRAC,RANGE,STAR,UPAROW,
     *            COMMA,COLON,NUMERO,LABRAC,RABRAC,LBRACE,RBRACE,BSLSH
      CHARACTER*1 BLANK,STOP,SEMIC,LBRAC,RBRAC,RANGE,STAR,UPAROW,
     *            COMMA,COLON,NUMERO,LABRAC,RABRAC,LBRACE,RBRACE,BSLSH
 
C     DEFAULT WEIGHT.
      PARAMETER (DEFWT = 5.)                                                  =*
 
      DO 10 L = 1, LWT
        IF (WT(L).NE.DEFWT)  GOTO 20
C       IF (WT(L).GT.0. .AND. WT(L).NE.DEFWT)  GOTO 20
   10   CONTINUE
        GOTO 110
 
   20 ITAB = -2
 
C   25 IF (ITPSET.GT.0)  THEN
C        CALL JSTTPS (29, -1, LFOUT)
C        CALL JSTTPS (9, 0, LTXOUT)
C      ENDIF
   25 LSTR = LEN (STR)
      CALL JSTSTR (STR(1:LSTR), 0, LTXOUT)
C      IF (ITPSET.GT.0)  CALL JSTTPS (10, 0, LTXOUT)
 
C     L = 0
C     FIND NEXT ENTRY.
C  50 L = L + 1
   50 IF (L.GT.LWT)  GOTO 100
        IF (WT(L).EQ.DEFWT)  GOTO 55
        WW = WT(L)
        CALL RANGER (WT, LWT, L, IB, IE, WW)
        IF (IB.EQ.0)  GOTO 100
        CALL OUTRNG (IB, IE, -1, ITPSET)
        CALL JSTOUT (COMMA, 1, -1, LFOUT)
        CALL JSTR (WW, -1, 0, LFOUT)
        L = IE
   55   L = L + 1
        GOTO 50
 
  100 CALL ENDLN
  110 CALL BLKLIN (1)
      RETURN
      END
      SUBROUTINE RANGER (A, L, ISTART, IB, IE, VAL)                         OUTP
 
C  REVISED 29/5/86.
C  FINDS THE START AND END OF A SPECIFIED RANGE OF REAL VALUES.
 
C  A RECEIVES AN ARRAY OF VALUES.
C  L RECEIVES THE LENGTH OF L.
C  ISTART RECEIVES THE STARTING POINT OF THE SEARCH.
C  IB RETURNS THE START OF THE RANGE.
C  IE RETURNS THE END OF THE ARRAY.
C  VAL RECEIVES THE VALUE TO BE SEARCHED FOR.
 
      DIMENSION A(L)
 
 
      DO 10 I = ISTART, L
        IF (A(I).EQ.VAL)  GOTO 20
   10   CONTINUE
      IB = 0
      GOTO 100
   20 IB = I
      DO 30 J = I+1, L
        IF (A(J).NE.VAL)  THEN
          IE = J - 1
          GOTO 100
        ENDIF
   30   CONTINUE
      IE = L
 
  100 RETURN
      END
      SUBROUTINE RANGES (IA, L, ISTART, IB, IE, IVAL)                       OUTP
 
C  REVISED 5/7/85.
C  FINDS THE START AND END OF A SPECIFIED RANGE OF INTEGER VALUES.
 
C  IA RECEIVES AN ARRAY OF VALUES.
C  L RECEIVES THE LENGTH OF L.
C  ISTART RECEIVES THE STARTING POINT OF THE SEARCH.
C  IB RETURNS THE START OF THE RANGE.
C  IE RETURNS THE END OF THE ARRAY.
C  IVAL RECEIVES THE VALUE TO BE SEARCHED FOR.
 
      DIMENSION IA(L)
 
 
      DO 10 I = ISTART, L
        IF (IA(I).EQ.IVAL)  GOTO 20
   10   CONTINUE
      IB = 0
      GOTO 100
   20 IB = I
      DO 30 J = I+1, L
        IF (IA(J).NE.IVAL)  THEN
          IE = J - 1
          GOTO 100
        ENDIF
   30   CONTINUE
      IE = L
 
  100 RETURN
      END
      SUBROUTINE RNKOD (R, NDEC, BUF, LR)                                   OUTP
 
C  REVISED 16-OCT-91.
C  ENCODES A REAL NUMBER.
 
C  R RECEIVES THE NUMBER.
C  NDEC RECEIVES THE NUMBER OF DECIMAL PLACES. IF NDEC IS NEGATIVE,
C    TRAILING ZEROS ARE REMOVED.
C  BUF RECEIVES A CHARACTER BUFFER.
C  LR RETURNS THE LENGTH OF THE ENCODED NUMBER.
 
      CHARACTER*(*) BUF
      CHARACTER*10 FMT
 
      COMMON /CWRKXX/ CTMP
      CHARACTER*10 CTMP
      COMMON /SYMXXX/ BLANK,STOP,SEMIC,LBRAC,RBRAC,RANGE,STAR,UPAROW,
     *            COMMA,COLON,NUMERO,LABRAC,RABRAC,LBRACE,RBRACE,BSLSH
      CHARACTER*1 BLANK,STOP,SEMIC,LBRAC,RBRAC,RANGE,STAR,UPAROW,
     *            COMMA,COLON,NUMERO,LABRAC,RABRAC,LBRACE,RBRACE,BSLSH
 
      LBUF = LEN (BUF)
      IDEC = IABS(NDEC)
 
C     NOTE: ON MS-DOS, 0.0 IS ENCODED INTO CTMP AS ".0".
C     THERE IS NO ZERO BEFORE THE DECIMAL POINT. THIS RESULTS IN AN EMPTY
C     STRING IF TRAILING ZEROS ARE REMOVED. HENCE THE KLUGE BELOW.

      WRITE(FMT,10)LBUF,IDEC
   10 FORMAT( '(F', I2, '.', I2, ')' )
      WRITE (CTMP,FMT,ERR=100) R
 
C    FIND START OF NUMBER.
      ISTART = 1
   20 IF (ISTART.GT.LBUF)  GOTO 50
        IF (CTMP(ISTART:ISTART).NE.BLANK)  GOTO 25
        ISTART = ISTART + 1
        GOTO 20
 
C     REMOVE TRAILING ZEROS IF REQUIRED.
   25 IEND = LBUF
      IF (NDEC.GE.0)  GOTO 35
   30 IF (CTMP(IEND:IEND).NE.'0')  GOTO 35
        IEND = IEND - 1
        GOTO 30
 
   35 IF (CTMP(IEND:IEND).EQ.STOP)  IEND = IEND - 1
C     EMPTY STRING? MUST BE 0.
      IF (ISTART.GT.IEND)  THEN
        CTMP(1:1) = '0'
        ISTART = 1
        IEND = 1
      ENDIF
      LR = 0
      DO 40 I = ISTART, IEND
        LR = LR + 1
        BUF(LR:LR) = CTMP(I:I)
   40   CONTINUE
 
   50 RETURN
 
  100 CALL FERROR ('Output field too small (RNKOD).%')
      END
C      SUBROUTINE SETTPS (L)                                                 OUTP
C 
CC  REVISED 1/4/87.
CC  SETS TYPESETTING PARAMETERS.
C 
CC  L RECEIVES THE NUMBER OF DIGITS IN THE LEAD.
C 
C 
C      COMMON /FMTXXX/ ITAB,LFOUT,LTXOUT,KCOLS,MAXWID
C      COMMON /LTYXXX/ LSTYLE,MAXSTY,LTAB,MAXTAB
C      COMMON /LUNXXX/ LUNI,LUNC,LUNT,LUNO,LUNP,LUNS,LUNS1,LUNE,LUNL,LUNB
C      COMMON /STYXXX/ TSTYLE,TTAB
C        CHARACTER TSTYLE*100,TTAB*30
C 
C 
CC     CLEAR TABS.
C      CALL JSTTPS (22, -1, LFOUT)
C 
C      IF (LTAB.LE.0)  THEN
CC     CALCULATE TABS AND INDENTATION.
C 
CC       LEFT TAB.
C        TPSTAB = 3.5 + (L-1)*1.4
C        CALL JSTTPS (21, -1, LFOUT)
C        CALL JSTR (TPSTAB, 1, -1, LFOUT)
C        CALL JSTTPS (23, -1, LFOUT)
C 
CC      LEFT INDENTATION.
C        TPSIND = 5.0 + (L-1)*1.4
C        CALL JSTTPS (21, -1, LFOUT)
C        CALL JSTR (TPSIND, 1, -1, LFOUT)
C        CALL JSTTPS (24, -1, LFOUT)
C 
C      ELSE
C 
CC       OUTPUT USER SPECIFICATIONS.
C        CALL JSTSTR (TTAB(1:LTAB), -1, LFOUT)
C 
C      ENDIF
C 
C      CALL ENDLN
C      RETURN
C      END
      SUBROUTINE SOURCE (IS)                                                OUTP
 
C  REVISED 24/2/86.
C  OUTPUTS SOURCE NODE ENCLOSED IN PARENTHESES.
 
 
      COMMON /FMTXXX/ ITAB,LFOUT,LTXOUT,KCOLS,MAXWID
      COMMON /SYMXXX/ BLANK,STOP,SEMIC,LBRAC,RBRAC,RANGE,STAR,UPAROW,
     *            COMMA,COLON,NUMERO,LABRAC,RABRAC,LBRACE,RBRACE,BSLSH
      CHARACTER*1 BLANK,STOP,SEMIC,LBRAC,RBRAC,RANGE,STAR,UPAROW,
     *            COMMA,COLON,NUMERO,LABRAC,RABRAC,LBRACE,RBRACE,BSLSH
 
      CALL JSTOUT (LBRAC, 1, -1, LFOUT)
      CALL JSTI (IS, -1, LFOUT)
      CALL JSTOUT (RBRAC, 1, -1, LFOUT)
      CALL JSTOUT (STOP, 1, -1, LFOUT)
 
      RETURN
      END
      SUBROUTINE STRMSK (MSK, LMSK, ITYPMK, STR, LSTR, IERR)                OUTP
 
C  REVISED 29-MAR-99.
C  WRITES A MASK INTO A STRING.
 
C  MSK RECEIVES THE MASK.
C  LMSK RECEIVES THE LENGTH OF MSK.
C  ITYPMK RECEIVES THE TYPESETTING MARKS.
C  STR RETURNS THE ENCODED STRING.
C  LSTR RETURNS THE LENGTH OF STR.
 
      COMMON /SYMXXX/ BLANK,STOP,SEMIC,LBRAC,RBRAC,RANGE,STAR,UPAROW,
     *            COMMA,COLON,NUMERO,LABRAC,RABRAC,LBRACE,RBRACE,BSLSH
      CHARACTER*1 BLANK,STOP,SEMIC,LBRAC,RBRAC,RANGE,STAR,UPAROW,
     *            COMMA,COLON,NUMERO,LABRAC,RABRAC,LBRACE,RBRACE,BSLSH
 
      DIMENSION MSK(LMSK)
      CHARACTER*(*) STR
 
      LENSTR = LEN(STR)
 
      K = 1
      L = 0
   20 L = L + 1
      IF (L.GT.LMSK)  GOTO 30
        CALL RANGES (MSK, LMSK, L, IB, IE, 1)
        IF (IB.EQ.0)  GOTO 30
        IF (K.GT.1)  THEN
          IF (K.GT.LENSTR) GOTO 40
          STR(K:K) = BLANK
          K = K + 1
        ENDIF
        CALL STRRNG(IB, IE, ITYPMK, STR(K:), LOUT, IERR)
        IF (IERR.NE.0) GOTO 40
        K = K + LOUT
        L = IE
        GOTO 20
 
   30 LSTR = K - 1
      GOTO 50

   40 IERR = 1
 
   50 RETURN
      END
      SUBROUTINE STRRNG (IB, IE, ITYPMK, STR, LSTR, IERR)                   OUTP
 
C REVISED 29-MAR-99.
C ENCODES A RANGE INTO A STRING.
 
C  IB RECEIVES THE BEGINNING OF THE RANGE.
C  IE RECEIVES THE END OF THE RANGE.
C  ITYPMK RECEIVES THE TYPESETTING MARKS.
C  LTYPMK RECEIVES THE LENGTH OF ITYPMK.
C  STR RETURNS THE ENCODED RANGE.
C  LSTR RETURNS THE LENGTH OF STR.
 
      COMMON /TPSXXX/ ITPSET,MAXTYPMK,NTYPMK,LTYPMK,INTYPMKS
 
      DIMENSION ITYPMK(LTYPMK)
      CHARACTER*(*) STR
      CHARACTER*10 TEMP
 
      LENSTR = LEN(STR)

      K = 1
      CALL INKOD (IB, TEMP, LOUT)
      IF (K+LOUT-1.GT.LENSTR)  GOTO 40
      STR(K:) = TEMP(1:LOUT)
      K = K + LOUT
      IF (IE.GT.IB)  THEN
C       Get range symbol.
        CALL GETTPS(1, ITYPMK, IB, LENTPS)
        IF (LENTPS.GT.0)  THEN
          IF (K+LENTPS-1.GT.LENSTR)  GOTO 40
          J = IB + 3
          DO I = 1, LENTPS
            STR(K:K) = CHAR(ITYPMK(J+I-1))
            K = K + 1
          ENDDO
        ENDIF
        CALL INKOD (IE, TEMP, LOUT)
        IF (K+LOUT-1.GT.LENSTR)  GOTO 40
        STR(K:) = TEMP(1:LOUT)
        K = K + LOUT
      ENDIF
      LSTR = K - 1
      GOTO 50
 
   40 IERR = 1

   50 RETURN
      END
      SUBROUTINE STRUCT (D, T, BRULE, ERULE, BREC,                          OUTP
     1 NSTAT, FO, LIST, MSTOR, IDIGS, INODE, ITAXON)
 
C* REVISED 10/8/87.
C* DETERMINES AND PUNCHES STRUCTURE OF KEY.
 
C  D RECEIVES THE TAXON-CHARACTER MATRIX.
C  T RECEIVES THE TAXON NUMBERS.
C  BRULE RECEIVES THE BETWEEN-TAXA RULINGS IN THE TABULAR KEY.
C  ERULE RECEIVES THE BETWEEN-CHARACTER RULINGS IN THE TABULAR KEY.
C  BREC RETURNS THE STARTING POSITION (IN LIST) OF EACH GROUP.
C  NSTAT RECEIVES THE NUMBERS OF FEATURE STATES.
C  FO RECEIVES THE ORIGINAL FEATURE NUMBERS.
C  LIST RETURNS THE STRUCTURE OF THE KEY.
C  MSTOR RECEIVES THE LENGTH OF LIST.
C  IDIGS RETURNS THE NUMBER OF CHARACTERS ALLOWED FOR A STATE NUMBER.
C  INODE RETURNS THE IDENTIFICATION OF A NODE IN THE STRUCTURE.
C  ITAXON RETURNS THE IDENTIFICATION OF A TAXON IN THE STRUCTURE.
 
      COMMON /DIMXXX/ LDM,NFR,NF,NTM,NTM1,NTU,NTH,NWORD,NDESC,LCDEP
C     COMMON /EXTXXX/ EXTIME(6)                                               C*
      COMMON /LUNXXX/ LUNI,LUNC,LUNT,LUNO,LUNP,LUNS,LUNS1,LUNE,LUNL,LUNB
      COMMON /LUOXXX/ NUN,LPRINT,LTOP,LUNCOM(10),LUNPRE(10),
     *  LUNUSE(13),LUNREC(13),LUNPAG(13)
      COMMON /MATXXX/ JU,JF,JS,I,J,NL,JB,NFP,NB,NE
C     COMMON /MSTXXX/ MSTOR,MSTORC
      COMMON /PARXXX/ NFB,NFE,JFB,NVAR,NEWLN,NT,NTD,NTA,NO,KN,NUSED,
     *                INCOMP,VARW,NTR,RBASE,ABASE,REUSE,VARYWT,NCONF,
     *                NSET,RES,ITUNKV,IADCNO,ITCHV,IRTF,IHTML
      COMMON /PRFXXX/ NP(8)
 
      INTEGER STATE
      INTEGER D(LDM),T(NTU),BRULE(NTU),ERULE(NTU),BREC(NTU),
     * NSTAT(NF),FO(NF),LIST(MSTOR)
 
C     NDIGS AND NDIGC ARE RESPECTIVELY THE NUMBERS OF DECIMAL DIGITS
C     REQUIRED TO REPRESENT A STATE NUMBER AND A CHARACTER NUMBER.
      DATA NDIGS/2/,NDIGC/3/                                                  =*
 
C     INITIALIZE.
      IDIGS = 10**NDIGS
      INODE = 10**(NDIGS+NDIGC)
      ITAXON = 2*INODE
      I = 1
      J = 1
      L = 1
      NL = 1
      BREC(1) = 1
      LIST(1) = 0
 
C---    FIND AND RECORD STRUCTURE OF NODES.
C--     RECORD ATTRIBUTES OF FIRST BRANCH OF NODE. COUNT CONFIRMATORY
C--     CHARACTERS.
   30   JCONF = 0
   34     L = L + 1
          IF (L.GT.MSTOR)  GO TO 300
C         FETCH CHARACTER JF, VALUE JS, AND FLAG JU.
          CALL FEATST (D, LDM)
C         RECORD JUMP TO NODE.
          LIST(L) = IDIGS*FO(JF) + JS
C         (JU.EQ.0 MARKS THE LAST CHARACTER IN THE BRANCH.)
          IF (JU.EQ.0)  GO TO 36
          J = J + 1
          JCONF = JCONF + 1
          GO TO 34
 
C--     FIND AND RECORD STRUCTURE OF BRANCHES.
C       SAVE MAIN ROW INDEX.
   36   ISAVE = I
        NVAL = 0
C         COUNT NUMBER OF VALUES.
   40     NVAL = NVAL + 1
C         PLANT CURRENT NODE NUMBER IN MATRIX.
          CALL SETNOD (D, LDM)
          IF (J.GE.ERULE(I))  GO TO 44
C         LEAVE SLOT FOR DESTINATION NODE NUMBER.
          L = L + 1
          IF (L.GT.MSTOR)  GO TO 300
          LIST(L) = 0
C         CAN THERE BE MORE BRANCHES.
          IF (NVAL.GE.NSTAT(JF)) GO TO 68
          GO TO 50
C         RECORD TAXON NUMBER.
   44     L = L + 1
          IF (L.GT.MSTOR)  GO TO 300
          LIST(L) = T(I) + ITAXON
C-          SEARCH FOR NEW BRANCH.
C           IS THIS THE BOTTOM OF THE NODE.
   50       IF (I.EQ.NTA.OR.BRULE(I).LT.J-JCONF)  GO TO 68
C           MOVE DOWN COLUMN TO NEXT ROW.
            I = I + 1
C           IS THIS A NEW BRANCH.
            IF (STATE(D,LDM,I).NE.JS)  GO TO 58
C           SAME BRANCH. RECORD TAXON NAME IF NECESSARY, AND CONTINUE
C           SEARCH.
            IF (J.LT.ERULE(I))  GO TO 54
            L = L + 1
            IF (L.GT.MSTOR)  GO TO 300
            LIST(L) = T(I) + ITAXON
   54       GO TO 50
 
C-        NEW BRANCH. RECORD ATTRIBUTES.
   58     J = J - JCONF
   60       L = L + 1
            IF (L.GT.MSTOR)  GO TO 300
            CALL FEATST (D, LDM)
            LIST(L) = IDIGS*FO(JF) + JS
            IF (JU.EQ.0)  GO TO 64
            J = J + 1
            GO TO 60
   64     GO TO 40
 
C--     SEARCH FOR NEXT NODE.
C       RESTORE MAIN ROW INDEX.
   68   I = ISAVE
C         IS THIS THE END OF THE ROW.
   70     IF (J.GE.ERULE(I))  GO TO 72
          J = J + 1
C         IS THERE RULING ABOVE THE ELEMENT AT THE LEFT OF THE
C         CURRENT ONE.
          IF (I.EQ.1)  GO TO 80
          IF (J.GT.BRULE(I-1))  GO TO 80
          GO TO 74
C         GO TO START OF NEXT ROW.
   72     IF (I.GE.NTA)  GO TO 100
          I = I + 1
          J = 1
C           SKIP TO LAST CONFIRMATORY CHARACTER.
   74       CALL FEATST (D, LDM)
            IF (JU.EQ.0)  GO TO 76
            J = J + 1
            GO TO 74
   76     GO TO 70
 
C--     PRELIMINARY PROCESSING OF NEW NODE.
C       INCREMENT STRUCTURE-ELEMENT INDEX.
   80   L = L + 1
        IF (L.GT.MSTOR)  GO TO 300
C       INCREMENT NODE COUNTER.
        NL = NL + 1
C       BEGINNING OF NODE RECORD.
        BREC(NL) = L
C       FETCH SOURCE NODE NUMBER.
        CALL GETNOD (D, LDM)
        LIST(L) = JB
C       INSERT DESTINATION (CURRENT) NODE NUMBER IN SLOT IN SOURCE NODE
C       RECORD.
        M = BREC(JB) + 1
   84     IF (LIST(M).EQ.0)  GO TO 86
          M = M + 1
          GO TO 84
   86   LIST(M) = INODE + NL
        GO TO 30
 
C---  RECORD START OF LAST (EMPTY) RECORD.
  100 L = L + 1
      BREC(NL+1) = L
      NO = NL
      IF (NP(6).EQ.0)  GO TO 150
 
C---    PUNCH KEY STRUCTURE.
        DO 140 NL = 1, NO
        NB = BREC(NL)
        NFE = BREC(NL+1) - 1
  130     NE = MIN0(NB+9,NFE)                                                 =*
          WRITE(LUNS,132)NL,(LIST(K),K=NB,NE)
          LUNREC(LUNS) = LUNREC(LUNS) + 1
  132     FORMAT(11I7)
          IF (NE.EQ.NFE)  GO TO 140
          NB = NB + 10                                                        =*
          GO TO 130
  140   CONTINUE
C---
  150 RETURN
 
C---  ERROR MESSAGE.
  300 CALL ERROR (0, 'Not enough space to form a conventional key.%')
      NP(5) = 0
      RETURN
      END
      SUBROUTINE STRWT (WT, LWT, ITYPMK, STR, LSTR, IERR)                   OUTP
 
C  REVISED 29-MAR-99.
C  ENCODES WEIGHTS IN A STRING.
 
C  WT RECEIVES THE WEIGHTS.
C  LWT RECEIVES THE LENGTH OF WT.
C  ITYPMK RECEIVES THE TYPESETTING MARKS.
C  STR RETURNS THE ENCODED STRING.
C  LSTR RETURNS THE LENGTH OF STR.
 
      DIMENSION WT(LWT)
      CHARACTER*(*) STR
      CHARACTER*10 TEMP
 
      COMMON /SYMXXX/ BLANK,STOP,SEMIC,LBRAC,RBRAC,RANGE,STAR,UPAROW,
     *            COMMA,COLON,NUMERO,LABRAC,RABRAC,LBRACE,RBRACE,BSLSH
      CHARACTER*1 BLANK,STOP,SEMIC,LBRAC,RBRAC,RANGE,STAR,UPAROW,
     *            COMMA,COLON,NUMERO,LABRAC,RABRAC,LBRACE,RBRACE,BSLSH
 
C     DEFAULT WEIGHT.
      PARAMETER (DEFWT = 5.)                                                  =*
 
      LENSTR = LEN(STR)

      K = 1
      L = 1
C     FIND NEXT ENTRY.
   50 IF (L.GT.LWT)  GOTO 100
        IF (WT(L).EQ.DEFWT)  GOTO 55
        WW = WT(L)
        CALL RANGER (WT, LWT, L, IB, IE, WW)
        IF (IB.EQ.0)  GOTO 100
        IF (K.GT.1)  THEN
          IF (K.GT.LENSTR)  GOTO 150
          STR(K:K) = BLANK
          K = K + 1
        ENDIF
        CALL STRRNG (IB, IE, ITYPMK, STR(K:), LOUT, IERR)
        IF (IERR.NE.0) GOTO 150
        K = K + LOUT
        IF (K.GT.LENSTR)  GOTO 150
        STR(K:K) = COMMA
        K = K + 1
        CALL RNKOD (WW, 1, TEMP, LOUT)
        IF (K+LOUT-1.GT.LENSTR)  GOTO 150
        STR(K:) = TEMP(1:LOUT)
        K = K + LOUT
        L = IE
   55   L = L + 1
        GOTO 50
 
  100 IF (K.EQ.1)  THEN
C     All weights are the same.
        CALL STRRNG (1, LWT, ITYPMK, STR(K:), LOUT, IERR)
        IF (IERR.NE.0)  GOTO 150
        K = K + LOUT
        IF (K.GT.LENSTR)  GOTO 150
        STR(K:K) = COMMA
        K = K + 1
        CALL RNKOD (DEFWT, 1, TEMP, LOUT)
        IF (K+LOUT-1.GT.LENSTR)  GOTO 150
        STR(K:) = TEMP(1:LOUT)
        K = K + LOUT
      ENDIF
 
      LSTR = K - 1
      GOTO 200
 
  150 IERR = 1
 
  200 RETURN
      END
      SUBROUTINE TAB                                                        OUTP
 
C  REVISED 24/7/85.
C  INDENTS TO COLUMN ITAB.
 
 
      COMMON /FMTXXX/ ITAB,LFOUT,LTXOUT,KCOLS,MAXWID
      COMMON /TPSXXX/ ITPSET,MAXTYPMK,NTYPMK,LTYPMK,INTYPMKS
 
      CALL INDEN (ITAB)
 
C   20 IF (ITPSET.GT.0)  THEN
C        CALL JSTTPS (18, 0, LFOUT)
C      ENDIF
 
      RETURN
      END
      SUBROUTINE WRTKEY (D, T, BRULE, ERULE, BRUL, ERUL, NOCC,              OUTP
     * FO, R, USED, RULE, DIO, FLAG,
     * ITXNAM, NLSET, KOSET, JBSET, NSD, FMSK, RINDX,
     * TMSK, AINDX, TAXON, LTAXON)
 
C* REVISED 11-APR-99.
C* PRINTS THE TABULAR KEY.
 
      COMMON /DIMXXX/ LDM,NFR,NF,NTM,NTM1,NTU,NTH,NWORD,NDESC,LCDEP
      COMMON /FMTXXX/ ITAB,LFOUT,LTXOUT,KCOLS,MAXWID
      COMMON /IOPARX/ JOUT,IENDWD,IBINARY
      COMMON /LINEXX/ LINE
      CHARACTER*200 LINE
      COMMON /LUNXXX/ LUNI,LUNC,LUNT,LUNO,LUNP,LUNS,LUNS1,LUNE,LUNL,LUNB
      COMMON /LUUXXX/ LUNOUT
      COMMON /MATXXX/ JU,JF,JS,I,J,NL,JB,NFP,NB,NE
      COMMON /PARXXX/ NFB,NFE,JFB,NVAR,NEWLN,NT,NTD,NTA,NO,KN,NUSED,
     *                INCOMP,VARW,NTR,RBASE,ABASE,REUSE,VARYWT,NCONF,
     *                NSET,RES,ITUNKV,IADCNO,ITCHV,IRTF,IHTML
      COMMON /PRFXXX/ NP(8)
      COMMON /SYMXXX/ BLANK,STOP,SEMIC,LBRAC,RBRAC,RANGE,STAR,UPAROW,
     *            COMMA,COLON,NUMERO,LABRAC,RABRAC,LBRACE,RBRACE,BSLSH
      CHARACTER*1 BLANK,STOP,SEMIC,LBRAC,RBRAC,RANGE,STAR,UPAROW,
     *            COMMA,COLON,NUMERO,LABRAC,RABRAC,LBRACE,RBRACE,BSLSH
      COMMON /TPSXXX/ ITPSET,MAXTYPMK,NTYPMK,LTYPMK,INTYPMKS
 
      REAL R(NF),RINDX(NFR),AINDX(NTR)
      INTEGER D(LDM),T(NTU),BRULE(NTU),ERULE(NTU),BRUL(NTU),ERUL(NTU),
     * NOCC(NTU),FO(NF),USED(NF),DIO(NFR),FLAG(NTM),ITXNAM(NTM1),
     * NLSET(NSD),KOSET(NSD),JBSET(NSD),FMSK(NFR),
     * TMSK(NTR)
      CHARACTER*1 TAXON(LTAXON),TAXTMP(48),TXNAME*24,OCCUR*3
      CHARACTER*4 RULE(NF)
 
C  MWID = MAXIMUM NUMBER OF CHARACTERS IN OUTPUT RECORD                       =/
C     RUL MUST BE DIMENSIONED AT LEAST (MWID-30)/4.
C     FIRST DIMENSION OF LABEL MUST BE MNS.                                   =/
      CHARACTER*4 RUL(30),LABEL(20,2),MMMP,BBBV,BBBB
      CHARACTER FMT*80,HRULE*29
C  (INCLUDING CARRIAGE CONTROL CHARACTER). FORMAT STATEMENTS 60, 62,          =/
C  77, AND 78 MAY NEED TO BE ALTERED TO CORRESPOND TO                         =/
C  MAXIMUM RECORD LENGTH.                                                     =/
 
      DATA HRULE /'+---------------------------+'/
      DATA MMMP/'---+'/,BBBV/'   |'/,BBBB/'    '/
      DATA LABEL/'A|  ','B|  ','C|  ','D|  ','E|  ',                          =*
     *           'F|  ','G|  ','H|  ','I|  ','J|  ',                          =*
     *           'K|  ','L|  ','M|  ','N|  ','O|  ',                          =*
     *           'P|  ','Q|  ','R|  ','S|  ','T|  ',                          =*
     *           'A   ','B   ','C   ','D   ','E   ',                          =*
     *           'F   ','G   ','H   ','I   ','J   ',                          =*
     *           'K   ','L   ','M   ','N   ','O   ',                          =*
     *           'P   ','Q   ','R   ','S   ','T   '/                          =*
 
 
C     DETERMINE AVERAGE LENGTH AND COST OF KEY,
C               MAXIMUM LENGTH AND COST OF KEY.
 
 
      AVGL = 0.
      CSTAVG = 0.
      LMAX = 0
      CSTMAX = 0.
      DO 10 I = 1, NTA
        NE = ERULE(I)
        LKEY = 0
        CSTKEY = 0.
        LJU = 0
        DO 5 J = 1, NE
          CALL FEATST (D, LDM)
          IF (LJU.EQ.0)  THEN
            LKEY = LKEY + 1
            CSTKEY = CSTKEY + R(JF)
          ENDIF
          LJU = JU
    5     CONTINUE
        AVGL = AVGL + LKEY
        CSTAVG = CSTAVG + CSTKEY
        IF (LKEY.GT.LMAX)  LMAX = LKEY
        IF (CSTKEY.GT.CSTMAX)  CSTMAX = CSTKEY
   10   CONTINUE
      CSTAVG = CSTAVG/NTA
      AVGL = AVGL/NTA
 
 
C     CHOOSE REQUIRED FORMAT OPTION, AND CALCULATE NUMBER OF STRIPS
C     NEEDED TO PRINT TABULAR KEY.
      MWID = LTXOUT
      NWID = MWID - 30
      NOPT = 1
      INSTPS = 0
 
      IF (INCOMP.EQ.1)
     * CALL ERROR (0, 'Key incomplete. More information needed.%')
 
   20 KWID = 4
      NSTRIP = 1
      LUNOUT = LUNO
 
      GO TO (22,26,34), NOPT
 
   22 IF (NP(3).EQ.0)  GO TO 150
      DO 24 K = 1, NF
        IF (USED(K).NE.0.AND.FO(K).GT.99)  KWID = 5
   24   CONTINUE
      GO TO 30
 
   26 IF (NP(4).EQ.0)  GO TO 150
      IF (NUSED.GT.99)  KWID = 5
   30 DO 32 K = 1, NTA
        NSTRIP = MAX0(NSTRIP,MIN0(ERULE(K),KCOLS))
   32   CONTINUE
      JWID = NWID/KWID
      NSTRIP = MAX0(1,(NSTRIP+JWID-1)/JWID)
      GO TO 36
 
   34 IF (NP(5).EQ.0)  GO TO 200
 
      IF (ITPSET.GT.0) THEN
        IF (IBINARY.NE.0)  THEN
          LUNOUT = LUNB
        ELSE
          LUNOUT = LUNP
        ENDIF
        INSTPS = 1
      ENDIF
 
C--   PRINT TABULAR KEY.
   36 DO 120 KSTRIP = 1, NSTRIP
C
C-      PRINT HEADING.
 
        CALL OUTHDR (FMSK, TMSK, RINDX, AINDX, JBSET, KOSET, NLSET, NSD,
     *   CSTAVG, CSTMAX, AVGL, LMAX, INSTPS)
 
        IF (NOPT.EQ.3)  GO TO 200
C
C-      SET LIMITS OF STRIP TO BE PRINTED.
        LEFT = (KSTRIP-1)*JWID
        LEFT1 = LEFT + 1
        DO 54 K = 1, NTA
          ERUL(K) = MIN0(IDIM(ERULE(K),LEFT),JWID)
          BRUL(K) = MIN0(IDIM(BRULE(K),LEFT1),JWID) + 1
   54     CONTINUE
C
C-      PRINT HORIZONTAL RULING AT TOP OF KEY.
        NR = MIN0(ERUL(1),KCOLS)
        IF (NR.EQ.0)  THEN
          WRITE(LINE,55) HRULE
   55     FORMAT(A29,'%')
        ELSE
          DO 56 K = 1, NR
            RULE(K) = MMMP
   56       CONTINUE
          IF (KWID.EQ.4)  THEN
            WRITE(FMT,60) HRULE,NR
   60       FORMAT( '(''',A29,''',',I2,'A4,''%'')' )
            WRITE(LINE,FMT) (RULE(K),K=1,NR)
          ELSE
            WRITE(FMT,62) HRULE,NR
   62       FORMAT( '(''',A29,''',',I2,'(A1,A4),''%'')' )
            WRITE(LINE,FMT) (RULE(K),RULE(K),K=1,NR)
          ENDIF
        ENDIF
        CALL MESS (LINE, LUNOUT)
 
C-      PRINT KEY.
 
C       COUNT NUMBER OF OCCURRENCES OF TAXA IN KEY.
        DO 63 I = 1, NTA
          NOCC(I) = 0
   63     CONTINUE
        DO 66 I = 1, NTA
          IF (NOCC(I).NE.0)  GOTO 66
          ID = T(I)
          KNT = 1
          DO 64 K = I+1, NTA
            IF (T(K).EQ.ID)  KNT = KNT + 1
   64       CONTINUE
          NOCC(I) = KNT
          DO 65 K = I+1, NTA
            IF (T(K).EQ.ID)  NOCC(K) = KNT
   65       CONTINUE
   66     CONTINUE
 
 
        I = 1
C
C       SET UP AND PRINT NEXT LINE OF KEY.
   70   I1 = T(I)
          J1 = ITXNAM(I1)
          J2 = ITXNAM(I1+1)-1
C         Make a temporary copy of the name. TAXTMP can hold 48 characters.
          IF (J2-J1+1.GT.48) J2 = J1 + 47
          L = 0
          DO K = J1, J2
            L = L + 1
            TAXTMP(L) = TAXON(K)
          ENDDO
C         Remove any typesetting marks, as we don't want these in the tabular key.
          CALL REMTYP (TAXTMP, L)
          L = MIN(L, 24)
          DO 75 K = 1, L
            TXNAME(K:K) = TAXTMP(K)
  75        CONTINUE
          IF (L.LT.24)  THEN
            DO 76 K = L+1, 24
              TXNAME(K:K) = BLANK
   76         CONTINUE
          ENDIF
   77     FORMAT( '(''|'',A,A,''|'',',I2,'(I2,A2),''%'')'  )
   78     FORMAT( '(''|'',A,A,''|'',',I2,'(I3,A2),''%'')'  )
          NE = MIN0(ERUL(I),KCOLS)
          IF (NOCC(I).GT.999) THEN
            OCCUR = '***'
          ELSEIF (NOCC(I).GT.1) THEN
            WRITE(OCCUR,79) NOCC(I)
   79       FORMAT(I3)
          ELSE
            OCCUR = ' '
          ENDIF
          IF (NE.LT.1)  THEN
            WRITE(LINE,80) TXNAME,OCCUR
   80       FORMAT('|',A,A,'|%')
            CALL MESS (LINE, LUNOUT)
            GOTO 85
          ENDIF
          DO 82 JJ = 1, NE
            J = JJ + LEFT
            CALL FEATST (D, LDM)
            DIO(JJ) = FO(JF)
            IF (NOPT.EQ.2)  DIO(JJ) = USED(JF)
            IF (JU.EQ.0)  THEN
              RULE(JJ) = LABEL(JS,1)
              RUL(JJ) = BBBV
            ELSE
              RULE(JJ) = LABEL(JS,2)
              RUL(JJ) = BBBB
            ENDIF
   82       CONTINUE
          IF (KWID.EQ.4)  THEN
            WRITE(FMT,77) NE
            WRITE(LINE,FMT) TXNAME,
     1       OCCUR,(DIO(K),RULE(K),K=1,NE)
          ELSE
            WRITE(FMT,78) NE
            WRITE(LINE,FMT) TXNAME,
     1       OCCUR,(DIO(K),RULE(K),K=1,NE)
          ENDIF
          CALL MESS (LINE, LUNOUT)
 
C         SET UP AND PRINT HORIZONTAL RULING.
   85     IF (I.GE.NTA)  GO TO 102
          NB = BRUL(I)
          NR = MIN0(MAX0(NE,ERUL(I+1)),KCOLS)
          IF (NR.GE.NB)  THEN
            DO 86 K = NB, NR
            RUL(K) = MMMP
   86       CONTINUE
          ENDIF
          IF (NR.LT.1)  THEN
            WRITE(LINE,55) HRULE
          ELSE
            IF (KWID.EQ.4)  THEN
            WRITE(FMT,60) HRULE,NR
            WRITE(LINE,FMT) (RUL(K),K=1,NR)
            ELSE
              WRITE(FMT,62) HRULE,NR
              WRITE(LINE,FMT) (RUL(K),RUL(K),K=1,NR)
            ENDIF
          ENDIF
          CALL MESS (LINE, LUNOUT)
 
          I = I + 1
          GO TO 70
C
C       HORIZONTAL RULING AT BOTTOM.
  102   IF (NE.LT.1)  THEN
          WRITE(LINE,55) HRULE
        ELSE
          DO 104 K = 1, NE
            RUL(K) = MMMP
  104       CONTINUE
          IF (KWID.EQ.4)  THEN
            WRITE(FMT,60) HRULE,NE
            WRITE(LINE,FMT) (RUL(K),K=1,NE)
          ELSE
            WRITE(FMT,62) HRULE,NE
            WRITE(LINE,FMT) (RUL(K),RUL(K),K=1,NE)
          ENDIF
        ENDIF
        CALL MESS (LINE, LUNOUT)
  120   CONTINUE
 
  150 NOPT = NOPT + 1
      GO TO 20
 
  200 CONTINUE
      RETURN
      END
