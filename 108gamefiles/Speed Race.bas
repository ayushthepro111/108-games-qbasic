'=======================================
'  Speed Racer Demo by William Yu
' Simple demonstration of a vertical
' scrolling road with a cheap imitation
' of a race car done in QuikDraw
'=======================================
DEFINT A-Z
SCREEN 7
REDIM Sprite%(240)
'
FOR a = 0 TO 158: READ Sprite%(a): NEXT
'
DATA 22,25,224,-8164,7168,-25,1948,-32513,224,-8164
DATA 7168,-17,4060,-16129,224,-8164,7168,-1,8188,-7937
DATA 224,-8164,7168,-1,8188,-7937,30944,-8164,7288,-1
DATA 8188,-7937,31968,-8164,7292,-1025,8188,-7937,-288,-8164
DATA 7422,-4609,8188,-7937,-512,0,254,-2785,8160,-7937
DATA -512,0,254,-2753,16368,-3841,-512,0,254,-641
DATA 32760,-1793,-512,0,254,-641,32760,-1793,-512,0
DATA 254,-17025,32760,-1793,-512,0,254,-17025,32760,-1793
DATA -512,0,254,-8833,32760,-1793,31744,0,124,-1153
DATA 32760,-1793,14336,0,56,-14465,32760,-1793,0,0
DATA 0,-129,32760,-1793,0,0,0,-193,16368,-3841
DATA 0,0,0,-225,8160,-7937,224,-8164,7168,-1
DATA 8188,-7937,192,-16372,3072,-1,16380,-3841,192,-16372
DATA 3072,-1,16380,-3841,248,-1924,31744,-5,892,255
DATA 248,-1924,31744,248,124,0,248,-1924,31744,248
DATA 124,0,0,0,0,0,0,0,0

PUT (100, 100), Sprite%, PSET
GET (98, 98)-(123, 126), Sprite%
LINE (98, 98)-(123, 126), 0, BF

X = 200: Y = 0: Z = 0: N = 1: M = 165: R = 230
UP = 0
DO
DO
  IF N > 0 THEN LINE (X, Y - N)-(X + 4, Y), 0, BF
  LINE (X, Y)-(X + 4, Y + 15), 15, BF
  Y = Y + 25
LOOP UNTIL Y >= 225
  PUT (R, M), Sprite%, PSET
  PUT (R + 1, M), Sprite%, PSET
  PUT (R, M), Sprite%, PSET
V$ = INKEY$
IF V$ = CHR$(0) + "H" THEN
  IF N = 0 THEN N = 1
  UP = 1
  M = M - 1
END IF
IF V$ = CHR$(0) + "P" THEN N = N - 1
IF V$ = CHR$(0) + "M" THEN R = R + 1
IF V$ = CHR$(0) + "K" THEN R = R - 1
IF N < 0 THEN N = 0
IF UP = 1 THEN Z = Z + N
IF M = 30 THEN M = M + 1: N = N + 1
IF N = 6 THEN N = N - 1
IF V$ = "+" AND N < 5 THEN N = N + 1
IF Z >= 15 THEN Z = -10
Y = Z
LOOP UNTIL V$ = CHR$(27)

