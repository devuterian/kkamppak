# Contributing

## 빌드

Mac에서 Xcode로 `apps/kkamppak/kkamppak.xcodeproj`를 열고 빌드하면 돼요. 자세한 건 [`docs/build.md`](docs/build.md).

## 운영자 지시문 보관

레이아웃·README를 손볼 때 쓴 **원문 프롬프트**는 [`docs/operator-prompt-repo-template-adoption.md`](docs/operator-prompt-repo-template-adoption.md)에 두었어요.

## repo-template 스캐폴드

- [`recreate-prompt.md`](recreate-prompt.md) — 다른 레포에 같은 운영 체계를 심을 때 에이전트에게 줄 프롬프트
- [`scaffold/`](scaffold/README.md) — [LPFchan/repo-template](https://github.com/LPFchan/repo-template) `scaffold/` 사본 (upstream-intake 제외)

## 커밋 메시지 (repo-template)

이 저장소는 [LPFchan/repo-template](https://github.com/LPFchan/repo-template) 스타일의 **provenance trailer**를 써요.

커밋 본문에 아래 네 줄을 넣어 주세요. (예시 값은 실제 작업에 맞게 바꿔요.)

```text
project: kkamppak
agent: <your-handle-or-run-id>
role: operator
artifacts: LOG-20260409-001
```

`role`은 `orchestrator` | `worker` | `subagent` | `operator` 중 하나예요.

`artifacts`는 `IBX-`, `RSH-`, `DEC-`, `LOG-` 등 **프리픽스-날짜-번호** 형식이에요. 여러 개면 쉼표로 구분해요.

**예외:** 저장소를 처음 맞추거나 큰 이주만 할 때는 커밋 제목/본문에 `bootstrap` 또는 `migration`을 분명히 쓰면 검사를 건너뛸 수 있어요.

## 로컬 git hook

```bash
./scripts/install-hooks.sh
```

푸시 전에 CI에서도 같은 규칙을 다시 검사해요.
