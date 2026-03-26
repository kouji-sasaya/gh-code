# gh-code


Visual Stuio Code の remote development extensionのDev Containerの機能を集約したコマンドです。

gh code build で、docker イメージをビルドして、ローカルマシンに作ります。

gh code shell で、docker コンテナを起動します。

vimを使いたい人もいるので、Visuial Studio Codeの利用を必須としたくないため、デーモンのコンテナにはしませんでした。

gh code . で開くと、Visual Codeが立ち上がり、docker コンテナに接続しましす。

コンテナ内で、GitHub copilot も使えることを確認済です。

## gh code のインストール方法

このリポジトリを取得して、実行権限を付与します。

```bash
gh ext kohji-sasaya/gh-code
```

必要なもの:

- Docker
- Docker Compose
- Visual Studio Code の `code` コマンド

## gh code build での Docker イメージ作成

このコマンドは [docker-compose.yml](docker-compose.yml) を使って `gh-code` という Docker イメージを build します。

```bash
gh-code build
```

内部では次のコマンドを実行します。

```bash
docker compose -f ./docker-compose.yml build
```

build が成功すると、`gh-code` コンテナを起動する準備が整います。

## hello-cmake を clone してコンテナに入る方法

作業用のディレクトリで、`hello-cmake` を clone します。

```bash
git clone https://github.com/kohji-sasaya/hello-cmake
cd hello-cmake
```

続けて、`hello-cmake` ディレクトリを `/workdir` としてマウントしたコンテナに入ります。

```bash
gh code shell
```

コンテナに入ると、カレントディレクトリは `/workdir` になります。

## gh code . でコンテナに入る方法

`gh-code .` は、`gh-code shell` で入ったコンテナの外、つまりホスト側で実行します。

`gh-code shell` で作業用コンテナに入ったあと、別ターミナルのホスト側シェルで次を実行します。

```bash
gh code .
```

このコマンドは VS Code に対して、`gh-code` コンテナの `/workdir/` を開くよう指示します。

想定する一連の流れは次のとおりです。

ホスト側ターミナル 1:

```bash
git clone https://github.com/kohji-sasaya/hello-cmake
cd hello-cmake
gh code build
gh code shell
```

ホスト側ターミナル 2:

```bash
gh code .
```

つまり、`gh code shell` の中で `gh code .` を実行するのではなく、`gh- ode shell` の外で `gh code .` を実行して、起動中のコンテナへ VS Code からアタッチします。

## 補足

- `gh code shell` は `docker compose run --rm` を使うため、終了するとコンテナは削除されます。
- `gh code .` の実行はホスト側で行います。
- `gh code .` の実行には、VS Code と Remote Development 系の拡張機能が利用可能であることを前提とします。
- 作業ディレクトリをコンテナへ渡したい場合は、必ず対象プロジェクトのディレクトリで `gh-code shell` を実行してください。
