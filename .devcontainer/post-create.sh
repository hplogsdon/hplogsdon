#!/usr/bin/env bash
set -eu -o pipefail

# Install the version of Ruby specified in .ruby-version.
if [ -f .ruby-version ]; then
    if command -v rvm 2>&1 >/dev/null
    then
        rvm install $(< .ruby-version)
        rvm use $(< .ruby-version)
    fi
    if command -v rbenv 2>&1 >/dev/null
    then
        rbenv install $(< .ruby-version)
        rbenv local $(< .ruby-version)
    fi

fi

# Install the version of Bundler.
if [ -f Gemfile.lock ] && grep "BUNDLED WITH" Gemfile.lock > /dev/null; then
    cat Gemfile.lock | tail -n 2 | grep -C2 "BUNDLED WITH" | tail -n 1 | xargs gem install bundler -v
fi

# If there's a Gemfile, then run `bundle install`
# It's assumed that the Gemfile will install Jekyll too
if [ -f Gemfile ]; then
    bundle install
fi

#bundle exec jekyll serve --force-polling --baseurl=''

# Mark workspace directory as safe for git
git config --global --add safe.directory $(realpath .)

echo "DONE"