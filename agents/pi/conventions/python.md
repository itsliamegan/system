# Python conventions

## Code style

- Follow the existing project's formatter, linter, supported Python version, and
local conventions first.
- Write clear, idiomatic Python; prefer simple control flow and the standard
library where appropriate.
- Do not name internal or private functions, methods, attributes, or variables
with leading underscores.
- Do not use `*` or `/` parameter markers in function signatures; avoid
keyword-only and positional-only parameter declarations.
- Add type annotations for public APIs and non-obvious values when the project
uses typing; do not introduce a new typing style into an established codebase.
- Keep imports organized according to the project's tooling. Do not leave unused
imports.
