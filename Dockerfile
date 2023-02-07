FROM opensuse/leap:15.4

ENV LANG=en_US.UTF-8

# install needed
RUN zypper refresh
RUN zypper --non-interactive install --replacefiles which
RUN zypper --non-interactive install --replacefiles hostname
RUN zypper --non-interactive install --replacefiles expect
RUN zypper --non-interactive install --replacefiles net-tools
RUN zypper --non-interactive install --replacefiles iputils
RUN zypper --non-interactive install --replacefiles wget
RUN zypper --non-interactive install --replacefiles vim
RUN zypper --non-interactive install --replacefiles iproute2
RUN zypper --non-interactive install --replacefiles unrar
RUN zypper --non-interactive install --replacefiles less
RUN zypper --non-interactive install --replacefiles tar
RUN zypper --non-interactive install --replacefiles gzip
RUN zypper --non-interactive install --replacefiles uuidd
RUN zypper --non-interactive install --replacefiles tcsh
RUN zypper --non-interactive install --replacefiles libaio
RUN zypper --non-interactive up

# uuidd is needed by nw abap
RUN mkdir /run/uuidd && chown uuidd /var/run/uuidd && /usr/sbin/uuidd

# Copy extracted SAP NW ABAP files to the container
COPY sapdownloads /tmp/sapdownloads/

WORKDIR /tmp/sapdownloads
RUN chmod +x zinstall.sh

# Important ports to be exposed (TCP):
# HTTP
EXPOSE 8000
# HTTPS
EXPOSE 44300
# ABAP in Eclipse
EXPOSE 3300
# SAP GUI
EXPOSE 3200
# SAP Cloud Connector
#EXPOSE 8443