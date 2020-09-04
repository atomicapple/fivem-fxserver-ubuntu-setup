#!/bin/bash

echo -e "\e[92mAutomatic FXServer Setup Script for Ubuntu 16.04, 18.04 & 20.04. LTS"
echo
echo Author: Ironlung
echo https://discord.me/kiffen
echo
echo

echo -e "\e[32mCreating Directories...\e[39m"
if [ ! -d "$HOME/fivemsrv" ]; then
    mkdir "$HOME/fivemsrv"
    echo Created base directory
else
    echo Skipping base directory, already exists
fi
if [ ! -d "$HOME/fivemsrv/temp" ]; then
    mkdir "$HOME/fivemsrv/temp"
    echo Created temp directory
else
    echo Skipping temp directory, already exists
fi
if [ ! -d "$HOME/fivemsrv/server" ]; then
    mkdir "$HOME/fivemsrv/server"
    echo Created server directory
else
    echo Skipping server directory, already exists
fi
if [ ! -d "$HOME/fivemsrv/server-data" ]; then
    mkdir "$HOME/fivemsrv/server-data"
    echo Created server-data directory
else
    echo Skipping server-data directory, already exists
fi
echo -e "\e[32mDone creating directories.\e[39m"

echo -e "\e[32mGrabbing latest FXServer build version...\e[39m"
LATEST_VERSION=`wget -q -O - https://runtime.fivem.net/artifacts/fivem/build_proot_linux/master/ | grep '<a href' | tail -1 | grep -Po '(?<=href=").{47}'`
echo Latest FXServer build: $LATEST_VERSION

if [ ! -f "$HOME/fivemsrv/server/latest_version.log" ]; then
    touch "$HOME/fivemsrv/server/latest_version.log"
fi
if [ "$(head -n 1 $HOME/fivemsrv/server/latest_version.log)" != $LATEST_VERSION ]; then
    echo -e "\e[32mDownloading latest build...\e[39m"
    wget -q --show-progress "https://runtime.fivem.net/artifacts/fivem/build_proot_linux/master/$LATEST_VERSION/fx.tar.xz" -P "$HOME/fivemsrv/temp"
    echo Finished downloading FXServer
    echo Decompressing FXServer...
    echo -e "\e[93mIgnore warning/error below\e[39m"
    tar -xf "$HOME/fivemsrv/temp/fx.tar.xz" -C "$HOME/fivemsrv/server"
    echo Done decompressing FXServer
    echo $LATEST_VERSION > "$HOME/fivemsrv/server/latest_version.log"
    echo -e "\e[32mSuccessfully installed new FXServer build version $LATEST_VERSION\e[39m"
else
    echo Skipping FXServer, you already have the latest build
fi

if [ ! -d "$HOME/fivemsrv/server-data/resources" ]; then
    echo -e "\e[32mCloning cfx-server-data to $HOME/fivemsrv/server-data\e[39m"
    git clone https://github.com/citizenfx/cfx-server-data.git "$HOME/fivemsrv/server-data"
    echo -e "\e[32mDone cloning cfx-server-data\e[39m"
else
    echo Found existing resources folder, skipping cloning cfx-server-data
fi

if [ ! -f "$HOME/fivemsrv/server-data/server.cfg" ]; then
    echo -e "\e[32mCreating server.cfg...\e[39m"
    wget -q --show-progress "https://gist.githubusercontent.com/atomicapple/ec69b51b36b079d119d6ca8508ba738c/raw/32a3819d0b9ca941e0b0e41e49ef0f509bad7981/server.cfg" -P "$HOME/fivemsrv/server-data"
    echo -e "\e[32mDone creating server.cfg in $HOME/fivemsrv/server-data\e[39m"
    echo -e "Don't forget to add your license key to 'server.cfg'!"
else
    echo Found existing server.cfg, skipping creating server.cfg
fi


rm -rf "$HOME/fivemsrv/temp"
rm -rf "$HOME/fivemsrv/server/latest_version.log"
echo -e "Deleted temp folder and cleaning up"

echo -e "\e[92mCompleted FXServer Setup!\e[39m"
echo
echo -e "First edit your server.cfg with 'nano $HOME/fivemsrv/server-data/server.cfg'"
echo -e "Be sure to at least add your Server License Key"
echo
echo -e "Instructions to start server"
echo "1. 'cd $HOME/fivemsrv/server-data'"
echo "2. 'bash $HOME/fivemsrv/server/run.sh +exec server.cfg'"
echo "or 'bash $HOME/fivemsrv/server/run.sh +exec server.cfg +set onesync legacy' if you want to enable OneSync" 
echo
echo "Enjoy your FiveM Server!"
echo
