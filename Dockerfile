FROM ubuntu:14.04.3
MAINTAINER Barnabas Debreczeni <keo@goa.hu>

# Original work by Kyle Manna: https://github.com/kylemanna/docker-bitcoind

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 97B6956B && \
    echo 'deb [ arch=amd64 ] http://bitcoinxt.software.s3-website-us-west-2.amazonaws.com/apt wheezy main' > /etc/apt/sources.list.d/bitcoinxt.list

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y bitcoinxt=0.11B && \
    DEBIAN_FRONTEND=noninteractive apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


ENV HOME /bitcoin
RUN useradd -s /bin/bash -m -d /bitcoin bitcoin
RUN chown bitcoin:bitcoin -R /bitcoin

ADD ./bin /usr/local/bin
RUN chmod a+x /usr/local/bin/*

# For some reason, docker.io (0.9.1~dfsg1-2) pkg in Ubuntu 14.04 has permission
# denied issues when executing /bin/bash from trusted builds.  Building locally
# works fine (strange).  Using the upstream docker (0.11.1) pkg from
# http://get.docker.io/ubuntu works fine also and seems simpler.
USER bitcoin

VOLUME ["/bitcoin"]

EXPOSE 8332 8333

WORKDIR /bitcoin

CMD ["btc_oneshot"]
