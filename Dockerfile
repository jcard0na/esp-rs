FROM ubuntu:16.04

RUN apt-get update && apt-get install -y git curl gcc libssl-dev pkg-config python-pip cmake llvm-3.9-dev libclang-3.9-dev clang-3.9 vim

RUN curl https://sh.rustup.rs -sSf > rustup.sh && chmod +x rustup.sh
RUN ./rustup.sh -y
ENV PATH="/root/.cargo/bin:${PATH}"

ENV HOME="/root"
ENV PATH="${HOME}/.local/bin:${PATH}"

WORKDIR /build

COPY . /build/esp-rs

WORKDIR /build/esp-rs

RUN ARCH=esp8266 ./build.sh --install
RUN ARCH=esp32 ./build.sh --install
