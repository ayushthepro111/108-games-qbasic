'===========================================================================
' Subject: BAGELS (NUMBER GUESSING GAME)      Date: 11-03-96 (23:05)       
'  Author: James Hooker                       Code: QB, QBasic, PDS        
'  Origin: alt.lang.basic                   Packet: GAMES.ABC
'===========================================================================
    PRINT TAB(33); "BAGELS"
    PRINT TAB(15); "CREATIVE COMPUTING MORRISTOWN, NEW JERSEY"
    PRINT "Modified for execution in QBASIC by James Hooker,  1996"
    REM *** BAGELS NUMBER GUESSING GAME
    REM *** ORIGINAL SOURCE UNKNOWN BUT SUSPECTED TO BE
    REM *** LAWRENCE HALL OF SCIENCE, U.C. BERKLEY
    DIM Answer%(3), PlayerGuess%(3)
    PRINT : PRINT : PRINT
    INPUT "WOULD YOU LIKE THE RULES (YES OR NO)"; a$
    IF UCASE$(LEFT$(a$, 1)) <> "N" THEN
        PRINT
        PRINT "I AM THINKING OF A 3 DIGIT NUMBER.  TRY TO GUESS"
        PRINT "MY NUMBER AND I WILL GIVE YOU CLUES AS FOLLOWS:"
        PRINT "PICO - ONE DIGIT IS IN THE WRONG PLACE"
        PRINT "FERMI - ONE DIGIT IS IN THE CORRECT PLACE"
        PRINT "BAGELS - NO DIGIT IS CORRECT"
    END IF
    DO
        FOR i% = 1 TO 3
NoDupDig:   Answer%(i%) = 10 * RND(1)
            IF i > 1 THEN
                FOR J% = 1 TO i - 1
                    IF Answer%(i) = Answer%(J%) THEN GOTO NoDupDig
                NEXT J%
            END IF
        NEXT i%
        PRINT
        PRINT "OK, I HAVE A NUMBER IN MIND."
        FOR i% = 1 TO 20
BadGuess:   PRINT "GUESS #"; i%,
            INPUT a$
            IF LEN(a$) <> 3 THEN
                PRINT "TRY GUESSING A THREE DIGIT NUMBER."
                GOTO BadGuess
            END IF
            FOR J% = 1 TO 3
                PlayerGuess%(J%) = ASC(MID$(a$, J%, 1)) - 48
                IF PlayerGuess%(J%) < 0 OR PlayerGuess%(J%) > 9 THEN
                    PRINT "WHAT?"
                    GOTO BadGuess
                END IF
            NEXT J%
            IF PlayerGuess%(1) = PlayerGuess%(2) OR PlayerGuess%(2) = PlayerGuess%(3) OR PlayerGuess%(3) = PlayerGuess%(1) THEN
                PRINT "OH, I FORGOT TO TELLL YOU THAT THE NUMBER I HAVE IN MIND"
                PRINT "HAS NO DIGITS THE SAME."
                GOTO BadGuess
            END IF
            PicoCount% = 0
            FermiCount% = 0
            FOR J% = 1 TO 2
                IF Answer%(J%) = PlayerGuess%(J% + 1) OR Answer%(J% + 1) = PlayerGuess%(J%) THEN PicoCount% = PicoCount% + 1
            NEXT J%
            IF Answer%(1) = PlayerGuess%(3) OR Answer%(3) = PlayerGuess%(1) THEN PicoCount% = PicoCount% + 1
            FOR J% = 1 TO 3
                IF Answer%(J%) = PlayerGuess%(J%) THEN FermiCount% = FermiCount% + 1
            NEXT J%
            IF FermiCount% = 3 THEN
                PRINT "YOU GOT IT!!!"
                Y = Y + 1
                GOTO Winner
            END IF
            FOR J% = 1 TO PicoCount%
                PRINT "PICO ";
            NEXT J%
            FOR J% = 1 TO FermiCount%
                PRINT "FERMI  ";
            NEXT J%
            IF PicoCount% + FermiCount% = 0 THEN PRINT "BAGELS";
            PRINT
        NEXT i%
        PRINT "OH WELL"
        PRINT "THATS'S TWENTY GUESSES. MY NUMBER WAS"; 100 * Answer%(1) + 10 * Answer%(2) + Answer%(3)
Winner: INPUT "PLAY AGAIN (YES OR NO)"; a$
    LOOP WHILE UCASE$(LEFT$(a$, 1)) = "Y"
    PRINT
    PRINT "A"; Y; " POINT BAGLES BUFF!!"
    PRINT "HOPE YOU HAD FUN. BYE."
