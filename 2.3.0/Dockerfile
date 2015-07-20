# Building the image using my Oracle JDK 7
FROM gelog/java:openjdk7

MAINTAINER Francois Langelier

ENV WGET_VERSION       1.15-1ubuntu1.14.04.1
# Setting HADOOP environment variables
ENV HADOOP_VERSION 2.3.0
ENV HADOOP_INSTALL /usr/local/hadoop
ENV PATH $PATH:$HADOOP_INSTALL/bin
ENV PATH $PATH:$HADOOP_INSTALL/sbin
ENV HADOOP_MAPRED_HOME $HADOOP_INSTALL
ENV HADOOP_COMMON_HOME $HADOOP_INSTALL
ENV HADOOP_HDFS_HOME $HADOOP_INSTALL
ENV HADOOP_COMMON_LIB_NATIVE_DIR $HADOOP_INSTALL/lib/native
ENV YARN_HOME $HADOOP_INSTALL
ENV HADOOP_CONF_DIR $HADOOP_INSTALL/etc/hadoop

# Installing wget
RUN \
    apt-get update && \
    apt-get install -y wget=$WGET_VERSION && \
    rm -rf /var/lib/apt/lists/*

# Installing HADOOP
RUN wget http://archive.apache.org/dist/hadoop/core/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz && \
    tar -zxf /hadoop-$HADOOP_VERSION.tar.gz && \
    rm /hadoop-$HADOOP_VERSION.tar.gz && \
    mv hadoop-$HADOOP_VERSION /usr/local/hadoop && \
    mkdir -p /usr/local/hadoop/logs

# Creating symlink for HADOOP configuration files
VOLUME /data

# Copying default HADOOP configuration files
ADD https://raw.githubusercontent.com/GELOG/docker-ubuntu-hadoop/$HADOOP_VERSION/$HADOOP_VERSION/core-site.xml $HADOOP_CONF_DIR/core-site.xml
ADD https://raw.githubusercontent.com/GELOG/docker-ubuntu-hadoop/$HADOOP_VERSION/$HADOOP_VERSION/yarn-site.xml $HADOOP_CONF_DIR/yarn-site.xml
ADD https://raw.githubusercontent.com/GELOG/docker-ubuntu-hadoop/$HADOOP_VERSION/$HADOOP_VERSION/mapred-site.xml $HADOOP_CONF_DIR/mapred-site.xml
ADD https://raw.githubusercontent.com/GELOG/docker-ubuntu-hadoop/$HADOOP_VERSION/$HADOOP_VERSION/hdfs-site.xml $HADOOP_CONF_DIR/hdfs-site.xml

CMD ["hdfs"]