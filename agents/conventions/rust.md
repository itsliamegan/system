# Rust conventions

## Code style

- Run `cargo fmt` and ensure `cargo fmt --check` is clean before considering any
  change done.
- Never use `matches!()`. Write an explicit `match` or `if let` instead. Be wary
  of any macro that takes a pattern or other non-expression syntax as an
  argument.
- Prefer an explicit `match` that names each reachable case over a compact
  boolean condition, even when the match is longer or an arm looks redundant.
- Do not fuse a match guard onto a question the matched value cannot answer.
  Match on the value alone and nest a separate `if` inside the arm.
- A wildcard arm should do real work, not stand in for a case declared
  impossible.
- In code still in flux, use bare `panic!()` and `.unwrap()`, not
  `unreachable!("...")` or `.expect("...")`. A line comment above a bare panic
  stating the assumption it rests on is welcome.

## Declarations

- Use tuple variants for enums, not named-field variants. If a tuple stops
  reading clearly, split the variant or drop a field.
- When an enum over self-contained structs replaces a `kind` field, put
  accessors on the enum for fields that are read uniformly at many sites.
- Bind named-field structs whole and read `x.field` at the use site. Do not
  destructure them in match arms, loops, or closure parameters.
- Keep `&self` on a method whose body no longer uses `self` if its siblings are
  called as `self.method(...)`.

## Naming

- When a binding must share a name with a keyword, use a trailing underscore
  (`loop_`, `match_`, `return_`).
- Name constructors `new`.

## Design

- Prefer arena patterns (a method on the owning registry, taking an id) over
  object patterns (a method on the record itself).
- Do not add narrow API surface to avoid widening a borrow. Widen the borrow
  instead.
