FROM centos:7.3.1611

# ENV TERM xterm
ENV HOME /home/jenkins

RUN yum update -y -x kernel \
     && yum install -y \
        epel-release \
     && yum install -y \
        autoconf \
        automake \
        bind-utils \
        binutils \
        bison \
        coreutils \
        curl \
        flex \
        gcc \
        gcc-c++ \
        gettext \
        git \
        libtool \
        make \
        patch \
        pkgconfig \
        # redhat-rpm-config \
        # rpm-build \
        # rpm-sign \
        sudo \
        tar \
        unzip \
        vim \
        wget \
        #  java-1.8.0-openjdk \
        #  java-1.8.0-openjdk-devel \
    #  && yum --setopt=group_package_types=mandatory,default,optional group install -y "Development Tools" \
     && wget -q -c --no-check-certificate \
        --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" \
        "http://download.oracle.com/otn-pub/java/jdk/8u112-b15/jdk-8u112-linux-x64.rpm" \
        # "http://download.oracle.com/otn-pub/java/jdk/8u102-b14/jdk-8u102-linux-x64.rpm" \
     && yum localinstall -y jdk-8u112-linux-x64.rpm \
     # && yum localinstall -y jdk-8u102-linux-x64.rpm \
     && rm -f jdk-8u112-linux-x64.rpm \
        # && rm -f jdk-8u102-linux-x64.rpm \
     && yum clean all \
     && groupadd -g 1111 jenkins \
     && useradd -c "Jenkins user" -d $HOME -u 1111 -g 1111 -m jenkins

ARG VERSION=2.62

RUN curl --create-dirs -sSLo /usr/share/jenkins/slave.jar https://repo.jenkins-ci.org/public/org/jenkins-ci/main/remoting/${VERSION}/remoting-${VERSION}.jar \
    && chmod 755 /usr/share/jenkins \
    && chmod 644 /usr/share/jenkins/slave.jar

USER jenkins
RUN mkdir /home/jenkins/.jenkins
VOLUME /home/jenkins/.jenkins
WORKDIR /home/jenkins
# Define default command.
# CMD ["bash"]