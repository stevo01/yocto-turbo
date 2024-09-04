# yocto - turbo

This document includes instructions how to checkout and build 
yocto distribution for distro "turbo"

Its just for training and testing purposes

## supported targets
 
 * raspberrypi4-64
 * qemux86-64
 * qemuarm64
 * turbo-arm64

## checkout relevant sources

```
git clone -b thud git@github.com:stevo01/yocto-turbo.git
cd yocto-turbo
./script/init_sources.sh
```
a
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
TARGET="raspberrypi3-64"
TARGET="k3r5"
TARGET="turbo-arm64"

### first time
```
source setup-environment build.${TARGET} ${TARGET} 
```

### repeated time
```
source setup-environment build.${TARGET}
```

## build image
```
bitbake turbo-image-minimal
```

## build multiconfig target
```
bitbake multiconfig:k3r5:ti-sci-fw
```




## bookmarks
- https://www.codeinsideout.com/blog/yocto/raspberry-pi/#raspberry-pi-layer
- https://docs.yoctoproject.org/ref-manual/variables.html#term-SYSROOT_DIRS
- https://docs.yoctoproject.org/dev-manual/new-recipe.html#installing



make -j 12 V=1 BUILD_BASE=/media/data/sv-sick/yocto-turbo/build.raspberrypi3-64/tmp/work/raspberrypi3_64-poky-linux/trusted-firmware-a/2.3-r0/build PLAT=rpi3 bl1
