# yocto - turbo

This document includes instructions how to checkout and build 
yocto distribution for distro "turbo"

Its just for training and testing porposes

## suppoprted targets
 
 * raspberrypi4-64
 * qemux86-64
 * qemuarm64

## checkout relevant sources

```
git clone -b thud git@github.com:stevo01/yocto-turbo.git
cd yocto-turbo
./script/init_sources.sh
```

## setup build environments

```
ln -s sources/meta-turbo/scripts/setup-environment setup-environment
ln -s sources/yocto-docker/docker-compose.yaml docker-compose.yaml
```

## docker
this step is optional but allows you to build the images in 
tested environment.

### build docker image and start docker container
```
docker compose build
docker compose up -d
```

### build and restart docker container
```
docker compose down && docker compose up -d --build
```

### join to docker container
```
docker compose exec -u $USER -w $PWD build-oe bash
```

## create build dir

### set machine

TARGET="qemux86-64"
TARGET="qemuarm64"
TARGET="raspberrypi4-64"

### first time
```
source setup-environment build.${TARGET} ${TARGET} 
```

### repeated time
```
source . setup-environment build.${TARGET}
```

## build image
```
bitbake turbo-image-minimal
```

## build sdk
```
bitbake turbo-image-minimal -c populate_sdk_ext
bitbake turbo-image-minimal -c populate_sdk
```

### start emulator
```
bitbake qemu-helper-native
sudo ./../sources/poky/scripts/runqemu-gen-tapdevs 1000 1000 4 tmp/sysroots-components/x86_64/qemu-helper-native/usr/bin

runqemu qemux86-64 nographic
runqemu qemuarm-64 nographic
```

### stop emulator
```
Ctrl-A X
```

## bookmarks
- https://www.codeinsideout.com/blog/yocto/raspberry-pi/#raspberry-pi-layer
- https://docs.yoctoproject.org/ref-manual/variables.html#term-SYSROOT_DIRS
- https://docs.yoctoproject.org/dev-manual/new-recipe.html#installing
