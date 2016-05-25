#!/usr/bin/env bash

set -e -x -u

git config url."https://github.com".insteadOf git://github.com
git config url."https://github.com/".insteadOf git@github.com:

ci/scripts/build.sh

export VERSION=$(cat ../docs-version/version)

tar -cvzf "docs-$VERSION.tgz" final_app/public
mv "docs-$VERSION.tgz" ../final-app/
