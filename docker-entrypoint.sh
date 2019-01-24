#!/bin/bash
set -e

afd -a

if [ "$1" = 'afd_ctrl' ]; then
    exec "$@" &
fi

echo "$@" >> ~/start_command.txt
tail -f ~/start_command.txt
