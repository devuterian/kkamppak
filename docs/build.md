# 빌드 (kkamppak)

## 요구 사항

- macOS
- Xcode (Swift 5, macOS 13+ 타깃)

## 절차

1. `apps/kkamppak/kkamppak.xcodeproj`를 Xcode로 엽니다.
2. 스킴 **kkamppak**을 선택합니다.
3. **Product → Build** (⌘B) 또는 **Archive**로 `.app`을 만듭니다.

로컬에서 zip으로 묶을 때는 Release 산출물 폴더에서 예를 들어 `zip -r kkamppak.app.zip kkamppak.app` 을 실행하면 됩니다.

## GitHub에서 DMG 릴리즈

`v` 로 시작하는 태그를 푸시하면 Actions가 Release용 DMG를 만들고 [GitHub Releases](https://github.com/devuterian/kkamppak/releases)에 올립니다.

```bash
git tag v1.0.0
git push origin v1.0.0
```

워크플로: `.github/workflows/release-dmg.yml` (서명·공증 없음).

## 산출물

- 빌드 결과: Xcode가 지정한 DerivedData 경로의 `kkamppak.app`
- 앱 번들 **Resources**에 `install.sh`, `kkamppak-apply.sh`, `com.kkamppak.helper.plist`가 포함됩니다.

## 참고

- 공증(Notarization)은 이 프로젝트 범위 밖으로 두었습니다. 배포 시 Gatekeeper 안내는 루트 [README.md](../README.md)를 참고하세요.
- 동작 확인: [`smoke-test.md`](smoke-test.md)
