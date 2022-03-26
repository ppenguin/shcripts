#!/usr/bin/env sh
ps auxc | grep $(whoami) | grep -v ${0} | grep -v tty2 | awk '{ print $2 }' | xargs kill
sleep 1
ps auxc | grep $(whoami) | grep -v ${0} | grep -v tty2 | awk '{ print $2 }' | xargs kill -9 
