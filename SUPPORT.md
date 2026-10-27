# Getting Support

Welcome to the **{{PROJECT_NAME}}** support guide! Whether you need help setting up the application, encountered unexpected behavior, or want to contribute, here is how to get help:

---

## 1. Quick Documentation Links

Before opening an issue, check if your question is covered in the documentation:

- 📖 **[User Guide](docs/user-guide.md)** — Step-by-step setup, configuration options, controls, and troubleshooting.
- 🧪 **[QA & Verification Matrix](docs/06-qa-and-validation.md)** — Known verification procedures, empirical testing status, and test logs.
- 📦 **[Release & Packaging](docs/release-methodology.md)** — Distribution packages, package managers (WinGet / Scoop), and updates.
- 🤖 **[Multi-Agent Architecture Guide](docs/multi-agent-methodology.md)** — Lead orchestrator protocol and Copilot agent workflows.

---

## 2. Frequently Asked Questions

### Q: Do I need administrator rights to install?
**A:** By default, standard installations target `%LOCALAPPDATA%\Programs\<ProjectName>` and require zero administrator / UAC elevation.

### Q: Where are configuration files stored?
**A:** User settings and state are stored in standard OS user application data directories (e.g., `%APPDATA%\<ProjectName>` on Windows, `~/.config/<projectname>` on Linux/macOS).

---

## 3. How to Report Issues & Submit QA Reports

- **Bug Reports:** Open an issue using [Bug Report](.github/ISSUE_TEMPLATE/bug_report.yml) with OS version and reproduction steps.
- **Feature Requests:** Suggest improvements via [Feature Request](.github/ISSUE_TEMPLATE/feature_request.yml).
- **QA Verification Results:** Submit empirical hardware/UI test results using [QA Verification Report](.github/ISSUE_TEMPLATE/qa_verification.yml).
