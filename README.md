# FiveM FXServer Setup Script for Ubuntu
Compatibility: *Ubuntu LTS 16.04. / 18.04. / 20.04.* (older versions might be compatible)

This bash script allows you to easily setup and upgrade your fxserver on Ubuntu. All you have to do is run the script and edit your `server.cfg` with `nano server.cfg`

The aim is to provide newcomers to Linux, who want to run a FiveM server, an easy way to get a basic server setup running. Currently it performs the simple setup steps that are described in https://docs.fivem.net/docs/server-manual/setting-up-a-server/ with some small twists. More features will be added iteratively. 

## Features
1. Fully automatic first time setup
2. Easy upgrade fxserver, just run the script again!

## Instructions
1. Check if `git` is already installed via root `apt-get install git` and add a new shell user `adduser fivemsrv`#
2. Login to your new created user `fivemsrv` via SSH 
3. Clone the repository to a folder on your server `git clone https://github.com/atomicapple/fivem-fxserver-ubuntu-setup.git`
4. Navigate to folder `cd fivem-fxserver-ubuntu-setup`
5. Give bash script execute permission `chmod +x fxserver_setup.sh`
6. Run bash script `./fxserver_setup.sh`
7. Follow instructions at the end of the script
