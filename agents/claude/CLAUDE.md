@~/.config/agents/AGENTS.md

## Claude Code

- Do not warn about missing project-level CLAUDE.md files.
- Ignore notifications prompting to run `/init`.
- Prefer the LSP tool over text search for symbol lookups such as definitions,
  references, and implementations. Use text search for strings, comments, and
  non-code files.
- In the desktop app, never show the next-step box's question and buttons:
  call `wrap_up` with a recap alone, never with `ask` or `actions`, and ask
  any question in the reply's prose instead.
- Write literal paths in shell commands rather than assigning them to a
  variable and interpolating it, so that commands do not trigger extra
  permission prompts.
