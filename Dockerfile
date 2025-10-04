FROM texlive/texlive:latest

# 必要なパッケージをインストール
RUN apt-get update && apt-get install -y \
    git \
    curl \
    make \
    && rm -rf /var/lib/apt/lists/*

# Node.jsとnpmをインストール（textlint用）
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs

# textlintとプラグインをグローバルインストール
RUN npm install -g \
    textlint \
    textlint-rule-preset-ja-technical-writing \
    textlint-rule-prh \
    textlint-rule-preset-ja-spacing \
    textlint-rule-spellcheck-tech-word

# 作業ディレクトリを設定
WORKDIR /workspace

# デフォルトコマンド
CMD ["bash"]