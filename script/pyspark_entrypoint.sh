#!/usr/bin/env bash

# Set path to pyspark
export PYTHONPATH=$(ZIPS=("$SPARK_HOME"/python/lib/*.zip); IFS=:; echo "${ZIPS[*]}"):$PYTHONPATH

# exec CMD
exec "$@"