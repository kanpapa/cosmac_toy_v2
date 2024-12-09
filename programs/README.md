# COSMAC TOY Computer Sample program

サンプルプログラムのアセンブラソースとSB-Assemblerでアセンブルしたリストです。  
こちらを参考にしてプログラムの入力や改良をしてください。

## サンプルプログラム

* [パルス信号を作る](https://kanpapa.com/cosmac/blog/2018/11/rca-cdp1802-cosmac2.html)
    * [01_osc1](01_osc1) - 動作確認用。Q出力の0,1を繰り返します。Q出力のLEDは超高速点滅なので点灯したままに見えます。オシロであれば信号を確認できます。
* [カウンタプログラム](https://kanpapa.com/cosmac/blog/2018/12/rca-cdp1802-cosmac4.html)
    * [02_count1](02_count1) - 高速表示版。これも速すぎて見えないです。
    * [03_count2](03_count2) - 低速表示版。これぐらいでようやく見えます。
* [加算プログラム](https://kanpapa.com/cosmac/blog/2018/12/rca-cdp1802-cosmac4.html)
    * [04_add1](04_add1) - トグルスイッチで設定した値に6を加算した数値をLEDに表示します。
* [押しボタンスイッチでQ出力を制御](05_sw1/README.md)
    * [05_sw1](05_sw1) - EF1に接続したスイッチを押すとQ-LEDが消灯し、離すとQ-LEDが点灯します。
* [Q LEDを点滅させる](06_blink1/README.md)
    * [06_blink1](06_blink1) - Q LEDが一定時間間隔で点滅します。いわゆるLチカです。

## Requirement

This source file can be assembled using SB-Assembler 3.
* [SB-Projects - SB-Assembler](https://www.sbprojects.net/sbasm/)

## License

This software is released under the [MIT license](https://en.wikipedia.org/wiki/MIT_License).