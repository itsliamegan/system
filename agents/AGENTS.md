# Global Agent Instructions

## Pi-specific instructions

### Configuration paths

- Before reading or modifying Pi's global configuration, determine its location from `$PI_CODING_AGENT_DIR` (for example, with `printf '%s\n' "$PI_CODING_AGENT_DIR"`).
- Do not assume Pi configuration is in `~/.pi` or `~/.pi/agent`.
- Only when `PI_CODING_AGENT_DIR` is unset, use Pi's default global config directory: `~/.pi/agent`.

## Generic agent instructions

### Project guidelines

#### Git safety

- Never create a Git commit unless the user has explicitly confirmed that commit in the current conversation.
- Preparing changes, showing a diff, and suggesting a commit message are allowed; ask for confirmation before running `git commit`.

#### Naming

- Avoid abbreviations. Use short, expressive, evocative names that make each value, function, type, or module's purpose clear.

#### Testing

- Test observable behavior and public contracts, not implementation details.
- Prefer assertions about outputs, side effects, and user-visible errors over private functions, internal call order, or incidental structure.
- Mock only external boundaries or nondeterministic dependencies; do not mock the unit under test merely to assert how it is implemented.
- Structure tests as setup, exercise, assert, and teardown. Keep each phase clear and separate.

### Language conventions

- Project-specific conventions take precedence over language-specific conventions.
- Language-specific conventions are stored in `conventions/` under Pi's global configuration directory.
- Before creating or modifying code in a language, read the applicable convention file in that directory (for example, `conventions/python.md`).
