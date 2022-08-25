FROM rust:1.63.0-buster

WORKDIR /opt
RUN git config --global user.email "noreply@example.com"
RUN git clone https://github.com/bjorn3/rustc_codegen_cranelift.git

WORKDIR /opt/rustc_codegen_cranelift
RUN git checkout 53f4bb935213a7d3f50a0317eac23cebe9bdab54
RUN ./y.rs prepare
RUN ./y.rs build
# RUN ./test.sh # benchmark is panicking in specified hash

WORKDIR /opt/rustc_codegen_cranelift/build
RUN ln -s cargo-clif fcargo
ENV PATH="/opt/rustc_codegen_cranelift/build:${PATH}"

WORKDIR /
