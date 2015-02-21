# Building the image using my Oracle JDK 7
FROM gelog/java:oraclejdk7

# Installing HADOOP 2.3.0
ADD http://archive.apache.org/dist/hadoop/core/hadoop-2.3.0/hadoop-2.3.0.tar.gz /
RUN sudo tar -zxf /hadoop-2.3.0.tar.gz
RUN sudo rm /hadoop-2.3.0.tar.gz
RUN sudo mv /hadoop-2.3.0 /usr/local
RUN sudo ln -s /usr/local/hadoop-2.3.0 /usr/local/hadoop

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
### TMP FOR TESTING PURPOSE
ADD https://raw.githubusercontent.com/GELOG/docker-ubuntu-hadoop/master/config/core-site.xml $HADOOP_INSTALL/etc/hadoop/core-site.xml
ADD https://raw.githubusercontent.com/GELOG/docker-ubuntu-hadoop/master/config/yarn-site.xml $HADOOP_INSTALL/etc/hadoop/yarn-site.xml
ADD https://raw.githubusercontent.com/GELOG/docker-ubuntu-hadoop/master/config/mapred-site.xml $HADOOP_INSTALL/etc/hadoop/mapred-site.xml
ADD https://raw.githubusercontent.com/GELOG/docker-ubuntu-hadoop/master/config/hdfs-site.xml $HADOOP_INSTALL/etc/hadoop/hdfs-site.xml
