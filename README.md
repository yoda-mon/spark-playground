Apach Spark Development Environment for me.

## Build Spark
### tarball
Requirement: 
- Java
- docker (BuildX)

Fetch the latest source code.

```sh
git clone https://github.com/apache/spark.git
# OR
sh -c "cd spark; git pull"
```

Build with sbt 

```sh
bash script/build_spark_tarball.sh 
```

This will result in `lib/spark-*${DATE}-${REVISION}.tgz`.

Caution: If build failed, patch on dev/make-distribution.sh has been applied yet and you have to Undo the patch.

```sh
patch spark/dev/make-distribution.sh script/make-distribution.sh.patch -R
```
### decompress

```sh
cd lib
tar xf spark-*${DATE}-${REVISION}.tgz
```
### docker

```sh
bash script/build_spark_image.sh lib/spark-*${DATE}-${REVISION}

bash script/build_spark_image.sh lib/spark-*${DATE}-${REVISION} yodamon x  # multiarch (repository name and docker-login required)
```

## Links
- https://github.com/apache/spark.git
- https://spark.apache.org/developer-tools.html#reducing-build-times
- https://spark.apache.org/docs/latest/running-on-kubernetes.html#docker-images