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

# GitHub/GitLab merge commits do not carry project trailers; only check real commits.
commits=$(git -C "$repo_root" rev-list --no-merges "$base..$head")

if [ -z "$commits" ]; then
	echo "No commits to check in range $base..$head"
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
