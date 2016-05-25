#!/usr/bin/env bash

set -x -u

tar -xvzf ../docs-release/*.tgz

ci/scripts/cf-deploy.dev.sh
