Opened: 2026-04-09 12-00-00 KST
Recorded by agent: cursor-background

# LOG-20260409-001 — repo layout & docs

## Summary

- README를 killeverybody 톤으로 재작성하고 영문 `README.en.md` 추가.
- [LPFchan/repo-template](https://github.com/LPFchan/repo-template)에 맞춰 `REPO.md`, `SPEC.md`, `STATUS.md`, `PLANS.md`, `INBOX.md`, `skills/`, `records/`, `research/`, 커밋 검사 스크립트·CI·`.githooks` 추가.
- Xcode 프로젝트를 `apps/kkamppak/`로 이동.
- MIT `LICENSE`, `CONTRIBUTING.md`, `docs/build.md` 추가.

## Verification

- 훅/스크립트 실행 비트 설정됨 (`chmod +x`).

## Follow-up (same log)

- README 하단에 [LPFchan/repo-template](https://github.com/LPFchan/repo-template) 감사 문구 추가, 영문 README에 토스 원칙·감사 문구 정리.
- 운영자 지시문 원문 보관: `docs/operator-prompt-repo-template-adoption.md`
- `recreate-prompt.md` 추가, 루트 `skills/`를 업스트림 스캐폴드와 동기화, `REPO.md`·`AGENTS.md`·`CONTRIBUTING.md`에 안내 링크.
- 중복이던 로컬 `scaffold/` 제거 — 복사용 원본은 [LPFchan/repo-template](https://github.com/LPFchan/repo-template/tree/main/scaffold)만 유지.
