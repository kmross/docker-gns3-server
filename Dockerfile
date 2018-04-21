FROM ubuntu:16.04

#MAINTAINER kmross

ENV DEBIAN_FRONTEND noninteractive
ENV depends="python-dev ubridge dynamips vpcs qemu-kvm libvirt-bin qemu-utils qemu-system python-pip wget cmake vim libelf-dev libpcap0.8-dev zip gns3-server"

RUN apt-get update && apt-get install -y software-properties-common locales
RUN locale-gen en_US.UTF-8
RUN add-apt-repository -y ppa:gns3/ppa
RUN apt-get update && apt-get install -y $depends && pip install --upgrade pip
#grab and compile dynamips
RUN wget https://github.com/GNS3/dynamips/archive/master.zip -P /root/ && unzip /root/master.zip -d /root/
RUN mkdir /root/dynamips-master/build/ && cd /root/dynamips-master/build && cmake ..
RUN make install -C /root/dynamips-master/build/

#housekeeping
RUN rm -f /root/master.zip && rm -rf /root/dynamips-master/


#grab and compile ubridge
RUN wget https://github.com/GNS3/ubridge/archive/master.zip -P /root/ && unzip /root/master -d /root/
RUN make install -C /root/ubridge-master/

#housekeeping
RUN rm -f /root/master.zip && rm -rf /root/ubridge-master/

#CMD ["sleep","infinity"]
CMD gns3server

EXPOSE 3080 22 23

