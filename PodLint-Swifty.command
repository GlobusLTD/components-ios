#!/bin/sh

cd "$(dirname "$0")"
bundle install
bundle exec pod spec lint ./GlobusSwifty.podspec --verbose