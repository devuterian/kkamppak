# 제거하기 (kkamppak 헬퍼)

앱을 **응용 프로그램에서 지우는 것만**으로는 시스템에 깔린 헬퍼가 남을 수 있어요. 완전히 지울 때는 아래를 **터미널**에서 실행하세요. (관리자 암호 필요)

## 1. LaunchDaemon 내리기·plist 삭제

```bash
sudo launchctl bootout system /Library/LaunchDaemons/com.kkamppak.helper.plist 2>/dev/null || true
sudo rm -f /Library/LaunchDaemons/com.kkamppak.helper.plist
```

## 2. 설치 스크립트 디렉터리 삭제

```bash
sudo rm -rf /usr/local/lib/kkamppak
```

## 3. sudoers 항목 삭제

```bash
sudo rm -f /private/etc/sudoers.d/kkamppak
```

## 4. 앱 번들

**응용 프로그램**에서 `kkamppak.app`을 휴지통으로 내면 됩니다.

## 확인

```bash
test ! -f /usr/local/lib/kkamppak/kkamppak-apply.sh && echo "apply script gone"
test ! -f /private/etc/sudoers.d/kkamppak && echo "sudoers drop-in gone"
```
