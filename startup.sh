#!/bin/bash

REALMD_CONFIG_FILE="/etc/cmangos-classic/realmd.conf"
BINARY_DIR=$1

if [ ! -e $REALMD_CONFIG_FILE ]; then
  echo "$REALMD_CONFIG_FILE must be present...a template for this file can be found here: https://github.com/cmangos/mangos-classic/blob/master/src/realmd/realmd.conf.dist.in"
  exit 1
fi
if [ ! -e $BINARY_DIR/realmd ]; then
  echo "$BINARY_DIR/realmd must be present...this file comes from $BINARY_PACKAGE"
  exit 1
fi

cd $BINARY_DIR
./realmd -c $REALMD_CONFIG_FILE
