#!/bin/bash
set -euo pipefail

MODE="${1:-}"
case "$MODE" in
	default)
		pmset -a sleep 1 disksleep 10 displaysleep 10
		;;
	remote)
		pmset -a sleep 0 disksleep 0 displaysleep 0
		;;
	*)
		exit 1
		;;
esac
