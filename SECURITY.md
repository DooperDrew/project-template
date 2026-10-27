# Security Policy

The **{{PROJECT_NAME}}** team takes software integrity, platform safety, and user security seriously.

---

## 1. Supported Versions

Security updates and critical patches are released for the following versions:

| Version | Supported | Notes |
|---|---|---|
| `v0.1.x` | ✅ Yes | Current development / release branch |

---

## 2. Core Security & Safety Guarantees

This project is engineered under strict non-functional security constraints:

1. **User-Space Safety (NFR-S1):** No unsigned kernel drivers or unverified native DLL injection.
2. **Infinite Loop & Recursion Prevention:** All synthetic events or asynchronous messages are tagged with distinct markers to prevent infinite self-amplification loops.
3. **Graceful Degradation & Cleanup:** OS hooks, network sockets, named pipes, and file locks are cleanly released on termination, suspension, or crash.
4. **Privacy & Offline First:** Zero silent telemetry, zero keystroke logging, and zero unauthorized external network transmission.

---

## 3. Reporting a Vulnerability

If you discover a potential security vulnerability:
- Please report it via **GitHub Private Vulnerability Reporting** (`https://github.com/{{REPO_URL}}/security/advisories/new`) or contact maintainers privately.
- Please do **not** open a public issue for zero-day security vulnerabilities.
- We will acknowledge receipt within 48 hours and coordinate a fix before disclosure.
