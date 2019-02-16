# Sokuseki

足跡

[![CircleCI](https://circleci.com/gh/june29/sokuseki/tree/master.svg?style=svg)](https://circleci.com/gh/june29/sokuseki/tree/master)

## 開発のはじめかた

### 開発環境の起動する

```bash
$ docker-compose up -d
$ docker-compose run --rm web bin/rails db:create db:migrate
```

### GitHub Enterpriseの情報を取得して、個人ページを表示する
https://github.example.com/settings/applications/new で、Oauth Appを作成して、`Client ID`, `Client Secret`を取得する

`.env` ファイルを作成する

```bash
$ echo GHE_APP_KEY="YOUR_CLIENT_ID" >> .env
$ echo GHE_APP_SECRET="YOUR_CLIENT_SECRET" >> .env
$ echo GHE_HOST="github.example.com" >> .env
```

Dockerを起動し直してからサインインすると、個人ページが表示できる

