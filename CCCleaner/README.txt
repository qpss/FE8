「スキルの書パッチ」スキル部分が無いと意味ないのでほぼFE8N専用

マスタープルフ以外のCCアイテムの効果をスキルの書に変えます。スキルの書システムと複数CCアイテムシステムが同居した例がないという事に気づいて作りました。
なお拙作の上限突破パッチも当てないと、スキル習得状態がセーブされません。

・一覧
0x64 大盾
0x65 祈り
0x66 見切り
0x67 練達
0x68 キャンセル
0x97 怒り
0x98 勇将
0x99 待ち伏せ
0x8A 連続
0xC1 エリート


＜補足＞
・「レベルさがった」は適当な説明に変えておきましょう。たぶん没説明文でしょうから
・CCアイテムが尽きたので10で終了ですが、保存領域的には12まで作れます。
・兵種スキルと同種の個人スキルを覚えさせてもまったく意味はありません。ゲーム内で止めてもくれないので気を付けて下さい


＜スキル制限について＞
デフォルトでは制限有り(個人スキル2種類まで習得可)状態です。兵種スキルは個人スキル制限数にはカウントされません。

無制限にしたい場合は、以下のようにEA.txtを編集してください。
```

scroll_check:
 #incbin "check.gba"
// #incbin "check_no.gba"

```
↓↓↓
```

scroll_check:
 #incbin "check_no.gba"

```
