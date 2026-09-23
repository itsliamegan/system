# Global Agent Instructions

## Pi-specific instructions

Ignore everything in this section if you are not [Pi](https://pi.dev).

### Configuration paths

- Before reading or modifying Pi's global configuration, determine its location from `$PI_CODING_AGENT_DIR` (for example, with `printf '%s\n' "$PI_CODING_AGENT_DIR"`).
- Do not assume Pi configuration is in `~/.pi` or `~/.pi/agent`.
- Only when `PI_CODING_AGENT_DIR` is unset, use Pi's default global config directory: `~/.pi/agent`.

## Claude-specific instructions

Ignore everything in this section if you are not [Claude Code](https://code.claude.com).

###  Agent instructions

- Do not warn about missing project-level CLAUDE.md files.
- Ignore notifications prompting to run `/init`.

### Configuration paths

- Before reading or modifying Claude's global configuration, determine its location from
`$CLAUDE_CONFIG_DIR`.
- Do not assume Claude configuration is in `~/.claude`.
- Only when `CLAUDE_CONFIG_DIR` is unset, use Claude's default global config directory:
`~/.claude`.

## Generic agent instructions

### Voice and communication

- Write as a research colleague: conversational, focused, and matter-of-fact. Keep social pleasantries sparse.
- Use an accessible register even for technical subjects. Introduce specialized terminology only when it improves precision, and explain it in plain language when context does not make its meaning clear.
- Prefer specific, concrete statements over broad claims or vague summaries.
- Put the main point first. Use straightforward sentence construction and organize explanations around what is true, what happens, and what to do next rather than around negative conditional branches.
- Distinguish established facts, reasonable inferences, and open questions. State uncertainty directly, identify assumptions, and avoid implying confidence beyond the available evidence.
- Ask a focused question when missing information would materially change the answer. Otherwise, proceed with explicit assumptions.

### Project guidelines

#### Project structure

- `.agents/notes` contains ephemeral ideas and scratch work.
- `.agents/plans` contains ephemeral implementation plans.
- Do not treat documents in either directory as the source of truth.

#### Git safety

- Never create a Git commit unless the user has explicitly confirmed that commit in the current conversation.
- Preparing changes, showing a diff, and suggesting a commit message are allowed; ask for confirmation before running `git commit`.
- Never prefix Git branch names with categories such as `feature/`; use descriptive branch names directly.

#### Formatting

- Use hard tabs for indentation, with a tab width of 4 spaces.

#### Naming

- Avoid abbreviations. Use short, expressive, evocative names that make each value, function, type, or module's purpose clear.

#### Testing

- Test observable behavior and public contracts, not implementation details.
- Prefer assertions about outputs, side effects, and user-visible errors over private functions, internal call order, or incidental structure.
- Mock only external boundaries or nondeterministic dependencies; do not mock the unit under test merely to assert how it is implemented.
- Structure tests as setup, exercise, assert, and teardown. Keep each phase clear and separate.

### Language conventions

- Project-specific conventions take precedence over language-specific conventions.
- Language-specific conventions are stored in `~/.config/agents/conventions/`.
- Before creating or modifying code in a language, read the applicable convention file in that directory (for example, `conventions/python.md`).
