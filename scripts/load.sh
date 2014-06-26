#!/usr/bin/env bash
echo $(free | awk '/Mem/{t=$2}/buffers\/cache/{u=$3}END{printf "Mem:%.1f%%", u/t*100}')
