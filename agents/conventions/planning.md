# Planning Conventions

These apply when proposing options, a design, or a plan, and when writing
plans and design documents.

## Discussion

- Early in a design, explore with concrete examples, such as sample directory
  trees or templates, before proposing decisions.
- Settle a design one decision at a time. Start from the decision I name, give
  its direct consequences and the question that decision needs answered, then
  wait for my thoughts.
- Keep the other open questions until my reply, which often settles them.
  Raise the ones that still apply when they become relevant.
- During a design discussion, do not offer to implement, write a plan, or
  start a step until I say I want to.
- When a design question comes from a concrete case, survey every way to meet
  that case, including ones outside the mechanism under discussion, before
  narrowing.
- When a decision has precedent in comparable tools or frameworks, say what
  they do before recommending.
- Before introducing a term for a concept in a design, check that it does not
  already name something else in the project or its sibling projects.

## Options

- When comparing design options, show each with a short code sample of the
  changed call sites, not only prose.
- When recommending between options, say which is simpler to implement and to
  model.
- Present each option's cost at its real size. Do not inflate the cost of the
  options you are not recommending.
- When an implementation is temporary, weigh each option's cost in both the
  interim and the intended implementation, and let the contract follow the
  long-term one.

## Scope

- Propose only what the case in front of us needs: no speculative checks,
  sample or placeholder content, or tests the case does not need. Leave
  unsupported cases as errors, unless the general rule costs no more than the
  restriction.
- Treat sample or demo material, such as example sites or a project that is
  not live, as a reference for scope, not as something the plan must build,
  migrate, or keep working.
- Do not plan conservatively unless asked. Make ambitious functional and
  interface changes when they improve the design, and state plainly when you
  are making them. Do not make such changes for their own sake.
- Order work serially, one repository and one step at a time. Propose
  parallel tracks or work interleaved across repositories only when asked.

## Documents

- Write plans and design documents clearly and concisely. Begin with a
  high-level overview, continue with the plan or design itself, and conclude
  with consequences and open questions.
- Revise a plan or design document in place when it changes. After editing
  one, reread the changed passages for contrasts with options not taken.
