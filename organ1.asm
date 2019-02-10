*
* Electronic organ program 1 for COSMAC
* SB-Assembler
*
	.CR	1802
	.OR	$0000
*
START	BR	MAIN
	.DB	$23
	.DB	$26
	.DB	$2B
	.DB	$31
	.DB	$38
	.DB	$3B
	.DB	$43
	.DB	$4C

MAIN	BN4	MAIN	IF EF4=0 MAIN 
	LDI	#$2F	$2F->D
	PLO	3	D->R(3).0
	SEX	3	3->X
	INP	4	BUS->M(R(3));N LINES=4
	LDN	3	M(R(3))->D
	ADI	2	D+2->D. DF
	PLO	4	D->R(4).0
	LDN	4	M(R(4))->D
	PLO	5	D->R(5).0
LOOP2	DEC	5	R(5)-1
	GLO	5	R(5).0->D
	BNZ	LOOP2	IF D!=0 LOOP2
	BQ	LOOP3	IF Q=0 LOOP3
	SEQ		1->Q
	BR	MAIN

LOOP3	REQ		0->Q
	BR	MAIN

	.EN
