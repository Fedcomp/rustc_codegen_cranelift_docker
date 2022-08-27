FROM debian:bookworm

RUN apt-get update
RUN apt-get install -y curl ca-certificates
RUN apt-get install -y build-essential
RUN apt-get install -y git

ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH

RUN curl https://sh.rustup.rs -sSf | \
    sh -s -- --default-toolchain nightly-2022-08-24 -y

RUN git config --global user.email "noreply@example.com"
RUN git clone https://github.com/bjorn3/rustc_codegen_cranelift.git /opt/rustc_codegen_cranelift

WORKDIR /opt/rustc_codegen_cranelift
RUN git checkout 53f4bb935213a7d3f50a0317eac23cebe9bdab54
RUN ./y.rs prepare
RUN ./y.rs build
# RUN ./test.sh # benchmark is panicking in specified hash

RUN (cd build && ln -s cargo-clif fcargo)

ENV PATH="/opt/rustc_codegen_cranelift/build:${PATH}"
