# Writing conventions

These apply to text that ships with code: comments, docstrings, READMEs and
other documentation, commit messages, pull request descriptions, interface
text, and user-facing error and help text. Sentences and Formatting also apply
to chat and to plans and notes in `.agents/`. None of these apply to the
Journal.

## Content

- Explain why this code does what it does. Do not explain how a library
  behaves unless that behavior is the reason.
- Use the domain's terms. Do not name files ("the site config", not
  `site.toml`) or the framework or project the text belongs to.
- Use one word per concept, as `code.md` Naming says. Do not vary a term for
  style.
- Put code names in backticks.
- In instructions for agents, call the human "the user".

## Docstrings

- Start with a short summary line. Add an extended part only when it states
  the contract: what a caller can rely on that the signature does not show.
- Leave out usage advice, lists of raised errors, and incidental reasons.
- The form of the summary line for each language is in its conventions file.

## Interface text

These apply to interfaces for users who know how to operate them.

- A page has a heading and its controls. Leave out introductions,
  instructions, and text that restates what a control does.
- Label a control with the shortest phrase that names its action, such as
  "Pair".
- Show a failure as a heading alone, such as "Link expired", unless the user
  needs a next step that the page does not offer.
- Add a link or control only when the page needs it.

## Sentences

- Use the active voice and name the actor: "the loader parses the file".
  Code can be the subject of a sentence when the verb is literal ("the parser
  rejects a bad date"). Do not use figurative verbs ("rides along", "holds
  it", "stands on").
- Do not join two sentences with a comma. Use a period, or join them with
  "because", "but", or "so". Do not use em-dashes.
- Do not stack genitives ("the site's config's base URL") or chain relative
  clauses ("a value, which the loader reads, which…").
- Write whole sentences, with their articles and verbs. Do not use arrows or
  other symbols in place of words.
- Write "is" or "has", not "serves as", "stands as", "boasts", or "features".
- Do not end a sentence with a participle clause (", ensuring…",
  ", highlighting…", ", reflecting…").
- Use "X, not Y" only when it corrects a reading the reader is likely to hold.
- Do not mark importance: no "worth noting", "it's important to note",
  "notably", "crucially", "honest", or "honestly".
- Do not write "it turns out". State the fact.
- Do not use these words: additionally, crucial, delve, enhance, foster,
  garner, interplay, intricate, landscape, leverage, pivotal, robust,
  seamless, showcase, tapestry, testament, underscore, utilize, vibrant.

## Formatting

- Write headings in sentence case.
- Use straight quotes and apostrophes.
- Do not start a line with a bold label that restates it ("**Performance:**
  Performance improved…"). A bold lead-in that names the item and is followed
  by new detail is fine.

## Commit messages and pull requests

- Describe what the change does. Do not write "instead of Y" unless someone
  proposed Y.
