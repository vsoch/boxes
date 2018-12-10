FROM ubuntu:18.04

# docker build -t vanessa/boxes .
# docker run vanessa/boxes "Like omhmahgosh potatoes"

ENV DEBIAN_FRONTEND noninteractive
LABEL Maintainer vsochat@stanford.edu

RUN apt-get update && \
    apt-get install -y boxes \
                       jq curl \
                       python3 \
                       python3-pip

ADD . /
RUN chmod u+x /entrypoint.sh && \
    pip3 install requests && \
    mkdir -p /data

ENTRYPOINT ["/bin/bash","/entrypoint.sh"]
