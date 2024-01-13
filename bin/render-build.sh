#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
echo "Before precompile"
./bin/rails assets:precompile
echo "After precompile"
./bin/rails assets:clean