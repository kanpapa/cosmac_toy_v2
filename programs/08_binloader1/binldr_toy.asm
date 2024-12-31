; 1802 Membership Card .bin loader by Jonathan Mordosky 
; Edited by Lee Hart Oct 29 2015, JOnathan Mordosky Nov 3 2015
;
; first, here is the original by Jonathan Mordosky in cosmacelf Oct 2015
; Loads binary file starting at address XX00, Where XX is any page in memory above 00
; For 1802 Membership Card, serial port configured as Normal (not inverting)
; Tested at 300 baud 8N1. Should work at slightly higher baud rates
;
; To Use: Toggle in program as usual.
; Start up and configure communications program on host computer.
; On 1802MC, make sure write protect is off. Flip switch to Clear, then Run.
; Hit <Space> exactly once on host computer, watching that the output LEDs do not change.
; On newer revision boards, the green LED will blink as the space character is received.
; Send BIN file as ASCII from host computer. Make sure program settings don't strip the 8th bit.
; Output LEDs should now change and show the data as it is received.
;
; When blinking stops, verify that the LEDs match the last byte of the program.
; Toggle in a long jump instruction to start of program (0xC0 0xXX 0x00) and run.
; If unsuccessful, check com settings and try again.

; Binary loader for COSMAC TOY V2 by Kazuhiro Ouchi
; Edited by Kazuhiro Ouchi Dec 31 2024
; This source program can be assembled with the SB assembler.

; hex listing for COSMAC TOY V2

;0000   F8 00 B2 F8 40 A2 E2 F8
;0008   00 3E 09 36 0B FC 01 3E
;0010   0D FF 04 B3 36 14 F8 09
;0018   A3 3E 19 93 F6 38 93 FF
;0020   01 3A 1F 02 F6 36 29 F9
;0028   80 52 23 83 3A 1E 61 30
;0030   14

	.CR 1802
	.OR 0000H	;initialization    初期化
Page	.EQ 00		; desired page destination    バイナリをロードするページ先。COSMAC TOYは256byteメモリなので00とする
;
	LDI Page	;Set destination starting address   デスティネーション開始アドレスの設定
	PHI 2		;R2 points to destination           R2 はデスティネーションを指す。
;	GHI 0		;  LSB of destination is 00
	LDI $40		;  LSB of destination is 40  COSMAC TOYの場合はデスティネーションの下位バイトは40とする。
	PLO 2		;  (assumes this program is at 00XX)  ロードするプログラムは00XXにあると仮定する。
	SEX 2
	LDI 0		; Dレジスタを$40にしてしまったので0を設定しておく。(Timeで使うから)

LoopA	BN3 LoopA	;スタートビットを待つ。EF3がLOWの場合はループ。B3がHIGHに変化したら次のステップへ

LoopB	B3 LoopB	;ASCIIコードのスペースのD5=1のデータビット(EF3=HIGHに変化)を待つ。（LSBファーストで送信）
			;time Data bit D5
			;  Dレジスタは0に初期化済
Time	ADI 1		;  D=D+1 for each loop    Dを1加算するループ
	BN3 Time	;  ...until end of bit    データビット終了(EF3=LOWになる)までループで加算し続ける。データビットが終了したら次のステップへ
			;each loop is 2 instructions,
			;so Delay x 2 = number of instructions per bit
	SMI 4		;Subtract 4 extra instructions
	PHI 3		;Store Delay Constant in R3.1

;	so (Delay+4) x 2 = # of instructions in one bit time

			;OK, we're ready to receive data
Main	B3 Main		;ストップビット(EF3=HIGHに変化)を待つ
	LDI 9		;R3.0 = #bits = 9
	PLO 3
LoopC	BN3 LoopC	;スタートビット(EF3=LOWに変化)を待つ
	GHI 3		;Delay 1/2 bit time
	SHR		;  to move to middle of bit
	SKP		;
NextBit	GHI 3		;Delay one bit time

Delay	SMI 001H
	BNZ Delay

	LDN 2		;Get bits received so far...
	SHR		;  Shift right, and set most.sig.bit=0
	B3 Zero		;  if serial input=1 (i.e. EF3 pin is low)　シリアルデータビットが0（EF3がLow）の場合は分岐する
	ORI 080H	;    then set most.sig.bit=1   シリアルデータビットが1の場合はORでビットを立てる
Zero	STR 2		;Store Data    R2は転送先アドレスを指す。そこにデータをストアする
	DEC 3		;Count out bits    処理したビット数をカウント
	GLO 3
	BNZ NextBit	;Loop until byte Finished
;	OUT 4		;Show Data and INC Pointer
	OUT 1		;受信したデータをLEDに表示して転送先アドレスのポインタを加算。COSMAC TOY V2の場合はLEDはOUT1なので変更
	BR  Main	;Get next byte

	.EN
