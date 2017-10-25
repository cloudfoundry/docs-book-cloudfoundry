#!/usr/bin/env bash

set -e -x -u

ci/scripts/build.sh

version=$(cat ../docs-version/version)

tar -cvzf "docs-${version}.tgz" final_app/public
mv "docs-${version}.tgz" ../final-app/
