#!/usr/bin/env bash
# Usage: ./build.sh <base-url> [site-url] [out-dir]
#
# Builds both sideloadable manifests from the templates and stamps the version
# into the task pane. <Version> in manifest.template.xml is the single source of
# truth for the version number; nothing else needs editing to cut a release.
#
#   ./build.sh https://you.github.io/your-repo https://you.example/your-page
#   ./build.sh https://localhost:3000 https://localhost:3000 dist   # local testing
#
# Writes <out-dir>/manifest.xml, <out-dir>/manifest.json and the zipped app
# package that unified-manifest hosts install from.
#
# Each manifest has two GUIDs: the production one, which is what the store and
# every real install know the add-in by, and a dev one used when <base-url> is
# localhost (or when DEV=1). Outlook keys installed add-ins on the GUID, so a
# dev build carrying the production id would sit on the mailbox pointed at a
# dead localhost, block the real one from installing, and resist removal. The
# dev build is also named "(dev)" so the two are telling apart in the add-in
# list.
set -euo pipefail
here="$(cd "$(dirname "$0")" && pwd)"
base="${1:?base url}"; base="${base%/}"
site="${2:-$base}"; site="${site%/}"
out="${3:-$here}"

# Production ids. These must never change: the store, and every mailbox the
# add-in is installed on, identify it by them. The two manifests are distinct
# Marketplace offers and must not share one.
xml_id_prod="57416ff4-2fb1-4851-a9c1-1014b2572f55"
json_id_prod="bd2bae9e-e017-43b1-9d50-f1a210c3b569"
xml_id_dev="3e6d1c7a-4b0f-4e2a-9a8e-6f1d2c9b5a10"
json_id_dev="c0a7e9d4-2f3b-4d61-8b5e-9e4a7c1d2f33"

case "${DEV:-}${base}" in
  1*|*://localhost*|*://127.0.0.1*) xml_id="$xml_id_dev"; json_id="$json_id_dev"; name_suffix=" (dev)" ;;
  *) xml_id="$xml_id_prod"; json_id="$json_id_prod"; name_suffix="" ;;
esac

version="$(sed -n 's:.*<Version>\([^<]*\)</Version>.*:\1:p' "$here/manifest.template.xml" | head -1)"
[ -n "$version" ] || { echo "no <Version> found in manifest.template.xml" >&2; exit 1; }

# The two manifest formats disagree on arity: the add-in only manifest wants
# a.b.c.d, while the unified manifest schema requires exactly n.n.n. Derive the
# short form rather than making anyone keep two numbers in step by hand.
version_json="$(echo "$version" | cut -d. -f1-3)"

# stamp <template> <version> <app-id>
stamp() {
  sed -e "s|__BASE_URL__|$base|g" -e "s|__SITE_URL__|$site|g" -e "s|__VERSION__|$2|g" \
      -e "s|__APP_ID__|$3|g" -e "s|__NAME_SUFFIX__|$name_suffix|g" "$1"
}

mkdir -p "$out"
# Must be absolute: the packaging step below runs from a staging directory, so a
# relative out-dir would resolve against that instead of the caller's cwd.
out="$(cd "$out" && pwd)"
stamp "$here/manifest.template.xml"  "$version"      "$xml_id"  > "$out/manifest.xml"
stamp "$here/manifest.template.json" "$version_json" "$json_id" > "$out/manifest.json"

# The task pane's cache-busting query string has to match the version: Outlook
# caches add-in subresources in a store that ignores Cache-Control, so a changed
# URL is the only reliable way to get an updated taskpane.js to clients.
sed -i "s|taskpane\.js?v=[^\"]*|taskpane.js?v=$version|" "$here/src/taskpane.html"

# Unified-manifest hosts install from a zip holding the manifest and its two
# package-relative icons, not from a bare manifest file.
pkg="$out/outlook-markdown-exporter.zip"
rm -f "$pkg"
staging="$(mktemp -d)"
trap 'rm -rf "$staging"' EXIT
cp "$out/manifest.json" "$here/assets/color.png" "$here/assets/outline.png" "$staging/"
( cd "$staging" && 7z a -tzip -bso0 -bsp0 "$pkg" manifest.json color.png outline.png >/dev/null )

echo "version  $version${name_suffix}" >&2
echo "xml      $out/manifest.xml" >&2
echo "json     $out/manifest.json" >&2
echo "package  $pkg"              >&2
