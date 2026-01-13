# Security

- Do NOT commit secrets (passwords, API keys, private keys) into this repository.
- `src/main/resources/application.properties` is ignored by `.gitignore` for this reason. Use `application.properties.example` as a template.
- For CI and production, use environment variables or your platform's secret manager.
- If you discover a secret was committed, rotate it immediately and contact the repo owner.
- Responsible disclosure: open an issue if you find a security vulnerability.
