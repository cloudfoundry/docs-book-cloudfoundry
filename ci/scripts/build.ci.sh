#!/usr/bin/env bash

set -e -x -u

version=$(cat ../docs-version/version)

ci/scripts/build.sh

echo "${version}" > final_app/public/version

tar -cvzf "docs-${version}.tgz" final_app/public manifest.yml manifest.dev.yml
mv "docs-${version}.tgz" ../final-app/
