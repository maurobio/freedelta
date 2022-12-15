      SUBROUTINE CLRNA (D, LD, IF)                                          UTIL
 
C  REVISED 15/7/88.
C  CLEARS THE NOT APPLICABLE BIT OF A GIVEN FEATURE IN THE CURRENT ROW.
 
C  IF RECEIVES THE FEATURE NUMBER.
 
      INTEGER D(LD)
      INTEGER FEAT
 
      COMMON /MATXXX/ JU,JF,JS,I,J,NL,JB,NFP,NB,NE
      COMMON /MNSXXX/ MNS,MNS1,MNS2,MNS3
 
      II = 2**MNS
      JJ = 2*II
 
      K1 = (I-1)*NFP + 1
      K2 = I*NFP
      ICOL = 0
      DO 20 IELT = K1, K2
        ICOL = ICOL + 1
        IF (FEAT(D,LD,I,ICOL).EQ.IF)  THEN
          IST = MOD (D(IELT),II)
          D(IELT) = (D(IELT)/JJ)*JJ + IST
          GOTO 30
        ENDIF
   20   CONTINUE
 
   30 RETURN
      END
      SUBROUTINE CLRST (D, LD)                                              UTIL
 
C  REVISED 11/12/86.
C  CLEARS ALL STATE BITS OF ELEMENT D(I,J).
 
      INTEGER D(LD)
 
      COMMON /MATXXX/ JU,JF,JS,I,J,NL,JB,NFP,NB,NE
      COMMON /MNSXXX/ MNS,MNS1,MNS2,MNS3
 
      K = (I-1)*NFP + J
      II = 2**MNS1
      D(K) = (D(K)/II)*II
      RETURN
      END
      SUBROUTINE CLRSTF (D, LD, IF)                                         UTIL
 
C  REVISED 11/12/86.
C  CLEARS ALL STATE BITS OF A GIVEN FEATURE IN THE CURRENT ROW.
 
      INTEGER D(LD)
      INTEGER FEAT
 
      COMMON /MATXXX/ JU,JF,JS,I,J,NL,JB,NFP,NB,NE
      COMMON /MNSXXX/ MNS,MNS1,MNS2,MNS3
 
      K1 = (I-1)*NFP + 1
      K2 = I*NFP
      ICOL = 0
      DO 20 IELT = K1, K2
        ICOL = ICOL + 1
        IF (FEAT(D,LD,I,ICOL).EQ.IF)  THEN
          II = 2**MNS1
          D(IELT) = (D(IELT)/II)*II
          GOTO 30
        ENDIF
   20   CONTINUE
 
   30 RETURN
      END
      INTEGER    FUNCTION FEAT (D, LD, IROW, ICOL)                          UTIL
 
C  REVISED 11/12/86.
C  GETS FLAG BIT AND FEATURE FROM ELEMENT (IROW,ICOL).
C  FLAG BIT IS RETURNED IN JU, AND FEATURE AS FUNCTION VALUE.
 
      INTEGER D(LD)
      COMMON /MATXXX/ JU,JF,JS,I,J,NL,JB,NFP,NB,NE
      COMMON /MNSXXX/ MNS,MNS1,MNS2,MNS3
 
      JU = 0
      K = (IROW-1)*NFP + ICOL
      FEAT = D(K)/(2**MNS1)
      IF (FEAT.LT.512)  GOTO 20
      JU = 1
      FEAT = FEAT - 512                                                       =*
   20 RETURN
      END
      SUBROUTINE FEATST (D, LD)                                             UTIL
 
C  REVISED 11/12/86.
C  RETURNS FLAG BIT, FEATURE, AND STATE FROM ELEMENT (I,J)
C  IN JU, JF, AND JS.
 
      INTEGER D(LD)
      COMMON /MATXXX/ JU,JF,JS,I,J,NL,JB,NFP,NB,NE
      COMMON /MNSXXX/ MNS,MNS1,MNS2,MNS3
 
      INTEGER FEAT,STATE
 
      JF = FEAT(D,LD,I,J)
      JS = STATE(D,LD,I)
      RETURN
      END

      INTEGER FUNCTION FINDCOL (D, LD, IF)                                  UTIL
 
C  REVISED 15-OCT-98.
C  FINDS THE COLUMN LOCATION OF A GIVEN FEATURE IN THE CURRENT ROW.
 
C  IF RECEIVES THE FEATURE NUMBER.
 
      INTEGER D(LD)
      INTEGER FEAT
 
      COMMON /MATXXX/ JU,JF,JS,I,J,NL,JB,NFP,NB,NE
      COMMON /MNSXXX/ MNS,MNS1,MNS2,MNS3
 
      II = 2**MNS
      JJ = 2*II
 
      FINDCOL = 0
      K1 = (I-1)*NFP + 1
      K2 = I*NFP
      ICOL = 0
      DO 20 IELT = K1, K2
        ICOL = ICOL + 1
        IF (FEAT(D,LD,I,ICOL).EQ.IF)  THEN
          FINDCOL = ICOL
          GOTO 30
        ENDIF
   20   CONTINUE
 
   30 RETURN
      END
      SUBROUTINE FINDST (D, LD, IROW, ICOL, ISTAT, NS, NSP)                 UTIL
 
C  REVISED 11/12/86.
C  DETERMINES THE STATE VALUES OF A SPECIFIED ITEM-CHARACTER PAIR.
 
C  IROW RECEIVES THE ITEM ROW NUMBER.
C  ICOL RECEIVES THE CHARACTER COLUMN NUMBER.
C  ISTAT RETURNS THE STATE SETTINGS.
C  NS RECEIVES THE NUMBER OF STATES OF THE CHARACTER.
C  NSP RETURNS THE NUMBER OF STATES PRESENT.
 
      INTEGER D(LD)
 
      COMMON /MATXXX/ JU,JF,JS,I,J,NL,JB,NFP,NB,NE
      COMMON /MNSXXX/ MNS,MNS1,MNS2,MNS3
 
      DIMENSION ISTAT(23)                                                     =*
 
 
      K = (IROW-1)*NFP + ICOL
      IVAL = D(K)
      KNT = 0
      DO 10 IS = MNS1, MNS3
        ISTAT(IS) = 0
   10   CONTINUE
 
      DO 20 IS = 1, NS
        ISTAT(IS) = MOD(IVAL,2)
        KNT = KNT + ISTAT(IS)
        IVAL = IVAL/2
   20   CONTINUE
 
      NSP = KNT
 
C     NOT APPLICABLE.
      II = 2**MNS
      IVAL = D(K)/II
      ISTAT(MNS2) = MOD(IVAL,2)
      KNT = KNT + ISTAT(MNS2)
 
C     VARIABLE.
      IF (KNT.GT.1)  ISTAT(MNS1) = 1
 
C     UNKNOWN.
      IF (KNT.LE.0)  ISTAT(MNS3) = 1
 
 
      RETURN
      END
      SUBROUTINE GETNOD (D, LD)                                             UTIL
 
C  REVISED 11/12/86.
C  RETURNS NODE NUMBER FROM ELEMENT (I,J-1) IN JB.
 
      INTEGER D(LD)
      COMMON /MATXXX/ JU,JF,JS,I,J,NL,JB,NFP,NB,NE
 
      K = (I-1)*NFP + J - 1
      JB = D(K)
      RETURN
      END
      SUBROUTINE REMTYP (STR, LSTR)                                         UTIL
 
C  REVISED 08-MAR-99.
C  REMOVES TYPE SETTING MARKS FROM A CHARACTER STRING.
 
C  STR RECEIVES AND RETURNS THE STRING.
C  LSTR RECEIVES AND RETURNS THE LENGTH OF THE STRING.
 
      COMMON /SYMXXX/ BLANK,STOP,SEMIC,LBRAC,RBRAC,RANGE,STAR,UPAROW,
     *            COMMA,COLON,NUMERO,LABRAC,RABRAC,LBRACE,RBRACE,BSLSH
      CHARACTER*1 BLANK,STOP,SEMIC,LBRAC,RBRAC,RANGE,STAR,UPAROW,
     *            COMMA,COLON,NUMERO,LABRAC,RABRAC,LBRACE,RBRACE,BSLSH
 
      CHARACTER*1 STR(LSTR)
      CHARACTER*9 RTF(7)
      CHARACTER*1 CHAR,REPL(7)
      PARAMETER (LRTF=9, NRTF=7)

      DATA RTF /
     * 'lquote   ', 'rquote   ', 'ldblquote', 'rdblquote',
     * 'bullet   ', 'endash   ', 'emdash   '/
      DATA REPL /
     * '''','''','"','"','.','-','-'/

      J = 0
      I = 0
C     INC is position of last character matched
      INC = 0
      DO WHILE (I.LT.LSTR)
        I = I + 1
        IF (I.LT.LSTR.AND.STR(I).EQ.BSLSH)  THEN
          IF (STR(I+1).EQ.BSLSH.OR.STR(I+1).EQ.LBRACE.OR.
     *        STR(I+1).EQ.RBRACE)  GOTO 10
          DO 5 K = 1, NRTF
            DO IR = 1, LRTF
              IF (RTF(K)(IR:IR).EQ.BLANK) THEN
                INC = IR - 1
                GOTO 6
              ENDIF
              IF (STR(I+IR).NE.RTF(K)(IR:IR)) GOTO  5
            ENDDO
            INC = 9
            GOTO 6
    5     CONTINUE
C         No match - ignore
          GOTO 7
C         Match.
    6     I = I + INC
          CHAR = STR(I+1)
C         Check that next character terminates the RTF command
          IF (CHAR.EQ.BLANK.OR.
     *        (ISNUM(CHAR).EQ.0.AND.ISALPHA(CHAR).EQ.0)) THEN
            J = J + 1  
            STR(J) = REPL(K)
          ENDIF
C         Skip to end of RTF command.
    7     I = I + 1
          IF (I.GT.LSTR)  GOTO 20
            CHAR = STR(I)
            IF (CHAR.EQ.BLANK.OR.
     *          (ISNUM(CHAR).EQ.0.AND.ISALPHA(CHAR).EQ.0)) THEN
C             Special case: RTF command is terminated by {}.
              IF (CHAR.EQ.LBRACE) I = I + 1
              GOTO 20
            ENDIF
            GOTO 7
        ENDIF
   10   J = J + 1
        STR(J) = STR(I)
   20   CONTINUE
      ENDDO
 
      LSTR = J
      RETURN
      END
C      SUBROUTINE REMTYP (STR, LSTR)                                         UTIL
C 
CC  REVISED 4/3/86.
CC  REMOVES TYPE SETTING MARKS FROM A CHARACTER STRING.
C 
C      CHARACTER*1 STR(LSTR)
C 
C      COMMON /IGNXXX/ ICMD
C 
C      J = 0
C      DO 10 I = 1, LSTR
C        IF (IGNOR(STR(I)).NE.0)  GOTO 10
C        J = J + 1
C        STR(J) = STR(I)
C   10 CONTINUE
C 
C      LSTR = J
C      RETURN
C      END
      SUBROUTINE SETF (D, LD, IROW, ICOL)                                   UTIL
 
C  REVISED 11/12/86.
C  ENCODE THE FEATURE NUMBER (=ICOL) AT D(IROW,ICOL) AND CLEAR FLAG BIT.
 
      INTEGER D(LD)
      COMMON /MATXXX/ JU,JF,JS,I,J,NL,JB,NFP,NB,NE
      COMMON /MNSXXX/ MNS,MNS1,MNS2,MNS3
 
      II = 2**MNS1
      K = (IROW-1)*NFP + ICOL
      IS = MOD (D(K),II)
      D(K) = ICOL*II + IS
      RETURN
      END
      SUBROUTINE SETNA (D, LD, IROW, ICOL)                                  UTIL
 
C  REVISED 11/12/86.
C  SETS THE NOT APPLICABLE BIT IN THE ELEMENT D(IROW,ICOL)
 
      INTEGER D(LD)
 
      COMMON /MATXXX/ JU,JF,JS,I,J,NL,JB,NFP,NB,NE
      COMMON /MNSXXX/ MNS,MNS1,MNS2,MNS3
 
      K = (IROW-1)*NFP + ICOL
      II = D(K)/(2**MNS)
      IF (MOD(II,2).EQ.0)  D(K) = D(K) + 2**MNS
 
      RETURN
      END
      SUBROUTINE SETNOD (D, LD)                                             UTIL
 
C  REVISED 11/12/86.
C  SETS NODE NUMBER NL OF ELEMENT (I,J).
 
      INTEGER D(LD)
      COMMON /MATXXX/ JU,JF,JS,I,J,NL,JB,NFP,NB,NE
 
      K = (I-1)*NFP + J
      D(K) = NL
      RETURN
      END
      SUBROUTINE SETS (D, LD)                                               UTIL
 
C  REVISED 11/12/86.
C  SET STATE JS AT ROW I, COLUMN J.
 
      INTEGER D(LD)
      COMMON /MATXXX/ JU,JF,JS,I,J,NL,JB,NFP,NB,NE
      COMMON /MNSXXX/ MNS,MNS1,MNS2,MNS3
 
      K = (I-1)*NFP + J
      II = 2**MNS1
      D(K) = (D(K)/II)*II + 2**(JS-1)
      RETURN
      END
      SUBROUTINE SETU (D, LD)                                               UTIL
 
C  REVISED 11/12/86.
C  SETS UNSUITABILITY FLAG BITS IN COLUMN J BETWEEN ROWS NB AND NE.
 
      INTEGER D(LD)
      COMMON /MATXXX/ JU,JF,JS,I,J,NL,JB,NFP,NB,NE
 
      IBIT = 2**30                                                            =*
      DO 30 II = NB, NE
      K = (II-1)*NFP + J
   30 D(K) = D(K) + IBIT
      RETURN
      END
      SUBROUTINE SETV (D, LD, IROW, ICOL, NS)                               UTIL
 
C  REVISED 11/12/86.
C  SETS THE ELEMENT D(IROW,ICOL) TO VARIABLE.
 
 
C  IROW RECEIVES THE ITEM NUMBER.
C  ICOL RECEIVES THE CHARACTER NUMBER.
C  NS RECEIVES THE NUMBER OF CHARACTER STATES.
 
      INTEGER D(LD)
      COMMON /MATXXX/ JU,JF,JS,I,J,NL,JB,NFP,NB,NE
      COMMON /MNSXXX/ MNS,MNS1,MNS2,MNS3
 
 
      K = (IROW-1)*NFP + ICOL
      IVAL = D(K)
      II = 2**MNS1
      IVAL = (IVAL/II)*II
      DO 10 IS = 1, NS
        IVAL = IVAL + 2**(IS-1)
   10   CONTINUE
 
      D(K) = IVAL
      RETURN
      END
      INTEGER    FUNCTION STATE (D, LD, IROW)                               UTIL
 
C  REVISED 11/12/86.
C  GETS STATE FROM ELEMENT (IROW,J).
 
      INTEGER D(LD)
      COMMON /MATXXX/ JU,JF,JS,I,J,NL,JB,NFP,NB,NE
      COMMON /MNSXXX/ MNS,MNS1,MNS2,MNS3
 
      DIMENSION ISTAT(23)                                                     =*
 
      STATE = 0
      CALL FINDST (D, LD, IROW, J, ISTAT, MNS, NSP)
      IF (ISTAT(MNS1).NE.0)  THEN
        STATE = MNS1
        GOTO 20
      ENDIF
 
        IS = 0
   10   IS = IS + 1
        IF (IS.GT.MNS)  GOTO 20
          IF (ISTAT(IS).EQ.0)  GOTO 10
          STATE = IS
 
   20 RETURN
      END
      SUBROUTINE SWAP (D, LD)                                               UTIL
 
C  REVISED 11/12/86.
C  EXCHANGE THE PARTS OF COLUMNS NL AND JB BETWEEN ROWS NB AND NE.
 
      INTEGER D(LD)
      COMMON /MATXXX/ JU,JF,JS,I,J,NL,JB,NFP,NB,NE
 
      DO 20 II = NB, NE
      INL = (II-1)*NFP + NL
      IJB = INL - NL + JB
      M = D(INL)
      D(INL) = D(IJB)
   20 D(IJB) = M
      RETURN
      END
