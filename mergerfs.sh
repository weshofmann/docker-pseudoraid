#!/bin/sh

while read -r sources target options; do
  [ -d ${target} ] || mkdir ${target}
  echo "* mounting mergerfs: ${sources} --> ${target}"
  mergerfs -o ${options} ${sources} ${target}
done </config/mergerfs.conf
