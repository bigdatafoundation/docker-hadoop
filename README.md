# Supported tags and respective `Dockerfile` links
- [`2.6.0`/Dockerfile](https://github.com/GELOG/docker-ubuntu-hadoop/tree/2.6.0/Dockerfile)
- [`2.5.2`/Dockerfile](https://github.com/GELOG/docker-ubuntu-hadoop/tree/2.5.2/Dockerfile)
- [`2.5.1`/Dockerfile](https://github.com/GELOG/docker-ubuntu-hadoop/tree/2.5.1/Dockerfile)
- [`2.5.0`/Dockerfile](https://github.com/GELOG/docker-ubuntu-hadoop/tree/2.5.0/Dockerfile)
- [`2.4.1`/Dockerfile](https://github.com/GELOG/docker-ubuntu-hadoop/tree/2.4.1/Dockerfile)
- [`2.4.0`/Dockerfile](https://github.com/GELOG/docker-ubuntu-hadoop/tree/2.4.0/Dockerfile)
- [`2.3.0`/Dockerfile](https://github.com/GELOG/docker-ubuntu-hadoop/tree/2.3.0/Dockerfile)

# What is Hadoop?
The Apache™ Hadoop® project develops open-source software for reliable, scalable, distributed computing.

The Apache Hadoop software library is a framework that allows for the distributed processing of large data sets across clusters of computers using simple programming models. It is designed to scale up from single servers to thousands of machines, each offering local computation and storage. Rather than rely on hardware to deliver high-availability, the library itself is designed to detect and handle failures at the application layer, so delivering a highly-available service on top of a cluster of computers, each of which may be prone to failures.

[http://hadoop.apache.org/](http://hadoop.apache.org/)

# What is Docker?
Docker is an open platform for developers and sysadmins to build, ship, and run distributed applications. Consisting of Docker Engine, a portable, lightweight runtime and packaging tool, and Docker Hub, a cloud service for sharing applications and automating workflows, Docker enables apps to be quickly assembled from components and eliminates the friction between development, QA, and production environments. As a result, IT can ship faster and run the same app, unchanged, on laptops, data center VMs, and any cloud.

[https://www.docker.com/whatisdocker/](https://www.docker.com/whatisdocker/)

## What is a Docker Image?
Docker images are the basis of containers. Images are read-only, while containers are writeable. Only the containers can be executed by the operating system.

[https://docs.docker.com/terms/image/](https://docs.docker.com/terms/image/)

# Dependencies
* [Install Docker](https://docs.docker.com/installation/)

# Base Docker image
* [gelog/spark:1.1.0-bin-hadoop2.3](https://registry.hub.docker.com/u/gelog/spark/)

# How to use this image?
