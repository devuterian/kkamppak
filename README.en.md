# kkamppak

Switch between **default macOS power settings** and **Remote Ready** (sleep off, keep remote/Parsec-friendly) with a single `NSAlert`.

[Korean](README.md) | [English](README.en.md)

Repository: [github.com/devuterian/kkamppak](https://github.com/devuterian/kkamppak)

Repo operating model: [REPO.md](REPO.md). Product summary: [SPEC.md](SPEC.md).

---

## Install

**Option A — build from source (always available)**

1. Build `kkamppak.app` in Xcode as described in [`docs/build.md`](docs/build.md).
2. Copy it into **Applications** and run it.
3. On **first launch**, enter your admin password once (installs helper script, LaunchDaemon, and a narrow `sudoers` rule).
4. After that, pick a mode without typing your password again.

**Option B — release binary (when published)**

If **[Releases](https://github.com/devuterian/kkamppak/releases)** has a zip or other artifact, download it and install the same way. If nothing is there yet, use **Option A**.

**If macOS blocks the app:** unsigned or ad-hoc builds may need **Right-click → Open** once, or approval under **System Settings → Privacy & Security**. This project assumes **no Notarization** is required by design.

---

## Usage

1. Run the app from Dock, Raycast, or a script. (Raycast **script command** example: `open -a kkamppak`)
2. The alert shows the **current mode** (from `pmset -g custom`).
3. Choose **기본 설정으로** (default) or **Remote Ready로**. The button matching the current mode is disabled.
4. A **result** alert appears; **OK** quits the app.

**Remote Ready** sets `sleep` / `displaysleep` / `disksleep` to **0**. **Default** uses the app’s **1 / 10 / 10** (minutes) preset (this may not match every Mac’s factory defaults). If AC and Battery blocks differ, the UI shows **custom**.

---

## Limitations

- Does not **guarantee** battery life, thermals, or security posture. Remote Ready trades power savings for staying awake.
- The passwordless path is limited to the **installed apply script**; if that path changes, you may need to re-run the installer flow.
- The installed **LaunchDaemon** (`com.kkamppak.helper`) is a placeholder (`RunAtLoad` false, no real job). Removal steps: [`docs/uninstall.md`](docs/uninstall.md).

---

## Source & contributing

- Build: [`docs/build.md`](docs/build.md)
- Smoke test: [`docs/smoke-test.md`](docs/smoke-test.md)
- Uninstall (helper & sudoers): [`docs/uninstall.md`](docs/uninstall.md)
- Commit hooks & trailers: [`CONTRIBUTING.md`](CONTRIBUTING.md)
- Behavior summary: [`SPEC.md`](SPEC.md)

Please file bugs and questions in [Issues](https://github.com/devuterian/kkamppak/issues).

---

## License

[MIT License](LICENSE) — read the license text for disclaimers around system power and privileged operations.

---

**Repo layout, commit conventions, and agent-facing docs** lean heavily on [LPFchan/repo-template](https://github.com/LPFchan/repo-template). It made this repository much easier to keep coherent. **Thank you, LPFchan.**

Korean README prose follows [Toss’s eight writing principles](https://toss.tech/article/8-writing-principles-of-toss) (see the Korean README).
