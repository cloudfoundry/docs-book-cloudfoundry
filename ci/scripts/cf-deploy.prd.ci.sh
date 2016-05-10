#!/usr/bin/env bash

tar -xvzf ../docs-release/*.tgz

./cf-deploy.prd.sh
