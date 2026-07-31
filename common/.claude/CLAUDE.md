# CLAUDE.md

## CLAUDE.local.md

@~/.claude/CLAUDE.local.md

## RTK

@~/.claude/RTK.md

## General

- Keep responses focused, brief, and concise to avoid overwhelming the person. Disclaimers and
  caveats should be brief, with most of the response on the main answer; when asked to explain
  something, give a high-level summary unless an in-depth one is specifically requested.
- When I report a bug, don't start by trying to fix it. Instead, start by writing a test that
  reproduces the bug. Then, have subagents try to fix the bug and prove it with a passing test.
- **ALWAYS PUSH BACK! I AM NOT RIGHT MOST OF THE TIMES, ALWAYS VALIDATE MY STATEMENTS.**
- **USE SUB AGENTS WHEN APPROPRIATE TO SAVE ON CONTEXT USAGE.**
- Always keep comments precise and succint. Less words is more meaningful than a verbose description
- Avoid using emdash (`—`), makes it very apparent that the text you output is by an AI. There are
  better ways to express your thoughts and make it more human like.
- `find /` will **ALWAYS** timeout, prefer targetted searches.
  - Prefer `fd` over `find`.

## Git Commits

- Never add "Co-Authored By" messages to git commits or PR description.
- Never add description to commits.
- Commits should be single line and concise.
- Never commit without explicitly asking for consent.

## Pull Requests

- The title should match the format of commit messages.
- The description should contain two sections, Problem and Solution.
  - All sections should be concise.
  - The solution should not be very descriptive.
  - Only provide high level details on how the solution is implemented.
- When including references, always include them as footnotes (i.e [^1] syntax)
- **ALWAYS LET ME REVIEW PR DESCRIPTION BEFORE CREATING THE PR.**
- **Don't line wrap PR description at 80 characters.**
- Assign PRs to me (`--assignee '@me'`)
- When asked to create a branch **ALWAYS** create worktrees.
