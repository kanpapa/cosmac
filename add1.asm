*
* Add program 1 for COSMAC
* SB-Assembler
*
* SW input + 6 -> LED Display
*
	.CR	1802	To load the 1802 cross overlay	
	.OR	$0000
*
START	LDI	#IOR	M(R(P))->D; R(P)+1
	PLO	5	D->R(5).0
	SEX	5	5->X
LOOP1	INP	2	BUS->M(R(5)); BUS->D
	LDI	#$06	M(R(P))->D; R(P)+1
	ADD		M(R(X))+D->DF,D
	STR	5	D->M(R(5))
	OUT	1	M(R(X))->BUS; R(X)+1
	DEC	5	R(5)-1
	BR	LOOP1	M(R(P))->R(P).0
*
IOR	.DB	0	IO Register

	.EN
