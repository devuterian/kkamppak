# Status

## Snapshot

- **Last updated:** 2026-04-11
- **Overall posture:** `active`
- **Current focus:** `v*` 태그 푸시 시 Actions가 DMG 빌드·GitHub Release 자동화 (`release-dmg.yml`)
- **Highest-priority blocker:** 없음 (커밋은 provenance trailer 또는 명시적 migration/bootstrap 예외)
- **Related decisions:** —

## Current state summary

Xcode 프로젝트는 `apps/kkamppak/kkamppak.xcodeproj`에 있으며, Swift 앱이 `pmset` 기반 스크립트로 전원 프리셋을 적용한다. 저장소 루트는 SPEC/STATUS/PLANS/INBOX·skills·records·커밋 검사를 포함한다. **서명 없는** macOS CI: `build-macos.yml`(PR·main zip 아티팩트), `release-dmg.yml`(`v*` 태그 → DMG + Release).

## Active phases or tracks

### App delivery

- **Goal:** 빌드 검증(CI) + 문서로 설치·제거·스모크 경로 명확화
- **Status:** `in progress`
- **Exit criteria:** README와 `docs/`가 “소스 빌드 / 릴리스(있을 때)”를 일관되게 설명
- **Related ids:** —

## Recent changes to project reality

- **2026-04-09:** 앱 소스 `apps/kkamppak/`, repo 운영 문서·커밋 표준 도입
- **2026-04-10:** `docs/smoke-test.md`, `docs/uninstall.md`, README 정리, SPEC에 프리셋·LaunchDaemon 설명, macOS CI 빌드 워크플로

## Immediate next steps

- 운영자: `git tag v1.0.0 && git push origin v1.0.0` 로 첫 DMG 릴리즈 확인
- 로컬 개발: `./scripts/install-hooks.sh`로 커밋 훅 켜 두기 (`CONTRIBUTING.md`)
