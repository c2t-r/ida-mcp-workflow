# Repository Layout

## Top-level layout

```text
.
├── AGENTS.md
├── functions/
├── main.py
├── resources/
│   └── functions_list/
├── tasks/
│   ├── <slug>/
│   └── subjects.md
└── .skills/ida-mcp-workflow/
```

## Directory ownership

### `resources/`

- User-provided binaries, asset bundles, extracted source dumps, and generated helper artifacts
- `functions_list/*.txt` is created by `main.py` and is the default first-pass index for finding entry points
- Keep analysis materials here instead of scattering them across the repo

### `functions/`

- Durable notes for functions or methods inspected during research
- Use one file per important function
- Add relative links when one function note depends on another

### `tasks/subjects.md`

- Index of research topics
- Each entry should capture purpose, state, and the strongest current observation

### `tasks/<slug>/`

- One research topic per directory
- Keep the slug short, stable, and easy to search

### `.skills/ida-mcp-workflow/`

- Repo-local workflow instructions for Codex and compatible clients
- Keep SKILL.md lean and move detailed guidance into `references/`
