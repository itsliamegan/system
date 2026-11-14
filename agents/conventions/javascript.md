# JavaScript conventions

## Code style

- Separate class methods with a blank line.

## Declarations

- Use `let` for variable declarations by default.
- Use `const` only when explicitly declaring a module-level or class-level constant.
- Declare instance fields without initializers, and assign each one in the
  constructor. Static constants keep their initializers.

## Control flow

- Do not use the conditional operator (`a ? b : c`). Write an `if` statement
  with a branch for each case.
- Do not use `??`, or `||` as a fallback, in a `return` expression. Test for
  the missing value with an `if` statement, and return each case from its own
  branch.

## Naming

- Use PascalCase (all uppercase) for initialisms, e.g., `URL` over `Url`, `ID` over `Id`.
- Only use all lowercase for an initialism if it is the first segment of a name, e.g., `id` for an object field (not `ID`), and `urlForHTTP` as a function name (not `URLForHTTP`).

## Design

- Prefer classes and composition over interfaces and functional patterns.

