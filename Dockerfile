FROM custom/opendj
MAINTAINER arunprasath33@gmail.com
#RUN apt-get -y update && apt-get install -y \
#    openjdk-7-jre-headless unzip \
#    wget \
#    unzip

WORKDIR /install/
RUN unzip OpenDJ-3.0.0-20151202.zip

ENV LDAP_PORT 1389
ENV LDAPS_PORT 1636
ENV ADMIN_CONN_PORT 4444
ENV ROOT_USER_DN "cn=Directory Manager"
ENV ROOT_USER_PASSWORD password 
# I shouldn't be doing this; links; coreos blah blah
ENV OPENDJ_DIR /install/opendj/


WORKDIR $OPENDJ_DIR
RUN ./setup --cli -v   \
    --ldapPort $LDAP_PORT   \
    --ldapsPort $LDAPS_PORT  \
    --adminConnectorPort $ADMIN_CONN_PORT \
    --rootUserDN "cn=Directory Manager" \
    --rootUserPassword $ROOT_USER_PASSWORD  \
    --generateSelfSignedCertificate   \
    --no-prompt --noPropertiesFile   \
    --doNotStart

COPY RunOpenDJ /install/RunOpenDJ
RUN chmod +x /install/RunOpenDJ
ENV PATH /install/opendj/bin:$PATH
WORKDIR /install/opendj/bin
ENTRYPOINT ["/install/RunOpenDJ"]

EXPOSE 1389 1636





