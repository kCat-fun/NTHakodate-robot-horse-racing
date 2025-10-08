# textlint セットアップと使い方

## 📝 概要

このプロジェクトでは textlint を使用して、LaTeX 文書の日本語チェックを行います。

## 🚀 ローカル環境のセットアップ

### 方法: Dockerを使用

```bash
# textlintチェックを実行
make lint

# 自動修正
make fmt
```

## 📋 使い方

### ローカルでのチェック

```bash
# Docker経由
make lint          # チェックのみ
make fmt           # 自動修正
```

### ビルド時のチェック

```bash
# ビルド前に自動的にtextlintチェックが実行されます
make build
```

## 🔍 チェック内容

### 基本ルール（preset-ja-technical-writing）
- 一文の長さ（最大150文字）
- 二重助詞のチェック
- 読点の数（最大5個/文）
- 技術文書として適切な表現

### スペーシングルール（preset-ja-spacing）
- 半角文字と全角文字の間にスペース
- コードブロック前後のスペース

### 表記ゆれチェック（prh）
- よくある誤字・脱字
- 技術用語の表記統一
- 数字と単位の間のスペース

### 技術用語スペルチェック
- プログラミング言語名
- フレームワーク名
- その他の技術用語

## ⚙️ カスタマイズ

### ルールの調整

`.textlintrc.json` を編集してルールを調整できます。   
例：
```json
{
  "rules": {
    "preset-ja-technical-writing": {
      "sentence-length": {
        "max": 150  // 一文の最大文字数を変更
      }
    }
  }
}
```

### 表記ゆれの追加

`.textlintrc.prh.yml` に独自の表記ルールを追加できます：

```yaml
rules:
  - expected: ロボット
    patterns:
      - ロボト
      - ろぼっと
```

## 🤖 GitHub Actions での自動チェック

### メインワークフロー（build-and-upload.yml）
- `main`/`master` ブランチへのpush時
- Pull Request作成時
- 手動実行時

実行フロー:
1. textlint チェック
2. PDF ビルド（textlintが成功した場合のみ）
3. Google Drive アップロード

### Pull Request専用チェック（textlint.yml）
- Pull Request作成時に `.tex` ファイルが変更された場合
- チェックに失敗すると、PRにコメントで結果を通知

## 📚 参考資料

- [textlint 公式ドキュメント](https://textlint.github.io/)
- [preset-ja-technical-writing](https://github.com/textlint-ja/textlint-rule-preset-ja-technical-writing)
- [prh（表記ゆれ検出）](https://github.com/textlint-rule/textlint-rule-prh)

## 💡 トラブルシューティング

### textlintがエラーになる場合

1. Docker イメージを再ビルド
```bash
make init
```

2. 設定ファイルの確認
```bash
# 設定ファイルが正しく存在するか確認
ls -la .textlintrc.json .textlintrc.prh.yml
```

3. 特定のルールを無効化
```json
// .textlintrc.json
{
  "rules": {
    "問題のあるルール名": false
  }
}
```

### よくある質問

**Q: 特定のファイルをチェック対象外にしたい**

A: `.textlintignore` ファイルを作成してください：
```
src/generated/*.tex
src/old/*.tex
```

**Q: 特定の行だけチェックを無効化したい**

A: コメントで無効化できます：
```latex
% textlint-disable
この行はチェックされません
% textlint-enable
```