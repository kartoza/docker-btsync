FROM ubuntu:14.04

MAINTAINER Tim Sutton <tim@kartoza.com>

RUN export DEBIAN_FRONTEND=noninteractive
ENV DEBIAN_FRONTEND noninteractive
RUN dpkg-divert --local --rename --add /sbin/initctl

# Use local cached debs from host (saves your bandwidth!)
# Change ip below to that of your apt-cacher-ng host
# Or comment this line out if you do not wish to use caching
ADD 71-apt-cacher-ng /etc/apt/apt.conf.d/71-apt-cacher-ng

# Install curl
RUN apt-get -y update && apt-get install -y curl

# Download and extract the executable to /usr/bin
RUN curl -o /usr/bin/btsync.tar.gz http://download-lb.utorrent.com/endpoint/btsync/os/linux-x64/track/stable
RUN cd /usr/bin && tar -xzvf btsync.tar.gz && rm btsync.tar.gz; mkdir -p /btsync/.sync; mkdir -p /home/realtime/analysis_data
RUN groupadd -g 1500 btsync;  useradd -m -d /home/btsync -u 1500 -g 1500 btsync; chown -R btsync.btsync /btsync /home/realtime/analysis_data

# Web GUI
EXPOSE 8888
# Listening port
EXPOSE 55555

USER btsync
ADD btsync.conf /btsync/btsync.conf

ENTRYPOINT ["btsync"]
CMD ["--config", "/btsync/btsync.conf", "--nodaemon"]
