:: %1 - path of environment

pushd %1

git clone -b 'boost-1.68.0' --single-branch --depth 1 https://github.com/boostorg/boost.git && cd boost && git submodule update --init --recursive

git clone -b 'v5.11.3' --single-branch --depth 1 https://code.qt.io/qt/qt5.git && cd qt5 && git submodule update --init --recursive

popd