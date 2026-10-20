---
name: publish
description: Publish local changes by committing them, pushing the branch, and creating a GitHub pull request that is a draft by default. Use whenever the user explicitly asks to create, open, raise, or publish a PR or pull request from the current checkout.
---

# Publish Changes

## Overview

Use this skill to publish changes from a local checkout: confirm scope, create a branch when needed, commit through the `commit` skill, push, and create a pull request that is a draft by default.

Use local `git` for branch management and pushing. Always use the GitHub CLI (`gh`) for GitHub authentication, repository information, pull request discovery, and pull request creation. Do not use a GitHub app or connector.

## Prerequisites

- Require `gh`. Run `gh --version`; if it is unavailable, ask the user to install it and stop.
- Require an authenticated GitHub CLI session. Run `gh auth status`; if authentication is unavailable, ask the user to run `gh auth login`, then retry before continuing.
- Require a git repository connected to an accessible GitHub remote.
- A ticket URL is optional. When the user supplies one, preserve it for the pull request body regardless of whether it comes from Jira, Linear, GitHub Issues, or another tracker. Do not prompt for, invent, or guess a ticket URL.

## Naming

- When starting from the default branch, create a concise, descriptive branch directly, without an `agent/` or other automatic prefix. Prefer lowercase kebab-case, such as `fix-session-timeout`.
- Stay on the current non-default branch unless the user requests another branch.
- Use a concise PR title that summarizes the complete diff.

## Workflow

1. Check the prerequisites.
2. Confirm the intended scope.
   - Run `git status -sb` and inspect staged, unstaged, and relevant untracked changes.
   - If unrelated changes are present, ask which files belong in the PR. Never assume the whole worktree is in scope.
3. Determine the repository and branch strategy.
   - Use `gh repo view --json nameWithOwner,defaultBranchRef` to identify the GitHub repository and default base branch.
   - Use a user-specified base branch when provided; otherwise use the remote default branch.
   - If currently on the default branch, create a directly named branch with no automatic prefix.
   - Otherwise remain on the current branch unless the user asks to change it.
4. Check for an existing pull request for the current branch with `gh pr view --json url,state,isDraft` or an equivalent `gh pr list --head` query, and record its URL and review state when found.
5. Create the commit by reading and following [`../commit/SKILL.md`](../commit/SKILL.md).
   - Treat the publish scope confirmed above as the commit scope.
   - If the intended changes are already committed, do not create an empty or unnecessary commit.
6. Run the most relevant project checks if they have not already been run. Do not bypass failures silently. Keep validation details out of the PR body.
7. Push with tracking:
   - `git push -u origin "$(git branch --show-current)"`
8. Create or identify the pull request.
   - If an existing pull request was found, do not create a duplicate or change its title, body, or review state unless the user requested that update.
   - Otherwise, generate the final title and body, then write the body to a temporary file so Markdown and newlines are preserved.
   - Create the pull request with `gh pr create --draft --title "<title>" --body-file "<body-file>" --base "<base>" --head "<head>"`.
   - Omit `--draft` only when the user explicitly asks for ready-for-review.
   - Capture the URL returned by `gh pr create`.
9. Report the branch, commit, base branch, pull request state, and URL. Clearly distinguish between a newly created draft and an existing pull request. Mention check failures or anything still requiring the user's attention, but do not add those details to the pull request body.

## Pull Request Body

When a ticket URL is supplied, place it at the very top as a plain URL, followed by a blank line. After that, include only a small summary of the work using concise, subjectless past-tense action bullets.

Example:

```markdown
https://linear.app/example/issue/PROJECT-123

## Summary

- Implemented the new account recovery flow.
- Refactored session handling to share the existing authentication path.
- Fixed the stale error state shown after retrying.
```

Keep the summary concise and grounded in the actual diff. Use one to three bullets when practical. Do not include a validation or test-plan section, tool output, generated footer, or claims not supported by the changes.

When no ticket URL was supplied, start with the summary instead. Do not prompt for a ticket or add an empty placeholder.

## Safety

- Never stage or commit unrelated user changes silently.
- Never push until scope is clear when the worktree is mixed.
- Never force-push unless the user explicitly requests it and confirms the target branch.
- Never create a duplicate pull request for the same branch.
- Do not request an extra confirmation immediately before creating the pull request when its scope and destination are already clear.
- Stop and explain the blocker if the repository or branch cannot be resolved through `gh`.
