FROM nciccbr/ccbr_ubuntu_base_20.04:v5

# build time variables
ARG BUILD_DATE="000000"
ENV BUILD_DATE=${BUILD_DATE}
ARG BUILD_TAG="000000"
ENV BUILD_TAG=${BUILD_TAG}
ARG REPONAME="000000"
ENV REPONAME=${REPONAME}

# download bagel scripts and install dependencies
RUN python3 -m pip install --upgrade pip
RUN pip3 install click numpy scipy scikit-learn
ADD https://github.com/hart-lab/bagel/archive/refs/tags/v2.0-115.tar.gz /opt2
WORKDIR /opt2
RUN tar -xzvf v2.0-115.tar.gz && rm -f v2.0-115.tar.gz
ENV PATH="${PATH}:/opt2/bagel-2.0-115"

# cleanup etc
# Save Dockerfile in the docker
COPY Dockerfile /opt2/Dockerfile_${REPONAME}.${BUILD_TAG}
RUN chmod a+r /opt2/Dockerfile_${REPONAME}.${BUILD_TAG}
#COPY argparse.bash /opt2
RUN chmod -R a+rx /opt2/argparse.bash
ENV PATH="/opt2/:$PATH"
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    apt-get autoclean && \
    apt-get autoremove -y && \
    rm -rf /var/lib/{apt,dpkg,cache,log}/
WORKDIR /data2
