#!/usr/bin/env bash
# Register MCP servers with Claude Code and Codex. Safe to re-run.
# Existing servers are skipped rather than replaced, so their OAuth logins survive.

set -euo pipefail

claude_mcp() {
	local name="$1" json="$2"
	if ! claude mcp get "$name" >/dev/null 2>&1; then
		claude mcp add-json --scope user "$name" "$json"
	fi
}

codex_mcp() {
	local name="$1"
	shift
	if ! codex mcp get "$name" >/dev/null 2>&1; then
		codex mcp add "$name" "$@"
	fi
}

if command -v claude >/dev/null; then
	claude_mcp jira-dng '{"type":"http","url":"https://mcp.atlassian.com/v2/mcp"}'
	claude_mcp jira-acl '{"type":"http","url":"https://mcp.atlassian.com/v2/mcp"}'
	claude_mcp chrome-devtools '{"type":"stdio","command":"npx","args":["-y","chrome-devtools-mcp@latest","--autoConnect","--no-usage-statistics"]}'
fi

if command -v codex >/dev/null; then
	codex_mcp jira-dng --url https://mcp.atlassian.com/v2/mcp
	codex_mcp jira-acl --url https://mcp.atlassian.com/v2/mcp
	codex_mcp 1password -- 1password-mcp
	codex_mcp railway -- railway mcp
	codex_mcp sentry -- npx -y mcp-remote@latest https://mcp.sentry.dev/mcp
fi
