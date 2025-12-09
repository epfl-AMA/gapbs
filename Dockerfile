# Build stage
FROM ubuntu:22.04 AS builder

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -qq && \
    apt-get install -y -qq --no-install-recommends make g++ && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /root/gapbs

COPY ./src /root/gapbs/src
COPY ./pagerank.mk /root/gapbs/Makefile

RUN make all

# Runtime stage
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install make and g++
RUN apt-get update -qq && \
    apt-get install -y -qq --no-install-recommends make g++ && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /root/gapbs

# Copy binaries and Makefile from builder stage
COPY --from=builder /root/gapbs/pr /root/gapbs/
COPY --from=builder /root/gapbs/pr_spmv /root/gapbs/
COPY --from=builder /root/gapbs/converter /root/gapbs/
COPY --from=builder /root/gapbs/Makefile /root/gapbs/Makefile

RUN mkdir -p /root/gapbs/benchmark/out

