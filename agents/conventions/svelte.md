# Svelte conventions

- Always use modern Svelte features and runes (such as `$props`, `$state`, `$derived`).
- Use `$effect` handlers and the new effect handler syntax.

## Conditionals in markup

Markup has no `if` statement, so the JavaScript rule against the conditional
operator does not apply there.

- Choose between pieces of markup with an `{#if}` block.
- Toggle a class with the object form of `class`, such as
  `class={{ played: isPlayed }}`.
- Write a conditional value used in one place inline in the markup, with the
  conditional operator. Compute a value used in several places in the script
  with `$derived.by` and an `if` statement.
