#!/bin/sh

cd "$(dirname "$0")"
bundle install
bundle exec pod trunk push ./Globus.podspec
bundle exec pod trunk push ./GlobusSwifty.podspec