# IDA MCP Workflow

This repository is a template for repo-based IDA Pro research driven by [`ida-pro-mcp`](https://github.com/mrexodia/ida-pro-mcp).

If you use Codex or a compatible client, `$ida-mcp-workflow` points to the repo-local workflow for this template. Keep
analysis materials under `resources/`, function notes under `functions/`, and per-topic writeups under `tasks/`.
`pnpm run setup` also installs the repo-local `$idapython` skill from `ida-pro-mcp` for concrete IDA Python API work
and helper scripts.
For analysis-oriented requests, agents should default to `$ida-mcp-workflow` even when the user does not mention it
explicitly.

## Initial setup

1. `pnpm run setup`
2. `uv run ida-pro-mcp install`
3. Open the target binary in IDA Pro.
4. Start the MCP server.
5. Ask your agent to run this prompt:

```md
Run `main.py` via `ida-pro-mcp` `py_exec_file` to generate the initial function list.
```

## Usage

1. Open the target binary in IDA Pro.
2. Start the MCP server.

### Example prompt

```md
Use `$ida-mcp-workflow`. Investigate how authentication works during the first application launch.
Trace the login flow, related network requests, token or credential handling, and the functions that gate access.
```

## Development Commands

- `pnpm run lint` runs Markdown lint checks for tracked docs under the repo root, `functions/`, and `tasks/`.
- `pnpm run fixpy` applies Ruff fixes and then formats Python files, including PoC helpers when needed.
