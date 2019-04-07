# 自己証明書を作成・適用したapacheDockerイメージ

## 確認環境
- Windows10 Home  
- VirtualBox 5.2.6  
- Vagrant 2.0.2

## 実行手順
1. 本リポジトリをクローンする(初回のみ)
1. ゲスト(CoreOS)とのファイル共有を行う(初回のみ)
    1. Windowsでnfsを利用できるよう下記を実行(Windowsのみ)  
    ```vagrant plugin install vagrant-winnfsd```
    1. Vagrantfileに必ず下記を記述する
       1. config.vm.networkを記述  
      例）```config.vm.network "private_network", ip: "192.168.100.2"```
       1. config.vm.synced_folderを記述  
      例）```config.vm.synced_folder ".", "/home/core/share", type: "nfs"```
1. コマンドプロンプトで仮想サーバーの起動を行う  
    ```vagrant up```
1. 仮想サーバーにログインする 
    ```vagrant ssh```
1. Dockerfileをビルドする
    1. 共有フォルダに移動する  
       ```cd /home/core/share```
    1. ビルドする(イメージ名をmy-apache2とする)   
       ```docker build -t my-apache2 .```
1. ビルドしたイメージを実行する  
  ```docker run --rm -p 80:80 -p 443:443 -d -t --name my-running-app my-apache2```
1. ブラウザで下記を試す
  1. ```http://localhost```にアクセスし、「It works!」が表示されることを確認
  1. ```https://localhost```にアクセスし、警告ページが表示されることを確認
1. 検証が終わったら終了する
    1. コンテナを終了する  
       ```docker stop my-running-app```
    1. 仮想サーバーをログアウトする  
       ```exit```
    1. 仮想サーバーを停止する  
       ```vagrant halt```

## 参考資料
* [Azure クラウドサービスの開発時に使えるオレオレ証明書をopensslで作るワンライナー](https://qiita.com/qyen/items/8678189d27d4e075482b)
