*
* Motor driver program for COSMAC-R2D2
* SB-Assembler
*
* BUS0 --- AIN1
* BUS1 --- AIN2
* BUS2 --- BIN1
* BUS3 --- BIN2
* Q    --- PWMA/B
*
* 動作
* R2D2は1モーターのため前進、後進のみの動き。テーブルから落ちないように注意。
* 前面にPUSH SWがあるのでこれを押すと動くようにする。前進して後進は繰り替えす。
* 停止する場合はRESETを押すことにする。
* 
        .CR     1802    ;To load the 1802 cross overlay
        .OR     $0000
*
* Wait Push SW
*
START	BN4     START   ;IF EF4=0 START (EF4=Vcc)
	LDI	#WAIT1
	PLO	7
        SEQ		;1 -> Q

LOOP2	LDI     #IOR    ;#IOR -> D
        PLO     3       ;D -> R(3).0
        SEX     3       ;3 -> X
*
	SEP	7	;Forward
	SEP	7	;Back
*
        BR      LOOP2   ;Branch to MAIN
*
* WAIT Routine
*
EXIT1	SEP	0
WAIT1   OUT     4       ;M(R(3)) -> BUS; R(3)++
	LDI	#255
	PHI	2
LOOP1	DEC     2	;R(2)--
        GHI     2	;R(2).1 -> D
        BNZ     LOOP1	;IF D!=0 LOOP1
	BR	EXIT1
*
* Forward
IOR	.DB     01      ;Forward
	.DB     02      ;Back

        .EN
