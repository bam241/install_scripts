#!/bin/bash
# This script builds the repo version of PyNE (with the MOAB optional
# dependency) from scratch on Ubuntu 16.04 or 18.04. The folder $HOME/opt is created
# and PyNE is installed within.
#
# Run this script from any directory by issuing the command where <version>
# is either "dev" or "stable":
# $ ./ubuntu.sh <version> 
# You can optionnaly specify the ubuntu version you re using either 16.04 or
# 18.4:
# $ ./ubuntu.sh <version> <ubuntu_version>
#
# After the build finishes run:
#  $ source ~/.bashrc
# or open a new terminal.

# Use package manager for as many packages as possible

if [ $# -lt 2 ]
then 
    version=`lsb_release -r -s`
    if [ -z "$var" ]
    then
        echo "Can't detect your ubuntu version, install 'lbs_core' from apt-get or
        provide your ubuntu version as the last argument to this script (16.04 or
        18.04)"
        exit 1
    fi
elif [ $# -eq 2 ]
then
    version=$2
else
    echo "To many argument provided. this script can only one take 1 optionnal
    argument: the ubuntu version you are using (16.04 or 18.04)"
fi

if [[ $version != "16.04" ]] && [[ $version != "18.04" ]]
then
    echo " Only Ubuntu 16.06 and 18.04 are supported by this script use at your
    own risk!"
fi

apt_package_list="software-properties-common wget \
             build-essential git cmake vim emacs gfortran libblas-dev \
             python-pip liblapack-dev libhdf5-dev autoconf libtool"
if [[ ${version} == "16.04" ]]
then
    apt_package_list="python-software-properties ${apt_package_list}" 
fi

pip_package_list="numpy scipy cython nose tables matplotlib jinja2 \
                  setuptools"

hdf5_libdir=/usr/lib/x86_64-linux-gnu/hdf5/serial


source ubuntu_mint.sh $1
