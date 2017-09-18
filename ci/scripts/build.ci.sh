#!/usr/bin/env bash

set -e -x -u

git config --global url."https://github.com".insteadOf git://github.com
git config --global url."https://github.com/".insteadOf git@github.com:

ci/scripts/build.sh

version=$(cat ../docs-version/version)

tar -cvzf "docs-${version}.tgz" final_app/public
mv "docs-${version}.tgz" ../final-app/
