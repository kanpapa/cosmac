	.LF	lcd2_1852
	.TF	lcd2_1852.hex,HEX
*
* SC1602 LCD Display program 1 for COSMAC CDP1852
* SB-Assembler
*
	.CR	1802	;To load the 1802 cross overlay	
	.OR	$0000
*
* CDP1852        SC1602LCD
* DATA_RDY ----> E(6)
* DO0 ---------> DB4(11)
* DO1 ---------> DB5(12)
* DO2 ---------> DB6(13)
* DO3 ---------> DB7(14)
* DO7 ---------> RS(4)
*         GND--> R/W(5)
*         GND--> GND(2)
*         +5V--> VDD(1)
*
START	LDI	#MAIN		;R3 = MAIN
	PLO	3		;D -> R(3).0 
	LDI	#WAIT1		;R7 = WAIT
	PLO	7		;D -> R(7).0
	LDI	#SEND1		;R8 = SEND
	PLO	8		;D -> R(8).0
	LDI	#INTDAT		;INTDAT -> D
	PLO	4		;D -> R(4).0
	LDI	#0		;0 -> D
	PHI	3		;D -> R(3).1
	PHI	7		;D -> R(7).1
	PHI	8		;D -> R(8).1
	PHI	4		;D -> R(4).1
	SEP	3		; Jump MAIN
*
*---------------------------
* LCD Initialize Data(4bit mode, RS=0)
*---------------------------
INTDAT	.DB	$03		;Function set (Interface is 8bits long.)
*				;wait 4.1ms
	.DB	$03		;Function set (Interface is 8bits long.)
*				;wait 100us
	.DB	$03		;Function set (Interface is 8bits long.)
*				;wait 40us
	.DB	$02		;Function set (Set interface to be 4 bits long.)
*				;wait 40us
	.DB	$02		;Function set (2Line mode)
	.DB	$08		;
*				;wait 40us
	.DB	$00		;Display OFF, Cursor OFF, Blink OFF
	.DB	$08		;
*				;wait 40us
	.DB	$00		;Clear Display
	.DB	$01		;
*				;wait 1.64ms
	.DB	$00		;Entry Mode Set(Cursor right, shift off)
	.DB	$06		;
*				;wait 40us
	.DB	$00		;Display ON, Cursor OFF, Blink OFF
	.DB	$0C		;
*				;wait 40us
*---------------------------
* LCD Display data(4bit mode, bit7=RS=1)
*---------------------------
	.DB	$84		;"C" $43
	.DB	$83		;
*				;wait 40us
	.DB	$84		;"O" $4F
	.DB	$8F		;
*				;wait 40us
	.DB	$85		;"S" $53
	.DB	$83		;
*				;wait 40us
	.DB	$84		;"M" $4D
	.DB	$8D		;
*				;wait 40us
	.DB	$84		;"A" $41
	.DB	$81		;
*				;wait 40us
	.DB	$84		;"C" $43
	.DB	$83		;
*				;wait 40us
*----------------------
* Main routine
*----------------------
MAIN	SEX	4		;4 -> X
*
* LCD Initrize
*
* Function set (Interface is 8bits long.)
*
	OUT	5		;M(R(X))->BUS, R(X)++
*
* Wait 4.1ms
*
	LDI	#170		;Load immediate value 170 into 0
	SEP	7		;Call WaitSub
*
* Function set (Interface is 8bits long.)
*
	OUT	5		;M(R(X))->BUS, R(X)++
*
* Wait 100us
*
	LDI	#4		;Load immediate value 4 into 0
	SEP	7		;Call WaitSub
*
* Send Initrize command (8byte)
*
	LDI	#8		;Send 8 byte
	SEP	8		;Call SEND
*
* Wait 1.64ms
*
	LDI	#64		;Load immediate value 64 into 0
	SEP	7
*
* Send Enrty Mode Set/Set Address
*
	LDI	#4		;Send 4 byte
	SEP	8		;Call SEND
*
* Write data to RAM (bit7=RS=1)
*
	LDI	#12		;Send 12 byte
	SEP	8		;Call SEND
*
STOP	BR	STOP		;HALT
*
* WAIT SUB ROUTINE
*
EXIT1	SEP	3
WAIT1	PLO	5		;Put D in R5,0
LOOP2	DEC	5		;Decrement R5 by 1 over 8 bits
	GLO	5		;Get R5.0 to test
	BNZ	LOOP2		;If R5.0 != 0, branch to LOOP
	BR	EXIT1
*
* SEND n byte SUB ROUTINE
*
EXIT2	SEP	3
SEND1	PLO	5		;Put D in R(5).0
LOOP6	OUT	5		;M(R(X)) -> BUS; R(X)++
	NOP			;WAIT
	NOP			;WAIT
	NOP			;WAIT
	NOP			;WAIT
	NOP			;WAIT
	NOP			;WAIT
	DEC	5		;Decrement R5
	GLO	5		;Get R5.0 to test
	BNZ	LOOP6		;If R(5).0 != 0, branch to LOOP
	BR	EXIT2

	.EN
