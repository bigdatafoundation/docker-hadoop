FROM ubuntu:14.04.1

MAINTAINER Francois Langelier

ENV WGET_VERSION       1.15-1ubuntu1.14.04.1
# Setting HADOOP environment variables
ENV HADOOP_VERSION 2.6.0
ENV HADOOP_INSTALL /usr/local/hadoop
ENV PATH $PATH:$HADOOP_INSTALL/bin
ENV PATH $PATH:$HADOOP_INSTALL/sbin
ENV HADOOP_MAPRED_HOME $HADOOP_INSTALL
ENV HADOOP_COMMON_HOME $HADOOP_INSTALL
ENV HADOOP_HDFS_HOME $HADOOP_INSTALL
ENV HADOOP_COMMON_LIB_NATIVE_DIR $HADOOP_INSTALL/lib/native
ENV YARN_HOME $HADOOP_INSTALL
ENV HADOOP_CONF_DIR $HADOOP_INSTALL/etc/hadoop
ENV JAVA_VERSION 7u79-2.5.6-0ubuntu1.14.04.1
ENV JAVA_HOME /usr/lib/jvm/jdk


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

# Install Java.
RUN \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y openjdk-7-jdk=$JAVA_VERSION && \
    ln -s /usr/lib/jvm/java-7-openjdk-amd64 /usr/lib/jvm/jdk && \
    rm -rf /var/lib/apt/lists/*

# Creating symlink for HADOOP configuration files
VOLUME /data

# Copying default HADOOP configuration files
ADD core-site.xml $HADOOP_CONF_DIR/core-site.xml
ADD yarn-site.xml $HADOOP_CONF_DIR/yarn-site.xml
ADD mapred-site.xml $HADOOP_CONF_DIR/mapred-site.xml
ADD hdfs-site.xml $HADOOP_CONF_DIR/hdfs-site.xml


####################
# PORTS
####################
#
# http://docs.hortonworks.com/HDPDocuments/HDP2/HDP-2.3.0/bk_HDP_Reference_Guide/content/reference_chap2.html
# http://www.cloudera.com/content/cloudera/en/documentation/core/latest/topics/cdh_ig_ports_cdh5.html
# http://hadoop.apache.org/docs/current/hadoop-project-dist/hadoop-common/core-default.xml
# http://hadoop.apache.org/docs/current/hadoop-project-dist/hadoop-hdfs/hdfs-default.xml

# HDFS: NameNode (NN):
#	 8020 = fs.defaultFS			(IPC / File system metadata operations)
#						(9000 is also frequently used alternatively)
#	 8022 = dfs.namenode.servicerpc-address	(optional port used by HDFS daemons to avoid sharing RPC port)
#       50070 = dfs.namenode.http-address	(HTTP  / NN Web UI)
#	50470 = dfs.namenode.https-address	(HTTPS / Secure UI)
# HDFS: DataNode (DN):
#	50010 = dfs.datanode.address		(Data transfer)
#	50020 = dfs.datanode.ipc.address	(IPC / metadata operations)
#	50075 = dfs.datanode.http.address	(HTTP  / DN Web UI)
#	50475 = dfs.datanode.https.address	(HTTPS / Secure UI)
# HDFS: Secondary NameNode (SNN)
#	50090 = dfs.secondary.http.address	(HTTP / Checkpoint for NameNode metadata)
EXPOSE 9000 50070 50010 50020 50075 50090

CMD ["hdfs"]
