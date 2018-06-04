FROM resin/raspberrypi3-alpine:3.7

ENV MITMPROXY_VERSION="4.0.1"

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

RUN pip3 install --upgrade setuptools pip

RUN pip3 install -r /tmp/requirements.txt \
    && rm -rf /var/cache/apk/* \
    && rm -rf ~/.cache/pip \
    && rm -rf /tmp/pip_build_root \
    && rm -rf /root/.cache \
    && rm -rf /usr/lib/python*/ensurepip

RUN [ "cross-build-end" ]

# Location of the default mitmproxy CA files
VOLUME ["/ca"]

EXPOSE 8080 8081

CMD [ "/usr/bin/mitmweb", "--cadir", "/ca", "--wiface", "0.0.0.0" ]