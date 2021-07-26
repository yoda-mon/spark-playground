FROM ubuntu:20.04

ARG SPARK_LIB

ENV SPARK_HOME="/opt/spark"
# Skip tzdata interactive setup
ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y \
  openjdk-11-jdk \
  python3-dev \
  python3-pip

# PySpark required libraries
RUN pip install \
  pandas \
  numpy \
  pyarrow \
  py4j

COPY $SPARK_LIB $SPARK_HOME
COPY ./pyspark_entrypoint.sh /root/pyspark_entrypoint.sh
RUN chmod +x /root/pyspark_entrypoint.sh

WORKDIR /workdir

ENTRYPOINT ["/root/pyspark_entrypoint.sh"]

# Extra libraries
RUN pip install \
  jupyterlab \
  matplotlib \
  plotly
