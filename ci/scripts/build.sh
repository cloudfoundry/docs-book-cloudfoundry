#!/usr/bin/env bash

set -e -x -u

bundle install
bundle exec bookbinder bind remote
