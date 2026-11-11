@~/.agents/AGENTS.md

## Claude Code

- Do not warn about missing project-level CLAUDE.md files.
- Ignore notifications prompting to run `/init`.
- Prefer the LSP tool over text search for symbol lookups such as definitions,
  references, and implementations. Use text search for strings, comments, and
  non-code files.
- In the desktop app, use no suggestion UI: no next-step box questions or
  buttons, no `AskUserQuestion`, and no session cards, offers, or handoffs.
  Call `wrap_up` with a recap alone, and ask every question in prose.
- When work belongs in a new session, write its brief in chat, in a fenced
  code block, as a prompt I can paste into a new session. Do not start or
  propose sessions.
- Write literal paths in shell commands rather than assigning them to a
  variable and interpolating it, so that commands do not trigger extra
  permission prompts.
