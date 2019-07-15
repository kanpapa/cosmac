*
* AquesTalkPico Sample program 1 for COSMAC
* SB-Assembler
*
	.CR	1802
	.OR	$0000
*
START	LDI	#IOR	;#IOR -> D
	PLO	5	;D -> R(5).0
	SEX	5	;5 -> X
;
STARTUP	OUT	4	;M(R(5)) -> BUS; R(5)+1 -> R(5)
	DEC	5	;R(5)-1 -> R(N)

LOOP1	LDI	#1	;1 -> D
	ADD		;M(R(X))+D -> DF,D
	STR	5	;D -> M(R(5));
	BN4	LOOP1	;IF EF4=0 MAIN 
	OUT	4	;M(R(5)) -> BUS; R(5)+1 -> R(5)
	DEC	5	;R(5)--
	BR	LOOP1	;Branch to LOOP1
*
IOR	.DB	0	;IO Register

	.EN
