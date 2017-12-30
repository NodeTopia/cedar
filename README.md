# cedar




## build the app
```bash
docker run -it -e APP_URL=https://play.minio.io:9000/herokuish/app.tar \
 -e CACHE_URL=https://play.minio.io:9000/herokuish/cache.tar \
 -e APP_UPLOAD_PATH=herokuish/build.tar \
 -e CACHE_UPLOAD_PATH=herokuish/cache.tar mangoraft/cedar:builder
```

## run the app
```bash
docker run -it mangoraft/cedar:runner /run.sh web https://play.minio.io:9000/herokuish/build.tar
```