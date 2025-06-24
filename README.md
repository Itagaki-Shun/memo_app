# これはメモアプリです

- ユーザはメモを書いて、保存することができます。
- 保存したメモはタイトルがトップ画面に表示され、タイトルをクリックするとメモの詳細を確認することができます。
- また、保存したメモを編集、削除することができます。

# How to use
1. 作業PCの任意の作業ディレクトリにて git clone してください。

```
$ git clone https://github.com/Itagaki-Shun/memo_app.git
```

2. `memo_app`というディレクトリが作成されるため、対象のディレクトリに移動します。
3. 移動後、`psql`とTerminalに打ち込み`PostgresSQL`を起動します。
   1. 起動が成功すれば、`..~/memo_app$`から`ユーザ名=#`へ表示が変わります。
   2. `CREATE DATABASE memodb;`と打ち込み、データベースを作成する。
   3. `CREATE DATABASE`と表示されたら、`\q`と打ち込み`PostgresSQL`を終了する。

4. 移動後`ruby memo_app.rb`とTerminalに打ち込み、Sinatra を起動します。
5. 以下のような表示がエディタに表示される（VScodeの場合）ため、`ブラウザーで開く`をクリックします。

   ![image](https://github.com/user-attachments/assets/2fe62858-56a3-42b6-a98a-538df540fb3a)

   もしくは任意のブラウザーを開き`http://127.0.0.1:4567`にアクセスします。

6. メモアプリが立ち上がるので、操作を行います。(新規作成、編集、削除)
