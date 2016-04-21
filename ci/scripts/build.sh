#!/bin/bash

ssh -o StrictHostKeyChecking=no git@github.com
git config --global url."https://github.com/".insteadOf git@github.com:

bundle install --binstubs
bundle exec bookbinder bind remote
