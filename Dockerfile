FROM ubuntu:18.04

# docker build -t vanessa/boxes .
# docker run vanessa/boxes "Like omhmahgosh potatoes"

RUN apt-get update && \
    apt-get install -y boxes

ADD entrypoint.sh /entrypoint.sh
ADD messages.txt /messages.txt
RUN chmod u+x /entrypoint.sh && \
    mkdir -p /data

ENTRYPOINT ["/entrypoint.sh"]
