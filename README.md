# Docker image for Hadoop
![hadoop logo](https://hadoop.apache.org/images/hadoop-logo.jpg)

[ ![issues](https://img.shields.io/github/issues/gelog/docker-ubuntu-hadoop.svg) ](https://github.com/gelog/docker-ubuntu-hadoop)

## Supported tags and respective `Dockerfile` links
- [`2.6.0`/Dockerfile](https://github.com/GELOG/docker-ubuntu-hadoop/tree/2.6.0/Dockerfile)
- [`2.5.2`/Dockerfile](https://github.com/GELOG/docker-ubuntu-hadoop/tree/2.5.2/Dockerfile)
- [`2.5.1`/Dockerfile](https://github.com/GELOG/docker-ubuntu-hadoop/tree/2.5.1/Dockerfile)
- [`2.5.0`/Dockerfile](https://github.com/GELOG/docker-ubuntu-hadoop/tree/2.5.0/Dockerfile)
- [`2.4.1`/Dockerfile](https://github.com/GELOG/docker-ubuntu-hadoop/tree/2.4.1/Dockerfile)
- [`2.4.0`/Dockerfile](https://github.com/GELOG/docker-ubuntu-hadoop/tree/2.4.0/Dockerfile)
- [`2.3.0`/Dockerfile](https://github.com/GELOG/docker-ubuntu-hadoop/tree/2.3.0/Dockerfile)


## What is Hadoop?
The Apache™ Hadoop® project develops open-source software for reliable, scalable, distributed computing.

The Apache Hadoop software library is a framework that allows for the distributed processing of large data sets across clusters of computers using simple programming models. It is designed to scale up from single servers to thousands of machines, each offering local computation and storage. Rather than rely on hardware to deliver high-availability, the library itself is designed to detect and handle failures at the application layer, so delivering a highly-available service on top of a cluster of computers, each of which may be prone to failures.

[http://hadoop.apache.org/](http://hadoop.apache.org/)


## What is Docker?
Docker is an open platform for developers and sysadmins to build, ship, and run distributed applications. Consisting of Docker Engine, a portable, lightweight runtime and packaging tool, and Docker Hub, a cloud service for sharing applications and automating workflows, Docker enables apps to be quickly assembled from components and eliminates the friction between development, QA, and production environments. As a result, IT can ship faster and run the same app, unchanged, on laptops, data center VMs, and any cloud.

[https://www.docker.com/whatisdocker/](https://www.docker.com/whatisdocker/)

### What is a Docker Image?
Docker images are the basis of containers. Images are read-only, while containers are writeable. Only the containers can be executed by the operating system.

[https://docs.docker.com/terms/image/](https://docs.docker.com/terms/image/)


## How to use this image?


### Starting the NameNode
This command starts a container for the HDFS NameNode in the background, and starts tailing its logs.

	docker run -d --name hdfs-namenode \
		-h hdfs-namenode -p 50070:50070 \
		gelog/hadoop hdfs namenode && \
	docker logs -f hdfs-namenode

If everything looks good in the logs (no errors), hit `CTRL + C` to detach the console from the logs.


### Starting a DataNode
This command starts a separate container for the HDFS DataNode in the background, link it with the NameNode container, and starts tailing its logs.

	docker run -d --name hdfs-datanode1 \
		-h hdfs-datanode1 -p 50075:50075 \
		--link=hdfs-namenode:hdfs-namenode \
		gelog/hadoop hdfs datanode && \
	docker logs -f hdfs-datanode1

If everything looks good in the logs (no errors), hit `CTRL + C` to detach the console from the logs.


### Starting a Secondary NameNode
This command starts a separate container for the HDFS Secondary NameNode in the background, link it with the NameNode container, and starts tailing its logs.

	docker run -d --name hdfs-secondarynamenode \
		-h hdfs-secondarynamenode -p 50090:50090 \
		--link=hdfs-namenode:hdfs-namenode \
		gelog/hadoop hdfs secondarynamenode && \
	docker logs -f hdfs-secondarynamenode

If everything looks good in the logs (no errors), hit `CTRL + C` to detach the console from the logs.


### Starting YARN
This command starts a container for the YARN system in background. It links with the NameNode, the Datanode.
The start-yarn.sh script starts a YARN Node manager and a YARN Resource Manager. 

```
docker run -d --name yarn \
		-h yarn \
		-p 8088:8088 \
     	-p 8042:8042 \
		--link=hdfs-namenode:hdfs-namenode \
		--link=hdfs-datanode1:hdfs-datanode1 \
		-v $HOME/data/hadoop/hdfs:/data \
		gelog/hadoop start-yarn.sh && \
docker logs -f yarn
```



### Submit a Map Reduce job 

#### Put some data in HDFS
```
docker run --rm \
        --link=hdfs-namenode:hdfs-namenode \
        --link=hdfs-datanode1:hdfs-datanode1 \
        gelog/hadoop \
        hadoop fs -put /usr/local/hadoop/README.txt /README.txt
```
#### Start wordcount example

This runs the word count example.
```
docker run --rm \
        --link yarn:yarn \
        --link=hdfs-namenode:hdfs-namenode \
        gelog/hadoop \
        hadoop jar /usr/local/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-examples-2.6.0.jar wordcount  /README.txt /README.result

```

If README.result already exists you need to remove it prior running the map reduce job.

```
docker run --rm --link=hdfs-namenode:hdfs-namenode \
        --link=hdfs-datanode1:hdfs-datanode1 \
        gelog/hadoop \
        hadoop fs -rm -R -f /README.result
```


#### Check the result
```
docker run --rm --link=hdfs-namenode:hdfs-namenode \
        --link=hdfs-datanode1:hdfs-datanode1 \
        gelog/hadoop \
        hadoop fs -cat /README.result/\*
```

### Accessing the web interfaces
Each component provide its own web UI. Open you browser at one of the URLs below, where `dockerhost` is the name / IP of the host running the docker daemon. If using Linux, this is the IP of your linux box. If using OSX or Windows (via Boot2docker), you can find out your docker host by typing `boot2docker ip`. On my machine, the NameNode UI is accessible at `http://192.168.59.103:50070/`

| Component               | Port                                               |
| ----------------------- | -------------------------------------------------- |
| HDFS NameNode           | [http://dockerhost:50070](http://dockerhost:50070) |
| HDFS DataNode           | [http://dockerhost:50075](http://dockerhost:50075) |
| HDFS Secondary NameNode | [http://dockerhost:50090](http://dockerhost:50090) |
| YARN Resource Manager   | [http://dockerhost:8088](http://dockerhost:8088) |
| YARN Node Manager   | [http://dockerhost:8042](http://dockerhost:8042) |


## Use this image using docker-compose
Note: your terminal need to be in the folder where the docker-compose.yml is located.

You can start this image using docker-compose. It will start a namenode, a secondary nanenode and a datanode. You have the possibility to scale the datanode.

### Starting the image with basic setting
    docker-compose up -d && \
        docker-compose logs

If everything looks good in the logs (no errors), hit `CTRL + C` to detach the console from the logs.

### Scaling the datanode
If you want to increase the number of datanode in your cluster

    docker-compose scale datanode=<number of instance>

### Finding the port for web access
To allow the datanode to scale, we need to let docker decide the port used on the host machine. To find which port it is

    docker-compose port datanode 50075

With this port, you can access the web interfaces of the datanode.


