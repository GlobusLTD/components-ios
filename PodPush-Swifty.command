#!/bin/sh

cd "$(dirname "$0")"
bundle install
bundle exec pod trunk push ./GlobusSwifty.podspec --allow-warnings