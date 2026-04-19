---
name: ida-mcp-workflow
description: Repository setup and IDA Pro research workflow for repos that manage IDA analysis, inspect call sites with `ida-pro-mcp`, and record notes under `tasks/`, `functions/`, and `resources/`.
---

# IDA Research Workflow

Use this skill when the repository is used as a durable IDA research workspace and the work should be recorded under
`tasks/`, `functions/`, and `resources/`.

This skill is the canonical agent workflow for this repository. Treat `README.md` as the human-oriented overview and
follow this skill for durable output locations, task scaffolding, and research execution.

## Use cases

- Set up a fresh repo for IDA-based research
- Trace call chains, decryption paths, asset loading, or data formats with `ida-pro-mcp`
- Turn a live analysis session into durable notes and per-topic reports

## Quick start

1. Confirm `ida-pro-mcp` is available.
2. Check `resources/` for binaries, dumps, and prior extracts.
3. Run `main.py` through `ida-pro-mcp` `py_exec_file` when `resources/functions_list/*.txt` is missing.
4. Pick the task slug.
5. Create `tasks/<slug>/task.md` and `tasks/<slug>/walkthrough.md` before any deep analysis, call-chain tracing, or string triage beyond basic setup checks.
6. Update `tasks/subjects.md` as soon as the slug and goal are stable enough to index.
7. Make the scaffold commit before continuing, unless the user explicitly asked for no commits or the work is only a draft pass.
8. Record findings continuously in `functions/*.md` and `tasks/<slug>/`.

## Working rules

- Use `ida-pro-mcp` for verification inside IDA.
- Record observations before conclusions. Avoid answer-first summaries without evidence.
- Do the scaffold first. Do not postpone `task.md` / `walkthrough.md` creation until after the main path is understood.
- Start a function note as soon as a function becomes important enough to revisit or cite.
- Keep function notes and walkthrough logs up to date while investigating.
- Add `quick.md` and `detail.md` once the main path is understood well enough to explain.
- Use Python PoCs only when a claim needs executable validation. Run them with `uv`.
- Keep commits small and meaningful.
- Separate task scaffolding, major analysis milestones, and PoC work into different commits when they would be reviewed independently.
- If the user did not forbid commits, treat each commit checkpoint below as an action item, not as a suggestion.

## File creation checkpoints

- New topic: create `tasks/<slug>/`, `task.md`, and `walkthrough.md`.
- New durable topic: add or update the `tasks/subjects.md` entry.
- Important function identified: create or extend `functions/<name>.md`.
- Main path understood: add `quick.md` and `detail.md`.
- Extra structure only when it helps: split topic notes under `tasks/<slug>/` and PoCs under `tasks/<slug>/poc/`.

## Commit checkpoints

- Commit task scaffolding after the slug, task contract, and walkthrough skeleton are in place.
- Do not continue into substantive tracing until this scaffold checkpoint is complete.
- Commit durable analysis updates after a meaningful path, caller/callee chain, or data-flow claim is verified in IDA.
- Commit PoCs separately from note-only updates when the PoC is part of the evidence.
- Use English Conventional Commits and keep each commit understandable without reading later commits.

## Commit message examples

- `docs(task): scaffold asset-loader research task`
- `docs(functions): document TextureArchive::LoadArchive call chain`
- `feat(poc): add xor stream decoder validation script`

## Read these references as needed

- Repository layout and directory ownership: [repo_layout.md](./references/repo_layout.md)
- Research loop and task lifecycle: [research_flow.md](./references/research_flow.md)
- `ida-pro-mcp` usage patterns: [mcp_usage.md](./references/mcp_usage.md)
- Output file contracts and examples: [output_contracts.md](./references/output_contracts.md)

## Optional dependency

- `idapython`
  - Use only when you need concrete IDA Python API examples or helper scripts for bulk extraction.
