# カウンタプログラム1

## 概要
R4レジスタをカウントアップしてその値をLEDに表示することを繰り返すものです。

## 使用する命令
|INSTRUCTION|MNEMONIC|OP CODE|OPERATION|
|---|---|---|---|
|LOAD IMMEDIATE|LDI|F8|M(R(P)) → D; R(P) + 1 → R(P)|
|PUT LOW REG N|PLO|AN|D → R(N).0|
|SET X|SEX|EN|N→X|
|GET LOW REG N|GLO|8N|R(N).0 → D|
|STORE VIA N|STR|5N|D → M(R(N))|
|OUTPUT 1|OUT 1|61|M(R(X)) → BUS; R(X) + 1 → R(X); N LINES = 1|
|DECREMENT REG N|DEC|2N|R(N) - 1 → R(N)|
|INCREMENT REG N|INC|1N|R(N) + 1 → R(N)|
|SHORT BRANCH|BR|30|M(R(P)) → R(P).0|


## サンプルプログラム

```
0000-F8 31   START LDI #$31    #$31をDレジスタに入れる
0002-A3            PLO 3       Dレジスタの内容をR3レジスタの下位8ビットに入れる
0003-E3            SEX 3       3をインデックスレジスタXに入れる
0004-84      LOOP1 GLO 4       R4レジスタの下位8ビットをDレジスタに入れる
0005-53            STR 3       Dレジスタの内容をR3レジスタが示すメモリに代入する。
0006-61            OUT 1       R(X)（ここではR3）レジスタが示すメモリの内容をBUSに出力する。
0007-23            DEC 3       OUT命令でR3レジスタが1加算されるので、R3レジスタを1減算しておく
0008-14            INC 4       R4を1加算する（カウントアップ）
0009-30 04         BR LOOP1    LOOP1にジャンプする。
```

## 実行結果
表示が速すぎて上位ビットのLEDがチラチラするだけで他のLEDは点灯状態です。  
画像をクリックすると動画が再生されます。

[![counter1 video](https://img.youtube.com/vi/xx0XIwDxB0M/0.jpg)](https://www.youtube.com/watch?v=xx0XIwDxB0M)