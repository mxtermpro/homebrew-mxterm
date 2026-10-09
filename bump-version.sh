#!/bin/sh
# Sets the cask's `version` to what mxterm.net serves now (latest.json). Run after each release, then commit.
set -eu
cd "$(dirname "$0")"
v=$(curl -fsSL https://mxterm.net/download/latest.json | sed -n 's/.*"version"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' | head -1)
[ -n "$v" ] || { echo "could not read the version from latest.json" >&2; exit 1; }
sed -i '' "s/^  version \".*\"/  version \"$v\"/" Casks/mxterm-pro.rb
echo "mxterm-pro -> $v"
