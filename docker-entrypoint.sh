#!/bin/bash
set -e


touch ~/local/etc/DIR_CONFIG
afd -a
udc

if [ "$1" = 'afd_ctrl' ]; then
    exec "$@" &
fi

echo "$@" >> ~/start_command.txt

tail -f ~/start_command.txt
