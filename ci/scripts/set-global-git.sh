#!/usr/bin/env bash

git config --global url."https://github.com".insteadOf git://github.com
git config --global url."https://github.com/".insteadOf git@github.com:

./build.sh
