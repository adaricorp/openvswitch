#!/bin/bash

set -euo pipefail

export DEBIAN_FRONTEND=noninteractive

set -x

apt-get update
apt-get -y full-upgrade
apt-get -y install packaging-dev equivs

(
  cd ovs

  ./boot.sh
  ./configure
  make debian
  mk-build-deps -i -r -t "apt-get -f -y --force-yes"
  make debian-deb
)
