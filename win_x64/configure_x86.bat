:: %1 - path of environment
:: %2 - path to MSVC

call %2\VC\vcvarsall.bat x86
set PATH=%PATH%;"%~dp0bin\jom"

:: ##### Boost #####

mkdir %1\boost_x86_bin
mkdir %1\boost_x86_temp

pushd %1\boost\tools\build\

call bootstrap.bat
call b2 install --prefix=%1\boost_x86_bin\build

popd

pushd %1\boost\

call %1\boost_x86_bin\build\bin\b2 headers

call %1\boost_x86_bin\build\bin\b2^
 --build-dir=%1\boost_x86_temp^
 --libdir=%1\boost_x86_bin\lib^
 --includedir=%1\boost_x86_bin\include^
 --layout=tagged^
   address-model=32^
   link=static^
   threading=multi^
   runtime-link=static^
   variant=release^
   install

popd

rmdir %1\boost_x86_temp /s /q

:: ##### Qt5 #####

mkdir %1\qt5_x86_bin
mkdir %1\qt5_x86_temp

copy /Y "%1\qt5\qtbase\mkspecs\common\msvc-version.conf" "%1\qt5_x86_temp\msvc-version.conf.orig"
copy /Y "%~dp0msvc-version.conf.fixed" "%1\qt5\qtbase\mkspecs\common\msvc-version.conf"

pushd %1\qt5_x86_temp

call %1\qt5\configure -prefix %1\qt5_x86_bin^
 -platform win32-msvc2015^
 -debug-and-release^
 -confirm-license^
 -opensource^
 -static^
 -static-runtime^
 -nomake tests^
 -nomake examples^
 -openssl-linked^
 -I "%~dp0bin\openssl\include"^
 -L "%~dp0bin\openssl\lib"^
  OPENSSL_LIBS="-lssleay32MT -llibeay32MT"

call jom

call jom install

popd

copy /Y "%1\qt5_x86_temp\msvc-version.conf.orig" "%1\qt5\qtbase\mkspecs\common\msvc-version.conf"

rmdir %1\qt5_x86_temp /s /q