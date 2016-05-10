#!/usr/bin/env bash

tar -xvzf ../docs-release/*.tgz

ci/scripts/cf-deploy.prd.sh
