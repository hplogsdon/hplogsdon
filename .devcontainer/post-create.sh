#!/usr/bin/env bash
set -eu -o pipefail

if ! command -v rbenv 2>&1 >/dev/null
then

  sudo apt-get update && \
  sudo apt-get install -y autoconf patch build-essential rustc libssl-dev libyaml-dev \
    libreadline6-dev zlib1g-dev libgmp-dev libncurses5-dev libffi-dev libgdbm6 libgdbm-dev \
    libdb-dev uuid-dev git-core

  echo "Installing rbenv"
  git clone https://github.com/rbenv/rbenv.git $HOME/.rbenv
  echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
  echo 'eval "$(rbenv init -)"' >> ~/.bashrc
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"

  git clone https://github.com/rbenv/ruby-build.git $HOME/.rbenv/plugins/ruby-build
fi

# Install the version of Ruby specified in .ruby-version.
if [ -f .ruby-version ]; then
    if command -v rbenv 2>&1 >/dev/null
    then
        rbenv install $(< .ruby-version)
        rbenv local $(< .ruby-version)
        rbenv rehash
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

echo "DONE"