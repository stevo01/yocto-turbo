# yocto - turbo

## suppoprted targets
- raspberry pi


## checkout sources
mkdir sources
cd sources
git clone -b kirkstone git://git.yoctoproject.org/meta-raspberrypi
git clone -b kirkstone git://git.yoctoproject.org/poky
git clone -b kirkstone git://git.openembedded.org/meta-openembedded
git clone -b kirkstone git://git.openembedded.org/meta-templates
cd ..

## create file links
ln -s sources/meta-turbo/scripts/setup-environment setup-environment
ln -s sources/meta-turbo/build-oe/docker-compose.yaml docker-compose.yaml

## start docker
docker compose build
docker compose exec -u $USER -w $PWD build-oe bash

## create build dir

### first time
source setup-environment build.pi raspberrypi4-64
source setup-environment build.pi.thun qemux86-64



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