#!/bin/bash

# ローカル環境用のtextlintセットアップスクリプト

echo "🔧 Setting up textlint for local development..."

# Node.jsがインストールされているか確認
if ! command -v node &> /dev/null; then
    echo "❌ Node.js is not installed."
    echo "Please install Node.js from https://nodejs.org/"
    exit 1
fi

echo "✅ Node.js version: $(node --version)"
echo "✅ npm version: $(npm --version)"

# textlintとプラグインをグローバルインストール
echo ""
echo "📦 Installing textlint and plugins..."
npm install -g \
    textlint \
    textlint-rule-preset-ja-technical-writing \
    textlint-rule-prh \
    textlint-rule-preset-ja-spacing \
    textlint-rule-spellcheck-tech-word

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ textlint setup completed!"
    echo ""
    echo "Usage:"
    echo "  make lint  - Run textlint check"
    echo "  make fmt   - Auto-fix issues with textlint"
    echo ""
    echo "Or use textlint directly:"
    echo "  textlint src/**/*.tex"
    echo "  textlint --fix src/**/*.tex"
else
    echo ""
    echo "❌ Installation failed."
    exit 1
fi