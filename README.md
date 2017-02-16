# frontenv.sh

フロントエンドのローカル開発でNodeのバージョンやyarnのインストールの有無などを確認する手順を省きたくなったので書いたシェルスクリプト

## Usage

frontenv.shを開いて `REQUIRE_NODE_VERSION="v6.9.5"` の部分を固定したいNodeのバージョンを記載

`./frontenv.sh` を実行

※ 実行権限がないときは `chmod +x ./frontenv.sh` を

## Flow

1. 古いpkgでインストールされたのNodeを削除
2. 最近のpkgでインストールされたNodeを削除
3. Homebrewをインストール
4. Nodebrewをインストール
5. 指定バージョンをインストール
6. npmのglobalインストールされたyarnを削除
7. Homebrewでyarnをインストール

※ インストール済みの内容はスキップされます
