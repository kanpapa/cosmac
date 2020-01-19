	.LF	tv5
	.TF	tv5.hex,HEX
*
* TV Display program 5 for COSMAC
* SB-Assembler
*
	.CR	1802	;To load the 1802 cross overlay	
	.OR	$0000
*
START	LDI	0	;initrize register R(3).1 R(4).1
	PHI	3
	PHI	4
	LDI	SETSTR	;SETSTR address R(3)
	PLO	3
	SEP	3	;Change Program Counter R(3)
*
SETSTR	LDI	$40	;Set data store address R(4)=$0040
	PLO	4
SETDMA	LDI	$20	;Set DMA address R(0)=$0020
	PLO	0
	LDI	0
	PHI	0
DWAIT	IDL		;DMA waiting
	BN2	DWAIT	;Check VSYNC(EF2)
	INC	5	;Counter R(5)++
	GLO	5
	STR	4	;Store count data
	INC	4	;Store address R(4)++
	GLO	4	;Check store address > $F0
	SMI	$F0
	BNZ	SETDMA
	BR	SETSTR

	.EN
