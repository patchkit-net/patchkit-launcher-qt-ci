FROM i386/ubuntu:16.04

ARG MAKE_J_VALUE

RUN apt-get update

RUN apt-get install -y git cmake build-essential perl python libxi-dev libxfixes-dev libxext-dev libx11-dev "^libxcb.*" libxcb1-dev libx11-xcb-dev libxcb-keysyms1-dev libxcb-image0-dev libxcb-shm0-dev libxcb-icccm4-dev libxcb-sync0-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-randr0-dev libxcb-render-util0-dev libglu1-mesa-dev libxrender-dev libasound2-dev libgstreamer0.10-dev libgstreamer-plugins-base0.10-dev libfontconfig1-dev libfreetype6-dev libssl-dev openssl

RUN git clone -b 'boost-1.68.0' --single-branch --depth 1 https://github.com/boostorg/boost.git && cd boost && git submodule update --init --recursive

RUN git clone -b 'v5.11.3' --single-branch --depth 1 https://code.qt.io/qt/qt5.git && cd qt5 && git submodule update --init --recursive

RUN mkdir /boost_bin && \
    mkdir /boost_temp && \
    cd /boost/tools/build && \
    ./bootstrap.sh && \
    ./b2 install --prefix=/boost_bin/build && \
    cd /boost && \
    /boost_bin/build/bin/b2 headers && \
    /boost_bin/build/bin/b2 \
        -j $MAKE_J_VALUE \
        --without-python \
        --build-dir=/boost_temp \
        --libdir=/boost_bin/lib \
        --includedir=/boost_bin/include \
        --layout=tagged \
        address-model=32 \
        link=static \
        threading=multi \
        runtime-link=static \
        variant=release \
        install && \
    rm -rf /boost_temp

RUN mkdir /qt5_bin && \
    mkdir /qt5_temp && \
    cd /qt5_temp && \
    /qt5/configure \
        -prefix /qt5_bin \
        -release \
        -no-optimized-tools \
        -opensource \
        -confirm-license \
        -c++std c++11 \
        -static \
        -accessibility \
        -no-qml-debug \
        -pkg-config \
        -qt-zlib \
        -qt-libpng \
        -qt-libjpeg \
        -qt-xcb \
        -qt-xkbcommon \
        -qt-pcre \
        -qt-doubleconversion \
        -system-freetype \
        -qt-harfbuzz \
        -nomake examples \
        -nomake tests \
        -gui \
        -widgets \
        -silent \
        -fontconfig \
        -strip \
        -openssl-linked \
        OPENSSL_LIBS='-l:libssl.a -l:libcrypto.a' \
        -no-icu && \
    make -j$MAKE_J_VALUE && \
    make install && \
    rm -rf /qt5_temp

COPY ../common/build_linux.sh /build.sh