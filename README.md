# COSMAC Toy Computer Version 2

[COSMAC Toy Computer](https://github.com/kanpapa/cosmac_toy)は「トラ技別冊 つくるシリーズ7 手作りコンピュータ入門」（1981年5月初版）を参考にして、COSMAC CPUボードやプログラムローダーや実験回路をコンパクトな基板にまとめて製作したものです。  
ROMは搭載されておらず、トグルスイッチでRAMにプログラムを書き込んで実行することができます。  
1980年代の当時の環境に近づけるべく可能な限り書籍を忠実に再現することを第一に製作しましたので、やや入手が容易ではないパーツも含まれていました。  
このため、実機を使って[COSMACマイコン](https://kanpapa.com/cosmac/cosmac-cpu)の基本的な動きとトグルスイッチによるブートストラップを容易に体験いただけるようにVersion 2として見直しを行いました。

さらに高度なプログラミングを行いたい場合は、モニタが搭載された[SBC1802](https://vintagechips.wordpress.com/2021/04/13/sbc1802fixed/)や[MemberShip Card](https://www.sunrise-ev.com/1802.htm)などの利用をおすすめします。

## Version 2での変更点

* CPUボードとローダーボードを1枚の基板にまとめ、さらに製作を容易にしました。
* メモリを書き込み禁止にするトグルスイッチを追加することで、メモリ内容の読み出しや正しく手順を踏めばメモリの修正も行えるようになりました。
* 600milのS-RAMを使用できるようにしました。これにより600milの6264ALPやDIP変換基板に実装したフラットパッケージのS-RAMも使用できます。
* COSMAC CPUの全ピンにアクセスできるようにピンソケット用のパターンを併設しました。
* Q出力がLEDでモニタできるようになりました。基板単体でQ出力の確認ができます。
* COSMAC CPUとS-RAMを除きすべて秋月電子さんで購入できるパーツとしました。

## スペック

* CPU: COSMAC CDP1802
* RAM: 256byte
* ROM: 無し
* CLOCK: 約400kHz
* I/O: バスLED, Q-LED, バス設定トグルスイッチ, モード設定トグルスイッチ
* 電源: 5V 標準DCジャック、センタープラス
* メモリバックアップバッテリー: CR2032 3V
* サイズ: 95mmX72mm
* 重さ: 約89g（全パーツ実装時）

## 外観
![image](/docs/images/cosmac_toy_v2-rev02-600mil.jpg)

## 特徴

* 入手が容易なパーツを使い、回路を極力簡素化することで必要なパーツ数を減らしています。専用基板も表面実装パーツは使用せずに製作しやすくしています。
* トグルスイッチで直接メモリに書き込むため、ROMライタなどの開発ツールは不要です。
* COSMAC CPUの全ピンにアクセスできるようにピンソケットを併設しています。CPUバスやQ出力やEF1~4入力などのアクセスはここから行ってください。
* メモリは6264を使用していますが、実際に使えるのは256バイトだけです。これはトグルスイッチで正確に手入力できるのは256バイトが限界と思われるため、アドレスバスを簡略化したためです。
* S-RAMは簡易的なバッテリバックアップが行えます。SW11をSTBYにするとメモリをスタンバイ状態にし、バッテリーで内容が保持されます。
* 8つのLEDはバスの信号をラッチしてバスの状態を表示することができます。
* 右上の3つのトグルスイッチで、CPUの動作モードを設定したあとに、DMA INにつながっているプッシュスイッチを押すことで、トグルスイッチで設定した値をメモリに書き込むことができます。ROにすることでメモリに書き込まずメモリの状態を確認することもできます。
* トグルスイッチはバスの信号を直接0/1に設定します。通常はバスバッファを介しますが、シンプルな回路にするために省略しています。
* Q出力はLEDが接続されています。  
* COSMAC CPUのクロックはCR発振なのでCRの値を変えることで周波数を調整できます。
* 本基板のサイズは秋月電子のB基板に合わせました。

## 基本的な操作方法

    UP   トグルスイッチを上側に倒します
    DOWN トグルスイッチを下側に倒します
     ↓  トグルスイッチの状態をそのまま維持します。（変更しない）
     -   トグルスイッチの状態は任意です。（上側でも下側でも良い）

1. メモリ書き込み

    |Step|SW9|SW10|SW12|操作内容|
    |---|----|---|----|----|
    |1	|UP|DOWN|-|CPUを初期状態(P, X, R(0)を0)にする(RESETモード)|	
    |2	|↓|↓|UP|メモリ書き込み許可|
    |3	|DOWN|↓|↓|メモリロード状態にする(LOADモード)|
    |4	|| | |トグルスイッチでメモリに書き込む値を設定→DMAINを押す（これを繰り返す） |

1. メモリ読み出し
    |Step|SW9|SW10|SW12|操作内容|
    |---|---|----|----|----|
    |1	|UP|DOWN|-|CPUを初期状態にする(RESETモード)|
    |2  |↓|↓|DOWN|メモリ書き込み禁止|
	|3  |DOWN|↓|↓|メモリロード状態にする(LOADモード)|	
	|4  | | | |DMAINボタンを押すとメモリの内容が表示される（これを繰り返す）|		

1. プログラム実行
    |Step|SW9|SW10|SW12|操作内容|
    |---|----|---|----|----|
    |1|UP|DOWN|-|CPUを初期状態にする(RESETモード)|
    |2|↓|↓|UP|メモリ書き込み許可(メモリに書き込む処理があるプログラムの場合)|	
	|3|↓|UP|↓|プログラム実行状態にする(RUNモード)|

1. プログラム一時停止
    |Step|SW9|SW10|SW12|操作内容|
    |---|---|---|---|---|
	|1|DOWN|UP|-|プログラム実行を一時停止する(PAUSEモード)|
	|2|UP|↓|- |プログラム実行状態にする(RUNモード)|

1. メモリバックアップ状態〜通常状態への切替
    |Step|SW9|SW10|SW12|SW11|操作内容|
    |---|---|---|---|---|---|
    |1|DOWN|UP|-|RUN|プログラムを一時停止する(PAUSEモード)|
    |2|↓|↓|DOWN|↓|メモリ書き込み禁止|
    |3|↓|↓|↓|STBY|RAMをスタンバイモードにする|
    |4|↓|↓|↓|↓|電源を切断|
    |5|DOWN|UP|DOWN|STBY|PAUSEモード+メモリ書き込み禁止になっていることを確認|
    |6|↓|↓|↓|↓|電源を投入|
    |7|↓|↓|↓|RUN|RAMをノーマルモードにする|

## ハードウェア

- [回路図](/schematics/)
- [部品表](/bom/)
- [KiCadデータ](/kicad/)
- [ガーバーデータ](/gerber/)

## ソフトウェア
 
- [サンプルアプリケーション](/programs/)

## 補足情報

- [COSMAC研究会](https://kanpapa.com/cosmac/)に関連記事をまとめています。

## 参考・引用文献

- トランジスタ技術別冊 つくるシリーズ７ 手作りコンピュータ入門 CQ出版社, 1981
- [KiCad 8 入門実習テキスト『KiCad Basics for 8.0』Kosaka.Lab.出版掛](https://kosakalab.booth.pm/items/5554691)
- [intersil CDP1802AC/3データシート](https://www.renesas.com/jp/ja/www/doc/datasheet/cdp1802ac-3.pdf)
- [SB-Assembler](https://www.sbprojects.net/sbasm/)
- [COSMAC ELF - RCA CDP1802 Computing](http://www.cosmacelf.com/)
- [Compute II Issue 3: The 1802 Instruction Set](https://www.atarimagazines.com/computeii/issue3/page52.php)
- [The 1802 Membership Card](http://www.sunrise-ev.com/1802.htm)

## 利用上の注意

本サイトに掲載している回路、技術、プログラムなどは無保証です。  
これらの利用によって発生したトラブルには責任を負いかねます。自己責任にてご利用ください。  
KiCADデータおよびガーバーデータはCC BY-SA 4.0 (Copyright (C) 2024 Kazuhiro Ouchi)です。  
サンプルプログラムはMITライセンスです。  
