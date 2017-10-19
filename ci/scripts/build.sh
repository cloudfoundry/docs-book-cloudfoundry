#!/usr/bin/env bash

set -e -x -u

bundle install
rm -rf output final_app
bundle exec bookbinder bind remote
