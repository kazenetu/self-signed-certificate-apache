# 自己証明書を作成・適用したapacheDockerイメージ

## 確認環境
- Windows10 Home  
- VirtualBox 5.2.6  
- Vagrant 2.0.2

## 実行手順
1. 本リポジトリをクローンする
1. コマンドプロンプトで仮想サーバーの起動を行う  
    ```vagrant up```
1. 仮想サーバーにログインする 
    ```vagrant ssh```
1. Dockerfileをビルドする(イメージ名をmy-apache2とする)  
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
