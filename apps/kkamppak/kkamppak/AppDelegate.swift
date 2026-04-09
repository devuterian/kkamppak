import AppKit

enum PowerMode: Equatable {
    case `default`
    case remoteReady
    case custom

    var displayName: String {
        switch self {
        case .default: return "기본 설정"
        case .remoteReady: return "Remote Ready"
        case .custom: return "사용자 지정"
        }
    }

    var resultMessage: String {
        switch self {
        case .default: return "기본 설정 모드로 변경했습니다."
        case .remoteReady: return "Remote Ready 모드로 변경했습니다."
        case .custom: return "전원 설정을 적용했습니다."
        }
    }
}

@main
final class AppDelegate: NSObject, NSApplicationDelegate {
    private let applyScriptPath = "/usr/local/lib/kkamppak/kkamppak-apply.sh"

    func applicationDidFinishLaunching(_ notification: Notification) {
        NSApp.setActivationPolicy(.regular)
        NSApp.activate(ignoringOtherApps: true)

        DispatchQueue.main.async { [weak self] in
            self?.runMainFlow()
        }
    }

    private func runMainFlow() {
        if !isHelperInstalled() {
            guard runFirstTimeInstall() else {
                NSApp.terminate(nil)
                return
            }
        }

        let current = detectCurrentMode()
        guard let chosen = presentModeChoice(current: current) else {
            NSApp.terminate(nil)
            return
        }

        guard applyMode(chosen) else {
            presentErrorAlert(message: "전원 설정을 적용하지 못했습니다.", detail: "관리자 권한이나 설치 상태를 확인한 뒤 다시 실행해 주세요.")
            NSApp.terminate(nil)
            return
        }

        presentResultThenQuit(for: chosen)
    }

    private func isHelperInstalled() -> Bool {
        FileManager.default.isExecutableFile(atPath: applyScriptPath)
    }

    private func runFirstTimeInstall() -> Bool {
        let alert = NSAlert()
        alert.messageText = "설치가 필요합니다"
        alert.informativeText = "최초 실행입니다. 관리자 암호를 한 번 입력하면 도구가 설치되고, 이후에는 암호 없이 모드를 바꿀 수 있습니다."
        alert.alertStyle = .informational
        alert.addButton(withTitle: "설치")
        alert.addButton(withTitle: "취소")

        guard alert.runModal() == .alertFirstButtonReturn else { return false }

        guard let installURL = Bundle.main.url(forResource: "install", withExtension: "sh") else {
            presentErrorAlert(message: "설치 스크립트를 찾을 수 없습니다.", detail: "앱 번들이 손상되었을 수 있습니다.")
            return false
        }

        let escaped = installURL.path.replacingOccurrences(of: "'", with: "'\\''")
        let osa = "do shell script \"bash '\\(escaped)'\" with administrator privileges"

        let task = Process()
        task.executableURL = URL(fileURLWithPath: "/usr/bin/osascript")
        task.arguments = ["-e", osa]

        let pipe = Pipe()
        task.standardError = pipe
        task.standardOutput = Pipe()

        do {
            try task.run()
            task.waitUntilExit()
        } catch {
            presentErrorAlert(message: "설치를 시작하지 못했습니다.", detail: error.localizedDescription)
            return false
        }

        if task.terminationStatus != 0 {
            let errData = pipe.fileHandleForReading.readDataToEndOfFile()
            let errText = String(data: errData, encoding: .utf8) ?? ""
            presentErrorAlert(message: "설치에 실패했습니다.", detail: errText.isEmpty ? "종료 코드 \(task.terminationStatus)" : errText)
            return false
        }

        return isHelperInstalled()
    }

    private func detectCurrentMode() -> PowerMode {
        let task = Process()
        task.executableURL = URL(fileURLWithPath: "/usr/bin/pmset")
        task.arguments = ["-g", "custom"]

        let pipe = Pipe()
        task.standardOutput = pipe
        task.standardError = FileHandle.nullDevice

        do {
            try task.run()
            task.waitUntilExit()
        } catch {
            return .custom
        }

        guard task.terminationStatus == 0 else { return .custom }

        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        guard let output = String(data: data, encoding: .utf8) else { return .custom }

        let blocks = extractPowerSourceBlocks(from: output)
        guard !blocks.isEmpty else { return .custom }

        let modes = Set(blocks.map { classifyPmsetBlock($0) })
        if modes.count == 1, let only = modes.first, only != .custom {
            return only
        }
        return .custom
    }

    private enum BlockMode { case `default`, remoteReady, custom }

    private func classifyPmsetBlock(_ block: String) -> BlockMode {
        let sleepM = parsePmsetInt(key: "sleep", in: block)
        let displayM = parsePmsetInt(key: "displaysleep", in: block)
        let diskM = parsePmsetInt(key: "disksleep", in: block)

        if sleepM == 0 && displayM == 0 && diskM == 0 {
            return .remoteReady
        }

        if (sleepM == 1 || sleepM == nil) && (displayM == 10 || displayM == nil) && (diskM == 10 || diskM == nil) {
            return .default
        }

        return .custom
    }

    private func extractPowerSourceBlocks(from pmsetOutput: String) -> [String] {
        let lines = pmsetOutput.split(separator: "\n", omittingEmptySubsequences: false).map(String.init)
        var blocks: [String] = []
        var currentHeader: String?
        var buffer: [String] = []

        func flush() {
            guard currentHeader != nil, !buffer.isEmpty else { return }
            blocks.append(buffer.joined(separator: "\n"))
            buffer.removeAll()
        }

        for line in lines {
            let trimmed = line.trimmingCharacters(in: .whitespaces)
            if trimmed == "AC Power:" || trimmed == "Battery Power:" {
                flush()
                currentHeader = trimmed
                continue
            }
            if currentHeader != nil {
                if trimmed.hasSuffix(":"), trimmed != "AC Power:", trimmed != "Battery Power:" {
                    flush()
                    currentHeader = nil
                    continue
                }
                buffer.append(line)
            }
        }
        flush()
        return blocks
    }

    private func parsePmsetInt(key: String, in block: String) -> Int? {
        let pattern = "^\\s*\(NSRegularExpression.escapedPattern(for: key))\\s+(\\d+)\\b"
        guard let regex = try? NSRegularExpression(pattern: pattern, options: [.anchorsMatchLines]) else { return nil }
        let range = NSRange(block.startIndex..., in: block)
        guard let match = regex.firstMatch(in: block, options: [], range: range),
              match.numberOfRanges >= 2,
              let r = Range(match.range(at: 1), in: block) else { return nil }
        return Int(block[r])
    }

    private func presentModeChoice(current: PowerMode) -> PowerMode? {
        let alert = NSAlert()
        alert.messageText = "어떤 모드로 변경할까요?"
        alert.informativeText = """
        현재 모드: \(current.displayName)

        • 기본 설정: 시스템 전원 관리를 일반적으로 사용합니다.
        • Remote Ready: 슬립을 완전히 끄고 Parsec·원격 연결을 유지합니다.

        Remote Ready는 슬립을 완전히 끄고 Parsec·원격 연결을 유지합니다.
        """
        alert.alertStyle = .informational

        alert.addButton(withTitle: "기본 설정으로")
        alert.addButton(withTitle: "Remote Ready로")
        alert.addButton(withTitle: "취소")

        switch current {
        case .default:
            alert.buttons[0].isEnabled = false
        case .remoteReady:
            alert.buttons[1].isEnabled = false
        case .custom:
            break
        }

        let response = alert.runModal()
        switch response {
        case .alertFirstButtonReturn:
            return .default
        case .alertSecondButtonReturn:
            return .remoteReady
        default:
            return nil
        }
    }

    private func applyMode(_ mode: PowerMode) -> Bool {
        let arg: String
        switch mode {
        case .default:
            arg = "default"
        case .remoteReady:
            arg = "remote"
        case .custom:
            return false
        }

        let task = Process()
        task.executableURL = URL(fileURLWithPath: "/usr/bin/sudo")
        task.arguments = [applyScriptPath, arg]

        let err = Pipe()
        task.standardError = err
        task.standardOutput = FileHandle.nullDevice

        do {
            try task.run()
            task.waitUntilExit()
        } catch {
            return false
        }

        return task.terminationStatus == 0
    }

    private func presentResultThenQuit(for mode: PowerMode) {
        let alert = NSAlert()
        alert.messageText = mode.resultMessage
        alert.informativeText = ""
        alert.alertStyle = .informational
        alert.addButton(withTitle: "OK")
        alert.runModal()
        NSApp.terminate(nil)
    }

    private func presentErrorAlert(message: String, detail: String) {
        let alert = NSAlert()
        alert.messageText = message
        alert.informativeText = detail
        alert.alertStyle = .warning
        alert.addButton(withTitle: "OK")
        alert.runModal()
    }
}
