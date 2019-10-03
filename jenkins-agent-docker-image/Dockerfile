FROM ubuntu:16.04
LABEL maintainer "swatimag@cybage.com"

#Installing git, curl, software-properties-common, oracle-java8-installer
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y git curl software-properties-common openssh-server
RUN git --version
RUN git config --global user.name "swatimag"
RUN git config --global user.email "swatimag@cybage.com"
#Adding jenkins user
RUN mkdir /var/run/sshd
RUN useradd -ms /bin/bash jenkins
RUN /usr/sbin/sshd
RUN curl -fsSL https://get.docker.com/ | sh
RUN usermod -aG docker jenkins
#Docker-compose installtion
RUN curl -L "https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
RUN chmod +x /usr/local/bin/docker-compose
RUN docker-compose --version
#Installing java
RUN add-apt-repository ppa:webupd8team/java
RUN apt-get update -y
RUN echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
RUN echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections
RUN apt-get update -y
RUN apt-get install -y oracle-java8-installer
RUN javac -version
RUN apt install -y oracle-java8-set-default
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
#Installing Maven
RUN cd /opt && wget http://www-eu.apache.org/dist/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz \
    && tar -xvzf apache-maven-3.3.9-bin.tar.gz \
    && mv apache-maven-3.3.9 maven \
    && ln -s /opt/maven/bin/mvn /usr/local/bin
COPY mavenenv.sh /etc/profile.d/mavenenv.sh
RUN chmod +x /etc/profile.d/mavenenv.sh
RUN /bin/bash -c "source /etc/profile.d/mavenenv.sh"
ENV MAVEN_HOME /opt/maven
RUN mvn --version
#Installing Nodejs
RUN apt-get update -y
RUN apt-get install -y nodejs
RUN apt-get install -y npm
#Installing scala and sbt
RUN wget https://downloads.lightbend.com/scala/2.11.11/scala-2.11.11.deb
RUN dpkg -i scala-2.11.11.deb
RUN wget https://dl.bintray.com/sbt/debian/sbt-1.1.4.deb
RUN dpkg -i sbt-1.1.4.deb
RUN apt-get update -y
RUN apt-get install -y jq
RUN apt-get install -y libxml2-utils
#Copying Files from host
COPY dm_job.sh /home/jenkins/workspace/DecisionMines/
COPY dckr.img.tagidtxt.sh /home/jenkins/workspace/DecisionMines/
COPY settings.xml /etc/maven/
COPY settings.xml /opt/maven/conf/
#Installing Kubectl
RUN apt-get update -y
RUN apt-get install -y apt-transport-https
RUN curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
RUN echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list
RUN apt-get update -y
RUN apt-get install -y kubectl
#Installing mysql-toolset
RUN apt-get update -y
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list | tee /etc/apt/sources.list.d/msprod.list
RUN apt-get update -y
RUN apt-get update && ACCEPT_EULA=Y apt-get install -y msodbcsql mssql-tools
RUN echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
RUN /bin/bash -c "source ~/.bashrc"