#!/bin/bash

# Expand variables and echo all commands
set -x

# Install / update vmware modules
# Needs to be run after every kernel update
# 
# Patches available from: https://github.com/mkubecek/vmware-host-modules/archive/workstation-x.y.z.tar.gz

KERNEL_VERSION=$(uname -r)
VMWARE_VERSION=$(vmware -v | cut -d ' ' -f 3)

mkdir -p /tmp/git
cd /tmp/git
wget https://github.com/mkubecek/vmware-host-modules/archive/workstation-${VMWARE_VERSION}.tar.gz
tar -xzf workstation-${VMWARE_VERSION}.tar.gz
cd vmware-host-modules-workstation-${VMWARE_VERSION}/
make
sudo make install
