# $1 - path of environment
# $2 - number of processes used for compiling Boost and Qt

##### Repositories #####

pushd $1

git clone -b 'boost-1.68.0' --single-branch --depth 1 https://github.com/boostorg/boost.git && cd boost && git submodule update --init --recursive

git clone -b 'v5.11.3' --single-branch --depth 1 https://code.qt.io/qt/qt5.git && cd qt5 && git submodule update --init --recursive

popd

##### Boost #####

mkdir $1/boost_bin
mkdir $1/boost_temp

pushd $1/boost/tools/build

./bootstrap.sh

./b2 install --prefix=$1/boost_bin/build

popd # $1/boost/tools/build

pushd $1/boost

$1/boost_bin/build/bin/b2 headers

$1/boost_bin/build/bin/b2 \
    -j $2 \
    --without-python \
    --build-dir=$1/boost_temp \
    --libdir=$1/boost_bin/lib \
    --includedir=$1/boost_bin/include \
    --layout=tagged \
    address-model=64 \
    link=static \
    threading=multi \
    runtime-link=static \
    variant=release \
    install

popd # $1/boost

rm -rf $1/boost_temp

##### Qt5 #####

mkdir $1/qt5_bin
mkdir $1/qt5_temp

pushd $1/qt5_temp

$1/qt5/configure \
    -prefix $1/qt5_bin \
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
    -no-xcb \
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
    -strip \
    -no-openssl \
    -securetransport

make -j$2
make install

popd

rm -rf $1/qt5_temp