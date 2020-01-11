	.LF	tv3
	.TF	tv3.hex,HEX
*
* TV Display program 3 for COSMAC
* SB-Assembler
*
	.CR	1802	;To load the 1802 cross overlay	
	.OR	$0000
*
START	LDI	LOOP1	;LOOP1 -> D
	PLO	3	;D -> R(3).0
	LDI	0	;0 -> D
	PHI	3	;D -> R(3).1
	SEP	3	;3 -> P
LOOP1	LDI	$40	;$40 -> D
	PLO	4	;D -> R(4).0
	LDI	0
	PHI	4
LOOP2	LDI	$20	;$20 -> D
	PLO	0	;D -> R(0).0
	LDI	0
	PHI	0
LOOP3	IDL
	BN2	LOOP3
	LDI	$AA	;$AA -> D
	STR	4	;D -> M(R(4))
	INC	4	;M(R(4))++
	GLO	4	;R(4).0 -> D
	SMI	$F0	;D - $F0 -> DF,D
	BNZ	LOOP2
	BR	LOOP1

	.EN
