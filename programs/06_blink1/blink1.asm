*
* Blink Q-LED program 1 for COSMAC
* SB-Assembler
*
        .CR	1802
        .OR	$0000
*
START:  LDI     #$40                ; Dレジスタに$40を入れる（点滅間隔のウェイトループ値）
        PHI     4                   ; R4の上位バイトにDレジスタの値を代入する
        LSQ                         ; Qが1だったら2バイトスキップする
        SEQ                         ; Qを1にする
        SKP                         ; 次の命令を無条件でスキップする
        REQ                         ; Qを0にする
LOOP1:  DEC     4                   ; R4を1減算する　
        GLO     4                   ; DレジスタにR4の下位バイトを代入する
        BNZ     LOOP1               ; Dレジスタが0でなければLOOP1にジャンプ
        GHI     4                   ; DレジスタにR4の上位バイトを代入する
        BNZ     LOOP1               ; Dレジスタが0でなければLOOP1にジャンプ
        BR      START               ; 0番地から繰り返し