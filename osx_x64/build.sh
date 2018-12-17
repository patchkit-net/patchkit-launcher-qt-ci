# $1 - path of environment
# $2 - build target version

pushd $1

rm -rf patchkit-launcher-qt
rm -rf patchkit-launcher-qt_bin

git clone -b $2 --single-branch --depth 1 https://github.com/patchkit-net/patchkit-launcher-qt.git

mkdir patchkit-launcher-qt_bin

pushd patchkit-launcher-qt_bin

export PK_LAUNCHER_BOOST_INCLUDEDIR=$1/boost_bin/include/ && \
    export PK_LAUNCHER_BOOST_LIBDIR=$1/boost_bin/lib/ && \
    $1/qt5_bin/bin/qmake $1/patchkit-launcher-qt && \
    make

popd # patchkit-launcher-qt_bin

popd # /