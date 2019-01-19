:: %1 - path of environment

call "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" x64
set PATH=%PATH%;"%~dp0bin\jom"

:: ##### Boost #####

mkdir %1\boost_x64_bin
mkdir %1\boost_x64_temp

pushd %1\boost\tools\build\

call bootstrap.bat
call b2 install --prefix=%1\boost_x64_bin\build

popd

pushd %1\boost\

call %1\boost_x64_bin\build\bin\b2 headers

call %1\boost_x64_bin\build\bin\b2^
 --build-dir=%1\boost_x64_temp^
 --libdir=%1\boost_x64_bin\lib^
 --includedir=%1\boost_x64_bin\include^
 --layout=tagged^
   address-model=64^
   link=static^
   threading=multi^
   runtime-link=static^
   variant=release^
   install

popd

rmdir %1\boost_x64_temp /s /q

:: ##### Qt5 #####

mkdir %1\qt5_x64_bin
mkdir %1\qt5_x64_temp

copy /Y "%1\qt5\qtbase\mkspecs\common\msvc-version.conf" "%1\qt5_x64_temp\msvc-version.conf.orig"
copy /Y "%~dp0msvc-version.conf.fixed" "%1\qt5\qtbase\mkspecs\common\msvc-version.conf"

pushd %1\qt5_x64_temp

call %1\qt5\configure -prefix %1\qt5_x64_bin^
 -platform win32-msvc2015^
 -debug-and-release^
 -confirm-license^
 -opensource^
 -static^
 -static-runtime^
 -nomake tests^
 -nomake examples^
 -openssl-linked^
 -I "%~dp0bin\openssl\include64"^
 -L "%~dp0bin\openssl\lib64"^
  OPENSSL_LIBS="-lssleay32MT -llibeay32MT"

call jom

call jom install

popd

copy /Y "%1\qt5_x64_temp\msvc-version.conf.orig" "%1\qt5\qtbase\mkspecs\common\msvc-version.conf"

rmdir %1\qt5_x64_temp /s /q
