*
* Oscillator program 1 for COSMAC
* SB-Assembler
*
	.CR	1802	To load the 1802 cross overlay	
	.OR	$0000
*
START	SEQ		1->Q
	REQ		0->Q
	BR	START	M(R(P))->R(P).0

	.EN
