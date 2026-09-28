# Python Conventions

## Code Style

- Follow the existing project's formatter, linter, supported Python version, and
  local conventions first.
- When a signature, call, or collection literal does not fit on one line, put
  each parameter, argument, or element on its own line with a trailing comma, so
  the formatter keeps it expanded. Do not leave several on a single continuation
  line.
- Write clear, idiomatic Python; prefer simple control flow and the standard
  library where appropriate.
- Add type annotations for public APIs and non-obvious values when the project
  uses typing; do not introduce a new typing style into an established codebase.
- Keep imports organized according to the project's tooling. Do not leave unused
  imports.

## Naming

- Do not name internal or private functions, methods, attributes, or variables
  with leading underscores.
- Use leading underscores for unused variables.
- Use leading underscores for variables that represent the internal state of a
  `@property` that wraps them with the same name.

## Declarations

- Avoid the `dataclasses.field` helper. Prefer `init=False` and a custom
  `__init__`.
