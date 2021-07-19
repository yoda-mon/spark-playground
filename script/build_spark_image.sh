#!/usr/bin/env bash

set -o pipefail
set -e
set -x

cd `dirname $0`

# Arguments
SPARK_LIB=$1        # `lib/spark-*${DATE}-${REVISION}`
REPOSITORY_NAME=$2
MULTIARCH=$3

# Parameters
SPARK_LIB_BASE=$(basename ${SPARK_LIB})
SPARK_VERSION=$(echo ${SPARK_LIB_BASE} | cut -d"-" -f2)
DATE=$(echo ${SPARK_LIB_BASE} | cut -d"-" -f5)
REVISION=$(echo ${SPARK_LIB_BASE} | cut -d"-" -f6)

REPOSITORY_FLAG=""
if [ -n "${REPOSITORY_NAME}" ]; then
  REPOSITORY_FLAG="-r ${REPOSITORY_NAME}"
fi

BUILDX_FLAG=""
if [ -n "${MULTIARCH}" ]; then
  BUILDX_FLAG="-X"
fi

CMD="./bin/docker-image-tool.sh \
  -t ${SPARK_VERSION}-${DATE}-${REVISION} \
  ${REPOSITORY_FLAG} \
  ${BUILDX_FLAG} \
  build"
echo ${CMD}

cd ../${SPARK_LIB}

eval ${CMD}