FROM ubuntu:20.04

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata
RUN apt-get -y install \
    cmake \
    gcc \
    g++ \
    python

ENV CC=/usr/bin/gcc \
    CXX=/usr/bin/g++

COPY . .

RUN mkdir /llvm-project/build && \
    cd /llvm-project/build && \
    cmake -DLLVM_ENABLE_PROJECTS=clang -DBUILD_SHARED_LIBS=ON -DLLVM_ENABLE_RTTI=ON -DLLVM_ENABLE_EH=ON -G "Unix Makefiles" ../llvm && \
    make -j4
