# 押しボタンスイッチでQ出力を制御

## 概要
EF1～EF4（4フラグ）の使用例です。  
EF1～EF4入力により、外部機器からのステータス情報をプロセッサに転送できます。
これらの入力レベルは、条件分岐命令でテストできます。

ここではEF1端子に押しボタンスイッチを接続し、スイッチを押した場合はEF1端子がHIGH、押していないときはEF1端子がLOWとなるようにしています。  
プログラムでEF1端子がHIGH(=5V)なのかLOW(=0V)なのかで処理を分岐し、Q出力を1にセットするもしくは0にリセットする処理を行います。

## 使用する命令

|INSTRUCTION|MNEMONIC|OP CODE|OPERATION|
|---|---|---|---|
|SHORT BRANCH IF EF1 = 1 (EF1 = VSS)|B1|34|IF EF1 = 1, M(R(P)) → R(P).0, ELSE R(P) + 1 → R(P)|
|RESET Q|REQ|7A|0 → Q|
|SHORT BRANCH|BR|30|M(R(P)) → R(P).0|
|SET Q|SEQ|7B|1 → Q|

## サンプルコード

```
0000-34 05    START:  B1      L1                  ; ~EF1 = 1(VSS) だったら L1にジャンプ
0002-7A               REQ                         ; Q出力を0にする(LED消灯)
0003-30 00            BR      START               ; 0000番地にジャンプ
0005-7B       L1:     SEQ                         ; Q出力を1にする(LED点灯)
0006-30 00            BR      START               ; 0000番地にジャンプ
```

## 回路図

![image](sw1_sch.png)

## 実行結果
手元にあったDFROBOT社の[Gravity: Digital Push Button (Yellow)](https://www.dfrobot.com/product-73.html)を使用しています。  
画像をクリックすると動画が再生されます。

[![sw1 video](https://img.youtube.com/vi/XKFlwYPNNAE/0.jpg)](https://www.youtube.com/watch?v=XKFlwYPNNAE)