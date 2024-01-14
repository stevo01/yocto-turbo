#!/bin/bash

set -e

function handle_repo {
    
    REPO_URL=$1
    REPO_DIR=$2
    REPO_BRANCH=$3

    echo handle repo:
    echo    REPO_URL=$REPO_URL
    echo    REPO_DIR=$REPO_DIR
    echo    REPO_BRANCH=$REPO_BRANCH

    if [ -d "$REPO_DIR" ]; then
        cd $REPO_DIR
        echo "update fetch $REPO_URL" 
        git fetch --all
        echo "checkout branch $REPO_BRANCH"
        git checkout $REPO_BRANCH
        cd ..
    else
        echo "clone repo $REPO_URL branch $REPO_BRANCH"
        git clone -b $REPO_BRANCH $REPO_URL
    fi

    return 0
} 

BRANCH="thud"
YOCTO_DIR="./sources"

if [ -d "$YOCTO_DIR" ]; then
  echo "$YOCTO_DIR does exist."
else
  mkdir -p $YOCTO_DIR
fi

cd $YOCTO_DIR

handle_repo git://git.yoctoproject.org/meta-raspberrypi  meta-raspberrypi   $BRANCH
handle_repo git://git.yoctoproject.org/poky              poky               $BRANCH
handle_repo git://git.openembedded.org/meta-openembedded meta-openembedded  $BRANCH
handle_repo git@github.com:stevo01/meta-turbo.git        meta-turbo         $BRANCH
handle_repo git@github.com:stevo01/meta-templates.git    meta-templates     $BRANCH

cd ..
