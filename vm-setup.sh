#!/bin/bash

set -eoux pipefail

IG_VERSION=v0.45.0
IG_ARCH=amd64

sudo apt-get update

sudo apt-get install -y docker docker-compose -y

# prepull builder image
sudo docker pull ghcr.io/inspektor-gadget/ebpf-builder:${IG_VERSION}

# install ig binary
curl -sL https://github.com/inspektor-gadget/inspektor-gadget/releases/download/${IG_VERSION}/ig-linux-${IG_ARCH}-${IG_VERSION}.tar.gz | sudo tar -C /usr/local/bin -xzf - ig

# VM Setup Script for KubeCon NA 2025 Demo
echo "Starting VM setup at $(date)" >> /var/log/vm-setup.log
