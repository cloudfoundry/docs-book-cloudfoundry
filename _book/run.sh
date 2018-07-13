#!/bin/bash

# Bring up the Docs at http://localhost:4567
bundle exec bookbinder bind local
cd final_app
ruby app.rb
