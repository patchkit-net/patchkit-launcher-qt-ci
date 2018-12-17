:: %1 - path of environment
:: %2 - path to MSVC
:: %3 - build target version

pushd %1

call %2\VC\vcvarsall.bat x64

rmdir patchkit-launcher-qt /s /q
rmdir patchkit-launcher-qt_x64_bin /s /q

git clone -b %3 --single-branch --depth 1 https://github.com/patchkit-net/patchkit-launcher-qt.git

mkdir patchkit-launcher-qt_x64_bin

pushd patchkit-launcher-qt_x64_bin

set PK_LAUNCHER_BOOST_INCLUDEDIR=%1\boost_x64_bin\include\
set PK_LAUNCHER_BOOST_LIBDIR=%1\boost_x64_bin\lib\

call %1\qt5_x64_bin\bin\qmake %1\patchkit-launcher-qt
call nmake Release

popd

popd