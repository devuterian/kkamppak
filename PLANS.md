# Plans

## Planning rules

- 수락된 방향만 적는다. 잡생각은 `INBOX.md`로.

## Approved directions

### Release artifacts

- **Outcome:** GitHub Releases에 `.app` zip 업로드 (또는 CI 아티팩트를 릴리스에 붙이기). README **방법 B**와 맞출 것.
- **Why this is accepted:** 사용자가 소스 빌드 없이 받을 수 있게.
- **Preconditions:** 태그·릴리스 노트; (선택) Developer ID 서명 시 GitHub secret 연동.
- **Related ids:** —

### 문서·검증

- **Outcome:** 스모크 테스트·제거 절차·Raycast 예시가 README·`docs/`에 정리됨.
- **Status:** 진행 중 (`docs/smoke-test.md`, `docs/uninstall.md`).

### CI 빌드

- **Outcome:** PR·`main` 푸시 시 macOS runner에서 **서명 없이** `xcodebuild`로 컴파일 검증, `kkamppak.app.zip` 아티팩트.
- **Workflow:** `.github/workflows/build-macos.yml`

## Sequencing

### Near term

- **Initiative:** 첫 GitHub Release 게시 (unsigned zip이라도) + README와 동기화
- **Initiative:** (선택) Release 워크플로로 태그 시 자동 zip 첨부

### Mid term

- **Initiative:** Developer ID 서명 + (필요 시) 공증은 제품 정책 바뀔 때만 검토 — 현재 SPEC은 Notarization 비목표

### 보류 (운영자 전용)

- **Initiative:** AppIcon 에셋 채우기 — Dock 식별용; 별도 요청 시 진행
