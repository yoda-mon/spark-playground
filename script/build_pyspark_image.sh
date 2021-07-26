#!/usr/bin/env bash

set -o pipefail
set -e
set -x

cd `dirname $0`

# Arguments
SPARK_LIB=$1        # `lib/spark-*${DATE}-${REVISION}`

# Parameters
SPARK_LIB_BASE=$(basename ${SPARK_LIB})
SPARK_VERSION=$(echo ${SPARK_LIB_BASE} | cut -d"-" -f2)
DATE=$(echo ${SPARK_LIB_BASE} | cut -d"-" -f5)
REVISION=$(echo ${SPARK_LIB_BASE} | cut -d"-" -f6)

# Context preparation
CONTEXT="/tmp/context"
if [ -d ${CONTEXT} ]; then
    rm -r ${CONTEXT}
fi
mkdir -p ${CONTEXT}/spark
cp -R ../lib/${SPARK_LIB_BASE}/* ${CONTEXT}/spark/
cp pyspark.dockerfile ${CONTEXT}
cp pyspark_entrypoint.sh ${CONTEXT}

cd ${CONTEXT}

docker build \
  -t pyspark:${SPARK_VERSION}-${DATE}-${REVISION} \
  -f pyspark.dockerfile \
  --build-arg SPARK_LIB="spark" \
  .