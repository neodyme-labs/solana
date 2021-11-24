# syntax=docker/dockerfile:1.2
FROM rust:1.56.1-bullseye AS builder

COPY . /src
WORKDIR /src

RUN apt-get update && apt-get install -y libssl-dev libudev-dev pkg-config zlib1g-dev llvm clang make
RUN --mount=type=cache,target=/usr/local/cargo/git \
    --mount=type=cache,target=/usr/local/cargo/registry \
    --mount=type=cache,sharing=private,target=/src/target \
    rustup component add rustfmt && \
    cargo build
