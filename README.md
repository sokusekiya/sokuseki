# Sokuseki

足跡

[![CircleCI](https://circleci.com/gh/june29/sokuseki/tree/master.svg?style=svg)](https://circleci.com/gh/june29/sokuseki/tree/master)

## 開発のはじめかた

```bash
$ docker-compose up -d
$ docker container exec sokuseki_web_1 bundle exec rails db:create
$ docker container exec sokuseki_web_1 bundle exec rails db:migrate
```

