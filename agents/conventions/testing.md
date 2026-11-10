# Testing conventions

These apply in every language. `code.md` covers the code under test.

## What to test

- Add or keep a test only when it catches a plausible failure in required
  behavior. Skip a test whose maintenance costs more than the failures it is
  likely to catch, and say in the conversation which significant behavior
  you left untested.
- Test observable behavior and public contracts, not implementation details.
- Prioritize regressions, consequential boundaries, and error paths.
- Do not test behavior that a library or language feature generates, such as
  dataclass equality or repr.
- Do not test a module's dependencies or what importing it loads.

## Expected results

- Derive expected results from requirements, documented contracts, or
  examples worked out independently of the implementation. Do not copy the
  implementation's logic into an assertion.
- Run a regression test against the code without the fix and confirm that it
  fails, then confirm that it passes with the fix.

## Assertions

- Prefer assertions about outputs, side effects, and user-visible errors over
  private functions, internal call order, or incidental structure.
- Do not assert on error message text. Assert the specific error type.
- After an error, assert the postconditions the contract promises, such as
  unchanged state, no partial writes, and a retry that has the same effect as
  a single call.
- Use a snapshot only when the captured output is the behavior under test.

## Structure

- Structure tests as setup, exercise, assert, and teardown. Keep each phase
  clear and separate.
- Structure tests as a pyramid: detailed cases beside the module that owns the
  behavior, and fewer, broader cases at higher levels.
- A higher-level test asserts only what its level decides and does not repeat
  cases a lower level owns. It may depend on the lower level's real behavior
  to do so.
- Give each case its own test function, even when cases share setup. Do not
  loop over inputs inside a test. Combine assertions into one test only when
  they check the same case.
- Name each test for the behavior it checks.

## Test data

- Set tests in the project's shared example domains and reuse their concepts
  and names across test files. A project can have several domains, but an
  individual test does not invent a new one.
- Use explicit, readable names and values in test data, such as
  `articles/intro`. Generate values only where a test needs them to be
  unique.
- Build each test's data in the test itself. Do not hide its construction
  behind helper functions within a test file.
- For examples of unsupported input, pick ones that will stay unsupported.

## Dependencies

- Mock only external boundaries or nondeterministic dependencies; do not mock
  the unit under test merely to assert how it is implemented.
- Prefer a fake that implements the real interface to a mock.
- Inject the clock and the random seed. Never sleep to wait for asynchronous
  work. Log the seed of a randomized test so that a failure reproduces from
  the log alone.
