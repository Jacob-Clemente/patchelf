# Build Stage
FROM --platform=linux/amd64 ubuntu:20.04 as builder

## Install build dependencies.
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y cmake

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y autoconf

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y g++

## Add source code to the build stage.
ADD . /patchelf
WORKDIR /patchelf

## TODO: ADD YOUR BUILD INSTRUCTIONS HERE.
RUN ./bootstrap.sh
RUN ./configure
RUN make
RUN make check

#Package Stage
FROM --platform=linux/amd64 ubuntu:20.04

## TODO: Change <Path in Builder Stage>
COPY --from=builder /patchelf/src/patchelf /
