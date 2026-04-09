# Spec

## Project

- **Name:** kkamppak
- **Canonical repo:** https://github.com/devuterian/kkamppak
- **Project id:** `kkamppak`
- **Last updated:** 2026-04-10

## Thesis

macOS에서 전원 모드를 **대화상자(NSAlert)만**으로 바꾸는 작은 유틸리티. Dock·Raycast 등에서 실행해 **기본 설정**과 **Remote Ready**(슬립·디스플레이·디스크 슬립 끔)를 전환한다.

## Core capabilities

- `NSAlert`로 모드 선택 및 결과 알림 후 종료
- `pmset -g custom` 파싱으로 현재 모드 표시 (AC·배터리 블록이 같을 때만 프리셋 라벨)
- 최초 실행 시 관리자 권한으로 헬퍼 설치: 적용 스크립트, LaunchDaemon 등록, 해당 스크립트만 NOPASSWD `sudoers`

## Power presets

- **Remote Ready:** `pmset -a`로 `sleep`, `displaysleep`, `disksleep`을 **0**(분)으로 설정.
- **기본(앱 프리셋):** 위 세 값을 **1 / 10 / 10**(분)으로 설정. Apple 기본 전원 프로파일과 동일하다고 가정하지 않음; UI·문서에서 “앱이 정한 기본”임을 구분.

## LaunchDaemon (설치 시)

- `com.kkamppak.helper`: 기획 요건(등록) 충족용. 현재 plist는 `RunAtLoad` false이며 실제 주기 작업 없음. 제거 절차는 `docs/uninstall.md`.

## Invariants

- UI는 AppKit `NSAlert` 중심 (별도 설정 창 없음)
- 적용은 `pmset` 기반 셸 스크립트로 수행
- Notarization은 제품 범위 밖으로 둠

## Non-goals

- Sparkle 등 자동 업데이트 프레임워크
- 세밀한 전원 프로파일 UI (예: 개별 키 편집)

## Main surfaces

- 앱 번들: `apps/kkamppak/`
- 사용자 문서: 루트 `README.md`, `docs/build.md`

## Success criteria

- 한 번의 실행으로 모드 전환이 끝나고 앱이 종료된다
- 현재 모드와 동일한 버튼은 선택할 수 없다
- 설치 후 일반 실행에서 관리자 암호 입력 없이 적용이 된다 (설치된 스크립트 경로에 한함)
