*
* Add program 1 for COSMAC
* SB-Assembler
*
* SW input + 6 -> LED Display
*
	.CR	1802	;To load the 1802 cross overlay	
	.OR	$0000
*
START	LDI	#IOR	;D <- #IOR
	PLO	5	;R(5).0 <- D
	SEX	5	;X <- 5
LOOP1	INP	2	;M(R(5)) <- BUS; D <- BUS
	LDI	#$06	;D <- #$06
	ADD		;D,DF <- M(R(5))+D
	STR	5	;M(R(5)) <- D
	OUT	1	;BUS <- M(R(5)); R(5)++
	DEC	5	;R(5)--
	BR	LOOP1	;Branch to LOOP1
*
IOR	.DB	0	;IO Register

	.EN
