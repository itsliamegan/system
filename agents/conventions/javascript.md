# JavaScript conventions

## Code style

- Do not use semicolons.
- Prefer double quotes for strings wherever possible.
- Prefer explicit conditionals over ternaries wherever possible.
- Separate class methods with a blank line.
- Always use curly braces for `if`, `for`, and `while` statements.

## Declarations

- Use `let` for variable declarations by default.
- Use `const` only when explicitly declaring a module-level or class-level constant.

## Naming

- Use PascalCase (all uppercase) for initialisms, e.g., `URL` over `Url`, `ID` over `Id`.
- Only use all lowercase for an initialism if it is the first segment of a name, e.g., `id` for an object field (not `ID`), and `urlForHTTP` as a function name (not `URLForHTTP`).

## Design

- Prefer classes and composition over interfaces and functional patterns.

