# Plans

## Planning rules

- 수락된 방향만 적는다. 잡생각은 `INBOX.md`로.

## Approved directions

### Release artifacts

- **Outcome:** `v*` 태그 푸시 시 Actions가 **UDZO DMG** 빌드 후 GitHub Release 자동 생성 (`.github/workflows/release-dmg.yml`). PR·main용 zip 아티팩트는 `build-macos.yml`.
- **Why this is accepted:** 사용자가 소스 빌드 없이 받을 수 있게.
- **Preconditions:** 시맨틱 버전 태그 예: `v1.0.0`; (선택) Developer ID 서명 시 워크플로 확장.
- **Related ids:** —

### 문서·검증

- **Outcome:** 스모크 테스트·제거 절차·Raycast 예시가 README·`docs/`에 정리됨.
- **Status:** 진행 중 (`docs/smoke-test.md`, `docs/uninstall.md`).

### CI 빌드

- **Outcome:** PR·`main` 푸시 시 macOS runner에서 **서명 없이** `xcodebuild`로 컴파일 검증, `kkamppak.app.zip` 아티팩트.
- **Workflow:** `.github/workflows/build-macos.yml`

## Sequencing

### Near term

- **Initiative:** 첫 `v*` 태그 푸시로 DMG 릴리즈 확인

### Mid term

- **Initiative:** Developer ID 서명 + (필요 시) 공증은 제품 정책 바뀔 때만 검토 — 현재 SPEC은 Notarization 비목표

### 보류 (운영자 전용)

- **Initiative:** AppIcon 에셋 채우기 — Dock 식별용; 별도 요청 시 진행
