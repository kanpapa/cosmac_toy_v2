# Q LEDを点滅させる

## 概要
Q LEDが一定時間間隔で点滅します。いわゆるLチカです。  
最初にアキュームレータである8ビットのDレジスタに$40を設定していますが、この値は点滅間隔の待ち時間のカウンタとして使用されるR4レジスタの上位バイトに代入されます。  
COSMACの汎用レジスタ(R0〜RF)は16bitですが、16bitの値を直接設定することができないため、Dレジスタを介して上位バイト、下位バイトに8bitずつ値を設定する必要があります。なおリセット直後は各レジスタの値は0となっていますので、R4の下位バイトの0設定は省略しています。  
R4レジスタを1減算したあとに、0になったかを確認していますが、この確認もDレジスタを使う必要があり、上位バイト、下位バイトをそれぞれ確認しています。  

このように何をやるにしてもこのDレジスタを経由して行うことが多いです。

## 使用する命令
|INSTRUCTION|MNEMONIC|OP CODE|OPERATION|
|---|---|---|---|
|LOAD IMMEDIATE|LDI|F8|M(R(P)) → D; R(P) + 1 → R(P)|
|PUT HIGH REG N|PHI|BN|D → R(N).1|
|LONG SKIP IF Q = 1|LSQ|CD|IF Q = 1, R(P) + 2 → R(P), ELSE CONTINUE|
|SET Q|SEQ|7B|1 → Q|
|SHORT SKIP|SKP|38|R(P) + 1 → R(P)|
|RESET Q|REQ|7A|0 → Q|
|DECREMENT REG N|DEC|2N|R(N) - 1 → R(N)|
|GET LOW REG N|GLO|8N|R(N).0 → D|
|GET HIGH REG N|GHI|9N|R(N).1 → D|
|SHORT BRANCH IF D NOT 0|BNZ|3A|IF D NOT 0, M(R(P)) → R(P).0, ELSE R(P) + 1 → R(P)|
|SHORT BRANCH|BR|30|M(R(P)) → R(P).0|

## サンプルコード

```
0000-F8 40    START:  LDI     #$40                ; Dレジスタに$40を入れる（点滅間隔のウェイトループ値）
0002-B4               PHI     4                   ; R4の上位バイトにDレジスタの値を代入する
0003-CD               LSQ                         ; Qが1だったら2バイトスキップする
0004-7B               SEQ                         ; Qを1にする
0005-38               SKP                         ; 次の命令を無条件でスキップする
0006-7A               REQ                         ; Qを0にする
0007-24       LOOP1:  DEC     4                   ; R4を1減算する
0008-84               GLO     4                   ; DレジスタにR4の下位バイトを代入する
0009-3A 07            BNZ     LOOP1               ; Dレジスタが0でなければLOOP1にジャンプ
000B-94               GHI     4                   ; DレジスタにR4の上位バイトを代入する
000C-3A 07            BNZ     LOOP1               ; Dレジスタが0でなければLOOP1にジャンプ
000E-30 00            BR      START               ; 0番地から繰り返し
```

## 実行結果
Q-LEDの点滅ができました。  
画像をクリックすると動画が再生されます。

[![blink1 video](https://img.youtube.com/vi/glT6MU6y57Q/0.jpg)](https://www.youtube.com/watch?v=glT6MU6y57Q)