# gh-code


Visual Stuio Code の remote development extensionのDev Containerを利用するためのコマンドです。

github copilot も使えました。



## gh code のインストール/アンインストール/アップグレード方法

gh コマンドで、拡張コマンドをインストールします。

```sh
$ gh ext install kohji-sasaya/gh-rust
$ gh ext install kohji-sasaya/gh-code
```

```sh
$ gh ext remove kohji-sasaya/gh-rust
$ gh ext remove kohji-sasaya/gh-code
```

```sh
$ gh ext upgrade gh-rust
$ gh ext upgrade gh-code
```

## 使い方

gh rust は、rust プログラミングの学習用のdocker コンテナです。

gh rust を起動して、gh code で、Visual Studio CodeにRemote Development の Dev Containerで接続します。

```sh
$ mkdir my-code && cd my-code
$ gh rust shell
```

gh rust コンテナ内に入った後、
```sh
$ cargo init
$ cargo build
$ cargo run -q
Hello, world!
```


```sh
$ docker ps -a
CONTAINER ID   IMAGE     COMMAND            CREATED         STATUS         PORTS     NAMES
b1426245ec91   gh-rust   "/entrypoint.sh"   5 minutes ago   Up 5 minutes             gh-rust
```

```

```sh
$ 
$ gh code <container name>
```




