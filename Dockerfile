FROM resin/raspberrypi3-alpine:3.7

ENV MITMPROXY_VERSION="4.0.1"

ENV LANG="US.UTF-8"

ENV max_mem_in_kb="550000"

RUN [ "cross-build-start" ]

RUN printf "git+https://github.com/mitmproxy/mitmproxy.git@v${MITMPROXY_VERSION}" > /tmp/requirements.txt

RUN apk add --no-cache \
    python3 \
    python3-dev \
    build-base \
    git \
    libffi-dev \
    libxml2-dev \
    libxslt-dev \
    libjpeg-turbo-dev \
    libwebp-dev \
    openssl-dev

RUN python3 -m ensurepip \
    && ln -s /lib /lib64

RUN pip3 install --upgrade setuptools pip httpie

RUN pip3 install -r /tmp/requirements.txt \
    && rm -rf /var/cache/apk/* \
    && rm -rf ~/.cache/pip \
    && rm -rf /tmp/pip_build_root \
    && rm -rf /root/.cache \
    && rm -rf /usr/lib/python*/ensurepip

RUN mkdir -p /opt/mitmoutput

RUN [ "cross-build-end" ]

# Location of the default mitmproxy CA files
VOLUME ["/opt/mitmoutput"]

HEALTHCHECK --interval=5s --timeout=5s --retries=3 \
    CMD if [ $(free -m | grep Mem: | awk '{print $3}') -le ${max_mem_in_kb} ]; then exit 0; else exit 1; fi

EXPOSE 8080 8081

CMD [ "/usr/bin/mitmweb","-p","8888","--listen-host","192.168.13.1","--web-iface","10.1.10.75","--mode","transparent","--showhost","-w","/opt/mitmoutput/defaultoutfile" ]