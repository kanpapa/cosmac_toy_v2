# 加算プログラム

## 概要
トグルスイッチで設定した値に6を加算した数値をLEDに表示します。

## 使用する命令
|INSTRUCTION|MNEMONIC|OP CODE|OPERATION|
|---|---|---|---|
|LOAD IMMEDIATE|LDI|F8|M(R(P)) → D; R(P) + 1 → R(P)|
|PUT LOW REG N|PLO|AN|D → R(N).0|
|SET X|SEX|EN|N→X|
|INPUT 2|INP 2|6A|BUS → M(R(X)); BUS → D; N LINES = 2|
|ADD|ADD|F4|M(R(X)) + D → DF, D|
|STORE VIA N|STR|5N|D → M(R(N))|
|OUTPUT 1|OUT 1|61|M(R(X)) → BUS; R(X) + 1 → R(X); N LINES = 1|
|DECREMENT REG N|DEC|2N|R(N) - 1 → R(N)|
|SHORT BRANCH|BR|30|M(R(P)) → R(P).0|

## サンプルプログラム

```
0000-F8 0D  START LDI #IOR    IOレジスタのメモリアドレスをDレジスタに代入する
0002-A5           PLO 5       Dレジスタの内容をR5レジスタの下位8ビットに代入する。（R5レジスタはIOレジスタのメモリアドレスになる。）
0003-E5           SEX 5       5をインデックスレジスタXに代入する。
0004-6A     LOOP1 INP 2       BUSの内容をR(X)レジスタ（ここではR5レジスタ）が示すメモリに代入する。
0005-F8 06        LDI #$06    加算する値である6をDレジスタに代入する。
0007-F4           ADD         R(X)レジスタ（ここではR5レジスタ）が示すメモリの内容とDレジスタを加算する。
0008-55           STR 5       Dレジスタの内容をR5レジスタが示すメモリに代入する。
0009-61           OUT 1       R(X)レジスタ（ここではR5レジスタ）が示すメモリの内容をLEDに出力する。
000A-25           DEC 5       OUT命令でR5に1加算されるので、1減算して元に戻す。
000B-30 04        BR LOOP1    LOOP1にジャンプする。
000D-       *
000D-00     IOR   .DB 0       IO Register
```

## 動作確認
* このプログラムを動かして、トグルスイッチを00000000（10進数で0）にするとLEDの値は00000110（10進数で6）になります。
![image](add1_in0_ans6.jpg)

* トグルスイッチを00000010（10進数で2）とすると、LEDの値は00001000（10進数で8）になります。
![image](add1_in2_ans8.jpg)

* トグルスイッチを00000110（10進数で6）とすると、LEDの値は00001100（10進数で12）になります。
![image](add1_in6_ans12.jpg)

* このようにいろいろな数値をトグルスイッチで設定して結果を確認してみてください。