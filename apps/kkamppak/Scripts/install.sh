#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
INSTALL_DIR="/usr/local/lib/kkamppak"
APPLY_DST="${INSTALL_DIR}/kkamppak-apply.sh"
DAEMON_PLIST="/Library/LaunchDaemons/com.kkamppak.helper.plist"
SUDOERS_FILE="/private/etc/sudoers.d/kkamppak"

CONSOLE_USER="$(stat -f '%Su' /dev/console 2>/dev/null || true)"
if [[ -z "${CONSOLE_USER}" || "${CONSOLE_USER}" == "root" ]]; then
	echo "로그인한 사용자를 확인할 수 없습니다. GUI 세션에서 설치해 주세요." >&2
	exit 1
fi

mkdir -p "${INSTALL_DIR}"
cp "${SCRIPT_DIR}/kkamppak-apply.sh" "${APPLY_DST}"
chmod 755 "${APPLY_DST}"
chown root:wheel "${APPLY_DST}"

cp "${SCRIPT_DIR}/com.kkamppak.helper.plist" "${DAEMON_PLIST}"
chmod 644 "${DAEMON_PLIST}"
chown root:wheel "${DAEMON_PLIST}"

launchctl bootout system "${DAEMON_PLIST}" 2>/dev/null || true
launchctl bootstrap system "${DAEMON_PLIST}"

TMPFILE="$(mktemp)"
echo "${CONSOLE_USER} ALL=(root) NOPASSWD: ${APPLY_DST}" >"${TMPFILE}"
chmod 0440 "${TMPFILE}"
chown root:wheel "${TMPFILE}"
if ! /usr/sbin/visudo -cf "${TMPFILE}" >/dev/null 2>&1; then
	rm -f "${TMPFILE}"
	echo "sudoers 구문 검사에 실패했습니다." >&2
	exit 1
fi
mv "${TMPFILE}" "${SUDOERS_FILE}"
