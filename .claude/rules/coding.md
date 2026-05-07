---
paths:
  - "**/src/**"
  - "**/*.md"
---

# Code

- All documentation and source code, variables, functions, and commits: **English**.
- **No secrets or passwords in code, env vars, logs, or `.tfvars`.** Use AWS Secrets Manager exclusively.
- **No floats or decimals for monetary values.** Always store as integers in cents. `12999` = R$ 129.99.
- `camelCase` for attribute names and query params.

## Logging

- Structured JSON logger — no plain string logs.
- **No PII in logs.** Never log email, CPF, or phone number.
