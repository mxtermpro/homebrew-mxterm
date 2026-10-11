#!/bin/sh
# Sets the cask's `version` and `sha256` to the release mxterm.net serves now (latest.json and the versioned DMG's .sha256).
# Run after each release, then commit. It refuses to touch the cask if the versioned DMG or its checksum is missing.
set -eu
cd "$(dirname "$0")"
v=$(curl -fsSL https://mxterm.net/download/latest.json | sed -n 's/.*"version"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' | head -1)
[ -n "$v" ] || { echo "could not read the version from latest.json" >&2; exit 1; }
dmg="https://mxterm.net/download/MXterm-Pro_${v}_universal.dmg"
curl -fsSI "$dmg" >/dev/null || { echo "the versioned DMG for $v is not published: $dmg" >&2; exit 1; }
sha=$(curl -fsSL "$dmg.sha256" | tr -d '[:space:]')
case "$sha" in *[!0-9a-f]*|"") echo "bad checksum for $v" >&2; exit 1 ;; esac
[ "${#sha}" -eq 64 ] || { echo "bad checksum length for $v" >&2; exit 1; }
sed -i '' -e "s/^  version \".*\"/  version \"$v\"/" -e "s/^  sha256 .*/  sha256 \"$sha\"/" Casks/mxterm-pro.rb
echo "mxterm-pro -> $v ($sha)"
