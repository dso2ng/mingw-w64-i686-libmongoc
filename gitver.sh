#!/bin/bash

# gitver.sh - a script to retrive the current release version
# This is by search through the tag inside git repo and find
# version number consists of n.n.n
# below is from https://goo.gl/VCVN8k
# Usage:
# $ gitver "creationix/nvm"

get_latest_release() {
  curl --silent "https://api.github.com/repos/$1/releases/latest" | # Get latest release from GitHub api
    grep '"tag_name":' |                                            # Get tag line
    sed -E 's/.*"([^"]+)".*/\1/'                                    # Pluck JSON value
}

# Usage
# $ get_latest_release "creationix/nvm"
# v0.31.4
