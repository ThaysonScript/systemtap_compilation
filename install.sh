#!/usr/bin/env bash

apt install libboost-all-dev
apt install python3-setuptools python3-distutils

git clone git://sourceware.org/git/systemtap.git

cd systemtap

./configure  python=':' pyexecdir='' python3='/usr/bin/python3' py3execdir='' --prefix=/root/systemtap_5_4

make all && make install

cd ../systemtap_5_4/bin

printf "%s\n" "Verificando instalação ..."

./stap -v -e 'probe vfs.read {printf("read performed\n"); exit()}'

printf "\n%s\n" "---------- Testing systemtap hello world ----------"
./stap -v -e 'probe oneshot { println("hello world") }'

printf "\n%s\n" "---------- List the probe points matching a certain pattern ----------"
./stap -L 'process("/bin/ls").function("*user*")'

printf "\n%s\n" "---------- See when a given function gets called ----------"
./stap -e 'probe process("/bin/ls").function("format_user") { printf("format_user(uid=%d)\n", $u) }'

printf "\n%s\n" "---------- You can instrument kernel functions, for example ----------"
./stap -ve 'probe kernel.function("icmp_reply") { println("icmp reply") }'
