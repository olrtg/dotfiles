---
name: commit
description: Commit intended local changes with a message that matches the user's lowercase style or the repository's established convention. Use when the user asks to commit, save, or check in changes, and when the publish skill needs to create a commit.
---

# Commit Changes

## Overview

Create a local git commit containing only the intended changes. Do not push, publish, or open a pull request.

The user's default style is a terse, lowercase subject without a prefix or suffix. Follow a repository convention instead when the project enforces one or the relevant commit history clearly establishes one.

## Workflow

1. Understand the intended scope.
   - Run `git status -sb`.
   - Inspect both staged and unstaged changes with `git diff --cached` and `git diff`; inspect relevant untracked files too.
   - Preserve the user's existing staging intent.
   - If the worktree contains unrelated or ambiguous changes, ask which files belong in the commit before staging anything else.
2. Determine the message convention using this priority order:
   1. Follow explicit repository rules, including applicable `AGENTS.md`, contribution documentation, commit templates, commitlint configuration, package scripts, or hooks.
   2. Find the latest non-merge commit authored by the current user, matching the configured git email when available. If its subject uses Conventional Commits, use Conventional Commits. Otherwise use the user's default plain lowercase style unless an explicit repository rule says otherwise.
   3. If the user has no earlier commit in the repository, inspect recent non-merge commits from other authors. Use Conventional Commits when that style is clearly established. Follow another style only when the project explicitly enforces it; otherwise use the user's default plain lowercase style.
3. Compose the message.
   - Keep the subject concise, specific, and lowercase.
   - Do not add a type, scope, issue key, emoji, or suffix unless the selected convention requires it.
   - Under Conventional Commits, keep the type, optional scope, and description lowercase, such as `fix(auth): handle expired sessions`.
   - Add a commit body only when the subject cannot capture the gist of the problem or when documenting a regression relationship.
   - A body should explain essential context or why the change was needed rather than repeat the diff.
   - For a regression, identify the related commit clearly, for example: `fixes a regression introduced by <sha>`.
4. Stage only the intended changes.
   - Prefer explicit paths when the worktree is mixed.
   - Use `git add -A` only after confirming that the entire worktree belongs in the commit.
5. Review `git diff --cached` before committing. Stop if it contains unrelated, generated, secret, or otherwise unintended content.
6. Create the commit.
   - Use a message file when a body is needed so paragraph breaks are preserved.
   - Do not amend an existing commit unless the user explicitly asks.
7. Report the commit hash and subject. Mention any intended changes left uncommitted.

## Safety

- Never stage unrelated user changes silently.
- Never discard or rewrite changes to make the worktree fit the commit.
- Never bypass git hooks unless the user explicitly requests it and understands the consequence.
- Never push as part of this skill.
