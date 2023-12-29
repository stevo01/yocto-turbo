# yocto - turbo

This document include sinstructions how to checkout and build 
yocto distribution for distro "turbo"

Its just for training and testing porposes

## suppoprted targets
 
 * raspberrypi4-64
 * qemux86-64
 * qemuarm64


## checkout relevant sources

```
git clone git@github.com:stevo01/yocto-turbo.git
cd yocto-turbo

mkdir sources
cd sources
git clone -b thud git://git.yoctoproject.org/meta-raspberrypi
git clone -b thud git://git.yoctoproject.org/poky
git clone -b thud git://git.openembedded.org/meta-openembedded
git clone -b thud git@github.com:stevo01/meta-turbo.git
git clone -b thud git@github.com:stevo01/meta-templates.git
cd ..
```

## setup build environments

```
ln -s sources/meta-turbo/scripts/setup-environment setup-environment
ln -s sources/meta-turbo/build-oe/docker-compose.yaml docker-compose.yaml
```

## docker
this step is optional but allows you to build the images in 
tested environment.

## build docker image and start docker container
```
docker compose build
docker compose up -d
```

## join to docker container
```
docker compose exec -u $USER -w $PWD build-oe bash
```

## create build dir

### first time
```
source setup-environment build.pi raspberrypi4-64
```

### repeated time
```
source setup-environment build.pi
```

## build image
```
bitbake core-image-minimal
```



## notes
git submodule add -b thud git://git.yoctoproject.org/poky sources/poky
git submodule add -b thud git://git.yoctoproject.org/poky sources/poky
git submodule add -b thud git://git.yoctoproject.org/poky sources/poky
git submodule add -b thud git://git.yoctoproject.org/poky sources/poky
git submodule add -b thud git://git.yoctoproject.org/poky sources/poky



### second time
source setup-environment build.pi

### build image
bitbake core-image-base
bitbake core-image-minimal
bitbake turbo-image-minimal

bitbake turbo-image-minimal -c populate_sdk_ext
bitbake turbo-image-minimal -c populate_sdk

### start emulator
runqemu qemux86-64 nographic
runqemu qemuarm-64 nographic



## bookmarks
- https://www.codeinsideout.com/blog/yocto/raspberry-pi/#raspberry-pi-layer
- https://docs.yoctoproject.org/ref-manual/variables.html#term-SYSROOT_DIRS
- https://docs.yoctoproject.org/dev-manual/new-recipe.html#installing