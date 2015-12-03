# docker-opendj
## Introduction
    OpenDJ is a REST & LDAP Directory - high performance, highly available, secure directory server, built-in data replication, client tools, and an LDAP SDK.
## Usage
```
$ docker pull bingoarunprasath/opendj
$ docker run -i -t -d -p 1389:1389 --name opendj bingoarunprasath/opendj-docker
```
## Verification
```
$ ldapsearch -x -h $(docker inspect --format '{{ .NetworkSettings.IPAddress }}' opendj) -p 1389 -b "dc=example,dc=com" -s sub "(objectclass=*)"
```
