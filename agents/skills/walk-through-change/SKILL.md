---
name: walk-through-change
description: Write a top-down walkthrough of a large change, such as a pull request, a commit range, or uncommitted work, with architecture diagrams and a guided reading of its features and files. Use only when the user asks for a walkthrough by name.
disable-model-invocation: true
---

# Walk through a change

Explain a change so that the user can understand it from the top down and
judge whether it should land. Only read. Do not edit, stage, stash, check out,
build, or post anything.

## Find the change

The user names a pull request or a commit range. When they name neither, walk
through the uncommitted work in the current repository.

- For a pull request, get its description, review discussion, base and head
  commits, and diff with the forge's command-line tool, such as `gh`. Read code
  at the head commit, and fetch missing commits without changing the working
  tree.
- For a commit range, resolve both ends to commits and keep the comparison the
  user wrote. `A..B` compares the two trees, and `A...B` compares B with their
  merge base. Read code at those commits with `git show`.
- For uncommitted work, combine staged, unstaged, and untracked files against
  `HEAD`, and leave out ignored files. In a repository with no commits, every
  file is an addition.

Start from the list of changed files and the diff statistics, and note binary
and generated files. When the diff is empty, or a missing commit or missing
access keeps you from reading the change, say so and stop. Do not walk through
a different change in its place.

## Read

Read the whole diff before writing. Read the callers, contracts, migrations,
and tests around it until you can say what each part does and why. Spend the
time on the parts that carry the design. Skim mechanical changes, generated
files, fixtures, and lockfiles, and check that each follows the pattern the
change claims.

A walkthrough is not a review. Report a problem you come across, with the
evidence for it, but do not search for more.

## Write

Write the walkthrough in the conversation, or in the file the user names, in
Markdown. Order it from the top down: the system first, then each feature, then
the files that implement it.

1. Open with what the change does, the behavior before and after, and the
   commits it covers.
2. Draw the architecture the change touches, and mark the parts it adds or
   alters. Use an ASCII diagram in the conversation and a Mermaid chart in a
   file. Draw a feature's flow too when prose cannot carry it, such as a
   sequence of calls between components.
3. Walk through the features as numbered stops, from the outermost behavior
   inward. Title each stop by what the feature does, not by a file name. In a
   few sentences, say what changed, why, and how it leads to the next stop. Do
   not narrate the code line by line.
4. Under each stop, link the files and lines to read, in the order to read
   them. Put each test beside the behavior it checks. Quote code only when a
   short excerpt explains the idea better than prose.
5. Group the remaining mechanical changes, and say which pattern you checked in
   each group.
6. Close with the tradeoffs, risks, and open questions the code shows, and the
   few places to read most closely.

Throughout the walkthrough:

- Account for every changed file in a stop or a group, and say what you could
  not read.
- Check each line number against the commit you read. For a removed line, give
  the old commit and its line number there.
- Say which tests you read and which you ran.
- Do not state or imply a verdict on whether the change should land.
