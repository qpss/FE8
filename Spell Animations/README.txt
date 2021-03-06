使い方


自作魔法スクリプトをexeにドラッグすると.eventといくつかの.binファイルが生成される。あなたのEA用ファイルに "Master Spell Animation Installer.event"を含めているのを確かめたら、"Master Spell Animation Installer.event"に変換された自作魔法ファイルを追加する。

自作魔法は追加の空きテーブル(0x13EC Bytes)に挿入される。（これは自分で指定可能なので、あなたの都合によりアドレス指定を変えても良い）自作魔法をどの魔法を置き換えるか指定したり、画面を暗くする(dim)としない(no_dim)を切り換えるには、出力された各自作魔法.eventファイルを編集する。

スクリプトの形式:

いくつかの種類がある。

Cコマンド: 種類が多いので、後にまとめてある。

画像を表示するのに必要なのは3行である。(FEditorと異なり p- は必須では無い)
O [Object_image.png]
B [Background_image.png]
[持続フレーム(10進数指定)]


Object 画像:
480x160pxサイズの画像(GBAの画面二つ分)。全部の画像が同じ16色のパレットであり、さらにパレットの順序も同じでなくてはならないし、最初のパレットが背景色であることが必要。(注意: 透過色を持つPNGの使用には問題がある。背景を単色にするのが最も良い。)

左の240pxは、戦闘アニメの前面に映され、右の240pxは戦闘アニメより後方に映される。表示出来るのは合わせて128のタイルまでだが、この時点で重複は検出されない。


Background 画像:
240x160pxサイズの画像(GBAの画面一つ分)。各画像は独自の16色パレットを使える。256タイル全てを使えるし(訳注：実際には256タイルは使えないらしい。全面に出したい画像は拡大を利用する)、画像の反転や回転などの機能も使える。また、Cコマンドの"CXXYY29"で、明るさと透明度が設定出来る。XXが明るさで、YYが透明度である。
戦闘アニメより前面に映されるが、戦闘情報ウィンドウ等よりは後ろに映る。




////////////// FEditor's CSA docより引用 ///////////////////////////////

以下は、スペルアニメーションのフォーマットの説明です。 「*」と記された項目は必須です。 「frames」という項目はオプションのアニメーションフレームです。

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
必須コマンド
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

C000040	- (スクリーン移動; 必須、無かったら酷いことになる)
ディレイの為の空きフレーム*	- (魔道士のようなアニメーションの中には、スペルアニメーション用に割り当てられたVRAMを使用するものがあるので、最初の数フレームが経過するまでスペルアニメーションの読み込みは避ける)
frames
C00001A*
C00001F	- (半必須。これはヒット音を鳴らすもの;すべての1Aコマンドに付随する必要がある)
frames
~	- ("ミス"終了; 発動者がミスしてこれに達するとアニメーションが終了する。これは00001Aコマンドの後に行わなければならない) --CIRCLE補足: YES, IT DOES
frames

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

重要な補足:

攻撃ヒット命令が複数あると問題を起こす。なので、コマンド0x51（81）は、2ヒット以上の演出をしたい場合は実際にHPを減らす命令は一つにして、他はヒットエフェクトだけの命令を使う事。

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Command format
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

CXXYYZZ

ZZ が一番重要なコマンドID
XX は補足の値
YY はさらに補足的な値

先頭のCはコマンドデータであることを示す。これはアニメーションスクリプト(txt)に必須。スクリプトを使わない場合は逆に"C"が付いてはいけない。

XXYYは、使わないコマンドでは無意味なので、何が入っていても無視されます

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Command list
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

0x00 ～ 0x13 (0x08以外) - 効果無し

0x08 HPを奪う攻撃 (クリティカル時は自動で変化する)

0x14 ～ 0x28 - 発動者のアニメに渡される?;(発動者と術アニメの組み合わせは、競合が起こらない必要がある?(it is recommended that all possible caster/spell animation combinations are considered such that no combination conflicts)

0x29 背景の明るさと不透明度を設定します。
  引数XXは0〜100％の輝度レベル（0x0〜0x10）です。
  引数YYは100％から50％の不透明度（0x0〜0x10）です。

0x2A 戦闘中の背景を表示するかを設定します。YYが0なら表示する、0以外なら表示しません。

0x2B ～ 0x3F - 発動者のアニメに渡される?

0x40 術発動者から攻撃対象にカメラ移動します。1回しか使えません。

0x41 ～ 0x47 - 発動者のアニメに渡される?

0x48 音楽・効果音を再生します。XXYYは16ビットの音IDです。

0x49 ～ 0x52 - 発動者のアニメに渡される?

0x53 - C000153でscreen stretchingをオンにする。C000053でオフにする

0x54 ～ 0xFF - 効果無し

