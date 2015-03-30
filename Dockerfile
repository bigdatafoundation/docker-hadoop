# Building the image using my Oracle JDK 7
FROM gelog/java:openjdk7

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

# Installing HADOOP
ADD http://archive.apache.org/dist/hadoop/core/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz /
RUN tar -zxf /hadoop-$HADOOP_VERSION.tar.gz
RUN rm /hadoop-$HADOOP_VERSION.tar.gz
RUN mv /hadoop-$HADOOP_VERSION /usr/local/hadoop
RUN mkdir -p /usr/local/hadoop/logs

# Creating symlink for HADOOP configuration files
VOLUME /data
RUN ln -fs /data/conf/core-site.xml /usr/local/hadoop/etc/hadoop/core-site.xml
RUN ln -fs /data/conf/yarn-site.xml /usr/local/hadoop/etc/hadoop/yarn-site.xml
RUN ln -fs /data/conf/mapred-site.xml /usr/local/hadoop/etc/hadoop/mapred-site.xml
RUN ln -fs /data/conf/hdfs-site.xml /usr/local/hadoop/etc/hadoop/hdfs-site.xml

# Copying default HADOOP configuration files
ADD https://raw.githubusercontent.com/GELOG/docker-ubuntu-hadoop/$HADOOP_VERSION/env/local/core-site.xml /data/conf/core-site.xml
ADD https://raw.githubusercontent.com/GELOG/docker-ubuntu-hadoop/$HADOOP_VERSION/env/local/yarn-site.xml /data/conf/yarn-site.xml
ADD https://raw.githubusercontent.com/GELOG/docker-ubuntu-hadoop/$HADOOP_VERSION/env/local/mapred-site.xml /data/conf/mapred-site.xml
ADD https://raw.githubusercontent.com/GELOG/docker-ubuntu-hadoop/$HADOOP_VERSION/env/local/hdfs-site.xml /data/conf/hdfs-site.xml
