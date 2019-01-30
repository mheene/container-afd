#!/bin/bash
set -e

afd -a
cp ~/config/DIR_CONFIG_03 ~/local/etc/DIR_CONFIG
touch ~/local/etc/DIR_CONFIG
udc

if [ "$1" = 'afd_ctrl' ]; then
    exec "$@" &
fi

echo "$@" >> ~/start_command.txt

tail -f ~/start_command.txt
