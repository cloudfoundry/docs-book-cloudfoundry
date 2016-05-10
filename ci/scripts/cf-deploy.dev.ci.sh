#!/usr/bin/env bash

tar -xvzf ../docs-release/*.tgz

ci/scripts/cf-deploy.dev.sh
