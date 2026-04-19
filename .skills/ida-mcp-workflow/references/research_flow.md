# Research Flow

## 1. Prepare the workspace

1. Reduce the research theme to a short slug.
2. Check `resources/` for binaries, extracted metadata, and previous source dumps.
3. Check `tasks/subjects.md` for existing or overlapping work.
4. If needed, run `main.py` through `ida-pro-mcp` to generate `resources/functions_list/*.txt`.

## 2. Set up the task folder

1. Create `tasks/<slug>/`.
2. Add `task.md` with goal, assumptions, and non-goals.
3. Add `walkthrough.md` before deep analysis starts.
4. Add or update the `tasks/subjects.md` entry for the slug.
5. Commit the scaffold once the task contract and initial log are reviewable.

## 3. Investigate in IDA

Repeat this loop with `ida-pro-mcp`.

- Choose an entry point from strings, imports, names, vtables, or `functions_list`
- Trace both callers and callees
- Confirm important branches, tables, constants, and struct layouts
- Write durable notes immediately in `functions/*.md` and `walkthrough.md`
- Re-check prior assumptions with alternate xrefs when the path matters

## 4. Consolidate the result

Update at least these files once the path is understood.

- `quick.md` for the shortest defensible answer
- `detail.md` for the full explanation
- extra `*.md` files when the topic is easier to explain in split documents
- Commit this milestone after the main claim and evidence are readable without live IDA context.

## 5. Add a PoC only when needed

Use `tasks/<slug>/poc/*.py` only when executable validation adds value.

- decryption and decoding checks
- binary format validation with real samples
- minimal reproductions of key transforms

Run PoCs with `uv run`.
Commit PoCs separately when they materially expand the evidence or review surface.
