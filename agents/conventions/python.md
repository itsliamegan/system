# Python Conventions

## Code style

- Follow the existing project's formatter, linter, supported Python version, and
  local conventions first.
- When a signature, call, or collection literal does not fit on one line, put
  each parameter, argument, or element on its own line with a trailing comma, so
  the formatter keeps it expanded. Do not leave several on a single continuation
  line.
- Write clear Python. Prefer simple, explicit control flow over terse idioms,
  and use the standard library where appropriate.
- Build collections and compute results with explicit `for` loops rather than
  comprehensions, `any`, `all`, `map`, or `filter`. A generator expression
  passed directly to a call, such as `", ".join(...)`, is fine.
- Default optional arguments with `value = value or default` on its own line.
  Do not write `if value is None:` blocks for this, and do not inline
  `(value or default)` into a call or a `**` expansion.
- Add type annotations for public APIs and non-obvious values when the project
  uses typing; do not introduce a new typing style into an established codebase.
- Do not annotate `-> None`.
- Do not use positional-only `/` markers.
- Import names explicitly (`from .codec import Codec`) rather than importing a
  module and qualifying names with it (`codec.Codec`).
- Keep imports organized according to the project's tooling. Do not leave unused
  imports.

## Naming

- Do not name internal or private functions, methods, attributes, or variables
  with leading underscores.
- Use leading underscores for unused variables.
- Use leading underscores for variables that represent the internal state of a
  `@property` that wraps them with the same name.

## Classes

- Order class members as attribute annotations, the constructor, static and
  class methods, then instance methods. Within each group, put the highest
  level first.
- Give a family of implementations an abstract base class, so each subclass's
  role is obvious where it is declared. Use `Protocol` only where a function
  must accept unrelated types.
- Prefer a dataclass to a hand-written `__init__` and `__repr__`.
- Use a plain `@dataclass` with field defaults when `__init__` would only
  assign its arguments. Use `init=False` and a custom `__init__` when the
  constructor checks or converts arguments.
- Do not use `dataclasses.field` or `dataclasses.replace`. Call constructors
  explicitly.
- Do not use `frozen=True`. Leave `eq` on unless there is a specific reason to
  turn it off.
- Pass flags and optional parts to constructors as keyword arguments.
