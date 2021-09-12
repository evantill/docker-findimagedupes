FROM golang:1.13 as build

ARG GOOS=linux
ARG GOARCH=amd64

ENV GOOS=$GOOS
ENV GOARCH=$GOARCH

RUN apt-get -qq update && \
    apt-get install -y libmagic-dev libpng-dev libjpeg-dev libtiff-dev && \
    rm -rf /var/lib/apt/lists/*

RUN go get -v -u gitlab.com/opennota/findimagedupes

FROM debian:10-slim

RUN apt-get -qq update && \
    apt-get install -y libmagic-dev libpng-dev libjpeg-dev libtiff-dev && \
    rm -rf /var/lib/apt/lists/*

COPY --from=build /go/bin/findimagedupes /usr/local/bin/findimagedupes

ENTRYPOINT [ "/usr/local/bin/findimagedupes" ]

CMD [ "--help" ]
