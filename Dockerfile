# Building the image using my Oracle JDK 7
FROM gelog/java:openjdk7

# Installing HADOOP
ENV HADOOP_VERSION 2.6.0
ADD http://archive.apache.org/dist/hadoop/core/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz /
RUN sudo tar -zxf /hadoop-$HADOOP_VERSION.tar.gz
RUN sudo rm /hadoop-$HADOOP_VERSION.tar.gz
RUN sudo mv /hadoop-$HADOOP_VERSION /usr/local
RUN sudo ln -s /usr/local/hadoop-$HADOOP_VERSION /usr/local/hadoop

# Setting HADOOP environment variables
ENV HADOOP_INSTALL /usr/local/hadoop
ENV PATH $PATH:$HADOOP_INSTALL/bin
ENV PATH $PATH:$HADOOP_INSTALL/sbin
ENV HADOOP_MAPRED_HOME $HADOOP_INSTALL
ENV HADOOP_COMMON_HOME $HADOOP_INSTALL
ENV HADOOP_HDFS_HOME $HADOOP_INSTALL
ENV HADOOP_COMMON_LIB_NATIVE_DIR $HADOOP_INSTALL/lib/native
ENV YARN_HOME $HADOOP_INSTALL

# Setting JAVA_HOME environment variable for HADOOP
RUN sed -i 's/JAVA_HOME=${JAVA_HOME}/JAVA_HOME=\/usr\/lib\/jvm\/jdk/g' /usr/local/hadoop/etc/hadoop/hadoop-env.sh

# Creating HDFS directories
RUN mkdir -p /hdfs-volume/namenode
RUN mkdir -p /hdfs-volume/datanode

# Copying HADOOP configuration files
ADD https://raw.githubusercontent.com/GELOG/docker-ubuntu-hadoop/config-1.0.0/config/core-site.xml $HADOOP_INSTALL/etc/hadoop/core-site.xml
ADD https://raw.githubusercontent.com/GELOG/docker-ubuntu-hadoop/config-1.0.0/config/yarn-site.xml $HADOOP_INSTALL/etc/hadoop/yarn-site.xml
ADD https://raw.githubusercontent.com/GELOG/docker-ubuntu-hadoop/config-1.0.0/config/mapred-site.xml $HADOOP_INSTALL/etc/hadoop/mapred-site.xml
ADD https://raw.githubusercontent.com/GELOG/docker-ubuntu-hadoop/config-1.0.0/config/hdfs-site.xml $HADOOP_INSTALL/etc/hadoop/hdfs-site.xml
