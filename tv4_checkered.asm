	.LF	tv4_checkered
	.TF	tv4_checkered.hex,HEX
*
* TV Display program 4 checkered for COSMAC
* SB-Assembler
*
	.CR	1802	;To load the 1802 cross overlay	
	.OR	$0000
*
START	LDI	LOOP1	;LOOP1 -> D
	PLO	3	;D -> R(3).0
	LDI	0
	PHI	3
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
	GLO	4
	SHR
	SHR
	SHR
	SHR
	BDF	LOOP4
	LDI	$AA
	STR	4
	BR	LOOP5
LOOP4	LDI	$55
	STR	4
LOOP5	INC	4
	GLO	4
	SMI	$F0
	BNZ	LOOP2
	BR	LOOP1

	.EN
