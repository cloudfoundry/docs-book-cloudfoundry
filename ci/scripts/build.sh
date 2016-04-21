#!/bin/bash

ssh -o StrictHostKeyChecking=no git@github.com

bundle install --binstubs
bundle exec bookbinder bind remote
