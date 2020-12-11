FROM centos:centos7

COPY ./valdcli-linux /valdcli-linux
WORKDIR /valdcli-linux
RUN chmod +x valdcli
