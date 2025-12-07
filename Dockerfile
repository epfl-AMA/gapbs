FROM akrishnaams/ubuntu2204:oh-my-bash
# FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -qq && \
    apt-get install -y -qq make g++

WORKDIR /root/gapbs

RUN mkdir -p /root/gapbs/

COPY ./src /root/gapbs/src
COPY ./pagerank.mk /root/gapbs/Makefile

RUN make all

RUN rm -rf /var/lib/apt/lists/*

