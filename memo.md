/opt/spark/bin/spark-submit \
--master k8s://https://192.168.49.2:8443 \
--deploy-mode cluster \
--name spark-pi \
--class org.apache.spark.examples.SparkPi \
--conf spark.executor.instances=2 \
--conf spark.executor.cores=2 \
--conf spark.executor.memory=4g \
--conf spark.kubernetes.container.image=spark:v3.1.2 \
--conf spark.kubernetes.authenticate.driver.serviceAccountName=spark \
local:///opt/spark/examples/jars/spark-examples_2.12-3.1.2.jar \
100000

/opt/spark/bin/spark-submit \
--master k8s://https://192.168.49.2:8443 \
--deploy-mode cluster \
--name spark-pi \
--class org.apache.spark.examples.SparkPi \
--conf spark.executor.instances=2 \
--conf spark.kubernetes.executor.request.cores=2 \
--conf spark.kubernetes.executor.limit.cores=2 \
--conf spark.executor.memory=4g \
--conf spark.kubernetes.container.image=spark:v3.1.2 \
--conf spark.kubernetes.authenticate.driver.serviceAccountName=spark \
--conf spark.kubernetes.local.dirs.tmpfs=true \
local:///opt/spark/examples/jars/spark-examples_2.12-3.1.2.jar \
100000
