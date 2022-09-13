ARG ubuntu_version=20.04

FROM ubuntu:$ubuntu_version

ENV DEBIAN_FRONTEND=noninteractive 

RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get -y install wget 

### PLEASE NOTE: ###
### You need to login to 10x genomics to get a download link for cellranger, if copying this dockerfile replace
### "personal login link" with the provided link when you log in to 10x genomics

RUN wget -O /cellranger-7.0.1.tar.gz "personal login link"

RUN tar -xzvf cellranger-7.0.1.tar.gz -C /opt

RUN rm /cellranger-7.0.1.tar.gz

ENV PATH="/opt/cellranger-7.0.1:${PATH}"
