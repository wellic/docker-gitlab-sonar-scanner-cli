FROM openjdk:8-jre-alpine

ENV SONAR_SCANNER_ROOT_DIR "/sonar-scanner"

RUN apk --update add --no-cache wget git openssh nodejs\
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p "$SONAR_SCANNER_ROOT_DIR"

## It was written using info http://stackoverflow.com/a/40612088/865222
## and plugin https://gitlab.talanlabs.com/gabriel-allaigre/sonar-gitlab-plugin
ENV SONAR_SCANNER_ARC_VERSION 3.2.0.1227
ENV SONAR_SCANNER_ARC_FILENAME sonar-scanner-cli-${SONAR_SCANNER_ARC_VERSION}.zip
ENV SONAR_SCANNER_ARC_DIRNAME "sonar-scanner-${SONAR_SCANNER_ARC_VERSION}"

WORKDIR /

RUN wget -q "https://sonarsource.bintray.com/Distribution/sonar-scanner-cli/${SONAR_SCANNER_ARC_FILENAME}" \
    && unzip -q "${SONAR_SCANNER_ARC_FILENAME}" -d "${SONAR_SCANNER_ROOT_DIR}" \
    && rm "${SONAR_SCANNER_ARC_FILENAME}"

COPY install-sonar-scanner /install-sonar-scanner

RUN /install-sonar-scanner && rm /install-sonar-scanner

#ENTRYPOINT /bin/true

