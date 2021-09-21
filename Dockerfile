FROM tomcat:9.0-jdk11
LABEL maintainer="Evolved Binary Ltd"
LABEL "org.opencontainers.image.authors"="https://www.evolvedbinary.com"
LABEL "org.opencontainers.image.title"="Orbeon"
LABEL "org.opencontainers.image.documentation"="https://doc.orbeon.com/"
LABEL "org.opencontainers.image.description"="Orbeon Forms"
LABEL "org.opencontainers.image.source"="https://www.github.com/evolvedbinary/docker-orbeon"

ARG ORBEON_TAG=tag-release-2019.2-ce
ARG ORBEON_FILE_NAME_BASE=orbeon-2019.2.0.201912301747-CE
ARG MARIADB_CONNECTOR_VERSION=2.1.0

### Install Dependencies
RUN apt-get update && \
    apt-get -y --no-install-recommends install \
        libmariadb-java \
        mariadb-client \
        unzip && \
	\
### Download and unpack Orbeon
    cd /usr/src && \
    curl -SlLo orbeon.zip https://github.com/orbeon/orbeon-forms/releases/download/${ORBEON_TAG}/${ORBEON_FILE_NAME_BASE}.zip && \
    unzip -d . orbeon.zip && \
    mkdir -p /usr/local/tomcat/webapps/orbeon && \
    cp -R /usr/src/${ORBEON_FILE_NAME_BASE}/orbeon.war /usr/local/tomcat/webapps/orbeon/ && \
    cd /usr/local/tomcat/webapps/orbeon/ && \
    unzip -d . orbeon.war && \
    rm -rf orbeon.war && \
    rm -rf /usr/src/* && \
	\
### Cleanup
    apt-get -y --purge remove unzip && \
    rm -rf /var/cache/apt/*

### Add Files
ADD install /
