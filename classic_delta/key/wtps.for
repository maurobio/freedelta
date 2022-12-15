      SUBROUTINE JSTTPS (STR, JBUF)
 
C  REVISED 31-MAR-99.
C  OUTPUTS A TYPESETTING MARK.
 
C  STR RECEIVES THE STRING TO BE OUTPUT.
C  JBUF RETURNS THE POSITION OF THE LAST CHARACTER IN THE STRING.
 
      COMMON /FMTXXX/ ITAB,LFOUT,LTXOUT,KCOLS,MAXWID
      COMMON /LUNXXX/ LUNI,LUNC,LUNT,LUNO,LUNP,LUNS,LUNS1,LUNE,LUNL,LUNB
      COMMON /LUUXXX/ LUNOUT
      COMMON /SYMXXX/ BLANK,STOP,SEMIC,LBRAC,RBRAC,RANGE,STAR,UPAROW,
     *            COMMA,COLON,NUMERO,LABRAC,RABRAC,LBRACE,RBRACE,BSLSH
      CHARACTER*1 BLANK,STOP,SEMIC,LBRAC,RBRAC,RANGE,STAR,UPAROW,
     *            COMMA,COLON,NUMERO,LABRAC,RABRAC,LBRACE,RBRACE,BSLSH
 
      CHARACTER*(*) STR
 
      LSTR = LEN(STR)
 
      JBUF = 0
 
C     Binary output?
      IF (LUNOUT.EQ.LUNB)  THEN
        CALL WRTREC (STR(1:LSTR), LUNOUT)
        JBUF = 0
      ELSE
C       Find word break.
        DO I = LSTR, 1, -1
          K = I
          IF (STR(K:K).EQ.BLANK)  THEN
            IE = 0
            GOTO 20
          ENDIF
        ENDDO
C       No break found, so output full string.
        IE = -1
        I = LSTR + 1
   20   CALL JSTSTR (STR(1:I-1), IE, LFOUT)
        IF (IE.EQ.0) THEN
C         Move rest of string to start of buffer.
          DO J = I+1, LSTR
            IF (STR(J:J).NE.BLANK)  GOTO 30
          ENDDO
          GOTO 100
   30     STR = STR(J:LSTR)
          JBUF = LSTR - J + 1
        ENDIF
      ENDIF

  100 RETURN
      END
      SUBROUTINE OUTTPS (NW, ITYPMK,
     * FMSK, TMSK, RINDX, AINDX, JBSET, KOSET, NLSET,
     * AVGL, CSTAVG, LMAX, CSTMAX,
     * TAXON, LTAXON, ITXNAM, FBUF, LFBUF,
     * FREC, FMEM, FLADDR, NSTAT, FN, FO, IFL,
     * LIST, MSTR, IDIGS, INODE,
     * KNODE, IFROM, NB, NE, NROW, ITOUT)
 
C  REVISED 29-MAR-99.
C  OUTPUTS TYPESETTING INSTRUCTIONS.
 
C  NW RECEIVES THE NUMBER OF TYPESETTING MARK TO BE OUTPUT.
C  ITYPMK RECEIVES THE TYPESETTING MARKS.
C  LTYPMK RECEIVES THE LENGTH OF ITYPMK.
C  NTYPMK RECEIVES THE NUMBER OF TYPESETTING MARKS DEFINED.
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

      COMMON /DIMXXX/ LDM,NFR,NF,NTM,NTM1,NTU,NTH,NWORD,NDESC,LCDEP
      COMMON /LUUXXX/ LUNOUT
      COMMON /PARXXX/ NFB,NFE,JFB,NVAR,NEWLN,NT,NTD,NTA,NO,KN,NUSED,
     *                INCOMP,VARW,NTR,RBASE,ABASE,REUSE,VARYWT,NCONF,
     *                NSET,RES,ITUNKV,IADCNO,ITCHV,IRTF,IHTML
      COMMON /TPSXXX/ ITPSET,MAXTYPMK,NTYPMK,LTYPMK,INTYPMKS
 
      DIMENSION ITYPMK(LTYPMK)
      REAL RINDX(NFR),AINDX(NTR)
      CHARACTER*1 TAXON(LTAXON),FBUF(LFBUF)
      INTEGER ITXNAM(NTM1),FREC(NF),FMEM(NF),FLADDR(NF),NSTAT(NF),
     * FN(NFR),FO(NFR),IFL(NDESC),LIST(MSTR)
      INTEGER FMSK(NFR),TMSK(NTR),JBSET(NSET),KOSET(NSET),NLSET(NSET)
 
      CHARACTER*5000 REPLSTR
C     Note: allow one extra character in buffer so final call to JSTTPS
C     can have a blank added if necessary.
      CHARACTER*1001 BUF
      PARAMETER (LBUF=1000)
 
      IFIRST = 1
      JBUF = 0
 
      CALL GETTPS (NW, ITYPMK, IB, LEN)
      IF (LEN.GT.0)  THEN
        KAT = ICHAR('@')
        J = IB + 3
        JB = J
        IEND = J + LEN
        DO WHILE (J.LT.IEND)
C          IF (JOUT.GE.MAXWID)  THEN
C            CALL WRTREC (IOUT(1:MAXWID), LUNOUT)
C            JOUT = 0
C          ENDIF
          IF (JBUF.GE.LBUF)  THEN
            CALL JSTTPS (BUF(1:JBUF), JBUF)
C            CALL JSTSTR (BUF(1:JBUF), -1, LFOUT)
C            JBUF = 0
          ENDIF
          LREPL = 0
          IF (ITYPMK(J).EQ.KAT)  THEN
            CALL SUBSTIT (ITYPMK, ITYPMK(J+1), LEN-(J-JB),
     *        FMSK, TMSK, RINDX, AINDX, JBSET, KOSET, NLSET,
     *        AVGL, CSTAVG, LMAX, CSTMAX,
     *        TAXON, LTAXON, ITXNAM, FBUF, LFBUF,
     *        FREC, FMEM, FLADDR, NSTAT, FN, FO, IFL,
     *        LIST, MSTR, IDIGS, INODE,
     *        KNODE, IFROM, NB, NE, NROW, ITOUT,
     *        LKEYWD, REPLSTR, LREPL, IFIRST)
            IFIRST = 0
            IF (LREPL.GT.0)  THEN
              J = J + 1 + LKEYWD
              DO I = 1, LREPL
                IF (JBUF.GE.LBUF)  THEN
                  CALL JSTTPS (BUF(1:JBUF), JBUF)
C                  CALL JSTSTR (BUF(1:JBUF), -1, LFOUT)
C                  JBUF = 0
                ENDIF
                JBUF = JBUF + 1
                BUF(JBUF:JBUF) = REPLSTR(I:I)
              ENDDO
            ENDIF
          ENDIF
          IF (LREPL.EQ.0)  THEN
            JBUF = JBUF + 1
            BUF(JBUF:JBUF) = CHAR(ITYPMK(J))
            J = J + 1
          ENDIF
        ENDDO
 
      ENDIF
 
  100 DO WHILE (JBUF.GT.0)
        CALL JSTTPS (BUF(1:JBUF), JBUF)
      ENDDO
C     And again, in case anything remains in buffer.
      IF (JBUF.GT.0)  CALL JSTTPS (BUF(1:JBUF), JBUF)
C      CALL JSTSTR (BUF(1:JBUF), -1, LFOUT)
 
      RETURN
      END
      SUBROUTINE SUBSTIT (ITYPMK, IBF, N,
     * FMSK, TMSK, RINDX, AINDX, JBSET, KOSET, NLSET,
     * AVGL, CSTAVG, LMAX, CSTMAX,
     * TAXON, LTAXON, ITXNAM, FBUF, LFBUF,
     * FREC, FMEM, FLADDR, NSTAT, FN, FO, IFL,
     * LIST, MSTR, IDIGS, INODE,
     * KNODE, IFROM, NB, NE, NROW, ITOUT,
     * LKEYWD, REPLSTR, LREPSTR, IFIRST)
 
C  REVISED 31-MAR-99.
C  REPLACES KEYWORDS WITH REQUIRED TEXT.
 
C  ITYPMK RECEIVES THE DEFINED TYPESETTING MARKS.
C  IBF RECEIVES THE KEYWORD.
C  N RECEIVES THE LENGTH OF IBF.
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
C  LKEYWD RETURNS THE LENGTH OF THE KEYWORD BEING REPLACED.
C  REPLSTR RETURNS THE REPLACEMENT STRING.
C  LREPSTR RETURNS THE LENGTH OF THE REPLACEMENT STRING.

      COMMON /DIMXXX/ LDM,NFR,NF,NTM,NTM1,NTU,NTH,NWORD,NDESC,LCDEP
      COMMON /PARXXX/ NFB,NFE,JFB,NVAR,NEWLN,NT,NTD,NTA,NO,KN,NUSED,
     *                INCOMP,VARW,NTR,RBASE,ABASE,REUSE,VARYWT,NCONF,
     *                NSET,RES,ITUNKV,IADCNO,ITCHV,IRTF,IHTML
      COMMON /SYMXXX/ BLANK,STOP,SEMIC,LBRAC,RBRAC,RANGE,STAR,UPAROW,
     *            COMMA,COLON,NUMERO,LABRAC,RABRAC,LBRACE,RBRACE,BSLSH
      CHARACTER*1 BLANK,STOP,SEMIC,LBRAC,RBRAC,RANGE,STAR,UPAROW,
     *            COMMA,COLON,NUMERO,LABRAC,RABRAC,LBRACE,RBRACE,BSLSH
 
      DIMENSION IBF(N)
      REAL RINDX(NFR),AINDX(NTR)
      INTEGER FMSK(NFR),TMSK(NTR),JBSET(NSET),KOSET(NSET),NLSET(NSET)
      CHARACTER*1 TAXON(LTAXON),FBUF(LFBUF)
      INTEGER ITXNAM(NTM1),FREC(NF),FMEM(NF),FLADDR(NF),NSTAT(NF),
     * FN(NFR),FO(NFR),IFL(NDESC),LIST(MSTR)
 
      DIMENSION IUSED(25)
      CHARACTER*7 KEYWD(25)
      CHARACTER*1 K,LWRCASE
      CHARACTER*10 TEMP
      CHARACTER*(*) REPLSTR
 
      SAVE IUSED
 
C     MAXKEY is maximum number of characters in a keyword.
      PARAMETER (MAXKEY=7, NKEY=25)
 
      DATA (KEYWD(I),I=1,NKEY)
     */'nchar  ','ntaxa  ','ncincl ','ncinkey','ntincl ','ntinkey',
     * 'rbase  ','abase  ','reuse  ','varywt ','nconf  ','avglen ',
     * 'avgcost','maxlen ','maxcost','cmask  ','rel    ','tmask  ',
     * 'tabund ','preset ','node   ','from   ','to     ','state  ',
     * 'nrow   '/
 
      LREP = LEN(REPLSTR)
 
C     First call from within the current typesetting mark.
      IF (IFIRST.NE.0)  THEN
        DO I = 1, NKEY
          IUSED(I) = 0
        ENDDO
      ENDIF
 
      LSTR = 0
      NTEMP = 0
      DO II = 1, MAXKEY
        IF (II.GT.N) GOTO 20
        NTEMP = NTEMP + 1
        K = CHAR(IBF(II))
        TEMP(NTEMP:NTEMP) = LWRCASE(K)
   20   MATCH = 0
C       Is it in the table of keywords?
        DO KK = 1, NKEY
          DO JJ = 1, NTEMP
            IF (TEMP(JJ:JJ).NE.KEYWD(KK)(JJ:JJ))  GOTO 30
          ENDDO
          MATCH = KK
          IF (NTEMP.LT.MAXKEY.AND.
     *      KEYWD(KK)(NTEMP+1:NTEMP+1).NE.' ')  MATCH = 0
          IF (MATCH.NE.0)  GOTO 40
   30     CONTINUE
        ENDDO
      ENDDO

   40 IF (MATCH.NE.0)  THEN
        LKEYWD = NTEMP
        IERR = 0
 
        GOTO (100,200,300,400,500,600,700,800,900,1000,1100,1200,
     *   1300,1400,1500,1600,1700,1800,1900,2000,2100,2200,
     *   2300,2400,2500), MATCH
 
C       nchar - Number of characters.
  100   CALL INKOD (NFR, REPLSTR, LREPSTR)
        GOTO 5000
 
C       ntaxa - Number of taxa.
  200   CALL INKOD (NTR, REPLSTR, LREPSTR)
        GOTO 5000

C       nincl - Number of characters included.
  300   CALL INKOD (NF, REPLSTR, LREPSTR)
        GOTO 5000

C       ncinkey - Number of characters in key.
  400   CALL INKOD (NUSED, REPLSTR, LREPSTR)
        GOTO 5000

C       ntincl - Number of taxa included.
  500   CALL INKOD (NTM, REPLSTR, LREPSTR)
        GOTO 5000

C       ntinkey - Number of taxa in key.
  600   CALL INKOD (NTA, REPLSTR, LREPSTR)
        GOTO 5000

C       rbase - RBASE
  700   CALL RNKOD (RBASE, 2, REPLSTR(1:10), LREPSTR)
        GOTO 5000

C       abase - ABASE.
  800   CALL RNKOD (ABASE, 2, REPLSTR(1:10), LREPSTR)
        GOTO 5000

C       reuse - REUSE.
  900   CALL RNKOD (REUSE, 2, REPLSTR(1:10), LREPSTR)
        GOTO 5000

C       varywt - VARYWT.
 1000   CALL RNKOD (VARYWT, 2, REPLSTR(1:10), LREPSTR)
        GOTO 5000

C       nconf - Number of confirmatory characters.
 1100   CALL INKOD (NCONF, REPLSTR, LREPSTR)
        GOTO 5000

C       avglen = Average length of key.
 1200   CALL RNKOD (AVGL, 2, REPLSTR(1:10), LREPSTR)
        GOTO 5000

C       avgcost - Average cost of key.
 1300   CALL RNKOD (CSTAVG, 2, REPLSTR(1:10), LREPSTR)
        GOTO 5000

C       maxlen - Maximum length of key.
 1400   CALL INKOD (LMAX, REPLSTR, LREPSTR)
        GOTO 5000

C       maxcost - Maximum cost of key.
 1500   CALL RNKOD (CSTMAX, 2, REPLSTR(1:10), LREPSTR)
        GOTO 5000

C       cmask - Character mask.
 1600   CALL STRMSK (FMSK, NFR, ITYPMK, REPLSTR, LREPSTR, IERR)
        GOTO 5000

C       rel - Character reliabilities.
 1700   CALL STRWT (RINDX, NFR, ITYPMK,  REPLSTR, LREPSTR, IERR)
        GOTO 5000

C       tmask - Taxon mask.
 1800   CALL STRMSK (TMSK, NTR, ITYPMK, REPLSTR, LREPSTR, IERR)
        GOTO 5000

C       tabund - Item abundances.
 1900   CALL STRWT (AINDX, NTR, ITYPMK, REPLSTR, LREPSTR, IERR)
        GOTO 5000

C       preset - Preset characters.
 2000   L = 1
        DO I = 1, NSET
          IF (I.GT.1)  THEN
            REPLSTR(L:L) = BLANK
            L = L + 1
          ENDIF
          CALL INKOD (JBSET(I), TEMP, LOUT)
          IF (L+LOUT.GT.LREP)  GOTO 2010
          REPLSTR(L:) = TEMP(1:LOUT)
          L = L + LOUT
          REPLSTR(L:L) = COMMA
          L = L + 1
          CALL INKOD (NLSET(I), TEMP, LOUT)
          IF (L+LOUT.GT.LREP)  GOTO 2010
          REPLSTR(L:) = TEMP(1:LOUT)
          L = L + LOUT
          REPLSTR(L:L) = COLON
          L = L + 1
          CALL INKOD (KOSET(I), TEMP, LOUT)
          IF (L+LOUT-1.GT.LREP)  GOTO 2010
          REPLSTR(L:) = TEMP(1:LOUT)
          L = L + LOUT
        ENDDO
        GOTO 2020
 2010   IERR = 1
 2020   LREPSTR = L - 1
        GOTO 5000

c     node - Node number.
 2100 CALL INKOD (KNODE, REPLSTR, LREPSTR)
      GOTO 5000
 
c     from - Previous node.
 2200 CALL INKOD (IFROM, REPLSTR, LREPSTR)
      GOTO 5000
 
c     to - Next node.
C     END OF BRANCH.
 2300 IF (IUSED(MATCH).EQ.0)  LIST(NB) = LIST(NB) - INODE
      NODEND = 0
      ITOUT = 0
      IF (LIST(NB).GT.INODE)  THEN
C       OUTPUT TAXON NAME(S).
        IT = LIST(NB) - INODE
 2310   IF (NB+1.GT.NE)  NODEND = 1
        ISTART = ITXNAM(IT)
        LT = ITXNAM(IT+1) - ITXNAM(IT)
        IF (LT.LE.LREP) THEN
          DO I = 1, LT
            REPLSTR(I:I) = TAXON(ISTART+I-1)
          ENDDO
          LREPSTR = LT
          ITOUT = 1
        ENDIF
 
      ELSE
 
C       DESTINATION NODE NUMBER.
        ND = LIST(NB)
        IF (NB+1.GT.NE)  NODEND = 1
        CALL INKOD (ND, REPLSTR, LREPSTR)
      ENDIF
 2350 GOTO 5000
 
c     state - feature/state text.
 2400 L = 1
      IFIRST = 1
      IOUT = 0
 2410 IF (IUSED(MATCH).EQ.0)  NB = NB + 1
      IF (NB.GT.NE)  GOTO 2450
      IF (LIST(NB).GT.INODE)  GOTO 2450
 
      IF (IOUT.GT.0.AND.IFIRST.NE.1)  THEN
        IF (L+1.GT.LREP)  GOTO 2430
        REPLSTR(L:L) = SEMIC
        REPLSTR(L+1:L+1) = BLANK
        L = L + 2
      ENDIF
      JF = LIST(NB)/IDIGS
      JS = LIST(NB) - JF*IDIGS
      JFN = FN(JF)
      IOUT = 0
      CALL GETFS (JFN, FBUF, LFBUF, FREC, FMEM, FLADDR, NSTAT, NF,
     * IFL, NDESC)
 
C     OUTPUT FEATURE DESCRIPTION.
      I = FLADDR(JFN)
      LF = IFL(I)
      ISTART = FMEM(JFN)
      ICAP = IFIRST
      IF (LF.GT.0)  THEN
C       INSERT CHARACTER NUMBER IF REQUIRED.
        IF (IADCNO.NE.0)  THEN
          CALL INKOD (FO(JFN), TEMP, LOUT)
          IF (L+LOUT+1.GT.LREP)  GOTO 2430
          REPLSTR(L:L) = LBRAC
          L = L + 1
          REPLSTR(L:) = TEMP(1:LOUT)
          L = L + LOUT
          REPLSTR(L:L) = RBRAC
          L = L + 1
        ENDIF
        IF (L+LF-1.GT.LREP) GOTO 2430
        DO I = 1, LF
          REPLSTR(L:L) = FBUF(ISTART+I-1)
          IF (ICAP.NE.0) CALL CAP(REPLSTR(L:L), ICAP)
          L = L + 1
        ENDDO
      ENDIF

C     OUTPUT STATE DESCRIPTION.
      I = FLADDR(JFN)
      LS = IFL(I+JS)
      ISTART = FMEM(JFN)
      DO 10 IS = 1, JS
        ISTART = ISTART + IFL(I)
        I = I + 1
   10   CONTINUE
 
      IF (L+LS.GT.LREP) GOTO 2430
      IF (REPLSTR(L-1:L-1).NE.BLANK) THEN
        REPLSTR(L:L) = BLANK
        L = L + 1
      ENDIF
      DO I = 1, LS
        REPLSTR(L:L) = FBUF(ISTART+I-1)
        L = L + 1
      ENDDO
      IOUT = IOUT + 1
      IFIRST = 0
      LREPSTR = L - 1
      GOTO 2410

 2430 IERR = 1
 
 2450 GOTO 5000
 
C     nrow - number of "destinations" for the current node.
 2500 CALL INKOD (NROW, REPLSTR, LREPSTR)
      GOTO 5000
 
      ENDIF
 
 5000 IF (IERR.NE.0) CALL ERROR(0,
     * 'Value of keyword is too long. Value has been truncated.')
 
      IF (MATCH.NE.0)  IUSED(MATCH) = 1
 
      RETURN
      END
      SUBROUTINE RTF2HTML (IBF, N, JIN, HTMLSTR, LSTR)                      INOU
 
C  REVISED 14-DEC-98.
C  REPLACES RTF STRINGS WITH HTML.
 
      CHARACTER*1 IBF(N),K,TERM
      CHARACTER*(*) HTMLSTR
 
      COMMON /SYMXXX/ BLANK,STOP,SEMIC,LBRAC,RBRAC,RANGE,STAR,UPAROW,
     *            COMMA,COLON,NUMERO,LABRAC,RABRAC,LBRACE,RBRACE,BSLSH
      CHARACTER*1 BLANK,STOP,SEMIC,LBRAC,RBRAC,RANGE,STAR,UPAROW,
     *            COMMA,COLON,NUMERO,LABRAC,RABRAC,LBRACE,RBRACE,BSLSH
 
      CHARACTER*10 RTFWD(20),TEMP
      CHARACTER*8 RTF2HTM(21)
 
C     MAXHTML is maximum number of characters in an HTML control word.
C     MAXRTF is maximum number of characters in an RTF control word.
C     MSUBSUP is the position if the RTFWD array of the control word 'sub'.
      PARAMETER (MAXHTML=8, MAXRTF=10, MSUBSUP=18, NRTFWD=20)
 
      SAVE INSUBSUP

C     The control words \sub, \super and \nosupersub should always
C     be the last three words in the array.
      DATA (RTFWD(I),I=1,NRTFWD)
     */'b         ','b0        ','i         ','i0        ',
     * '~         ','{         ','}         ','\         ',
     * '_         ',
     * 'ldblquote ','rdblquote ','lquote    ','rquote    ',
     * 'par       ','endash  '  ,'emdash    ','line      ',
     * 'sub       ','super     ','nosupersub'/
 
      DATA (RTF2HTM(I),I=1,NRTFWD+1)
     */'<B>     ','</B>    ','<I>     ','</I>    ',
     * '&nbsp;  ','{       ','}       ','\       ',
     * '-       ',
     * '&#145;  ','&#146;  ','&#145;  ','&#146;  ',
     * '<P>     ','&#150;  ','&#151;  ','<BR>    ',
     * '<SUB>   ','</SUB>  ','<SUPER> ','</SUPER>'/

      LHTML = 0
      NTEMP = 0
      DO II = 1, MAXRTF
        IF (JIN+II.GT.N) GOTO 141
        K = IBF(JIN+II)
C       Special case: Have we got "\\" i.e a simple backslash?
        IF (K.EQ.BSLSH.AND.II.EQ.1)  THEN
          NTEMP = NTEMP + 1
          TEMP(NTEMP:NTEMP) = K
          TERM = CHAR(0)
          MATCH = 0
          GOTO 143
        ENDIF
C       Control word is terminated by '\' or other non-alpha character?
        IF (K.EQ.BLANK.OR.K.EQ.BSLSH.OR.
     *      (K.NE.RANGE.AND.ISNUM(K).EQ.0.AND.ISALPHA(K).EQ.0)) THEN
          TERM = K
C         Check for {} as command terminator.
          IF (TERM.EQ.LBRACE.AND.IBF(JIN+II+1).EQ.RBRACE)  THEN
            TERM = RBRACE
          ELSE
C             Case of \x, where x is some non-alphanumeric character
C             This is an RTF special symbol.
            IF (NTEMP.EQ.0)  THEN
              NTEMP = NTEMP + 1
              TEMP(NTEMP:NTEMP) = K
            ENDIF
          ENDIF
          GOTO 141
        ENDIF
        NTEMP = NTEMP + 1
        TEMP(NTEMP:NTEMP) = K
      ENDDO
  141 MATCH = 0
C     Is it in the table of conversions?
      DO II = 1, NRTFWD
        DO JJ = 1, NTEMP
          IF (TEMP(JJ:JJ).NE.RTFWD(II)(JJ:JJ))  GOTO 142
        ENDDO
        MATCH = II
        IF (NTEMP.LT.MAXRTF.AND.
     *    RTFWD(II)(NTEMP+1:NTEMP+1).NE.' ')  MATCH = 0
        IF (MATCH.NE.0)  GOTO 143
  142   CONTINUE
      ENDDO
  143 IF (MATCH.NE.0)  THEN
C       Handle subscripts and superscripts. (Note these match values
C       depend on the positions of the relevant control words in the
C       RTFWD array.)
C       \sub or \super?
        IF (MATCH.EQ.MSUBSUP.OR.MATCH.EQ.MSUBSUP+1)
     *    INSUBSUP = MATCH
C       \nosupersub? The line below assumes there was a previous \sub or \super.
        IF (MATCH.EQ.MSUBSUP+2)  MATCH = INSUBSUP + 1
        DO KK = 1, MAXHTML
          IF (RTF2HTM(MATCH)(KK:KK).EQ.' ') GOTO 144
          LHTML = LHTML + 1
        ENDDO
  144   CONTINUE
      ENDIF
C     Skip over RTF control word in input buffer.
      JIN = JIN + NTEMP
      IF (TERM.EQ.BLANK) THEN
        JIN = JIN + 1
      ELSEIF (TERM.EQ.RBRACE) THEN
C       Command is terminated by {}.
        JIN = JIN + 2
      ENDIF
      IF (MATCH.NE.0)  THEN
        LSTR = LHTML
        DO KK = 1, LHTML
          HTMLSTR(KK:KK) = RTF2HTM(MATCH)(KK:KK)
        ENDDO
      ELSE
C       Signal caller to ignore this RTF control word.
        LSTR = -1
      ENDIF
 
      RETURN
      END
