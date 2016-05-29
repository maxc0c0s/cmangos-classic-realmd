#!/bin/bash

if [ -z $CMANGOS_VERSION ]
then
  echo 'You need to specify the $CMANGOS_VERSION environment variable, which is the cmangos/mangos-classic version'
  exit
fi

cd /tmp
tar -xvf cmangos-classic-$CMANGOS_VERSION.tar.gz
cd cmangos/bin

/tmp/wait-for-it.sh db:3306
# TODO So ugly...replace this sleep by a check to make sure the db-filler is over...maybe when it stops pinging.
sleep 30
./realmd -c /etc/cmangos-classic/realmd.conf

exec $@
