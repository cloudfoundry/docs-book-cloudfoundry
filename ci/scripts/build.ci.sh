#!/usr/bin/env bash

git config --global url."https://github.com".insteadOf git://github.com
git config --global url."https://github.com/".insteadOf git@github.com:

ci/scripts/build.sh

export DOCS_VERSION=$(cat ../docs-version/version)

tar -cvzf "docs-$DOCS_VERSION.tgz" final_app/public
mv "docs-$DOCS_VERSION.tgz" ../final-app/
