FROM ubuntu:16.04

# Install Docker CLI
RUN apt-get update && apt-get install -y apt-transport-https ca-certificates
RUN apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
RUN echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main" > /etc/apt/sources.list.d/docker.list
RUN apt-get update && apt-get install -y docker-engine

RUN apt-get update && apt-get install -y openjdk-8-jre

RUN apt-get update && apt-get install -y curl

RUN useradd -d /home/jenkins jenkins
RUN mkdir -p /home/jenkins
RUN chown jenkins . /home/jenkins

WORKDIR /home/jenkins
