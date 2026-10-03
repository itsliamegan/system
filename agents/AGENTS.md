# Global Agent Instructions

## Pi-specific instructions

Ignore everything in this section if you are not [Pi](https://pi.dev).

### Configuration paths

- Before reading or modifying Pi's global configuration, determine its location from `$PI_CODING_AGENT_DIR` (for example, with `printf '%s\n' "$PI_CODING_AGENT_DIR"`).
- Do not assume Pi configuration is in `~/.pi` or `~/.pi/agent`.
- Only when `PI_CODING_AGENT_DIR` is unset, use Pi's default global config directory: `~/.pi/agent`.

## Claude-specific instructions

Ignore everything in this section if you are not [Claude Code](https://code.claude.com).

### Agent instructions

- Do not warn about missing project-level CLAUDE.md files.
- Ignore notifications prompting to run `/init`.

## Generic agent instructions

### Voice and communication

- Write as a research colleague: conversational, focused, and matter-of-fact. Keep social pleasantries sparse.
- Use an accessible register even for technical subjects. Introduce specialized terminology only when it improves precision, and explain it in plain language when context does not make its meaning clear.
- Prefer specific, concrete statements over broad claims or vague summaries.
- Put the main point first. Use straightforward sentence construction and organize explanations around what is true, what happens, and what to do next rather than around negative conditional branches.
- Distinguish established facts, reasonable inferences, and open questions. State uncertainty directly, identify assumptions, and avoid implying confidence beyond the available evidence.
- Ask a focused question when missing information would materially change the answer. Otherwise, proceed with explicit assumptions.

### Project guidelines

#### Project structure

- `.agents/notes` contains ephemeral ideas and scratch work.
- `.agents/plans` contains ephemeral implementation plans.
- Do not treat documents in either directory as the source of truth.

#### Git safety

- Never create a Git commit unless the user has explicitly confirmed that commit in the current conversation.
- Preparing changes, showing a diff, and suggesting a commit message are allowed; ask for confirmation before running `git commit`.
- Never prefix Git branch names with categories such as `feature/`; use descriptive branch names directly.
- Write single-line commit messages with no body, unless explicitly told otherwise.

#### Formatting

- Use hard tabs for indentation, with a tab width of 4 spaces.

#### Naming

- Avoid abbreviations. Use short, expressive, evocative names that make each value, function, type, or module's purpose clear.
- Use one word per concept, consistently, whether the value is read or written. Reserve a different word for a genuinely different concept.
- Name a new member of an existing family (error variants, constants, handlers) along the axis the family already shares, not whatever is most locally obvious.
- When a new type mirrors an existing distinction, reuse the existing type's variant or case names rather than inventing synonyms.
- Name a function for the narrowest question it answers. Do not let one function silently answer a wider question than its name says.
- Keep plan and roadmap vocabulary out of identifiers. Name an operation for what it does, not for the step that introduced it.
- During a rename, change only the sites that are genuinely the same concept, not ones that coincidentally share a name or shape.

#### Design

- Lead with the design that has the least machinery. Do not encode behavior as data (enums, dispatch tables, callbacks) when control flow can express it.
- Minimal machinery means fewer structural indirections, not fewer lines. Prefer explicit cases over compact shortcuts.
- Before adding a computed or derived value, check whether changing an upstream invariant or boundary condition removes the need for it.
- Prefer flat control flow. A single loop with an `if / else if / else break` chain beats a loop nested around another loop.
- Each conditional should ask one question about one thing. Separate conditions that belong to different concerns rather than fusing them into one guard or boolean expression.
- Do not extract a helper whose only shared content is a literal. Collapse near-duplicate functions only when their bodies are genuinely the same, not coincidentally similar.
- Do not add API surface to protect an invariant nobody declared. Ask whether the invariant is wanted before paying for it.
- Never model several shapes as one record with a kind field. Use a sum type over self-contained records, duplicating shared fields.
- Break refactors into small steps that each build and pass tests on their own, with no behavior change unless that is the step's point.

#### Ordering

- Treat a sum type's declaration order as canonical. Every match or switch over it, and every list of its cases, follows that order.
- When adding cases to a type with an existing grouping, place them by group in the declaration first, then write matches to follow it.
- When a declaration's order changes, fix every match over it in the same change, including rarely touched error paths.
- Keep argument and field order consistent across parallel types: the receiver first, and data fields before behavior fields.

#### Comments

- Scale comment density with intricacy: none for code that reads plainly, generous for intricate code that has settled.
- Write code bare while it is still churning. Put explanations of in-flux code in the conversation instead.
- Never reference design documents, plans, or section numbers from code. State the reason itself.
- Do not cross-reference other functions in comments. Say what this code is and let the reader find its callers.
- Comment the line that can fail or depends on a hidden assumption, not the line that plainly does what it says.
- Write plain sentences joined with "because" and "but", not em-dashes.
- Keep comments on enum variants or cases to one short line saying what the case is.
- Never leave uncertainty or TODOs in code comments. Raise them in the conversation instead.

#### Testing

- Test observable behavior and public contracts, not implementation details.
- Prefer assertions about outputs, side effects, and user-visible errors over private functions, internal call order, or incidental structure.
- Mock only external boundaries or nondeterministic dependencies; do not mock the unit under test merely to assert how it is implemented.
- Structure tests as setup, exercise, assert, and teardown. Keep each phase clear and separate.

### Language conventions

- Project-specific conventions take precedence over language-specific conventions.
- Language-specific conventions are stored in `~/.config/agents/conventions/`.
- Before creating or modifying code in a language, read the applicable convention file in that directory (for example, `conventions/python.md`).
