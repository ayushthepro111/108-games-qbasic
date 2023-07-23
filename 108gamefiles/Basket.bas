DECLARE SUB PRINTSTATS (AT, MK, PLYR, HPS, P) 'WRITES STATISTICS
DECLARE SUB ACCBOARD ()                       'DRAWS ACCURACY BOARDS
DECLARE SUB DRAWHOOP ()                       'DRAWS HOOP
DECLARE SUB INTRO ()                          'FIRST SCREEN
PLYRS = 1                                     '-DO NOT CHANGE THESE
HPS = 20                                      '/
INTR:
INTRO
INTROS:
 P = 0
 COLOR 2: LOCATE 10, 11: PRINT "1) START"
 COLOR 4: LOCATE 11, 11: PRINT "2) PRACTICE"
 COLOR 14: LOCATE 12, 11: PRINT "3) PLAYERS"; PLYRS
 COLOR 5: LOCATE 13, 11: PRINT "4) SHOTS/PLAYER"; HPS
 COLOR 1: LOCATE 14, 11: PRINT "5) EXIT"
 CH$ = ""
 DO UNTIL CH$ = "1" OR CH$ = "2" OR CH$ = "3" OR CH$ = "4" OR CH$ = "5"
 CH$ = INPUT$(1)
 LOOP
 IF CH$ = "1" THEN GOTO START
 IF CH$ = "2" THEN PLYRS = 1: P = 1: HPS = 0: GOTO START
 IF CH$ = "3" THEN
  PLYRS = PLYRS + 1
  IF PLYRS > 8 THEN PLYRS = 1
  GOTO INTROS
 END IF
 IF CH$ = "4" THEN
  HPS = HPS + 5
  IF HPS > 40 THEN HPS = 5
  GOTO INTROS
 END IF
 COLOR 7: SCREEN 12
 SYSTEM
START:
DIM SHARED BALL(1 TO 190)
SND = 1                                 'SOUND(0=OFF 1=ON)
DELAY = 40                              'COMPUTER SPEED
FR = 2                                  'SKILL LEVEL
AT = 0                                  'STARTING # OF ATTEMPTS
MK = 0                                  'STARTING # OF SHOTS MADE
KEY(9) ON
ON KEY(9) GOSUB EXT
KEY(1) ON
ON KEY(1) GOSUB SNDS
SCREEN 12: CLS
CIRCLE (16, 16), 15, 15: DRAW "P15,15 C9 TA2 D15 U30 TA0 BR10 BD3 TA3 D22 U22 TA0 BL20 BD2 TA3 D22 TA0"
GET (1, 1)-(31, 31), BALL
CLS
PLYR = 1
DRAWHOOP
ACCBOARD
STARTOVER:
X = 135: Y = 400
PRINTSTATS AT, MK, PLYR, HPS, P
AX = 400: AY = 58
AAX = 558: AAY = 151
PUT (AAX, AAY), BALL
DO
 FOR AX = 301 TO 519 STEP 8
 PUT (AX, AY), BALL
 FOR I = 1 TO 8000
 NEXT
 FOR I = 1 TO DELAY / FR: D$ = INKEY$: IF D$ = CHR$(32) THEN EXIT DO: EXIT FOR: GOTO DONE
 NEXT I
 PUT (AX, AY), BALL, XOR
 NEXT AX
 FOR AX = 519 TO 301 STEP -8
 PUT (AX, AY), BALL
 FOR I = 1 TO 8000
 NEXT
 FOR I = 1 TO DELAY / FR: D$ = INKEY$: IF D$ = CHR$(32) THEN EXIT DO: EXIT FOR: GOTO DONE
 NEXT I
 PUT (AX, AY), BALL, XOR
 NEXT AX
LOOP
DONE:
PUT (AAX, AAY), BALL, XOR
D$ = ""
DO
 FOR AAY = 151 TO 269 STEP 8
 PUT (AAX, AAY), BALL
 FOR I = 1 TO 8000
 NEXT
 FOR I = 1 TO DELAY / FR: D$ = INKEY$: IF D$ = CHR$(32) THEN EXIT DO: EXIT FOR: GOTO DONE2
 NEXT I
 PUT (AAX, AAY), BALL
 NEXT AAY
 FOR AAY = 269 TO 151 STEP -8
 PUT (AAX, AAY), BALL
 FOR I = 1 TO 8000
 NEXT
 FOR I = 1 TO DELAY / FR: D$ = INKEY$: IF D$ = CHR$(32) THEN EXIT DO: EXIT FOR: GOTO DONE2
 NEXT I
 PUT (AAX, AAY), BALL
 NEXT AAY
LOOP
DONE2:
D$ = ""
GOSUB ANIM
PUT (AX, AY), BALL, XOR
PUT (AAX, AAY), BALL, XOR
GOTO STARTOVER

SYSTEM
ANIM:
 IF AX < 400 THEN X = 105
 IF AX > 420 THEN X = 165
 IF AX > 400 AND AX < 420 THEN X = 135
 FOR Y = 300 TO 70 STEP -4
 PUT (X, Y), BALL
 FOR I = 1 TO DELAY: NEXT I
 PUT (X, Y), BALL, XOR
 NEXT Y
 PUT (X, Y), BALL
 IF SND = 1 THEN SOUND 60, 1
 FOR I = 1 TO DELAY * 1.5: NEXT I
 PUT (X, Y), BALL, XOR
 FOR Y = 70 TO 85 STEP 4
 PUT (X, Y), BALL
 FOR I = 1 TO DELAY: NEXT I
 PUT (X, Y), BALL, XOR
 NEXT Y
 IF X = 135 AND AAY > 248 THEN GOSUB SWOOSH: GOTO DONE3
 IF X = 105 THEN GOSUB LEFT: GOTO DONE3
 IF X = 165 THEN GOSUB RIGHT: GOTO DONE3
 IF AAY < 249 THEN GOSUB HARD: GOTO DONE3
DONE3:
 IF AT = HPS THEN
  PL(PLYR) = MK
  IF PLYR = PLYRS THEN GOTO ENDOFGAME
  IF PLYR <> PLYRS THEN
   IF SND = 1 THEN SOUND 500, 6
   PLYR = PLYR + 1
  END IF
  AT = 0
  MK = 0
 END IF
 RETURN

RIGHT:
 IF SND = 1 THEN SOUND 200, 1
 FOR Y = 85 TO 1 STEP -4
 X = X + 2
 PUT (X, Y), BALL
 FOR I = 1 TO DELAY: NEXT I
 PUT (X, Y), BALL, XOR
 NEXT Y
 AT = AT + 1
 RETURN

LEFT:
 IF SND = 1 THEN SOUND 200, 1
 FOR Y = 85 TO 1 STEP -4
 X = X - 2
 PUT (X, Y), BALL
 FOR I = 1 TO DELAY: NEXT I
 PUT (X, Y), BALL, XOR
 NEXT Y
 AT = AT + 1
 RETURN

HARD:
 IF SND = 1 THEN SOUND 200, 1
 FOR Y = 85 TO 1 STEP -4
 PUT (X, Y), BALL
 FOR I = 1 TO DELAY: NEXT I
 PUT (X, Y), BALL, XOR
 NEXT Y
 AT = AT + 1
 RETURN

SWOOSH:
 FOR Y = 85 TO 130 STEP 4
 PUT (X, Y), BALL
 FOR I = 1 TO DELAY: NEXT I
 PUT (X, Y), BALL, XOR
 NEXT Y
 MK = MK + 1: AT = AT + 1
 RETURN

EXT:
 GOTO INTR

SNDS:
 IF SND = 1 THEN SND = 0: GOTO HAHA
 IF SND = 0 THEN SND = 1
HAHA:
 RETURN

ENDOFGAME:
 SCREEN 12: CLS
 IF SND = 1 THEN SOUND 300, 2
 IF PLYRS = 1 THEN PRINT "YOU MADE"; PL(1); "SHOTS"
 IF PLYRS > 1 THEN PRINT "PLAYER 1 MADE"; PL(1); "SHOTS"
 IF PLYRS > 1 THEN PRINT "PLAYER 2 MADE"; PL(2); "SHOTS"
 IF PLYRS > 2 THEN PRINT "PLAYER 3 MADE"; PL(3); "SHOTS"
 IF PLYRS > 3 THEN PRINT "PLAYER 4 MADE"; PL(4); "SHOTS"
 IF PLYRS > 4 THEN PRINT "PLAYER 5 MADE"; PL(5); "SHOTS"
 IF PLYRS > 5 THEN PRINT "PLAYER 6 MADE"; PL(6); "SHOTS"
 IF PLYRS > 6 THEN PRINT "PLAYER 7 MADE"; PL(7); "SHOTS"
 IF PLYRS > 7 THEN PRINT "PLAYER 8 MADE"; PL(8); "SHOTS"
 GH$ = INPUT$(1)
 GOTO INTR

SUB ACCBOARD
 LOCATE 3, 50: PRINT "ACCURACY"
 LOCATE 12, 68: PRINT "P"
 LOCATE , 68: PRINT "O"
 LOCATE , 68: PRINT "W"
 LOCATE , 68: PRINT "E"
 LOCATE , 68: PRINT "R"
 LINE (300, 50)-(550, 100), 15, B: DRAW "BM 301,51 P9,15"
 LINE (400, 50)-(450, 100), 4, B
 LINE (300, 50)-(550, 100), 15, B
 LINE (550, 150)-(600, 300), 15, B: DRAW "BLBU P9,15"
 LINE (550, 250)-(600, 300), 4, B
 LINE (550, 150)-(600, 300), 15, B
END SUB

SUB DRAWHOOP
DRAW "BM 275,0 C5 D480"
PAINT (1, 1), 5
DRAW "BM 75,160 C15 U150 R155 D150 L155 BUBR P9,15"
DRAW "BM 120,50 C15 G25 D39 R110 U39 H25 L60 BR1BD1 P15,15"
FOR D = 4 TO 1 STEP -1
LINE (135 - D, 70 - D)-(165 + D, 90 + D), 4, B
NEXT D
DRAW "BM 120,110 C15 TA-20 F30 TA0 BR24 TA20 E30"
DRAW "BM 132,115 C15 TA-28 F26 TA0 BR14 TA28 E26"
DRAW "BM 142,116 C15 TA-36 F25 TA0 BR04 TA36 E25"
DRAW "BM 150,116 C15 TA0 D35"
FOR D = 11 TO 17 STEP 2
CIRCLE (150, 150 - (5 * (D - 11))), 11 + (D - 11) * (D / 7), 15, , , .2
NEXT D
FOR D = 30 TO 26 STEP -1
CIRCLE (150, 110), D, 4, , , .2
NEXT D
DRAW "BM 75,160 C9 TA5 D200 TA0 R120 TA-5 U200 TA0 L154 BR10BD1 P9,9"
CIRCLE (140, 340), 15, 6: DRAW "P6,6 C0 TA2 D15 U30 TA0 BR10 BD3 TA3 D25 U25 TA0 BL20 BD2 TA3 D20 TA0"
DRAW "BM 93,350 C0 R119 D10 L119 U10 BD1BR1 P0,0"
DRAW "BM 75,160 C9 U150 R155 D150 L155"
END SUB

SUB INTRO
 SCREEN 13: CLS
 COLOR 6
 LOCATE 9, 9: PRINT "лллллллллллллллллллллл"
 FOR Y = 10 TO 14
 LOCATE Y, 9: PRINT "л                    л"
 NEXT Y
 LOCATE 15, 9: PRINT "лллллллллллллллллллллл"
END SUB

SUB PRINTSTATS (AT, MK, PLYR, HPS, P)
LOCATE 10, 40: PRINT "ATTEMPTS:"; AT; "  "
LOCATE 12, 40: PRINT "SHOTS MADE:"; MK; "  "
IF MK = 0 THEN LOCATE 14, 40: PRINT "PERCENTAGE: 0 % "
IF MK > 0 THEN LOCATE 14, 40: PRINT "PERCENTAGE:"; INT((MK / AT) * 100); "%  "
LOCATE 17, 40: PRINT "F1-TOGGLE SOUND(ON/OFF)"
LOCATE 19, 40: PRINT "F9-MAIN MENU"
IF P = 0 THEN
 LOCATE 22, 40: PRINT "PLAYER"; PLYR
 LOCATE 22, 48: PRINT "'S TURN"
 LOCATE 24, 40: PRINT HPS - AT; "SHOTS LEFT "
END IF
END SUB

