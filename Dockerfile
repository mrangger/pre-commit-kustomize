FROM alpine:3.21
RUN apk add --no-cache git kustomize openssh

COPY ./bin /bin
RUN chmod +x /bin/kustomize-build

ENV PATH=/bin:$PATH
WORKDIR /src
