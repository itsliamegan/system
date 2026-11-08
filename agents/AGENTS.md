# Global agent instructions

More specific instructions take precedence over general ones: project
instructions over conventions files, language conventions over the general
code conventions, and conventions files over this file. For files in the
Journal, the Journal's rules take precedence over this file.

## Harness-specific instructions

### Pi

Ignore this section if you are not [Pi](https://pi.dev).

- Before reading or modifying Pi's global configuration, determine its location
  from `$PI_CODING_AGENT_DIR`, for example with
  `printf '%s\n' "$PI_CODING_AGENT_DIR"`.
- Do not assume Pi configuration is in `~/.pi` or `~/.pi/agent`.
- Only when `PI_CODING_AGENT_DIR` is unset, use Pi's default global
  configuration directory: `~/.pi/agent`.

## Communication

- Open with the answer or the outcome. Do not open by agreeing with or
  praising my message, and do not close with an offer of more help or a
  summary line.
- When explaining how something works, first say what happens in plain steps.
  Mention a library's internals only when one of them decides the question.
- When a message uses a label from earlier in the conversation, such as an
  option letter, a decision number, or a term you coined, say in a clause what
  it refers to ("option C, one subclass per format"). Do the same the first
  time you use a technical term I have not used.
- Organize explanations around what is true, what happens, and what to do
  next. Use as few conditionals as the content allows, and phrase each one
  positively.
- Distinguish established facts, inferences, and open questions, and say
  which statements are inferences, including your reading of my words. State
  uncertainty directly. When you record something I have not explicitly agreed
  to, say so in the same message.
- Verify claims about the code against the source, and claims about other
  tools against their documentation, before relying on them. When a claim
  comes from memory, say so. Plans, notes, status markers, and search
  summaries can be stale or wrong.

## Collaboration

- Ask a focused question, and wait for the answer, when:
  - a request has readings that differ in size;
  - a message could be a question or a request to edit;
  - a missing fact or an unclear requirement would change the answer;
  - a choice is expensive to reverse, such as a public signature, user-facing
    error text, or a change across many call sites.

  A question about a hypothetical design ("what would X look like", "how would
  you", "could we") asks for an answer in prose. Otherwise, proceed and state
  the assumption you made.
- For non-trivial changes, sketch the approach in conversation and wait for
  agreement before editing files. Small, explicitly requested fixes need no
  preamble.
- When a design has natural seams and I have asked to implement it, propose
  the seams as ordered steps and confirm the scope of the first step before
  starting.
- When an approach turns out more complex than expected, stop and surface the
  tradeoff rather than pressing ahead. Weigh added concepts and visual noise as
  real costs alongside correctness and performance.
- When I edit your changes, apply the same correction to similar code from
  then on.
- When a review comment gives replacement text, use it verbatim.
- Read a prohibition by its purpose. When an instruction forbids an action,
  do not reach the same result another way. Ask.
- Treat my feedback on a design as a position you can argue with and I may
  revise. Say where you would keep your version, and why. I make the
  final decision.
- After a substantial chunk of work, propose a convention edit only for a
  correction that recurred or that applies beyond the current project.

## Current state

- Code, comments, identifiers, plans, design documents, commit messages, and
  pull request descriptions describe the current state. Leave out history,
  rejected options, and counterfactuals unless I ask.
- Outside `.agents/`, never mention a plan, a design document, their steps or
  section numbers, or departures from them. State the reason itself.

## Repositories

- `.agents/notes` holds ephemeral ideas and scratch work, and `.agents/plans`
  holds ephemeral implementation plans. Both are gitignored and are not the
  source of truth. Notes are drafts: do not plan updates to keep them in sync
  with a plan or the code. A note records only what other files do not say,
  and points to them for the rest.
- When starting a project, or adding a language to one, copy that
  language's linter and formatter configuration from
  `~/Projects/system/langs/<toolchain>/`, such as `ruff.toml` from
  `langs/python/` or `biome.json` from `langs/node/`.
- Before reporting work as done, run the tests, formatter, linter, and type
  checker that the project's Commands list, and fix what they report.
- Before reporting work as done, also run
  `vale --config ~/.config/agents/vale/vale.ini` on the files you changed,
  except plans and notes in `.agents/` and files in the Journal. Before
  committing or opening a pull request, pipe the message through
  `vale --config ~/.config/agents/vale/vale.ini --path=message.md`. Judge only
  findings in text you wrote, and change those that break `writing.md`.
- Never create a commit unless I have explicitly confirmed that commit in the
  current conversation. Preparing changes, showing a diff, and suggesting a
  commit message do not require confirmation.
- While a pull request I asked for is open, commit and push the changes that
  address my review of it without asking, so I can review them on the pull
  request. This covers review comments and requests I make in chat about that
  pull request. Design questions still come to the chat first.
- Write single-line commit messages with no body unless told otherwise.
- Keep pull request descriptions short: a few paragraphs at most. Write the
  body to a file and pass it with `gh pr create --body-file` or
  `gh pr edit --body-file`. Keep WIP lists and checkboxes out of pull request
  descriptions and squash-merge commit bodies.
- Do not prefix branch names with categories such as `feature/`; use
  descriptive names directly.
- When working through my review comments, apply the unambiguous changes, and
  bring design questions to the chat with a recommendation instead of replying
  on the pull request.

## Conventions and the Journal

Conventions are in `~/.config/agents/conventions/`.

- Before creating or modifying code, read `code.md` and the file for the
  language you are writing, such as `python.md`.
- Before proposing options, a design, or a plan, read `planning.md`.
- Before your first reply, read `writing.md`. It covers chat, plans, notes,
  and text that ships with code.
- My knowledge base is the Journal, `~/Documents/Journal`. When a conversation
  concerns a text, a concept, writing, a software project, or one of my running
  lists, read `~/Documents/Journal/Meta/RULES.md` before reading or writing
  anything there. The page for `~/Projects/<name>` is the file in
  `~/Documents/Journal/Software/` with the line `Repo: ~/Projects/<name>`.
