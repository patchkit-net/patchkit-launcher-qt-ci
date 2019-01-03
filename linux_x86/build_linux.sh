# $1 - build target version

pushd /

rm -rf patchkit-launcher-qt
rm -rf patchkit-launcher-qt_bin

git clone -b $1 --single-branch --depth 1 https://github.com/patchkit-net/patchkit-launcher-qt.git

mkdir patchkit-launcher-qt_bin

pushd patchkit-launcher-qt_bin

export PK_LAUNCHER_BOOST_INCLUDEDIR=/boost_bin/include/ && \
    export PK_LAUNCHER_BOOST_LIBDIR=/boost_bin/lib/ && \
    /qt5_bin/bin/qmake /patchkit-launcher-qt && \
    make

popd # patchkit-launcher-qt_bin

popd # /