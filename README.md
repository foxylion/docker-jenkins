# docker-jenkins

This project aims to build a pre-configured Docker image for Jenkins 2.

![Jenkins+Docker Logo](https://raw.githubusercontent.com/foxylion/docker-jenkins/master/documentation/logo.png)

The image provides all required plugins to run a fully Docker enabled Jenkins
with multiple docker based slaves and support for the Docker Pipeline plugin.

## Quickstart

If you want start testing the Jenkins directly. Just ensure you've
[Vagrant](https://www.vagrantup.com) installed, clone the repository and
call `vagrant up`. Now you can access your Jenkins on http://10.111.0.10/.

## The Docker Images

There are two Docker images on Docker Hub, one is the Jenkins master and one the
Jenkins slave.

### Jenkins Master [![Docker Stars](https://img.shields.io/docker/stars/foxylion/jenkins.svg?style=flat-square)](https://hub.docker.com/r/foxylion/jenkins/) [![Docker Pulls](https://img.shields.io/docker/pulls/foxylion/jenkins.svg?style=flat-square)](https://hub.docker.com/r/foxylion/jenkins/)

***The latest image can be found on [Docker Hub](https://hub.docker.com/r/foxylion/jenkins/).***

The Jenkins master image provides a preconfigured version of Jenkins 2 with all
required plugins to run Docker based builds in a Pipeline. It also brings the new
Blueocean pipeline view.

A Jenkins master should expose the HTTP port and the slave communication port.

```bash
docker run -d --name jenkins -p 80:8080 -p 50000:50000 \
           -v /var/lib/jenkins:/var/jenkins_home \
           foxylion/jenkins
```

- This will start a new Jenkins master
- It will listen on Port 80 for any HTTP requests
- Authentication is only possible using credentials (default: admin/admin)
- Changing is password is only possible by using the `JENKINS_PASS` environment variable
- All configuration will be saved into `/var/lib/jenkins`

Removing the `-v` will prevent the Docker container from writing anything to
the host file system but may result in data loss when the container is removed.

### Jenkins Slave [![Docker Stars](https://img.shields.io/docker/stars/foxylion/jenkins-slave.svg?style=flat-square)](https://hub.docker.com/r/foxylion/jenkins-slave/) [![Docker Pulls](https://img.shields.io/docker/pulls/foxylion/jenkins-slave.svg?style=flat-square)](https://hub.docker.com/r/foxylion/jenkins-slave/)

***The latest image can be found on [Docker Hub](https://hub.docker.com/r/foxylion/jenkins-slave/).***

The Jenkins slave image provides a configurable version of the Jenkins slave. It
supports authentication using credentials or the JNLP slave secret. It is also
possible to create a slave nodes automatically when the slave container is
started, the slave node will then automatically removed when the container is
stopped.

```bash
docker run -d \
           -v /home/jenkins:/home/jenkins \
           -v /var/run/docker.sock:/var/run/docker.sock
           -e JENKINS_URL=https://jenkins.mycompany.com
           foxylion/jenkins-slave
```

By default the slave will automatically create a temporary Jenkins node. The name
will consist of the prefix `docker-slave` and the container hostname.

There are some environment variables to customize the slave behavior.

| ENV var | Description | Default |
| ------- | ----------- | ------- |
| `JENKINS_URL` | The URL where your Jenkins can be reached via HTTP. | `http://jenkins` |
| `JENKINS_SLAVE_ADDRESS` | An alternative address used to connect to the Jenkins server when starting the TCP connection, it will override the address provided by the Jenkins master. | `-` |
| `JENKINS_USER` | The user used for authentication against Jenkins master. | `admin` |
| `JENKINS_PASS` | The password used for authentication against Jenkins master. | `admin` |
| `SLAVE_NAME` | The name of the Jenkins node (must match a existing node). When left empty, the slave name will be generated. | `-` |
| `SLAVE_SECRET` | Will use the provided JNLP secret instead of user/password authentication. | `-` |
| `SLAVE_EXECUTORS` | Defines how many executors the slave should provide. | `1` |
| `SLAVE_LABELS`| Defines which labels the slave should have. Separete them using a space. | `docker` |
| `SLAVE_WORING_DIR`| Define a custom working directory when it is not possible to use `-w` at `docker run` command. | `-` |
| `CLEAN_WORKING_DIR` | When set to `true` the slave will clean the working directory on startup. This can help to prevent failed builds due to stored configuration in the working directory. | `true` |

#### Temporary Slaves

The temporary slaves feature is enabled when leaving the `SLAVE_NAME` environment
variable empty. The slave will automatically create a new Jenkins node with a
generated slave name. After the shutdown of the slave the Jenkins node will be
deleted. If this behavior is unwanted use a persistent slave.

#### Persistent Slaves

Running a slave without automatically creating a Jenkins node, but using JNLP slave authentication.

*Note:* It's important to set the *Remote root directory* of your slave to `/home/jenkins`.

```bash
docker run -d \
           -v /home/jenkins:/home/jenkins \
           -v /var/run/docker.sock:/var/run/docker.sock
           -e JENKINS_URL=http://jenkins.mycompany.com
           -e SLAVE_NAME=docker-slave-028
           foxylion/jenkins-slave
```

#### Varying *Remote root directory*

By default the Jenkins slave requires `/home/jenkins` to be mounted with the
equivalent directory on the Docker host.

**Note:** A different directory path on the host will result in failing builds.
[Read more (chapter: "Running build steps inside containers")](https://go.cloudbees.com/docs/cloudbees-documentation/cje-user-guide/chapter-docker-workflow.html)

If you need to use a different directory on your Docker host you can pass that
information when starting the Docker container.

```bash
docker run -d \
           -w /tmp/jenkins-slave
           -v /tmp/jenkins-slave:/tmp/jenkins-slave \
           -v /var/run/docker.sock:/var/run/docker.sock
           -e JENKINS_URL=http://jenkins.mycompany.com
           foxylion/jenkins-slave
```

## Read More

There are some useful links to get started using Jenkins pipelines in combination
with docker.

- [First step with Jenkins pipelines. Includes steps, stages, stash, docker](https://dzone.com/refcardz/continuous-delivery-with-jenkins-workflow)
- [Overview on Jenkins pipeline, including links to documentation, etc.](https://wilsonmar.github.io/jenkins2-pipeline/)
