*
* Oscillator program 2 for COSMAC
* SB-Assembler
*
	.CR	1802
	.OR	$0000
*
START	LDI	#$31	$31->D
	PLO	5	D->R(5).0
	SEX	5	5->X
LOOP1	INP	2	BUS->M(R(5))
	LDN	5	M(R(5))->D
	PLO	3	D->R(3).0
LOOP2	DEC	3	R(3)-1
	GLO	3	R(3).0->D
	BNZ	LOOP2	IF D!=0 LOOP2
	SEQ		1->Q
	REQ		0->Q
	BR	LOOP1

	.EN
