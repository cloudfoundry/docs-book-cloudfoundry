#!/usr/bin/env bash

set -e -x

bundle install
bundle exec bookbinder bind remote
