#!/usr/bin/env bash

set -o pipefail
set -e
set -x

cd `dirname $0` && cd ..

# Parameters
SPARK_SRC="./spark"                # Spark source code location
SPARK_DST="./lib"                  # Build output location
DATE=`date "+%Y%m%d"`
#HADOOP_PROFILE="hadoop-3.2"         # At this moment this will use hadoop 3.3
export SPARK_PREPEND_CLASSES=true   # Reuse compiled class before
SBT_MAX_MEM="8g"
SBT_RESERVED_CODE_CACHE="4g"

# sbt configuration
bash -c "cd ${SPARK_SRC} && patch -p1 < ../script/make-distribution.sh.patch"
cat <<EOF > ${SPARK_SRC}/.jvmopts
-Xmx${SBT_MAX_MEM}
-XX:ReservedCodeCacheSize=${SBT_RESERVED_CODE_CACHE}
EOF

cd ${SPARK_SRC}

REVISION=`git rev-parse --short HEAD`                                        # Commit hash of HEAD
TAG=`git symbolic-ref -q --short HEAD || git describe --tags --exact-match`  # Tag of the commit

# Build
./dev/make-distribution.sh \
  --name ${DATE}-${REVISION} \
  --pip \
  --tgz \
  -Phadoop-cloud \
  -Pkubernetes \
  -Pkinesis-asl \
  -Phive \
  -Phive-thriftserver

TARBALL=($(pwd)/spark-*${DATE}-${REVISION}.tgz)

# Clean Up
patch dev/make-distribution.sh ../script/make-distribution.sh.patch -R
rm .jvmopts
mv ${TARBALL} ${SPARK_DST}

echo "complete: build on ${REVISION}/${TAG}"
