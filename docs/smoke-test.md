# 스모크 테스트 (kkamppak)

실제 Mac에서 **한 번씩** 확인할 때 쓰는 짧은 체크리스트예요.

## 준비

- [ ] Xcode로 `apps/kkamppak/kkamppak.xcodeproj` 빌드하거나, 배포용 `.app` 준비
- [ ] 테스트 맥에서 로그인 세션(GUI) 사용

## 첫 실행·설치

- [ ] 앱 실행 → **설치** 선택 → 관리자 암호 입력 → 오류 없이 끝남
- [ ] `/usr/local/lib/kkamppak/kkamppak-apply.sh` 존재
- [ ] `/Library/LaunchDaemons/com.kkamppak.helper.plist` 존재
- [ ] `/private/etc/sudoers.d/kkamppak` 존재 (해당 사용자·스크립트 경로만 NOPASSWD)

## 모드 전환

- [ ] 알림에 **현재 모드** 표시됨 (`pmset -g custom`과 대략 일치)
- [ ] 현재 모드와 같은 버튼 비활성화
- [ ] 다른 모드 선택 → **결과 알림** → OK 시 앱 종료
- [ ] 터미널에서 `pmset -g custom`으로 `sleep` / `displaysleep` / `disksleep` 값이 기대와 맞는지 확인  
  - Remote Ready: AC·배터리 블록 모두 해당 키가 `0` 근처  
  - 기본 프리셋: 앱이 쓰는 **1 / 10 / 10(분)** ([SPEC.md](../SPEC.md) 참고)

## 재실행

- [ ] 두 번째 실행부터는 설치 단계 없이 바로 모드 선택 알림만 뜸
- [ ] `sudo` 암호 없이 적용되는지 확인 (설치된 스크립트 경로가 그대로일 때)

## 제거

- [ ] [`uninstall.md`](uninstall.md) 순서대로 지운 뒤 헬퍼·sudoers가 사라졌는지 확인
