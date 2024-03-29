      SUBROUTINE PAYCHA (ITYPC, NSTAT, KSTAT, ICDES, LCDES, NC, IKEYCH,     TPAY
     * KCOM, IAS, MS, ISBND, ITYPMK, LIDAT, ICSTR, LCSTR, IC, IPASS)
 
C* REVISED 3-AUG-92.
C* OUTPUTS A CHARACTER DESCRIPTION IN PAYNE FORMAT.
C
C  ITYPC RECEIVES THE CHARACTER TYPES.
C  NSTAT RECEIVES THE NUMBER OF STATES
C  KSTAT RECEIVES THE NUMBERS OF KEY STATES.
C  ICDES RECEIVES THE STARTING POSITIONS OF THE CHARACTER DESCRIPTIONS.
C  LCDES RECEIVES THE LENGTHS OF THE CHARACTER DESCRIPTIONS.
C  NC RECEIVES THE NUMBER OF CHARACTERS.
C  IKEYCH RECEIVES WHETHER THIS IS A KEY CHARACTER LIST.
C  KCOM RECEIVES THE COMMA CHARACTER TO BE USED TO SEPARATE STATE DESCRIPTIONS.
C  IAS RECEIVES WORKING SPACE OF LENGTH MS.
C  MS RECEIVES THE MAXIMUM NUMBER OF STATES.
C  ISBND RECEIVES THE NEW STATE BOUNDARIES.
C  ITYPMK RECEIVES TYPESETTING MARKS.
C  LIDAT RECEIVES THE DATA BUFFER LENGTH.
C  ICSTR. IF ISTYPE.EQ.1, ICSTR RECEIVES THE CHARACTER DESCRIPTIONS.
C    IF ISTYPE.NE.1, ICSTR IS WORKING SPACE. SEE SUBR. FETCHC.
C  LCSTR RECEIVES THE DIMENSION OF ICSTR.
C  IC RECEIVES THE CHARACTER NUMBER.
C  IPASS RECEIVES THE VALUE 1 (EXTRACT CHAR. DESC) OR 2 (EXTRACT STATE DESC)
C
      DIMENSION ITYPC(NC),NSTAT(NC), KSTAT(NC),
     * ICDES(NC),LCDES(NC),IAS(MS),ISBND(LIDAT),ITYPMK(LIDAT),
     * ICSTR(LCSTR)
C
      COMMON /ALPXXX/ KA,KB,KC,KD,KE,KF,KG,KH,KI,KJ,KK,KL,KM,
     *                KN,KO,KP,KQ,KR,KS,KT,KU,KV,KW,KX,KY,KZ
      COMMON /SYMXXX/ KPOINT,KDASH,KSTAR,KVERT,KEQUAL,KCOMMA,KSEMIC,
     * KCOLON,KSTOP,KSOL,KLPAR,KRPAR,KDOLLA,KQUEST,KEXCL,KAT,KLBRACE,
     * KRBRACE
C
C
C
C---  GET CHARACTER DESCRIPTION.
      CALL FETCHC (ICSTR, LCSTR, ICDES, LCDES, NC, IC, IAC, IAS, MS)
C
      JTYPC = IABS(ITYPC(IC))
      NS = KSTAT(IC)
C
C     CHARACTER NAMES AND STATES WRITTEN TO SCRATCH FILE
      LUNTYP = 5
C
C---  NO. STATES.
      INULST = 0
      IF (NS.GE.2)  GO TO 50
      INULST = 1
      NS = 2
C
   50 IF (IPASS.LT.1 .OR. IPASS.GT.2)  GO TO 1000
      IF (IPASS.EQ.2)  GO TO 100
C
C---  FEATURE.
      CALL WSENT (ICSTR(IAC), LCSTR, 1, 0, 0, 0, -1, ITYPMK, LIDAT,
     * LUNTYP)
      CALL JSTS (KCOLON, 1, LUNTYP)
      GO TO 1000
C
C---  STATES.
  100 JSG = ISBND(IC) + 1
C
      DO 500 JS = 1, NS
        IF (INULST.LE.0)  GO TO 150
C
C-      SUPPLY NULL STATE DESCRIPTIONS TO SATISFY PROGRAM REQUIREMENTS
        IF (JS.EQ.1) CALL JSTS (KA, -1, LUNTYP)
        IF (JS.EQ.2) CALL JSTS (KB, -1, LUNTYP)
        CALL JSTS (KCOLON, 1, LUNTYP)
        GO TO 500
C-
  150   IF (ISBND(IC).GT.0.AND.IKEYCH.EQ.0)  GO TO 200
C
C--     ORIGINAL STATES.
        I = IAS(JS)
        CALL WSENT (ICSTR(I), LCSTR, 0, 0, 0, 0, -1, ITYPMK, LIDAT,
     *   LUNTYP)
        CALL JSTS (KCOLON, 1, LUNTYP)
        GO TO 500
C
C--     NEW STATES.
  200   NB = JSG + 2
        NE = JSG + ISBND(JSG) - 1
        ITS = ISBND(JSG+1)
        IF (JTYPC.GE.3)  GO TO 300
C
C-      MULTISTATE.
        DO 230 J = NB, NE
          IS = ISBND(J)
          I = IAS(IS)
          CALL WSENT (ICSTR(I), LCSTR, 0, 0, 0, 0, -1, ITYPMK, LIDAT,
     *     LUNTYP)
          IF (J.EQ.NE)  GO TO 230
          IF (JTYPC.EQ.2)  GO TO 224
          CALL JSTWD (KCOM, 0, ITYPMK, LIDAT, LUNTYP)
          CALL JSTWD (1, 0, ITYPMK, LIDAT, LUNTYP)
          GO TO 230
  224     CALL ENDWD (LUNTYP)
          CALL JSTWD (2, 0, ITYPMK, LIDAT, LUNTYP)
  230     CONTINUE
        GO TO 400
C
C-      NUMERIC.
  300   IF (NSTAT(IC).EQ.1)  I1 = IAS(1)
        IF (JTYPC.EQ.4)  GO TO 310
        VMIN = ISBND(NB)
        VMAX = ISBND(NE)
        GO TO 320
  310   VMIN = RELIN (ISBND(NB))
        VMAX = RELIN (ISBND(NE))
C
 320    IF (NE.GT.NB)  GO TO 340
C       ONE VALUE.
        IF (JS.EQ.1.AND.ITS.EQ.3)  CALL JSTWD (12, 0, ITYPMK, LIDAT,
     *   LUNTYP)
        CALL JSTR (VMIN, -5, 0, LUNTYP, 1)
        IF (NSTAT(IC).EQ.1)
     *    CALL WSENT (ICSTR(I1), LCSTR, 0, 0, 0, 0, 0, ITYPMK, LIDAT,
     *     LUNTYP)
        IF (JS.EQ.NS.AND.ITS.EQ.3)
     *   CALL JSTWD (13, 0, ITYPMK, LIDAT, LUNTYP)
        GO TO 400
C
C       MORE THAN ONE VALUE.
  340   CALL JSTR (VMIN, -5, 0, LUNTYP, 1)
        CALL JSTWD (2, 0, ITYPMK, LIDAT, LUNTYP)
        CALL JSTR (VMAX, -5, 0, LUNTYP, 1)
        IF (NSTAT(IC).EQ.1)
     *    CALL WSENT (ICSTR(I1), LCSTR, 0, 0, 0, 0, 0, ITYPMK, LIDAT,
     *     LUNTYP)
C--
  400   CALL JSTS (KCOLON, 1, LUNTYP)
        IF (ISBND(IC).GT.0)  JSG = JSG + ISBND(JSG)
  500   CONTINUE
C---
 1000 RETURN
      END
      SUBROUTINE PAYCRD (IMC, KSTAT, WTC, NC, JIM)                          TPAY
 
C* REVISED 6-OCT-92.
C* OUTPUTS CONTROL CARDS FOR PAYNE FORMAT.
C
C  IMC RECEIVES THE CHARACTER MASK. (NOTE THAT CHARACTERS WITH
C    KSTAT(IC).LE.1 HAVE BEEN MASKED OUT BY SUBR. CHKDK.)
C  KSTAT RECEIVES THE NUMBER OF KEY STATES
C  WTC RECEIVES THE CHARACTER WEIGHTS.
C  NC RECEIVES THE NUMBER OF CHARACTERS.
C  JIM RECEIVES THE NUMBER OF MASKED-IN ITEMS
C
C  THE OUTPUT BUFFER IS IOUT(1,4).
 
      LOGICAL*4 O
      DIMENSION IMC(NC),KSTAT(NC),WTC(NC),KUSEWD(5)
      CHARACTER*1 KODPAY(3,9),LUSEWD(5)
C
      COMMON /BLKXXX/ KBLANK
      COMMON /DELXXX/ KDPLUS,KDSTAR,KDNUM,KDSOL,KDLBRA,KDRBRA,
     * KDCOM,KDRANG,KDAMP,KDCOLN,KDSTOP,KDINF,KDLPAR,KDRPAR,KDBSLSH
      COMMON /HEDXXX/ LHEAD,IHEAD(200)
      COMMON /JSTXXX/ IOUT(132,5),LOUT,ICAP,
     * JIOUT(5),IENDWD(5),INDEN(5),LWIDTH(5),PSEQ,SEQINC,NSQDIG
      COMMON /LUNXXX/ LUNE,LUNL,LUNO,LUNP,LUNS1,LUNBO,LUNBI,LUNI,LUNDA,
     * LUNS2,LUNS3,LUNS4,LUNS5,LUNS6,LUNS7
      COMMON /NUMXXX/ KNUM(10),KDEC,KMINUS
      COMMON /SCRNMX/ SCRNAM(7)
        CHARACTER*8 SCRNAM
C
C     KEY WORDS REQUIRED FOR PAYNE SPECIFICATIONS
C     1 - CAPTION. 2 - COSTS. 3 - LEVELS. 4 - NAMES.
C     5 - NUMBERS. 6 - PREFERENCES. 7 - PRIOR.  8 - RESULTS.
C     9 - CHARACTERS.
C
      DATA LUSEWD(1),LUSEWD(2),LUSEWD(3),LUSEWD(4),LUSEWD(5)
     *    /'U','S','E',' ','9'/
C
C     ABBREVIATED KEY WORDS
      DATA KODPAY(1,1),KODPAY(2,1),KODPAY(3,1)/'C','A','P'/
      DATA KODPAY(1,2),KODPAY(2,2),KODPAY(3,2)/'C','O','S'/
      DATA KODPAY(1,3),KODPAY(2,3),KODPAY(3,3)/'L','E','V'/
      DATA KODPAY(1,4),KODPAY(2,4),KODPAY(3,4)/'N','A','M'/
      DATA KODPAY(1,5),KODPAY(2,5),KODPAY(3,5)/'N','U','M'/
      DATA KODPAY(1,6),KODPAY(2,6),KODPAY(3,6)/'P','R','E'/
      DATA KODPAY(1,7),KODPAY(2,7),KODPAY(3,7)/'P','R','I'/
      DATA KODPAY(1,8),KODPAY(2,8),KODPAY(3,8)/'R','E','S'/
      DATA KODPAY(1,9),KODPAY(2,9),KODPAY(3,9)/'C','H','A'/
      DATA NKODES /9/
 
 
      LUNTYP = 4
 
C--   READ SPECIFICATION CARDS
   50 CALL CARDI (IOUT(1,LUNTYP), ICARD)
        IF (ICARD.LT.0)  GO TO 1000
C-
        ICOL = 1
   60   IF (ICOL.GE.79)  GO TO 970
          IF (IOUT(ICOL,LUNTYP).EQ.KDNUM)  GO TO 70
          ICOL = ICOL + 1
          GO TO 60
C
   70   ICOL = ICOL + 1
        IB = ICOL
   75   IF (ICOL.GE.80)  GO TO 80
          IF (IOUT(ICOL,LUNTYP).EQ.KBLANK)  GO TO 80
          ICOL = ICOL + 1
          GO TO 75
   80   IE = ICOL - 1
        CALL CONPHR (KODPAY, 3, NKODES, 3, IOUT(1,LUNTYP),
     *   IB, IE, ICODE, JE)
        IF (ICODE.LE.0)  GO TO 960
C        IF (ICODE.EQ.9)  GOTO 99
C
C-      BEGIN KEY WORD IN COLUMN 1
        NCHAR = ICOL - IB + 1
        DO 90 I = 1, NCHAR
        IOUT(I,LUNTYP) = IOUT(IB+I-1,LUNTYP)
   90   CONTINUE
        JIOUT(LUNTYP) = NCHAR
        IENDWD (LUNTYP) = NCHAR
C
C-      ACT ON KEY WORD.
   99   GO TO (100,200,300,400,500,200,700,800,900), ICODE
C
C-    CAPTION
  100 I = 80 - NCHAR - 1
      CALL SENSIM (IHEAD(2), LHEAD, IOUT(NCHAR+1,LUNTYP),
     * I, 1, JE, 0, 0)
C
C     REMOVE IMBEDDED COLONS IN COMPUTER GENERATED TIME/DATE
      IB = NCHAR + 1
      IE = IB + JE - 1
      DO 110 I = IB, IE
        IF(IOUT(I,LUNTYP).EQ.KDCOLN)  IOUT(I,LUNTYP) = KDSTOP
  110   CONTINUE
      IE = IE + 1
      IOUT(IE,LUNTYP) = KDCOLN
      CALL WRTREC (IOUT(1,LUNTYP), IE, LUNTYP, 4)
      JIOUT(LUNTYP) = -1
      IENDWD(LUNTYP) = -1
      GO TO 50
C
C-    COSTS / PREFERENCES
  200 IC = 0
  220 IF (IC.GE.NC)  GO TO 260
        IC = IC + 1
        IF (IMC(IC).NE.0)  GO TO 230
          I = 10
          GO TO 250
  230   IF (WTC(IC).GT.0)  GO TO 240
          I = 9
          GO TO 250
  240   I = 10 - MAX0(1,5+INT(1.45*ALOG(WTC(IC))))
  250   CALL JSTI (I, 0, LUNTYP)
        GO TO 220
  260 CALL ENDLN (LUNTYP)
C
      IF (ICODE.EQ.2)  GO TO 270                                              =*
C
C     IF USING 'PREFERENCES', APPEND 'USE' TO IMPLEMENT CHARACTER MASKING
      CALL COPCIA (LUSEWD, KUSEWD, 5)
      CALL WRTREC (KUSEWD, 5, LUNTYP, 4)
      JIOUT(LUNTYP) = -1
      IENDWD(LUNTYP) = -1
C
  270 GO TO 50
C
C-      LEVELS
  300   DO 310 I = 1, NC
          NS = KSTAT(I)
          IF (NS.LE.1)  NS = 2
          CALL JSTI (NS, 0, LUNTYP)
  310     CONTINUE
        CALL ENDLN (LUNTYP)
        GO TO 50
 
C-      NAMES.
  400   LUN = LUNS2
        CALL JSTS (KNUM(4), 0, LUNTYP)
        CALL JSTS (KDCOLN, 1, LUNTYP)
        GOTO 910
 
C-      NUMBERS
  500   CALL JSTI (JIM, 0, LUNTYP)
        CALL JSTI (NC, 1, LUNTYP)
        GO TO 50
C
C-      PRIOR
  700   GO TO 50
 
C-      RESULTS.
  800   LUN = LUNS1
        CALL ENDLN (LUNTYP)
        GOTO 910
 
C-    CHARACTERS.
  900   LUN = LUNS1
C       ALSO NAMES (FROM 400) AND RESULTS (FROM 500).
  910   INQUIRE (UNIT=LUN, OPENED=O)
        IF (.NOT.O) GOTO 50
        REWIND LUN
  920   CALL RREC (IOUT(1,LUNTYP), 80, LUN, LREC)
C     * SCRNAM(2), 8, 0)
          IF (LREC.LT.0)  GO TO 950
          IF (LREC.EQ.0)  GO TO 940
          CALL WRTREC(IOUT(1,LUNTYP), LREC, LUNTYP, 4)
  940   GO TO 920
  950   JIOUT(LUNTYP) = -1
        IENDWD(LUNTYP) = -1
        CLOSE (UNIT=LUN, STATUS='DELETE')
        GO TO 50
 
  960   CALL MESSA (12, 3, JE)
C
  970   CALL WRTREC (IOUT(1,LUNTYP), 80, LUNTYP, 4)
      GO TO 50
C
 1000 RETURN
      END
      SUBROUTINE PAYTC (ITYPC, NSTAT, KSTAT, IALTC, ICDES, LCDES, NC,       TPAY
     * IKEYCH, MM1S, MS, ISBND, ITYPMK, LIDAT, ICSTR, LCSTR)
 
C* REVISED 3-AUG-92.
C* OUTPUTS CHARACTER LIST IN PAYNE FORMAT.
 
C  ITYPC RECEIVES THE CHARACTER TYPES.
C  NSTAT RECEIVES THE NUMBERS OF STATES.
C  KSTAT RECEIVES THE NUMBERS OF KEY STATES.
C  IALTC RECEIVES WHETHER TO USE THE ALTERNATE COMMA CHARACTER.
C  ICDES RECEIVES THE STARTING POSITIONS OF THE CHARACTER DESCRIPTIONS.
C  LCDES RECEIVES THE LENGTHS OF THE CHARACTER DESCRIPTIONS.
C  NC RECEIVES THE NUMBER OF CHARACTERS.
C  MM1S RECEIVES WORDING SPACE OF LENGTH MS.
C  MS RECEIVES THE MAXIMUM NUMBER OF STATES.
C  ISBND RECEIVES THE NEW STATE BOUNDARIES.
C  ITYPMK RECEIVES TYPESETTING MARKS.
C  LIDAT RECEIVES THE DATA BUFFER LENGTH.
C  ICSTR. IF ISTYPE.EQ.1, ICSTR RECEIVES THE CHARACTER DESCRIPTIONS.
C    IF ISTYPE.NE.1, ICSTR IS WORKING SPACE. SEE SUBR. FETCHC.
C  LCSTR RECEIVES THE DIMENSION OF ICSTR.
 
      DIMENSION ITYPC(NC),NSTAT(NC),KSTAT(NC),IALTC(NC),
     * ICDES(NC),LCDES(NC),MM1S(MS),ISBND(LIDAT),ITYPMK(LIDAT),
     * ICSTR(LCSTR)
 
      COMMON /LUOXXX/ NUN,LPAGE,LPRINT,LTOP,LPRDEF,LPUDEF,
     * LUNCOM(15),LUNPRE(15),LUNUSE(19),LUNREC(19),LUNPAG(19)
      COMMON /SCRNMX/ SCRNAM(7)
        CHARACTER*8 SCRNAM
      COMMON /SCRXXX/ LUNTS1,LUNTS2,LUNTS3,LUNTS4,LUNTS5,LUNTS6,LUNTS7
      COMMON /VLWXXX/ NVWD,MAXVWD,LVWD(18),IBPUNC,IEPUNC,
     * KVSTOP,KVCOM1,KVCOM2,KVSEMI,KVDEC
 
      CHARACTER*60 FSPEC
 
C-    OPEN SCRATCH  FILE FOR CHARACTER DESCRIPTIONS AND STATES.
      CALL GETAU (L)
      FSPEC = SCRNAM(1)
      CALL SETLUN (FSPEC, L, LUNTS1)
      CALL UOPEN (L, LUNUSE(L), FSPEC, IDUMMY, IERR)
      IF (IERR.NE.0)  CALL MESSB (20, 1, 1, -1, 0)
 
C-
      DO 200 IPASS = 1, 2
C
        DO 100 IC = 1, NC
C         SET COMMA CHARACTER TO BE USED.
          IF (IALTC(IC).EQ.0)  THEN
            KCOM = KVCOM1
          ELSE
            KCOM = KVCOM2
          ENDIF
          CALL PAYCHA (ITYPC, NSTAT, KSTAT, ICDES, LCDES, NC, IKEYCH,
     *      KCOM, MM1S, MS, ISBND, ITYPMK, LIDAT, ICSTR, LCSTR, IC,
     *      IPASS)
  100     CONTINUE
C
  200   CONTINUE
C
      RETURN
      END
      SUBROUTINE PAYTI (IDAT, LIDAT, ITYPC, KSTAT, NORNG,                   TPAY
     * NC, IUNRNG, ISTAT, MS, ISBND, IMI, JI)
 
C* REVISED 26-JUL-89.
C* CONVERTS AN ITEM TO PAYNE FORMAT AND OUTPUTS IT.
 
C  IDAT RECEIVES THE ITEM.
C  LIDAT RECEIVES THE DIMENSION OF IDAT AND ISBND.
C  ITYPC RECEIVES THE CHARACTER TYPES.
C  KSTAT RECEIVES THE NUMBERS OF KEY STATES.
C  NORNG RECEIVES WHERE TO USE NORMAL CHARACTER RANGES.
C  NC RECEIVES THE NUMBER OF CHARACTERS.
C  IUNRNG RECEIVES WHETHER TO USE NORMAL CHARACTER RANGES.
C  ISTAT IS WORKING SPACE OF LENGTH MS.
C  MS RECEIVES THE MAXIMUM NUMBER OF STATES.
C  ISBND RECEIVES THE KEY-STATE BOUNDARIES (SEE SUBR. SBOUND).
C  IMI RECEIVES THE ITEM MASK.
C  JI RECEIVES THE ITEM NUMBER.
C  JIM RECEIVES THE MASKED-IN ITEM NUMBER.
C
      DIMENSION IDAT(LIDAT),ITYPC(NC),KSTAT(NC),NORNG(NC),
     * ISTAT(MS),ISBND(LIDAT),IMI(JI),ITSF(3)
C
C     LOCAL VARIABLES.
      DIMENSION IBF(80)
      CHARACTER*60 FSPEC
C
      COMMON /LUOXXX/ NUN,LPAGE,LPRINT,LTOP,LPRDEF,LPUDEF,
     * LUNCOM(15),LUNPRE(15),LUNUSE(19),LUNREC(19),LUNPAG(19)
      COMMON /SYMXXX/ KPOINT,KDASH,KSTAR,KVERT,KEQUAL,KCOMMA,KSEMIC,
     * KCOLON,KSTOP,KSOL,KLPAR,KRPAR,KDOLLA,KQUEST,KEXCL,KAT,KLBRACE,
     * KRBRACE
      COMMON /SCRNMX/ SCRNAM(7)
        CHARACTER*8 SCRNAM
      COMMON /SCRXXX/ LUNTS1,LUNTS2,LUNTS3,LUNTS4,LUNTS5,LUNTS6,LUNTS7
      COMMON /WRKXXX/ IWRK(132)
 
 
      IF (JI.GT.1)  GO TO 10
C
C-    OPEN SCRATCH FILE FOR ITEMS.
      CALL GETAU (L)
      FSPEC = SCRNAM(1)
      CALL SETLUN (FSPEC, L, LUNTS1)
      CALL UOPEN (L, LUNUSE(L), FSPEC, IDUMMY, IERR)
      IF (IERR.NE.0)  CALL MESSB (20, 1, 1, -1, 0)
C
C-    OPEN SCRATCH FILE FOR ITEM NAMES.
      CALL GETAU (L)
      FSPEC = SCRNAM(2)
      CALL SETLUN (FSPEC, L, LUNTS2)
      CALL UOPEN (L, LUNUSE(L), FSPEC, IDUMMY, IERR)
      IF (IERR.NE.0)  CALL MESSB (20, 2, 1, -1, 0)
C
      LUNTYP = LUNTS1
 
C     SKIP MASKED-OUT ITEM.
10    IF (IMI(JI).EQ.0)  GO TO 2000
C
C     EXTRACT ITEM NAME AND SAVE ON SCRATCH UNIT
      CALL SENSIM (IDAT(NC+2), LIDAT, IBF, 80, 1, LBF, 0, 0)
C
C     REMOVE TYPSETTING MARKS.
      J = 0
      DO 20 I = 1, LBF
        IF (IGNOR(IBF(I)).NE.0)  GO TO 20
        J = J + 1
        IWRK(J) = IBF(I)
   20   CONTINUE
      J = J + 1
      IWRK(J) = KCOLON
      CALL WRTREC (IWRK, J, LUNTS2, 4)
C
C--   OUTPUT ATTRIBUTES.
      DO 1000 IC = 1, NC
        NS = KSTAT(IC)
        IF (NS.LE.1)  GO TO 420
        IF (IDAT(IC).LE.0)  GO TO 420
        JG = IDAT(IC)
        JSG = JG + 1
C
C-      SIMPLE, NON-NUMERIC ATTRIBUTE (CODED SEPARATELY FOR EFFICIENCY).
        IF (ISBND(IC).NE.0 .OR. IDAT(JG).NE.4 .OR.
     *   IDAT(JSG+1).NE.1)  GO TO 100
        IV = IDAT(JSG+2)
        GO TO 450
C
C-      COMPOUND, PSEUDO, OR NUMERIC ATTRIBUTE.
  100   CALL FNDKST (IDAT, ISBND, IC, LIDAT, ITYPC, KSTAT, NORNG, NC,
     *   IUNRNG, ISTAT, MS, ITSF, JI, 0.0, 0.0)
C       ENCODE ATTRIBUTE.
        IF (ITSF(1).NE.0. OR. ITSF(2).NE.0)  GO TO 420
        KS = NONZER (ISTAT, NS)
        IF (KS.EQ.0)  GO TO 130
        IF (KS.GT.1)  CALL JSTS (KSOL, 0, LUNTYP)
        DO 120 I = 1, NS
          IF (ISTAT(I).EQ.0) GO TO 120
          CALL JSTI (I, 0, LUNTYP)
  120   CONTINUE
        IF (KS.GT.1)  CALL JSTS (KCOLON, 0, LUNTYP)
        GO TO 1000
C
  130   IF (ITSF(3).NE.0)  GO TO 430
C
C       VARIABLE OR UNKNOWN.
  420   IV = 0
        GO TO 450
C       NOT APPLICABLE.
  430   IV = -1
C
  450   CALL JSTI (IV, 0, LUNTYP)
C-
 1000 CONTINUE
        CALL ENDLN (LUNTYP)
C--
C
 2000 RETURN
      END
