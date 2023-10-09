FROM ubuntu:20.04
LABEL maintainer "Kelly Sovacool *(kelly-sovacool on GitHub)*"
LABEL github_handle="kelly-sovacool"

# build time variables
ARG BUILD_DATE="000000"
ENV BUILD_DATE=${BUILD_DATE}
ARG BUILD_TAG="000000"
ENV BUILD_TAG=${BUILD_TAG}
ARG REPONAME="000000"
ENV REPONAME=${REPONAME}

RUN mkdir -p /opt2 && mkdir -p /data2
ENV TZ=America/New_York
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt update && apt-get -y upgrade
# Set the locale
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
		locales build-essential cmake cpanminus && \
	localedef -i en_US -f UTF-8 en_US.UTF-8 && \
	cpanm FindBin Term::ReadLine

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    build-essential \
	bzip2 \
	curl \
	figlet \
	g++ \
	gcc \
	gfortran \
	git \
	libatlas-base-dev \
	libblas-dev \
	libboost-dev \
	libbz2-dev \
	libcurl4-openssl-dev \
	libexpat1-dev \
	libfreetype6-dev \
	libgd-dev \
	libgd-perl \
    libgpgme11-dev \
	libgs-dev \
	libgsl-dev \
	libgsl0-dev \
	libhtml-template-compiled-perl \
	libicu-dev \
	libjudy-dev \
	liblapack-dev \
	liblzma-dev \
	libmysqlclient-dev \
	libncurses-dev \
	libopenmpi-dev \
	libpng-dev \
	librtmp-dev \
    libseccomp-dev \
	libssl-dev \
	libtool \
	libxml-libxml-debugging-perl \
	libxml-opml-simplegen-perl \
	libxml2-dev \
	libxslt-dev \
	make \
	manpages-dev \
	openjdk-17-jre-headless \
	parallel \
	pigz \
    pkg-config \
	python3-pip \
    python3-dev \
	rsync \
    squashfs-tools \
	unzip \
    uuid-dev \
	wget \
	zlib1g \
	zlib1g-dev \
	zlibc

RUN python3 -m pip install --upgrade pip

# install go for singularity
RUN export VERSION=1.11 OS=linux ARCH=amd64 && \
    wget https://dl.google.com/go/go$VERSION.$OS-$ARCH.tar.gz && \
    tar -C /opt2 -xzvf go$VERSION.$OS-$ARCH.tar.gz && \
    rm go$VERSION.$OS-$ARCH.tar.gz
ENV PATH="/opt2/go/bin/:$PATH"
RUN go get -u github.com/golang/dep/cmd/dep

# install singularity https://docs.sylabs.io/guides/3.0/user-guide/installation.html
RUN export VERSION=3.10.5 && \
    mkdir -p /opt2/go/src/github.com/sylabs && \
    cd /opt2/go/src/github.com/sylabs && \
    wget https://github.com/sylabs/singularity/releases/download/v${VERSION}/singularity-ce-${VERSION}.tar.gz && \
    tar -xzf singularity-ce-${VERSION}.tar.gz && \
	cd ./singularity-ce-${VERSION} && \
    ./mconfig --prefix /opt2 && \
    make -C ./builddir && \
    make -C ./builddir install

# install nextflow
RUN export VERSION=23.04.4 && \
	wget -qO- https://github.com/nextflow-io/nextflow/releases/download/v${VERSION}nextflow | bash && \
    chmod +x nextflow && \
    mv nextflow /opt2/

# cleanup etc
# Save Dockerfile in the docker
COPY Dockerfile /opt2/Dockerfile_${REPONAME}.${BUILD_TAG}
RUN chmod a+r /opt2/Dockerfile_${REPONAME}.${BUILD_TAG}
#COPY argparse.bash /opt2
#RUN chmod -R a+rx /opt2/argparse.bash
ENV PATH="/opt2/:$PATH"

# check install
RUN which singularity
RUN which nextflow

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    apt-get autoclean && \
    apt-get autoremove -y && \
    rm -rf /var/lib/{apt,dpkg,cache,log}/
WORKDIR /data2
