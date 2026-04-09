# kkamppak

Switch between **default macOS power settings** and **Remote Ready** (sleep off, keep remote/Parsec-friendly) with a single `NSAlert`.

[Korean](README.md) | [English](README.en.md)

Repository: [github.com/devuterian/kkamppak](https://github.com/devuterian/kkamppak)

Repo operating model: [REPO.md](REPO.md). Product summary: [SPEC.md](SPEC.md).

---

## Install

1. Grab the latest build from **[Releases](https://github.com/devuterian/kkamppak/releases)** (or **build from source** below).
2. Copy **kkamppak.app** into **Applications**.
3. On **first launch**, enter your admin password once (installs helper script, LaunchDaemon, and a narrow `sudoers` rule).
4. After that, pick a mode without typing your password again.

**If macOS blocks the app:** unsigned or ad-hoc builds may need **Right-click → Open** once, or approval under **System Settings → Privacy & Security**. This project assumes **no Notarization** is required by design.

---

## Usage

1. Run the app from Dock, Raycast, or a script.
2. The alert shows the **current mode** (from `pmset -g custom`).
3. Choose **기본 설정으로** (default) or **Remote Ready로**. The button matching the current mode is disabled.
4. A **result** alert appears; **OK** quits the app.

**Remote Ready** sets `sleep` / `displaysleep` / `disksleep` to **0**. **Default** uses a **1 / 10 / 10** (minutes) preset. If AC and Battery blocks differ, the UI shows **custom**.

---

## Limitations

- Does not **guarantee** battery life, thermals, or security posture. Remote Ready trades power savings for staying awake.
- The passwordless path is limited to the **installed apply script**; if that path changes, you may need to re-run the installer flow.

---

## Source & contributing

- Build: [`docs/build.md`](docs/build.md)
- Commit hooks & trailers: [`CONTRIBUTING.md`](CONTRIBUTING.md)
- Behavior summary: [`SPEC.md`](SPEC.md)

Please file bugs and questions in [Issues](https://github.com/devuterian/kkamppak/issues).

---

## License

[MIT License](LICENSE) — read the license text for disclaimers around system power and privileged operations.
