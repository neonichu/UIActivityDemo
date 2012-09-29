#!/bin/sh

# Not sure why, but FlattrKit has a ridiculous build process.

NATIVE_SDK=`xcodebuild -showsdks|grep iphoneos|awk '{print $4}'`
SIMUL_SDK=`xcodebuild -showsdks|grep iphonesimulator|awk '{print $6}'`

if [ -z "$NATIVE_SDK" -o -z "$SIMUL_SDK" ]
then
  echo 'Missing iOS SDK.'
  exit 1
fi

git submodule init &&
git submodule update &&

cd external/FlattrKit &&
git submodule init &&
git submodule update &&

cd OAuth2Client &&
xcodebuild -sdk $NATIVE_SDK -target OAuth2Client &&
xcodebuild -arch i386 -sdk $SIMUL_SDK -target OAuth2Client &&
cd ..

mkdir -p build/Release-{iphoneos,iphonesimulator} &&
cp OAuth2Client/build/Release-iphoneos/*.a build/Release-iphoneos &&
cp OAuth2Client/build/Release-iphonesimulator/*.a build/Release-iphonesimulator &&
xcodebuild -sdk $NATIVE_SDK -target libFlattrKit &&
xcodebuild -arch i386 -sdk $SIMUL_SDK -target libFlattrKit &&
cd ../../lib

libs=`find ../external -name '*.a'|xargs basename|sort|uniq`
for lib in $libs
do
  file `find ../external -name $lib|head -n 1`|grep 'Mach-O universal binary' >/dev/null 2>&1
  if [ $? -eq 0 ]
  then
      continue
  fi

  lipo -create -output $lib `find ../external -name $lib`
done

