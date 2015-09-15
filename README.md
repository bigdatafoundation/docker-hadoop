# Docker image for Hadoop

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

### Data storage
This image is configured (in `hdfs-site.xml`) to store HDFS data at the following locations: `file:///data/dfs/data` (for DataNode), `file:///data/dfs/name` (for NameNode), and `file:///data/dfs/namesecondary` (for SecondaryNameNode). To enable data persistence accross HDFS restarts, the data should be stored outside Docker. In the examples below, a directory from the host is mounted into the container. To follow these examples, please create a local directory as follow:

	mkdir -p ~/data/hadoop/hdfs


### Formating the namenode (only do this step once)

	docker run --rm -i -h hdfs-namenode \
		-v $HOME/data/hadoop/hdfs:/data \
		gelog/hadoop hdfs namenode -format


### Starting the NameNode
This command starts a container for the HDFS NameNode in the background, and starts tailing its logs.

	docker run -d --name hdfs-namenode \
		-h hdfs-namenode -p 50070:50070 \
		-v $HOME/data/hadoop/hdfs:/data \
		gelog/hadoop hdfs namenode && \
	docker logs -f hdfs-namenode

If everything looks good in the logs (no errors), hit `CTRL + C` to detach the console from the logs.


### Starting a DataNode
This command starts a separate container for the HDFS DataNode in the background, link it with the NameNode container, and starts tailing its logs.

	docker run -d --name hdfs-datanode1 \
		-h hdfs-datanode1 -p 50075:50075 \
		--link=hdfs-namenode:hdfs-namenode \
		-v $HOME/data/hadoop/hdfs:/data \
		gelog/hadoop hdfs datanode && \
	docker logs -f hdfs-datanode1

If everything looks good in the logs (no errors), hit `CTRL + C` to detach the console from the logs.


### Starting a Secondary NameNode
This command starts a separate container for the HDFS Secondary NameNode in the background, link it with the NameNode container, and starts tailing its logs.

	docker run -d --name hdfs-secondarynamenode \
		-h hdfs-secondarynamenode -p 50090:50090 \
		--link=hdfs-namenode:hdfs-namenode \
		-v $HOME/data/hadoop/hdfs:/data \
		gelog/hadoop hdfs secondarynamenode && \
	docker logs -f hdfs-secondarynamenode

If everything looks good in the logs (no errors), hit `CTRL + C` to detach the console from the logs.


### Accessing the web interfaces
Each component provide its own web UI. Open you browser at one of the URLs below, where `dockerhost` is the name / IP of the host running the docker daemon. If using Linux, this is the IP of your linux box. If using OSX or Windows (via Boot2docker), you can find out your docker host by typing `boot2docker ip`. On my machine, the NameNode UI is accessible at `http://192.168.59.103:50070/`

| Component               | Port                                               |
| ----------------------- | -------------------------------------------------- |
| HDFS NameNode           | [http://dockerhost:50070](http://dockerhost:50070) |
| HDFS DataNode           | [http://dockerhost:50075](http://dockerhost:50075) |
| HDFS Secondary NameNode | [http://dockerhost:50090](http://dockerhost:50090) |


