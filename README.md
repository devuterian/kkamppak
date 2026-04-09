# kkamppak

맥에서 **기본 전원 설정**과 **Remote Ready**(슬립 끔, 원격·Parsec 유지)를 `NSAlert` 하나로 바꿔요.

[한국어](README.md) | [English](README.en.md)

저장소: [github.com/devuterian/kkamppak](https://github.com/devuterian/kkamppak)

운영·에이전트 규칙은 [REPO.md](REPO.md)를 봐요. 제품 스펙 요약은 [SPEC.md](SPEC.md).

---

## 설치하기

1. **[Releases에서 최신 아티팩트](https://github.com/devuterian/kkamppak/releases)** 를 받아요. (또는 아래 **소스에서 빌드**)
2. **kkamppak.app**을 **응용 프로그램** 폴더에 넣어요.
3. **첫 실행**에서 관리자 암호를 한 번 입력해요. (도구 스크립트·LaunchDaemon·`sudoers` 한 줄이 깔려요.)
4. 그다음부터는 암호 없이 모드만 고르면 돼요.

**보안 경고가 뜨면:** 직접 빌드하거나 서명이 없으면 **우클릭 → 열기**로 한 번 실행하거나, **시스템 설정 → 개인 정보 보호 및 보안**에서 허용해 주면 돼요. 이 프로젝트는 기획상 **공증(Notarization) 없이** 배포해도 된다고 가정해요.

---

## 쓰는 법

1. Dock·Raycast 등에서 앱을 실행해요.
2. **현재 모드**가 안내문에 나와요. (`pmset -g custom` 기준)
3. **기본 설정으로** / **Remote Ready로** 중 하나를 골라요. 지금 모드와 같은 버튼은 비활성화돼요.
4. 적용이 끝나면 **결과 알림**이 뜨고, **OK** 누르면 앱이 꺼져요.

**Remote Ready**는 `sleep` / `displaysleep` / `disksleep`을 0으로 맞춰요. **기본**은 1 / 10 / 10(분) 프리셋이에요. AC와 배터리 설정이 서로 다르면 **사용자 지정**으로 보여요.

---

## 이런 건 못해요

- **배터리 수명·발열·보안**까지 대신 판단해 주진 않아요. Remote Ready는 전원을 덜 아끼는 쪽이에요.
- `sudoers`에 **적용 스크립트 한 줄**만 열어 두므로, 그 파일이 바뀌면 다시 설치 흐름이 필요할 수 있어요.

---

## 소스 코드·기여

- 빌드: [`docs/build.md`](docs/build.md)
- 커밋 메시지·훅: [`CONTRIBUTING.md`](CONTRIBUTING.md)
- 동작 요약: [`SPEC.md`](SPEC.md)

버그·질문은 [Issues](https://github.com/devuterian/kkamppak/issues)에 남겨 주세요.

---

## 라이선스

[MIT License](LICENSE) — 시스템 전원·권한과 관련된 위험은 라이선스 전문과 면책 조항을 확인해 주세요.

한국어 README 문장은 [토스의 8가지 라이팅 원칙](https://toss.tech/article/8-writing-principles-of-toss)을 참고해 짧게 맞췄어요.

---

이 저장소의 **폴더 뼈대·커밋 규칙·에이전트용 문서**는 [LPFchan/repo-template](https://github.com/LPFchan/repo-template)을 많이 참고해 맞췄어요. 덕분에 레포가 훨씬 정리됐어요. **고마워요, LPFchan님.**
