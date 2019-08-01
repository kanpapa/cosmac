*
* Motor driver program 2 for COSMAC
* SB-Assembler
*
        .CR     1802    ;To load the 1802 cross overlay
        .OR     $0000
*
START   LDI     #IOR    ;#IOR -> D
        PLO     3       ;D -> R(3).0
        SEX     3       ;3 -> X
*
        SEQ		;1 -> Q
*
LOOP1   GHI     4       ;R(4).1 -> D
        STR     3       ;D -> M(R(3))
        OUT     4       ;M(R(3)) -> BUS; R(3)++
        DEC     3       ;R(3)--
        INC     4       ;R(4)++
*
WAIT1   DEC     2	;R(2)--
        GHI     2	;R(2).1 -> D
        BNZ     WAIT1	;IF D!=0 WAIT1
*
        BR      LOOP1   ;Branch to LOOP1
*
IOR     .DB     0       ;IO Register

        .EN
