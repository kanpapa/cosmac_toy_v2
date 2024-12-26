*
* POV program 1 for COSMAC TOY V2
* SB-Assembler
*
	.CR	1802	;To load the 1802 cross overlay	
	.OR	$0000
*
* R3 BITMAPデータを指すインデックスレジスタ
* R4 BITMAPデータの個数
* R5 ウェイトカウンタ
*
START	LDI	#BITMAP	; DレジスタにBITMAPデータの先頭アドレスを設定
	PLO	3	; R3にBITMAPのアドレスを設定
	SEX	3	; R3をインデックスレジスタに設定
	LDI	27	; DレジスタにBITMAPデータの個数である27を設定する
	PLO	4	; R4にBITMAPデータの個数を設定する
LOOP1	OUT	1	; BITMAPのデータでLEDを表示する。R3は自動インクリメントされる。BUS <- M(R(3)); R(3)++
	LDI	228	; ウェイトカウンタの初期値←ここは調整要
	PLO	5	; R5をウェイトカウンタとしてDレジスタから初期値を設定する
LOOP2	DEC	5	; ウェイトカウンタを1減らす。
	GLO	5	; Dレジスタにウェイトカウンタをセット
	BNZ	LOOP2	; Dレジスタが0でなかったらLOOP2へ
	DEC	4	; BITMAPカウンタを１減らす
	GLO	4	; Dレジスタにビットマップカウンタの値をセット
	BNZ	LOOP1	; Dレジスタが0でなかったらLOOP1へ
	BR	START	; BITMAPのデータを表示し終えたので、最初から繰り返し
*
* BITMAP DATA "HELLO" 27byte
*
BITMAP	.DB	0b11111110	; H
	.DB	0b00010000
	.DB	0b00010000
	.DB	0b00010000
	.DB	0b11111110
	.DB	0b00000000

	.DB	0b11111110	; E
	.DB	0b10010010
	.DB	0b10010010
	.DB	0b10010010
	.DB	0b00000000
 
	.DB	0b11111110	; L
	.DB	0b10000000
	.DB	0b10000000
	.DB	0b10000000
	.DB	0b00000000

	.DB	0b11111110	; L
	.DB	0b10000000
	.DB	0b10000000
	.DB	0b10000000
	.DB	0b00000000

	.DB	0b11111110	; O
	.DB	0b10000010
	.DB	0b10000010
	.DB	0b10000010
	.DB	0b11111110
	.DB	0b00000000

	.EN
