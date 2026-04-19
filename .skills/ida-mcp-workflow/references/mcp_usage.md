# MCP Usage

Use `ida-pro-mcp` as the source of truth for what currently exists in the IDA database.

## Default usage

- Use decompilation, callers, callees, and xref inspection to confirm behavior
- Use function lists and symbol names only to decide where to look next
- Verify every important claim against the live database before treating it as final

## What to capture from MCP-backed observations

- function address and current IDA name
- strongest caller or callee relationship
- key arguments, return values, and side effects
- constants, offsets, struct fields, or string references that support the conclusion

## Escalate to a PoC when

- a transform is easier to prove by executing it
- a binary format assumption needs sample-based validation
- the control flow is clear but the data interpretation is still uncertain

## Avoid

- copying large pseudocode dumps when a smaller summary plus the critical block is enough
- concluding from one xref path when the function has multiple material call sites
- leaving observations only in chat instead of the repo notes
