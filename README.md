
```sh
python:3.11.11-slim
```

```sh
# アプリケーションコンテナ作成
bin/build.sh

# アプリケーションコンテナ実行
bin/run.sh

# djangoアプリケーション作成
django-admin startproject config .
django-admin startapp sample

# djangoアプリケーション起動
gunicorn config.wsgi -b 0
```

```sh
# Sphinxコンテナ実行
bin/sphinx.sh

sphinx-quickstart
```
