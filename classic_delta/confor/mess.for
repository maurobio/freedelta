      SUBROUTINE EMESS (SBF, IPOINT)                                        MESS
 
C* REVISED 26-JUL-89.
C* POINTS TO ERROR AND PRINTS MESSAGE.
 
C  SBF RECEIVES THE MESSAGE.
C    FOR A DEFINITION OF THE MESSAGE DELIMITER, SEE FUNCTION LSTR.
C  IPOINT RECEIVES THE POSITION OF THE MESSAGE.
 
C  NCERR IS INCREMENTED. IF NCERR.GE.100, THE PROGRAM IS TERMINATED.
 
      COMMON /LUNXXX/ LUNE,LUNL,LUNO,LUNP,LUNS1,LUNBO,LUNBI,LUNI,LUNDA,
     * LUNS2,LUNS3,LUNS4,LUNS5,LUNS6,LUNS7
 
      PARAMETER (LBF=400)
      CHARACTER SBF*(*),SBR*400
 
      DATA SBR /'****** '/
 
      L = LSTR(SBF) + 1
      IF (L+7.GT.LBF) CALL BUG (26, L)
      SBR(8:L+7) = SBF(1:L)
      CALL MPRT (IPOINT, 1)
      IF (LUNL.NE.LUNE)  CALL MPRT (IPOINT, 2)
      CALL MESS (SBR)
      CALL ECOUNT
 
      RETURN
      END
      SUBROUTINE FETMES (IERRNO, MESS, LMESS, MORE)                         MESS
 
C  REVISED 08-AUG-00.
C  RETRIEVES TEXT OF SPECIFIED ERROR MESSAGE.
 
C  IERRNO RECEIVES THE ERROR NUMBER.
C  MESS RETURNS THE TEXT.
C  LMESS RETURNS THE LENGTH OF THE TEXT.
C  MORE RETURNS WHETHER MS-DOS FILE INFORMATION IS TO BE OUTPUT.
 
      CHARACTER*(*) MESS
      CHARACTER MESTXT*300
 
C     THIS VALUE MUST BE UPDATED WHEN NEW ERROR MESSAGES ARE ADDED.           =/
      PARAMETER (NERR = 166)                                                  =*
 
      IF (IERRNO.GT.NERR)  GOTO 3000
 
      MORE = 0
 
      MESTXT = '.%'
 
      GOTO (10,20,30,40,50,60,70,80,90,100,
     * 110,120,130,140,150,160,170,180,190,200,
     * 210,220,230,240,250,260,270,280,290,300,
     * 310,320,330,340,350,360,370,380,390,400,
     * 410,420,430,440,450,460,470,480,490,500,
     * 510,520,530,540,550,560,570,580,590,600,
     * 610,620,630,640,650,660,670,680,690,700,
     * 710,720,730,740,750,760,770,780,790,800,
     * 810,820,830,840,850,860,870,880,890,900,
     * 910,920,930,940,950,960,970,980,990,1000,
     * 1010,1020,1030,1040,1050,1060,1070,1080,1090,1100,
     * 1110,1120,1130,1140,1150,1160,1170,1180,1190,1200,
     * 1210,1220,1230,1240,1250,1260,1270,1280,1290,1300,
     * 1310,1320,1330,1340,1350,1360,1370,1380,1390,1400,
     * 1410,1420,1430,1440,1450,1460,1470,1480,1490,1500,
     * 1510,1520,1530,1540,1550,1560,1570,1580,1590,1600,
     * 1610,1620,1630,1640,1650,1660), IERRNO
 
   10 MESTXT = 'Value constraints must be specified for all included'//
     * ' RN characters.%'
      GOTO 2000
 
   20 MESTXT = 'Directive out of order.%'
      GOTO 2000
 
   30 MESTXT = 'Equivalent directive already used.%'
      GOTO 2000
 
   40 MESTXT =  'Errors in previous directives.%'
      GOTO 2000
 
   50 MESTXT = 'Character \ has more than 32 states. It has been'//
     * ' excluded.%'
      GOTO 2000
 
   60 MESTXT = 'Sequence number or # expected.%'
      GOTO 2000
 
   70 MESTXT = 'Slash missing after previous character or state'//
     * ' description.%'
      GOTO 2000
 
   80 MESTXT = 'Character number terminated by full stop expected.%'
      GOTO 2000
 
   90 MESTXT = 'State number terminated by period+space expected.%'
      GOTO 2000
 
  100 MESTXT = 'Missing data.%'
      GOTO 2000
 
  110 MESTXT = 'Illegal symbol - integer expected.%'
      GOTO 2000
 
  120 MESTXT = 'Illegal symbol.%'
      GOTO 2000
 
  130 MESTXT = 'Character number greater than specified maximum (\).%'
      GOTO 2000
 
  140 MESTXT = 'Character number out of order.%'
      GOTO 2000
 
  150 MESTXT = 'State number out of order.%'
      GOTO 2000
 
  160 MESTXT = 'Number of states not as specified (\).%'
      GOTO 2000
 
  170 MESTXT = 'Number of states in preceding character not as '//
     * 'specified (\).%'
      GOTO 2000
 
  180 MESTXT = 'Preceding numeric character has too many "units".%'
      GOTO 2000
 
  190 MESTXT = 'Preceding text character should not have "units"'//
     * ' or "states".%'
      GOTO 2000
 
  200 MESTXT = 'Error opening file SCRATCH\.%'
      MORE = 1
      GOTO 2000
 
  210 MESTXT = 'Invalid integer.%'
      GOTO 2000
 
  220 MESTXT = 'Illegal value.%'
      GOTO 2000
 
  230 MESTXT = 'Invalid real number.%'
      GOTO 2000
 
  240 MESTXT = 'Only RN characters can be scaled.%'
      GOTO 2000
 
  250 MESTXT = 'All characters excluded.%'
      GOTO 2000
 
  260 MESTXT = 'All items excluded.%'
      GOTO 2000
 
  270 MESTXT = 'Character \ is not integer.%'
      GOTO 2000
 
  280 MESTXT = 'Word too long - truncated.%'
      GOTO 2000
 
  290 MESTXT = 'Not all vocabulary words specified.%'
      GOTO 2000
 
  300 MESTXT = 'Character \ must be numeric.%'
      GOTO 2000
 
  310 MESTXT = 'Illegal delimiter.%'
      GOTO 2000
 
  320 MESTXT = 'Previous item is empty.%'
      GOTO 2000
 
  330 MESTXT = 'Only multistate characters allowed.%'
      GOTO 2000
 
  340 MESTXT = 'State specified previously.%'
      GOTO 2000
 
  350 MESTXT = 'Not enough space in data buffer. The length is \.%'
      GOTO 2000
 
  360 MESTXT = 'The directives NUMBER OF CHARACTERS, MAXIMUM NUMBER'//
     *' OF STATES and MAXIMUM NUMBER OF ITEMS must precede the'//
     *' CHARACTER LIST and ITEM DESCRIPTIONS directives or any other'//
     *' directive which may require this information.%'
      GOTO 2000
 
  370 MESTXT =  'Invalid taxon number.%'
      GOTO 2000
 
  380 MESTXT =  '# expected.%'
      GOTO 2000
 
  390 MESTXT = 'Value already specified.%'
      GOTO 2000
 
  400 MESTXT = 'Not all states specified.%'
      GOTO 2000
 
  410 MESTXT = 'Invalid specification.%'
      GOTO 2000
 
  420 MESTXT = 'Only RN characters allowed.%'
      GOTO 2000
 
  430 MESTXT = 'Illegal combination of values.%'
      GOTO 2000
 
  440 MESTXT = 'RN characters have been scaled.%'
      GOTO 2000
 
  450 MESTXT = 'Processing of items stopped after item \.%'
      GOTO 2000
 
  460 MESTXT = 'Number of items exceeds specified maximum.%'
      GOTO 2000
 
  470 MESTXT = 'Items excluded.%'
      GOTO 2000
 
  480 MESTXT = 'Characters excluded from items.%'
      GOTO 2000
 
  490 MESTXT = 'Typesetting marks omitted from items.%'
      GOTO 2000
 
  500 MESTXT = 'Character descriptions required.%'
      GOTO 2000
 
  510 MESTXT = 'Characters and states have not been specified.%'
      GOTO 2000
 
  520 MESTXT = 'No previous file.%'
      GOTO 2000
 
C     SPARE
C  530 MESTXT = '%'
  530 CONTINUE
      GOTO 2000
 
  540 MESTXT = 'Invalid file name.%'
      GOTO 2000
 
  550 MESTXT = 'File does not exist.%'
      GOTO 2000
 
  560 MESTXT = 'Incompatible with previous use of this file.%'
      GOTO 2000
 
  570 MESTXT = 'File is inaccessible or is a directory.%'
      MORE = 1
      GOTO 2000
 
  580 MESTXT = 'File cannot be opened.%'
      MORE = 1
      GOTO 2000
 
  590 MESTXT = 'Heading too long.%'
      GOTO 2000
 
  600 MESTXT = 'Excess data, or missing delimiter.%'
      GOTO 2000
 
  610 MESTXT = 'Value less than permitted minimum.%'
      GOTO 2000
 
  620 MESTXT = 'Value greater than permitted maximum.%'
      GOTO 2000
 
  630 MESTXT = 'Character number cannot be determined because of a'//
     * ' previous error.%'
      GOTO 2000
 
  640 MESTXT = 'Character \ has already been specified.%'
      GOTO 2000
 
  650 MESTXT = 'Value out of order.%'
      GOTO 2000
 
  660 MESTXT = 'Integer number required.%'
      GOTO 2000
 
  670 MESTXT = 'Value outside permitted range.%'
      GOTO 2000
 
  680 MESTXT = 'Too many values.%'
      GOTO 2000
 
  690 MESTXT = 'Not all characters specified.%'
      GOTO 2000
 
  700 MESTXT = '       Missing Characters -%'
      GOTO 2000
 
  710 MESTXT = 'Real number required.%'
      GOTO 2000
 
  720 MESTXT = 'Full stop missing.%'
      GOTO 2000
 
  730 MESTXT = 'Missing character number.%'
      GOTO 2000
 
  740 MESTXT = 'Illegal symbol. Character number expected.%'
      GOTO 2000
 
  750 MESTXT = 'Invalid character number.%'
      GOTO 2000
 
  760 MESTXT = 'Insufficient storage for headings.%'
      GOTO 2000
 
  770 MESTXT = 'More than \ words skipped without finding a legal'//
     * ' delimiter.%'
      GOTO 2000
 
  780 MESTXT = '****** More than 100 errors.%'
      GOTO 2000
 
  790 MESTXT = '*** Number of warnings = \ %'
      GOTO 2000
 
  800 MESTXT = 'Normal Termination.%'
      GOTO 2000
 
  810 MESTXT = '****** Number of errors = \ %'
      GOTO 2000
 
  820 MESTXT = '****** Abnormal Termination.%'
      GOTO 2000
 
  830 MESTXT = 'Too many files in use.%'
      GOTO 2000
 
  840 MESTXT = 'Output field too short.%'
      GOTO 2000
 
  850 MESTXT = 'Not enough storage. \ locations required,'//
     * ' \ available.%'
      GOTO 2000
 
  860 MESTXT = 'Record sequence error.%'
      GOTO 2000
 
  870 MESTXT = 'Invalid or missing record sequence number.%'
      GOTO 2000
 
  880 MESTXT = 'Input line too long.%'
      GOTO 2000
 
  890 MESTXT = 'Output files - %'
      GOTO 2000
 
C  900 MESTXT = 'Output files specified but not used -%'
  900 CONTINUE
      GOTO 2000
 
  910 MESTXT = 'Closing bracket is missing.%'
      GOTO 2000
 
  920 MESTXT = 'Dependency error. Item ? - characters \:\%'
      GOTO 2000
 
  930 MESTXT = 'Controlling character not applicable. Item ?'//
     * ' - characters \:\%'
      GOTO 2000
 
  940 MESTXT = 'Controlling character not coded. Item ?'//
     * ' - characters \:\%'
      GOTO 2000
 
  950 MESTXT = 'Mandatory character \ not coded. Item ?.%'
      GOTO 2000
 
  960 MESTXT = 'Missing or invalid delimiter.%'
      GOTO 2000
 
  970 MESTXT = 'Maximum of five values allowed.%'
      GOTO 2000
 
  980 MESTXT = 'Slash missing after previous item name.%'
      GOTO 2000
 
  990 MESTXT = 'Invalid control phrase.%'
      GOTO 2000
 
 1000 MESTXT = 'Unmatched closing bracket.%'
      GOTO 2000
 
 1010 MESTXT = 'Dependent character removed. Item \ character \.%'
      GOTO 2000
 
 1020 MESTXT = 'Insufficient space to invert matrix. Increase the '//
     * 'size of the data buffer.%'
      GOTO 2000
 
 1030 MESTXT = 'Taxon names duplicated or not matched-%'
      GOTO 2000
 
 1040 MESTXT = 'For efficiency reasons, character \'//
     * ' has been treated as a RN.%'
      GOTO 2000
 
 1050 MESTXT = 'It would be more efficient to treat character \'//
     * ' as a RN.%'
      GOTO 2000
 
 1060 MESTXT = 'Character \ has been treated as real. Some'//
     * ' information may have been lost.%'
      GOTO 2000
 
 1070 MESTXT = 'Error reading scratch file 4.%'
      GOTO 2000
 
 1080 MESTXT = 'Error opening output file - ?.%'
      MORE = 1
      GOTO 2000
 
 1090 MESTXT = 'Illegal or missing delimiter.%'
      GOTO 2000
 
C
 1100 MESTXT ='Unmatched { or } in the preceding text.%'
      GOTO 2000
 
 1110 MESTXT = 'Not all values of character \ in item ?'//
     * ' are within the specified key states.%'
      GOTO 2000
 
 1120 MESTXT = 'Characters excluded from character list.%'
      GOTO 2000
 
 1130 MESTXT = 'Typesetting marks omitted from character list.%'
      GOTO 2000
 
 1140 MESTXT = 'Character \ is an ordered multistate.%'
      GOTO 2000
 
 1150 MESTXT = 'Final comment repositioned in item ? character \.%'
      GOTO 2000
 
 1160 MESTXT = 'Character \  has more than 15 states.%'
      GOTO 2000
 
 1170 MESTXT = 'No ? file specified.%'
      GOTO 2000
 
 1180 MESTXT = 'Empty output file ? closed and deleted.%'
      GOTO 2000
 
 1190 MESTXT = 'Output file ? closed.%'
      GOTO 2000
 
 1200 MESTXT = '****** Program bug \ . File ? line \.%'
      GOTO 2000
 
 1210 MESTXT = '****** File ? does not exist.%'
      GOTO 2000
 
 1220 MESTXT = '****** File ? is not accessible.%'
      MORE = 1
      GOTO 2000
 
 1230 MESTXT = '****** Directives file not specified.%'
      GOTO 2000
 
 1240 MESTXT = '****** Invalid Symbol - \ (decimal). File ?'//
     * ' line \ column \.%'
      GOTO 2000

C
 1250 MESTXT = 'Too many taxon names in the previous directive.%'
C 'This function is now performed by the program'//
C     * ' DELFOR.%'
      GOTO 2000

 1260 MESTXT ='Unmatched < or > in the preceding text.%'
      GOTO 2000
 
C     **SPARE**
C 1270 MESTXT = '.%'
C 'The value in the FILES command in the CONFIG.SYS'//
C     *  ' file may need to be increased.%'
 1270 CONTINUE
      GOTO 2000
 
 1280 MESTXT = 'Delimiter must be a single character.%'
      GOTO 2000
 
 1290 MESTXT = 'More than \ words read without finding a closing'//
     * ' bracket for comment.%'
      GOTO 2000

 1300 MESTXT = 'Character \ has more than 10 states. It has been'//
     * ' excluded.%'
      GOTO 2000

 1310 MESTXT = 'Image character must be a text character.%'
      GOTO 2000

 1320 MESTXT = 'Character ranges must not include different types.%'
      GOTO 2000

C     Identify program translators here e.g.
C       'Greek version translated by name.%'
 1330 MESTXT = '%'
      GOTO 2000

 1340 MESTXT = 'Only numeric characters allowed.%'
      GOTO 2000
 
 1350 MESTXT = 'Number of characters not as specified (\).%'
      GOTO 2000

 1360 MESTXT = 'Taxon name can only be used once-%'
      GOTO 2000
 
 1370 MESTXT = 'Maximum number of state codes permitted is 64.%'
      GOTO 2000
 
 1380 MESTXT = 'State number greater than specified maximum (\).%'
      GOTO 2000
 
 1390 MESTXT = 'DEPENDENT CHARACTERS have not been specified. For'//
     *' best results, the development of the character list and the'//
     *' character dependencies should proceed together.%'
      GOTO 2000
 
 1400 MESTXT = 'TAXON IMAGES: %'
      GOTO 2000
 
 1410 MESTXT = 'ADD CHARACTERS: %'
      GOTO 2000

 1420 MESTXT = 'EMPHASIZE CHARACTERS: %'
      GOTO 2000

 1430 MESTXT = 'Taxon name duplicated in items file-%'
      GOTO 2000

 1440 MESTXT = 'TAXON LINKS: %'
      GOTO 2000

 1450 MESTXT = 'ADD CHARACTERS cannot be used with TRANSLATE INTO'//
     *' INTKEY FORMAT or TRANSLATE INTO NEXUS FORMAT%'
      GOTO 2000
 
 1460 MESTXT = 'EMPHASIZE CHARACTERS cannot be used with TRANSLATE'//
     *' INTO INTKEY FORMAT%'
      GOTO 2000

 1470 MESTXT = 'List item \ has already been specified.%'
      GOTO 2000

 1480 MESTXT = 'Nested input files are not supported.%'
      GOTO 2000

 1490 MESTXT = 'Taxon name character must be a text character.%'
      GOTO 2000

 1500 MESTXT = 'The file may already be in use or the directory may'//
     * ' not exist.%'
      GOTO 2000
 
 1510 MESTXT = 'Synonomy character must be a text character.%'
      GOTO 2000

 1520 MESTXT = 'Invalid language. Item ? - ?%'
      GOTO 2000

 1530 MESTXT = 'Invalid language - ?%'
      GOTO 2000

C     *** SPARE ***
C 1540 MESTXT = '%'
 1540 CONTINUE
      GOTO 2000

 1550 MESTXT = 'ITEM HEADINGS: %'
      GOTO 2000

 1560 MESTXT = 'No index file previously specified.%'
      GOTO 2000
 
 1570 MESTXT = 'Data cannot be record against the CHARACTER FOR'//
     * ' TAXON IMAGES. Use the TAXON IMAGES directive.%'
      GOTO 2000
 
 1580 MESTXT = 'The first item cannot be a variant item.%'
      GOTO 2000
 
C     *** SPARE ***
C 1590 MESTXT = '%'
 1590 CONTINUE
      GOTO 2000

 1600 MESTXT = 'ITEM OUTPUT FILES: %'
      GOTO 2000

C     *** SPARE ***
C 1610 MESTXT = '%'
 1610 CONTINUE
      GOTO 2000

 1620 MESTXT = 'INDEX HEADINGS: %'
      GOTO 2000
 
 1630 MESTXT = 'The directory does not exist and cannot be created.%'
      GOTO 2000

 1640 MESTXT = 'The directory "?" does not exist and cannot be' //
     *' created.%'
      GOTO 2000

 1650 MESTXT = 'Output File character must be a text character.%'
      GOTO 2000
 
 1660 MESTXT ='The CHARACTER FOR OUTPUT FILES is not coded in ?.%'
      GOTO 2000
 
 2000 LMESS = INDEX (MESTXT,'%')
      MESS = MESTXT(1:LMESS)
 
 3000 RETURN
      END
      SUBROUTINE MESS (SBF)                                                 MESS
 
C* REVISED 13-APR-94.
C* PRINTS A MESSAGE ON THE ERROR AND LISTING FILES.
 
C  SBF RECEIVES THE MESSAGE.
C    FOR A DEFINITION OF THE DELIMITER, SEE FUNCTION LSTR.
 
      PARAMETER (LBF=80)
      CHARACTER SBF*(*)
      DIMENSION MBUF(80)
 
      COMMON /BLKXXX/ KBLANK
      COMMON /LUNXXX/ LUNE,LUNL,LUNO,LUNP,LUNS1,LUNBO,LUNBI,LUNI,LUNDA,
     * LUNS2,LUNS3,LUNS4,LUNS5,LUNS6,LUNS7
 
      L = LSTR(SBF)
      IB = 1
      DO WHILE (L.GT.0)
        LOUT = MIN(L, LBF)
        IF (L.GT.LOUT)  THEN
C         FIND BREAK IN STRING
          IE = IB + LOUT - 1
          DO WHILE (IE.GT.0)
            IF (SBF(IE:IE).EQ.CHAR(KBLANK))  GOTO 10
            IE = IE - 1
            LOUT = LOUT - 1
          END DO
          IF (IE.EQ.0)  LOUT = LBF
   10     CONTINUE
        ENDIF
        CALL COPSIA (SBF(IB:), MBUF, LOUT)
        CALL WRTREC (MBUF, LOUT, 1, 3)
        IF (LUNL.NE.LUNE)  CALL WRTREC (MBUF, LOUT, 2, 3)
        L = L - LOUT
        IB = IB + LOUT
      END DO
 
      RETURN
      END
      SUBROUTINE MESSA (IERRNO, MTYPE, IPOINT)                              MESS
 
C  REVISED 25-JUL-89.
C  OUTPUTS SPECIFIED MESSAGE.
 
C  IERRNO RECEIVES THE ERROR MESSAGE NUMBER.
C  MTYPE RECEIVES THE TYPE OF MESSAGE OUTPUT REQUIRED.
C  IPOINT RECEIVES THE COLUMN TO BE POINTED TO.

      CALL MESSB (IERRNO, IDUM, 1, MTYPE, IPOINT)
 
      RETURN
      END
      SUBROUTINE MESSA2 (IERRNO1, IERRNO2, MTYPE, IPOINT)                   MESS
 
C  REVISED 07-JAN-99.
C  COMBINES AND OUTPUTS SPECIFIED MESSAGES.
 
C  IERRNO1 RECEIVES THE FIRST ERROR MESSAGE NUMBER.
C  IERRNO2 RECEIVES THE SECOND ERROR MESSAGE NUMBER.
C  MTYPE RECEIVES THE TYPE OF MESSAGE OUTPUT REQUIRED.
C  IPOINT RECEIVES THE COLUMN TO BE POINTED TO.

      CALL MESSB2 (IERRNO1, IERRNO2, IDUM, 1, MTYPE, IPOINT)
 
      RETURN
      END
      SUBROUTINE MESSB (IERRNO, IVAL, N, MTYPE, IPOINT)                     MESS
 
C  REVISED 07-JAN-99.
C  OUTPUTS MESSAGE, OPTIONALLY ENCODING VALUES WITHIN THE
C   MESSAGE.
 
C  IERRNO RECEIVES THE ERROR MESSAGE NUMBER.
C  IVAL RECEIVES VALUES TO BE ENCODED.
C  N RECEIVES THE NUMBER OF VALUES.
C  MTYPE RECEIVES THE TYPE OF MESSAGE OUTPUT REQUIRED. IF MTYPE < 0,
C   THE ERROR IS FATAL
C  IPOINT RECEIVES THE COLUMN TO BE POINTED TO.
 
      CALL MESSB2 (IERRNO, 0, IVAL, N, MTYPE, IPOINT)
 
C      COMMON /INPXXX/ IBUF(121),JBUF,JBDAT,JEDAT,IDERR,NCERR,NSERR,NWERR
C 
C      DIMENSION IVAL(N)
C      CHARACTER MESTXT*300,OUTMES*400,SYS*5
C 
C      CALL FETMES (IERRNO, MESTXT, LENMES, MORE)
C      IF (LENMES.EQ.0)  GOTO 100
C 
C      CALL INSINT (MESTXT(1:LENMES), IVAL, N, OUTMES, LOUT)
C 
C      ITYPE = IABS (MTYPE)
C      IF (ITYPE.EQ.0)  THEN
C        CALL MESS (OUTMES(1:LOUT))
C      ELSEIF (ITYPE.EQ.1)  THEN
C        CALL EMESS (OUTMES(1:LOUT), JBUF)
C      ELSEIF (ITYPE.EQ.2)  THEN
C        CALL WMESS (OUTMES(1:LOUT), JBUF)
C      ELSEIF (ITYPE.EQ.3)  THEN
C        CALL EMESS (OUTMES(1:LOUT), IPOINT)
C      ELSEIF (ITYPE.EQ.4)  THEN
C        CALL WMESS (OUTMES(1:LOUT), IPOINT)
C      ENDIF
C 
C      IF (MORE.NE.0)  THEN
CC        CALL SYSID (SYS)
CC        IF (SYS.EQ.'MSDOS')
C        CALL MSMESS
C      ENDIF
C 
CC     TERMINATE IF FATAL ERROR.
C      IF (MTYPE.LT.0)  CALL EXTERM
 
  100 RETURN
      END
      SUBROUTINE MESSB2 (IERRNO1, IERRNO2, IVAL, N, MTYPE, IPOINT)          MESS
 
C  REVISED 07-JAN-99.
C  COMBINES AND OUTPUTS MESSAGES, OPTIONALLY ENCODING VALUES WITHIN THE
C   MESSAGE.
 
C  IERRNO1 RECEIVES THE FIRST ERROR MESSAGE NUMBER.
C  IERRNO2 RECEIVES THE SECOND ERROR MESSAGE NUMBER.
C  IVAL RECEIVES VALUES TO BE ENCODED.
C  N RECEIVES THE NUMBER OF VALUES.
C  MTYPE RECEIVES THE TYPE OF MESSAGE OUTPUT REQUIRED. IF MTYPE < 0,
C   THE ERROR IS FATAL
C  IPOINT RECEIVES THE COLUMN TO BE POINTED TO.
 
      COMMON /INPXXX/ IBUF(121),JBUF,JBDAT,JEDAT,IDERR,NCERR,NSERR,NWERR
 
      DIMENSION IVAL(N)
      CHARACTER MESTXT*300,OUTMES*400,SYS*5
 
      CALL FETMES (IERRNO1, MESTXT, LENMES1, MORE1)
      IF (IERRNO2.NE.0)
     * CALL FETMES (IERRNO2, MESTXT(LENMES1:), LENMES2, MORE2)
      LENMES = LENMES1 + LENMES2
      IF (LENMES.EQ.0)  GOTO 100
      MORE = MORE1 + MORE2
 
      CALL INSINT (MESTXT(1:LENMES), IVAL, N, OUTMES, LOUT)
 
      ITYPE = IABS (MTYPE)
      IF (ITYPE.EQ.0)  THEN
        CALL MESS (OUTMES(1:LOUT))
      ELSEIF (ITYPE.EQ.1)  THEN
        CALL EMESS (OUTMES(1:LOUT), JBUF)
      ELSEIF (ITYPE.EQ.2)  THEN
        CALL WMESS (OUTMES(1:LOUT), JBUF)
      ELSEIF (ITYPE.EQ.3)  THEN
        CALL EMESS (OUTMES(1:LOUT), IPOINT)
      ELSEIF (ITYPE.EQ.4)  THEN
        CALL WMESS (OUTMES(1:LOUT), IPOINT)
      ENDIF
 
      IF (MORE.NE.0)  THEN
C        CALL SYSID (SYS)
C        IF (SYS.EQ.'MSDOS')
        CALL MSMESS
      ENDIF
 
C     TERMINATE IF FATAL ERROR.
      IF (MTYPE.LT.0)  CALL EXTERM
 
  100 RETURN
      END
      SUBROUTINE MESSC (IERRNO, IVAL, N, MTYPE, IPOINT, STR, LSTR, NSTR)    MESS
 
C  REVISED 23-APR-90.
C  OUTPUTS MESSAGE, OPTIONALLY ENCODING INTEGER VALUES AND STRINGS
C   WITHIN THE MESSAGE.
 
C  IERRNO RECEIVES THE ERROR MESSAGE NUMBER.
C  IVAL RECEIVES VALUES TO BE ENCODED.
C  N RECEIVES THE NUMBER OF VALUES.
C  MTYPE RECEIVES THE TYPE OF MESSAGE OUTPUT REQUIRED. IF MTYPE < 0,
C   THE ERROR IS FATAL.
C  IPOINT RECEIVES THE COLUMN TO BE POINTED TO.
C  STR RECEIVES STRINGS TO BE ENCODED IN THE MESSAGE.
C  LSTR RECEIVES THE LENGTHS OF STRINGS IN STR.
C  NSTR RECEIVES THE NUMBER OF STRINGS IN STR.
 
      COMMON /INPXXX/ IBUF(121),JBUF,JBDAT,JEDAT,IDERR,NCERR,NSERR,NWERR
      COMMON /MESXXX/ OUTMES
        CHARACTER*200 OUTMES
 
      DIMENSION IVAL(N),LSTR(NSTR)
      CHARACTER*(*) STR
      CHARACTER*1 MESTXT*150,OUTST1*200,OUTST2*200,SYS*5
 
      CALL FETMES (IERRNO, MESTXT, LENMES, MORE)
      IF (LENMES.EQ.0)  GOTO 100
 
      CALL INSINT (MESTXT(1:LENMES), IVAL, N, OUTST1, L1)
      CALL INSSTR (OUTST1(1:L1), STR, LSTR, NSTR, OUTST2, L2)
 
      ITYPE = IABS (MTYPE)
      IF (ITYPE.EQ.0)  THEN
        CALL MESS (OUTST2(1:L2))
      ELSEIF (ITYPE.EQ.1)  THEN
        CALL EMESS (OUTST2(1:L2), JBUF)
      ELSEIF (ITYPE.EQ.2)  THEN
        CALL WMESS (OUTST2(1:L2), JBUF)
      ELSEIF (ITYPE.EQ.3)  THEN
        CALL EMESS (OUTST2(1:L2), IPOINT)
      ELSEIF (ITYPE.EQ.4)  THEN
        CALL WMESS (OUTST2(1:L2), IPOINT)
      ELSE
        OUTMES = OUTST2(1:L2)
      ENDIF

      IF (ITYPE.LE.4 .AND. MORE.NE.0)  THEN
C        CALL SYSID (SYS)
C        IF (SYS.EQ.'MSDOS')
        CALL MSMESS
      ENDIF

C     TERMINATE IF FATAL ERROR.
      IF (MTYPE.LT.0)  CALL EXTERM
 
  100 RETURN
      END
      SUBROUTINE MESSF (IERRNO, IVAL, N)                                    MESS
 
C  REVISED 23-APR-90.
C  EXTRA MESSAGE ROUTINE TO PREVENT RECURSIVE CALLS.
 
      CHARACTER MESTXT*150,OUTMES*200,SYS*5
 
      CALL FETMES (IERRNO, MESTXT, L, MORE)
      CALL INSINT (MESTXT(1:L), IVAL, N, OUTMES, LOUT)
      CALL MESS (OUTMES(1:LOUT))
 
      IF (MORE.NE.0)  THEN
C        CALL SYSID (SYS)
C        IF (SYS.EQ.'MSDOS')
        CALL MSMESS
      ENDIF

      RETURN
      END
      SUBROUTINE MSMESS                                                     MESS
 
C  OUTPUTS MESSAGE FOR MS-DOS SYSTEMS.
C  REVISED 24-SEP-96.
 
      CHARACTER MESTXT*150
 
      CALL FETMES (150, MESTXT, L, MORE)
      CALL MESS (MESTXT(1:L))
 
      END
      SUBROUTINE PMESSC (IERRNO, IVAL, N, STR, LSTR, NSTR, MESS, LMESS)     MESS
 
C  REVISED 31-JUL-89.
C  PREPARES A MESSAGE, OPTIONALLY ENCODING INTEGER VALUES AND STRINGS
C   WITHIN THE MESSAGE.
 
C  IERRNO RECEIVES THE ERROR MESSAGE NUMBER.
C  IVAL RECEIVES VALUES TO BE ENCODED.
C  N RECEIVES THE NUMBER OF VALUES.
C  STR RECEIVES STRINGS TO BE ENCODED IN THE MESSAGE.
C  LSTR RECEIVES THE LENGTHS OF STRINGS IN STR.
C  NSTR RECEIVES THE NUMBER OF STRINGS IN STR.
C  MESS RETURNS THE PREPARED MESSAGE.
C  LMESS RETURNS THE LENGTH OF THE PREPARED MESSAGE.

      COMMON /MESXXX/ OUTMES
        CHARACTER*200 OUTMES
 
      DIMENSION IVAL(N),LSTR(NSTR)
      CHARACTER*(*) STR,MESS
  
C     (NOTE KLUGE: USE MESSAGE-TYPE = 100 TO PREVENT OUTPUT BY MESSC)
      CALL MESSC (IERRNO, IVAL, N, 100, 0, STR, LSTR, NSTR)
      LMESS = INDEX (OUTMES, '%')
      MESS = OUTMES(1:LMESS)
 
      RETURN
      END
      SUBROUTINE INSINT (STR, IVAL, N, OUTSTR, LOUT)                        MESS
 
C  REVISED 26-JUL-89.
C  INSERTS INTEGER VALUES AT MARKED PLACES IN A STRING.
 
      CHARACTER*(*) STR,OUTSTR
      DIMENSION IVAL(N)
 
      CHARACTER*1 MARKER
      PARAMETER (MARKER = '\')
 
      LSTRI = LEN(STR)
      LSTRO = LEN(OUTSTR)
      LOUT = 0
      IB = 1
      JB = 1
 
      DO 100 I = 1, N
        LM = INDEX (STR(IB:LSTRI),MARKER)
        IF (LM.GT.0)  THEN
          IE = IB + LM - 2
          OUTSTR(JB:) = STR(IB:IE)
          JB = JB + LM - 1
          CALL INKODS (IVAL(I), OUTSTR(JB:), LOUT)
          JB = JB + LOUT
          IB = IE + 2
        ENDIF
  100 CONTINUE
      IF (IB.LE.LSTRI)  THEN
        OUTSTR(JB:) = STR(IB:LSTRI)
        JB = JB + LSTRI - IB + 1
        LOUT = JB - 1
      ENDIF

      RETURN
      END
      SUBROUTINE INSSTR (STR, TXT, LTXT, NTXT, OUTSTR, LOUT)                MESS
 
C  REVISED 26-JUL-89.
C  INSERTS TEXT AT MARKED PLACES IN A STRING.
 
      CHARACTER*(*) STR,OUTSTR,TXT
      DIMENSION LTXT(NTXT)
 
      CHARACTER*1 MARKER
      PARAMETER (MARKER = '?')
 
      LSTRI = LEN(STR)
      LSTRO = LEN(OUTSTR)
      LOUT = 0
      IB = 1
      JB = 1
      KB = 1
 
      DO 100 I = 1, NTXT
        LM = INDEX (STR(IB:LSTRI),MARKER)
        IF (LM.GT.0)  THEN
          IE = IB + LM - 2
          OUTSTR(JB:) = STR(IB:IE)
          JB = JB + LM - 1
          OUTSTR(JB:) = TXT(KB:KB+LTXT(I)-1)
          JB = JB + LTXT(I)
          KB = KB + LTXT(I)
          IB = IE + 2
        ENDIF
  100 CONTINUE
      IF (IB.LE.LSTRI)  THEN
        OUTSTR(JB:) = STR(IB:LSTRI)
        JB = JB + LSTRI - IB + 1
        LOUT = JB - 1
      ENDIF

      RETURN
      END
      SUBROUTINE INKODS (INT, STR, LOUT)                                    MESS
 
C  REVISED 20-MAY-88.
C  ENCODES AN INTEGER, LEFT-JUSTIFIED, IN A CHARACTER STRING.
 
C  INT RECEIVES THE INTEGER.
C  STR RECEIVES THE CHARACTER STRING.
C  LOUT RETURNS THE ACTUAL LENGTH OF THE ENCODED INTEGER.
 
      COMMON /BLKXXX/ KBLANK
 
      CHARACTER*(*) STR
 
      CHARACTER*15 TMP                                                        =*
      PARAMETER (MAXDIG=15)                                                   =*
 
      LSTR = LEN (STR)
 
      WRITE(TMP,10)INT
   10 FORMAT(I15)
 
      DO 20 I = MAXDIG, 1, -1
        IF (TMP(I:I).EQ.CHAR(KBLANK))  GOTO 30
   20 CONTINUE
      I = 0
 
   30 LOUT = MAXDIG - I
      IF (LOUT.GT.LSTR)  THEN
        CALL MESS ('Integer too large for output field.%')
        call mess (TMP(I+1:MAXDIG))
        CALL EXTERM
      ENDIF
      STR(1:LOUT) = TMP(I+1:MAXDIG)
 
      RETURN
      END
      SUBROUTINE WMESS (SBF, IPOINT)                                        MESS
 
C* REVISED 26-JUL-89.
C* POINTS TO ERROR AND PRINTS WARNING MESSAGE.
 
C  SBF RECEIVES THE MESSAGE.
C    FOR A DEFINITION OF THE MESSAGE DELIMITER, SEE FUNCTION LSTR.
C  IPOINT RECEIVES THE POSITION OF THE MESSAGE.
 
C  NWERR IS INCREMENTED.
 
      PARAMETER (LBF=400)
      CHARACTER SBF*(*),SBR*400
 
      COMMON /INPXXX/ IBUF(121),JBUF,JBDAT,JEDAT,IDERR,NCERR,NSERR,NWERR
      COMMON /LUNXXX/ LUNE,LUNL,LUNO,LUNP,LUNS1,LUNBO,LUNBI,LUNI,LUNDA,
     * LUNS2,LUNS3,LUNS4,LUNS5,LUNS6,LUNS7
 
      DATA SBR /'*** WARNING - '/
 
      L = LSTR(SBF) + 1
      IF (L+14.GT.LBF) CALL BUG (28, L)
      SBR(15:L+14) = SBF(1:L)
      CALL MPRT (IPOINT, 1)
      IF (LUNL.NE.LUNE)  CALL MPRT (IPOINT, 2)
      CALL MESS (SBR)
      NWERR = NWERR + 1
 
      RETURN
      END
