# valdcli-linux-docker
すぐvald疎通確認したい時のためにつくりました。  
本家のがちょっと使いにくそうだったので思い切って車輪を再発明しました（笑）

## 参考
* vald  
分散密ベクトル探索エンジン(Yahoo!)  
https://github.com/vdaas/vald

* valdクライアントツール  
GraalVMを利用した高速起動時間のCLIツール  
https://github.com/vdaas/vald-client-clj#valdcli

* valdクライアントツール  
イメージに内包したネイティブバイナリ  
https://github.com/vdaas/vald-client-clj/releases/tag/v0.0.45.Rev1

## Dockerイメージをビルドする
イメージ構築
```
docker build . -t orinbou/valdcli-linux
```
結果確認
```
docker image list
REPOSITORY               TAG          IMAGE ID            CREATED             SIZE
orinbou/valdcli-linux    latest       XXXXXXXXXXXX        18 seconds ago      61.7MB
```
実行確認
```
docker container  run -it orinbou/valdcli-linux:latest /bin/bash
```

## DockerイメージをdockerhubへPushする
https://hub.docker.com/repository/docker/orinbou/valdcli-linux
```
docker push orinbou/valdcli-linux
The push refers to repository [docker.io/orinbou/valdcli-linux]
XXXXXXXXXXXX: Pushed
```

## DockerイメージをdockerhubからPullする
https://hub.docker.com/repository/docker/orinbou/valdcli-linux
```
docker pull orinbou/valdcli-linux:latest
```

## k8sで実行する
※終了と同時にコンテナを破棄する
```
kubectl run valdcli-linux --rm -ti -n myname --image=orinbou/valdcli-linux -- /bin/sh
```

## 疎通確認する
vald疎通確認一時コンテナを起動
```
kubectl run valdcli-linux --rm --restart=Never -ti -n myname --image=orinbou/valdcli-linux -- /bin/sh
```
valdへの疎通を確認する
```
./valdcli -h [Service名].[Namespace名].svc.[ClusterDomain名] -p [Port番号] insert --json xyz "[0.1, 0.2, 0.3, 0.4, 0.5, 0.6]"
inserted.
./valdcli -h [Service名].[Namespace名].svc.[ClusterDomain名] -p [Port番号] insert --json xyz "[0.1, 0.2, 0.3, 0.4, 0.5, 0.6]"
ALREADY_EXISTS: Insert API meta xyz already exists
```
※正式なFQDNは、[Service名].[Namespace名].svc.[ClusterDomain名]

## 参考
* KubernetesのDiscovery＆LBリソース（その1）  
https://thinkit.co.jp/article/13738
