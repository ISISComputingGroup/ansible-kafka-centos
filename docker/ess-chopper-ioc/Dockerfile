FROM dmscid/lewis:v1.2.0

# Build and install kafkacat, it'll be used to publish that we want the EPICS forwarder to forward this IOC
RUN apk add --no-cache openssl-dev curl git build-base bash tar wget python yajl yajl-dev cmake coreutils \
    && git clone --branch 1.3.1 --single-branch https://github.com/edenhill/kafkacat.git kafkacat \
    && cd kafkacat \
    && ./bootstrap.sh \
    && make install \
    && cd .. \
    && rm -rf kafkacat \
    && apk del openssl-dev curl git build-base tar wget python yajl-dev cmake coreutils

RUN mkdir launchconfig
WORKDIR /launchconfig
COPY launch.sh /launchconfig/

ENTRYPOINT ["/bin/bash", "-c"]
CMD ["./launch.sh"]
