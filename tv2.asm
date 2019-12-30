	.LF	tv2
	.TF	tv2.hex,HEX
*
* TV Display program 2 for COSMAC
* SB-Assembler
*
	.CR	1802	;To load the 1802 cross overlay	
	.OR	$0000
*
START	LDI	0	;0 -> D
	PHI	3	;D -> R(3).1
	LDI	LOOP1	;LOOP1 -> D
	PLO	3	;D -> R(3).0
	SEP	3	;3 -> P
LOOP1	LDI	0	;0 -> D
	PHI	0	;D -> R(0).1	
	LDI	$20	;$20 -> D
	PLO	0	;D -> R(0).0
LOOP2	IDL		;WAIT FOR DMA OR INTERRUPT; M(R(0)) -> BUS
	BN2	LOOP2	;IF EF2=0(Vcc) LOOP2
	BR	LOOP1

	.EN
