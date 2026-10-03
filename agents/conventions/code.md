# Code Conventions

These apply in every language. Language files in this directory add to them.

## Design

Before writing code, ask:

- **Modeling:** What concept is this? Does a class for it already exist, or is
  it missing?
- **Ownership:** Which existing object should own this behavior? Is there a
  general path it can go through instead of a new special case?
- **Consistency:** Do sibling modules already solve this problem?
- **Public interfaces:** What will callers see and write?
- **Scope:** Did the plan or request ask for this?

### Modeling

- Give each concept its own class. When code identifies something with a
  meaning of its own (a parsed key, a set of rules, a SQL statement, a model's
  loaded relationships), model it as a named type with its own behavior. Do
  not pass dicts, tuples, or strings between functions to stand in for it.
  Classes are how a codebase builds its vocabulary.
- Put behavior on the concept it concerns, as a method, class method, or
  static method (`Condition.parse`, `Fragment.join`). Avoid module-level
  functions that take the concept as their first argument.
- Keep data with the object it belongs to. Do not pass a value as a separate
  argument alongside an object that should carry it.
- Represent structure as data. Build objects (statements, clauses, trees) and
  turn them into output in one place. Do not assemble strings or nested
  formats piece by piece where they are used.
- Use composition for domain behavior. Extending a framework base class is
  fine. Avoid mixins and domain inheritance hierarchies.
- Do not extract generic helpers early. Write an operation inline where it is
  used. Extract a helper only once the operation is shared across several
  places and deserves a name. Inline one-line wrappers.

### Ownership

- Keep each object to its own layer. Do not reach into another object's
  private state; give it an accessor. Do not let a module take on a
  neighbor's concern.
- Route variants through the general path. Express a variant in terms of the
  general operation (an existence check as a limited select) rather than
  adding a parallel method beside it. If the general path cannot express the
  variant, extend the general path.

### Consistency

- When several modules solve the same problem, solve it once in a shared
  place.
- Give equivalent operations the same name and shape everywhere.

### Public interfaces

- Accept objects with named methods and declarative keys. Do not accept
  closures or lambdas, and do not expose combinators.
- Prefer explicit declarations to convention. Declarations name what they
  depend on. Do not infer names by pluralizing, suffixing, or pairing.
- Keep exports narrow. Export base types and entry points, and leave specific
  implementations in their own modules.

### Scope

- Build what the plan or request asks for. Do not add methods, exports, or
  conveniences that nothing uses.
- Do not restyle existing code outside the change.

### Machinery

- Lead with the design that has the least machinery. Do not encode behavior as
  data (enums, dispatch tables, callbacks) when control flow can express it.
- Minimal machinery means fewer structural indirections, not fewer lines.
  Prefer explicit cases over compact shortcuts.
- Before adding a computed or derived value, check whether changing an
  upstream invariant or boundary condition removes the need for it.
- Do not extract a helper whose only shared content is a literal. Collapse
  near-duplicate functions only when their bodies are genuinely the same, not
  coincidentally similar.
- Do not add API surface to protect an invariant nobody declared. Ask whether
  the invariant is wanted before paying for it.
- Never model several shapes as one record with a kind field. Use a sum type
  over self-contained records, duplicating shared fields.
- Break refactors into small steps that each build and pass tests on their
  own, with no behavior change unless that is the step's point.

## Naming

- Avoid abbreviations. Use short, expressive, evocative names that make each
  value, function, type, or module's purpose clear.
- Name things by their role in the domain. Use the field's established
  vocabulary and the vocabulary of any reference frameworks the project
  names. Avoid words that mean something else in context.
- Before naming something, check what its siblings are called.
- Avoid vague names such as `normalize`, `check`, `process`, `handle`,
  `entry`, `values`, or `problem`. If no precise name fits, the function is
  probably doing more than one thing.
- Do not add prefixes that restate context, such as `passed_props` or
  `declared_column`.
- Write boolean names as predicates (`is_collection`). An adjective that
  already reads as one (`invalid`) needs no prefix.
- Use one word per concept, consistently, whether the value is read or
  written. Reserve a different word for a genuinely different concept.
- Name a new member of an existing family (error variants, constants,
  handlers) along the axis the family already shares, not whatever is most
  locally obvious.
- When a new type mirrors an existing distinction, reuse the existing type's
  variant or case names rather than inventing synonyms.
- Name a function for the narrowest question it answers. Do not let one
  function silently answer a wider question than its name says.
- Keep plan and roadmap vocabulary out of identifiers. Name an operation for
  what it does, not for the step that introduced it.
- During a rename, change only the sites that are genuinely the same concept,
  not ones that coincidentally share a name or shape.

## Code shape

- Indent with hard tabs at a tab width of 4 spaces, unless the language or
  format requires otherwise.
- Write control flow that reads as prose. When both branches are normal
  outcomes, use an explicit `else` instead of returning early and falling
  through. Guard clauses at the top of a function are fine.
- Handle errors first, then branch over the valid cases. Do not interleave
  error handling with case handling.
- Separate a function body into paragraphs with blank lines: after guard
  clauses, between groups of checks, and between phases.
- Prefer flat control flow. A single loop with an `if / else if / else break`
  chain beats a loop nested around another loop.
- Each conditional should ask one question about one thing. Separate
  conditions that belong to different concerns rather than fusing them into
  one guard or boolean expression.

## Ordering

- Treat a sum type's declaration order as canonical. Every match or switch
  over it, and every list of its cases, follows that order.
- When adding cases to a type with an existing grouping, place them by group
  in the declaration first, then write matches to follow it.
- When a declaration's order changes, fix every match over it in the same
  change, including rarely touched error paths.
- Keep argument and field order consistent across parallel types: the
  receiver first, and data fields before behavior fields.

## Comments

- Scale comment density with intricacy: none for code that reads plainly,
  generous for intricate code that has settled.
- Write code bare while it is still churning. Put explanations of in-flux code
  in the conversation instead.
- Never reference design documents, plans, or section numbers from code. State
  the reason itself.
- Do not cross-reference other functions in comments. Say what this code is
  and let the reader find its callers.
- Comment the line that can fail or depends on a hidden assumption, not the
  line that plainly does what it says.
- Write plain sentences joined with "because" and "but", not em-dashes.
- Keep comments on enum variants or cases to one short line saying what the
  case is.
- Never leave uncertainty or TODOs in code comments. Raise them in the
  conversation instead.

## Files

- Give each domain concept its own file. A small type used only by one class
  can live beside it.
- Name a module for its main concept, in the singular.
- Order files and classes top-down: the highest-level concept first, then
  what it uses, breadth-first. Put supporting constants, type aliases, and
  helpers after the code that uses them.

## Types and validation

- Let types carry correctness. Annotate parameters with what they actually
  accept. Do not accept `object` or `Any` and then check the type at runtime.
- Validate only failures the type checker cannot catch and that would
  otherwise fail confusingly or silently. For each runtime check, be able to
  say which bug it prevents.
- Keep typing pragmatic. String keys checked at runtime against declarations
  are fine. Do not build typed wrappers or DSLs only to gain static checks.

## Errors

- Say what went wrong, plainly. Do not add usage examples or suggestions for
  how to fix it.
- Phrase errors for the same kind of failure the same way across modules.

## Testing

- Test observable behavior and public contracts, not implementation details.
- Prefer assertions about outputs, side effects, and user-visible errors over
  private functions, internal call order, or incidental structure.
- Mock only external boundaries or nondeterministic dependencies; do not mock
  the unit under test merely to assert how it is implemented.
- Structure tests as setup, exercise, assert, and teardown. Keep each phase
  clear and separate.
- Structure tests as a pyramid: detailed cases beside the module that owns the
  behavior, and fewer, broader cases at higher levels.
- Combine tests that exercise the same behavior with closely related inputs.
- Do not assert on error message text. Assert the specific error type.
- Do not test behavior that a library or language feature generates, such as
  dataclass equality or repr.
- Use one small, consistent set of domain fixtures across test files.
- Generate identifiers and similar values in each test and assert against the
  generated value. Do not hard-code constants.
- For examples of unsupported input, pick ones that will stay unsupported.
