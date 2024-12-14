
```sh
python:3.11.11-slim
```

```sh
# アプリケーションコンテナ作成
docker build -t trial-django_app:0.1 docker/app

# アプリケーションコンテナ実行
docker run -it --rm \
    -h trial-django_app \
    -p "3000:8000" \
    -v "./src/:/opt/app/src/" \
    -w "/opt/app/src/main" \
    trial-django_app:0.1 /bin/bash

# djangoアプリケーション作成
django-admin startproject config .
django-admin startapp sample

# djangoアプリケーション起動
gunicorn config.wsgi -b 0
```

```sh
# Sphinxコンテナ実行
docker run -it --rm \
    -h sphinx \
    -v "./doc/:/docs/" \
    sphinxdoc/sphinx:5.0.1 /bin/bash

sphinx-quickstart
```
