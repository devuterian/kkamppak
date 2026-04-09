# 빌드 (kkamppak)

## 요구 사항

- macOS
- Xcode (Swift 5, macOS 13+ 타깃)

## 절차

1. `apps/kkamppak/kkamppak.xcodeproj`를 Xcode로 엽니다.
2. 스킴 **kkamppak**을 선택합니다.
3. **Product → Build** (⌘B) 또는 **Archive**로 `.app`을 만듭니다.

## 산출물

- 빌드 결과: Xcode가 지정한 DerivedData 경로의 `kkamppak.app`
- 앱 번들 **Resources**에 `install.sh`, `kkamppak-apply.sh`, `com.kkamppak.helper.plist`가 포함됩니다.

## 참고

- 아이콘: `Assets.xcassets`의 AppIcon에 실제 PNG를 넣으면 Dock에 표시됩니다.
- 공증(Notarization)은 이 프로젝트 범위 밖으로 두었습니다. 배포 시 Gatekeeper 안내는 루트 [README.md](../README.md)를 참고하세요.
