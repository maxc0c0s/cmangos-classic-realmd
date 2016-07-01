#!/bin/bash

if [ -z $CMANGOS_VERSION ]
then
  echo 'You need to specify the $CMANGOS_VERSION environment variable, which is the cmangos/mangos-classic version...see https://github.com/cmangos/mangos-classic/releases'
  exit 1
fi

REALMD_CONFIG_FILE="/etc/cmangos-classic/realmd.conf"
TEMP_DIR="/tmp"
BINARY_PACKAGE="$TEMP_DIR/cmangos-classic-$CMANGOS_VERSION.tar.gz"
BINARY_DIR="/cmangos/bin"

if [ ! -f "/cmangos/bin/realmd" ]
then
  if [ ! -e $BINARY_PACKAGE ]; then
    echo "$BINARY_PACKAGE missing...this file can be generated using https://github.com/maxc0c0s/cmangos-classic-deploy"
    exit 1
  fi

  echo "extracting $BINARY_PACKAGE"
  tar -xf $BINARY_PACKAGE -C /
fi

if [ ! -e $REALMD_CONFIG_FILE ]; then
  echo "$REALMD_CONFIG_FILE must be present...a template for this file can be found here: https://github.com/cmangos/mangos-classic/blob/master/src/realmd/realmd.conf.dist.in"
  exit 1
fi
if [ ! -e $BINARY_DIR/realmd ]; then
  echo "$BINARY_DIR/realmd must be present...this file comes from $BINARY_PACKAGE"
  exit 1
fi

# TODO this command could be called from a custom script
/wait-for-it/wait-for-it.sh db-master:3306

if [ -z $@ ]; then
  cd $BINARY_DIR
  ./realmd -c $REALMD_CONFIG_FILE
else
  exec $@
fi
