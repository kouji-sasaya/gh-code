# gh-code

## gh-code のインストール方法

このリポジトリを取得して、実行権限を付与します。

```bash
git clone <このリポジトリのURL>
cd gh-code
chmod +x gh-code
```

必要なもの:

- Docker
- Docker Compose
- Visual Studio Code
- Visual Studio Code の `code` コマンド

必要に応じて、`gh-code` を PATH の通った場所へ配置するか、カレントディレクトリから `./gh-code` として実行します。

```bash
sudo cp gh-code /usr/local/bin/gh-code
```

## gh code build での Docker イメージ作成

`gh code build` ではなく、このリポジトリに含まれる実体コマンドは `gh-code build` です。

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

そのあと、`gh-code` のスクリプトがある場所を指定して Docker イメージを build します。

```bash
/home/ubuntu/workdir/gh-code/gh-code build
```

続けて、`hello-cmake` ディレクトリを `/workdir` としてマウントしたコンテナに入ります。

```bash
/home/ubuntu/workdir/gh-code/gh-code shell
```

コンテナに入ると、カレントディレクトリは `/workdir` になります。

## gh code . でコンテナに入る方法

`gh-code .` は、`gh-code shell` で入ったコンテナの外、つまりホスト側で実行します。

`gh-code shell` で作業用コンテナに入ったあと、別ターミナルのホスト側シェルで次を実行します。

```bash
/home/ubuntu/workdir/gh-code/gh-code .
```

このコマンドは VS Code に対して、`gh-code` コンテナの `/workdir/` を開くよう指示します。

想定する一連の流れは次のとおりです。

ホスト側ターミナル 1:

```bash
git clone https://github.com/kohji-sasaya/hello-cmake
cd hello-cmake
/home/ubuntu/workdir/gh-code/gh-code build
/home/ubuntu/workdir/gh-code/gh-code shell
```

ホスト側ターミナル 2:

```bash
/home/ubuntu/workdir/gh-code/gh-code .
```

つまり、`gh-code shell` の中で `gh-code .` を実行するのではなく、`gh-code shell` の外で `gh-code .` を実行して、起動中のコンテナへ VS Code からアタッチします。

## 補足

- `gh-code shell` は `docker compose run --rm` を使うため、終了するとコンテナは削除されます。
- `gh-code .` の実行はホスト側で行います。
- `gh-code .` の実行には、VS Code と Remote Development 系の拡張機能が利用可能であることを前提とします。
- 作業ディレクトリをコンテナへ渡したい場合は、必ず対象プロジェクトのディレクトリで `gh-code shell` を実行してください。