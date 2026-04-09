#!/bin/sh

set -eu

if [ "$#" -ne 2 ]; then
	echo "usage: $0 <base_sha> <head_sha>" >&2
	exit 2
fi

base=$1
head=$2

repo_root=$(cd "$(dirname "$0")/.." && pwd)
checker="$repo_root/scripts/check-commit-standards.sh"

ZERO=0000000000000000000000000000000000000000

valid_base() {
	git -C "$repo_root" rev-parse -q --verify "$1^{commit}" >/dev/null 2>&1
}

# github.event.before is all zeros on first push of a new ref — "base..head" is invalid.
# Merge commits do not carry project trailers; use --no-merges.
if [ "$base" = "$ZERO" ] || [ -z "$base" ] || ! valid_base "$base"; then
	if git -C "$repo_root" show-ref --verify --quiet refs/remotes/origin/main; then
		commits=$(git -C "$repo_root" rev-list --no-merges "origin/main..$head")
	else
		commits=$(git -C "$repo_root" rev-list --no-merges "$head")
	fi
else
	commits=$(git -C "$repo_root" rev-list --no-merges "$base..$head")
fi

if [ -z "$commits" ]; then
	echo "No commits to check in range $base..$head (after resolving base)"
	exit 0
fi

for commit in $commits; do
	tmp=$(mktemp)
	git -C "$repo_root" log -1 --format=%B "$commit" >"$tmp"
	if ! "$checker" "$tmp"; then
		echo >&2
		echo "Offending commit: $commit" >&2
		rm -f "$tmp"
		exit 1
	fi
	rm -f "$tmp"
done

echo "Commit standards passed for range $base..$head"
