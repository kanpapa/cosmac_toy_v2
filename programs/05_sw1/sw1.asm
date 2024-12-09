*
* Push switch Q-LED program 1 for COSMAC
* SB-Assembler
*
        .CR	1802
        .OR	$0000
*
START:  B1      L1                  ; ~EF1 = 1(VSS) だったら L1にジャンプ
        REQ                         ; Q出力を0にする(LED消灯)
        BR      START               ; 0000番地にジャンプ
L1:     SEQ                         ; Q出力を1にする(LED点灯)
        BR      START               ; 0000番地にジャンプ