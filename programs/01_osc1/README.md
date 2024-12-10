# パルス信号を作る

## 概要
動作確認用として4バイトのシンプルなプログラムを動かします。CDP1802にはQという端子があり簡単な命令で0/1を出力することができます。

## 使用する命令

|INSTRUCTION|MNEMONIC|OP CODE|OPERATION|
|---|---|---|---|
|SET Q|SEQ|7B|1 → Q|
|RESET Q|REQ|7A|0 → Q|
|SHORT BRANCH|BR|30|M(R(P)) → R(P).0|

## サンプルプログラム

```
0000-7B        START   SEQ             ;Q <- 1
0001-7A                REQ             ;Q <- 0
0002-30 00             BR      START   ;Branch to START
```

## 実行結果
このプログラムを実行するとQ LEDが点灯します。Q端子にオシロスコープを接続すればパルス出力が確認できます。

![image](osc1.jpg)