# Status

## Snapshot

- **Last updated:** 2026-04-09
- **Overall posture:** `active`
- **Current focus:** macOS AppKit 앱 + repo-template 레이아웃 정리
- **Highest-priority blocker:** 없음 (CI·로컬 훅은 커밋 trailer 정책 준수 필요)
- **Related decisions:** —

## Current state summary

Xcode 프로젝트는 `apps/kkamppak/kkamppak.xcodeproj`에 있으며, Swift 앱이 `pmset` 기반 스크립트로 전원 프리셋을 적용한다. 저장소 루트는 [repo-template](https://github.com/LPFchan/repo-template) 스타일의 SPEC/STATUS/PLANS/INBOX·skills·records·커밋 검사를 포함한다.

## Active phases or tracks

### App delivery

- **Goal:** 직접 빌드·배포 가능한 `.app` 유지
- **Status:** `in progress`
- **Exit criteria:** README의 설치·사용 흐름과 코드 동작 일치
- **Related ids:** —

## Recent changes to project reality

- **2026-04-09:** 앱 소스를 `apps/kkamppak/` 아래로 이동, repo-template 스캐폴드 및 커밋 표준 도입

## Immediate next steps

- Releases 아티팩트 또는 빌드 파이프라인은 운영자가 필요 시 추가
