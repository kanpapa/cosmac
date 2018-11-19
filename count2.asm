*
* Counter program 2 for COSMAC
* SB-Assembler
*
	.CR	1802	To load the 1802 cross overlay	
	.OR	$0000
*
START	LDI	#$31	M(R(P))->D; R(P)+1
	PLO	3	D->R(3).0
	SEX	3	3->X
LOOP1	GHI	4	R(4).0->D
	STR	3	D->M(R(3))
	OUT	1	M(R(X))->BUS; R(X)+1
	DEC	3	R(3)-1
	INC	4	R(4)+1
	BR	LOOP1	M(R(P))->R(P).0

	.EN
