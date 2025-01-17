# POVを試してみる

## 概要
いわゆるPOV(Persistent Of Vision)です。目の残像を利用してLEDでメッセージを表示するものです。　  
COSMAC TOY V2では8個のLEDが使えますので、このLEDにビットマップデータの1列毎に一定時間表示するようにしておきます。この状態でCOSMAC TOY V2基板を横に振ることでうまくいけばメッセージが表示されているように見えます。  
個人差や照明環境もありますので、うまく見えない場合は7行目のLDI 60の値を調整してください。  
表示するビットマップデータを入れ替えることもできます。ビットマップのデータ数を4行目のLDI 27で設定していますので、ビットマップデータの長さに合わせて調整してください。  
ビットマップデータの値でLEDを表示するためにOUT 1命令を使用していますが、この命令は自動的にインデックスレジスタを加算してくれますので、今回のような連続したデータの出力は容易に行えることがわかります。

## 使用する命令
|INSTRUCTION|MNEMONIC|OP CODE|OPERATION|
|---|---|---|---|
|LOAD IMMEDIATE|LDI|F8|M(R(P)) → D; R(P) + 1 → R(P)|
|PUT LOW REG N|PLO|AN|D → R(N).0|
|SET X|SEX|EN|N→X|
|OUTPUT 1|OUT 1|61|M(R(X)) → BUS; R(X) + 1 → R(X); N LINES = 1|
|DECREMENT REG N|DEC|2N|R(N) - 1 → R(N)|
|GET LOW REG N|GLO|8N|R(N).0 → D|
|SHORT BRANCH IF D NOT 0|BNZ|3A|IF D NOT 0, M(R(P)) → R(P).0, ELSE R(P) + 1 → R(P)|
|SHORT BRANCH|BR|30|M(R(P)) → R(P).0|

## サンプルコード

```
0000-                  1        *
0000-                  2        * POV program 1 for COSMAC TOY V2
0000-                  3        * SB-Assembler
0000-                  4        *
0000-                  5                .CR     1802    ;To load the 1802 cross overlay
0000-                  6                .OR     $0000
0000-                  7        *
0000-                  8        * R3 BITMAPデータを指すインデックスレジスタ
0000-                  9        * R4 BITMAPデータの個数カウンタ
0000-                 10        * R5 ウェイトカウンタ
0000-                 11        *
0000-F8 15            12 (   2) START   LDI     #BITMAP ; DレジスタにBITMAPデータの先頭アドレスを設定
0002-A3               13 (   2)         PLO     3       ; R3にBITMAPのアドレスを設定
0003-E3               14 (   2)         SEX     3       ; R3をインデックスレジスタに設定
0004-F8 1B            15 (   2)         LDI     27      ; DレジスタにBITMAPデータの個数である27を設定する
0006-A4               16 (   2)         PLO     4       ; R4にBITMAPデータカウンタの初期値を設定する
0007-61               17 (   2) LOOP1   OUT     1       ; BITMAPのデータでLEDを表示する。R3は自動インクリメントされる。BUS <- M(R(3)); R(3)++
0008-F8 3C            18 (   2)         LDI     60      ; ウェイトカウンタの初期値←ここは調整要
000A-A5               19 (   2)         PLO     5       ; R5をウェイトカウンタとしてDレジスタから初期値を設定する
000B-25               20 (   2) LOOP2   DEC     5       ; ウェイトカウンタを1減らす。
000C-85               21 (   2)         GLO     5       ; Dレジスタにウェイトカウンタをセット
000D-3A 0B            22 (   2)         BNZ     LOOP2   ; Dレジスタが0でなかったらLOOP2へ
000F-24               23 (   2)         DEC     4       ; BITMAPカウンタを１減らす
0010-84               24 (   2)         GLO     4       ; DレジスタにBITMAPデータカウンタの値をセット
0011-3A 07            25 (   2)         BNZ     LOOP1   ; Dレジスタが0でなかったらLOOP1へ
0013-30 00            26 (   2)         BR      START   ; BITMAPのデータを表示し終えたので、最初から繰り返し
0015-                 27        *
0015-                 28        * BITMAP DATA "HELLO" 27byte
0015-                 29        *
0015-FE               30        BITMAP  .DB     0b11111110      ; H
0016-10               31                .DB     0b00010000
0017-10               32                .DB     0b00010000
0018-10               33                .DB     0b00010000
0019-FE               34                .DB     0b11111110
001A-00               35                .DB     0b00000000
001B-                 36
001B-FE               37                .DB     0b11111110      ; E
001C-92               38                .DB     0b10010010
001D-92               39                .DB     0b10010010
001E-92               40                .DB     0b10010010
001F-00               41                .DB     0b00000000
0020-                 42
0020-FE               43                .DB     0b11111110      ; L
0021-80               44                .DB     0b10000000
0022-80               45                .DB     0b10000000
0023-80               46                .DB     0b10000000
0024-00               47                .DB     0b00000000
0025-                 48
0025-FE               49                .DB     0b11111110      ; L
0026-80               50                .DB     0b10000000
0027-80               51                .DB     0b10000000
0028-80               52                .DB     0b10000000
0029-00               53                .DB     0b00000000
002A-                 54
002A-FE               55                .DB     0b11111110      ; O
002B-82               56                .DB     0b10000010
002C-82               57                .DB     0b10000010
002D-82               58                .DB     0b10000010
002E-FE               59                .DB     0b11111110
002F-00               60                .DB     0b00000000
0030-                 61
0030-                 62                .EN
```

## 実行結果
このプログラムを実行するとLEDがチラチラするだけで、正常に動作しているのかわかりません。  
画像をクリックすると動画が再生されます。  
[![blink1 video](https://img.youtube.com/vi/aNgpml-eRWY/0.jpg)](https://www.youtube.com/watch?v=aNgpml-eRWY)

この状態でCOSMAC TOY V2基板を手に持ち横に振るとかろうじてメッセージが見えます。（心の目で見てください・・・）  
画像をクリックすると動画が再生されます。  
[![blink1 video](https://img.youtube.com/vi/d47GrqhgYpU/0.jpg)](https://www.youtube.com/watch?v=d47GrqhgYpU)
