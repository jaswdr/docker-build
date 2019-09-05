FROM docker:stable

# install docker-compose
RUN apk add -U \
        gcc \
        git \
        go \
        libc-dev \
        libffi-dev \
        make \
        openssl \
        openssl-dev \
        py-pip \
        python-dev \
    && pip install docker-compose

# install dockerize
ENV DOCKERIZE_VERSION v0.6.1
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz

# install pvr
RUN mkdir -p /go/src/gitlab.com/pantacor \
    && cd /go/src/gitlab.com/pantacor \
    && git clone --single-branch --depth 1 https://gitlab.com/pantacor/pvr \
    && cd pvr \
    && go get -v \
    && go build -o pvr \
    && mv ./pvr /usr/local/bin/pvr \
    && rm -rf /go/src/gitlab.com/patancor/pvr
