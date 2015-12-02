FROM custom/opendj
MAINTAINER arunprasath33@gmail.com
#RUN apt-get -y update && apt-get install -y \
#    openjdk-7-jre-headless unzip \
#    wget \
#    unzip

WORKDIR /install/
RUN unzip OpenDJ-3.0.0-20151202.zip

WORKDIR /install/opendj/
RUN ./setup --cli -v   \
    --ldapPort 1389   \
    --ldapsPort 1636  \
    --adminConnectorPort 4444 \
    --rootUserDN "cn=Directory Manager" \
    --rootUserPassword password  \
    --generateSelfSignedCertificate   \
    --no-prompt --noPropertiesFile   \
    --doNotStart
COPY RunOpenDJ /install/RunOpenDJ
RUN chmod +x /install/RunOpenDJ
ENV PATH /install/opendj/bin:$PATH
WORKDIR /install/opendj/bin
ENTRYPOINT ["/install/RunOpenDJ"]

EXPOSE 1389 1636





