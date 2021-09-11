FROM golang:1.13

ARG GOOS=linux
ARG GOARCH=amd64

ENV GOOS=$GOOS
ENV GOARCH=$GOARCH

WORKDIR /go/src/github.com/v1k0d3n/myapp
COPY . .

RUN go get -d -v ./...

RUN CGO_ENABLED=0 go build -ldflags '-w -s' -a -installsuffix cgo -o /myapp

FROM scratch AS build
COPY --from=0 /myapp /myapp

VOLUME /data

ENTRYPOINT [ "/myapp" ]
CMD [ "--help" ]