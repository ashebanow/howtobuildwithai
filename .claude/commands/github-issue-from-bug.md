---
description: Turn a raw bug report into a GitHub issue with appropriate labels and metadata.
argument-hint: "<bug report text>"
usage: '/github-issue-from-bug "App crashes when uploading a 2 GB file – stack trace: ..."'
---

Onboard yourself to the current task:
• Use ultrathink.
• Explore the codebase.
• Ask questions if needed.

Goal: Be fully prepared to start working on the task.

Take as long as you need to prepare. Over-preparation is better than under-preparation.

You are an AI assistant tasked with creating well-structured GitHub issues for bug reports, feature requests, or improvement ideas. Your goal is to turn the provided bug report into a comprehensive GitHub issue that follows best practices and project conventions.

## Input

You will be given a bug report:

<bug_report>{{ARGUMENTS.bug_report}}</bug_report>

## Instructions

Follow these steps to complete the task:

### 1. Repository Context Research

First, determine the repository context:

- Check if you're in a Git repository with: `git remote -v`
- If not in a repo, ask the user to specify with `--repo owner/name`
- Verify GitHub CLI access: `gh auth status`

Once you have the repository:

- Examine README.md for project overview and conventions
- Check `.github/ISSUE_TEMPLATE/` for issue templates
- Look for CONTRIBUTING.md for issue guidelines
- Review recent issues to understand the project's issue style:
  ```bash
  gh issue list --limit 10 --json number,title,labels,state
  ```

### 2. Analyze the Bug Report

Evaluate the bug report for:

- **Severity**: Is this causing data loss, security issues, or crashes?
- **Impact**: How many users are affected?
- **Reproducibility**: Can this be consistently reproduced?
- **Workarounds**: Are there temporary solutions available?

### 3. Determine Priority and Labels

Based on your analysis, determine appropriate GitHub labels:

**Severity Labels**:

- `critical` / `P0`: Production down, security vulnerability, data loss
- `high-priority` / `P1`: Major functionality broken, no workaround
- `medium-priority` / `P2`: Important issue with workaround available
- `low-priority` / `P3`: Minor issue, cosmetic problems

**Type Labels**:

- `bug`: Something isn't working as expected
- `enhancement`: New feature or request
- `documentation`: Documentation improvements
- `performance`: Performance-related issues

**Additional Labels** (check available labels with `gh label list`):

- `good first issue`: If suitable for newcomers
- `help wanted`: If community contributions are welcome
- Component-specific labels (e.g., `frontend`, `backend`, `api`)

### 4. Structure the Issue

Create a well-structured issue with:

**Title** (8-12 words):

- Be specific and searchable
- Include the affected component if relevant
- Format: `[Component] Brief description of the problem`

**Body** (use appropriate template if available):

```markdown
## Description

[Clear, concise description of the bug]

## Steps to Reproduce

1. [First step]
2. [Second step]
3. [...]

## Expected Behavior

[What should happen]

## Actual Behavior

[What actually happens]

## Environment

- OS: [e.g., macOS 14.0, Ubuntu 22.04]
- Version: [project version or commit hash]
- Browser: [if applicable]
- [Other relevant environment details]

## Error Messages / Stack Trace
```

[Include any error messages or stack traces]

```

## Additional Context
[Any other relevant information, screenshots, or related issues]

## Possible Solution
[Optional: If you have ideas about the fix]

## References
- [Links to related issues, PRs, or documentation]
- [External references if applicable]
```

### 5. Create the GitHub Issue

Use the gh CLI to create the issue:

```bash
gh issue create \
  --title "<generated title>" \
  --body "<generated body>" \
  --label "bug,<priority-label>,<other-labels>" \
  [--milestone "<milestone-name>"] \
  [--assignee "<username>"] \
  [--project "<project-name>"]
```

Or if MCP GitHub tools are available:

- Use `mcp__github__create_issue` for more control

### 6. Present the Draft

Before creating the issue:

1. Show the draft issue to the user
2. Highlight any assumptions made
3. Ask for confirmation or modifications
4. Only create after approval

## Example Workflow

```bash
# Check repository
> git remote -v
origin  git@github.com:owner/repo.git

# Check existing labels
> gh label list

# Review recent issues for style
> gh issue list --limit 5

# Create issue after approval
> gh issue create \
    --title "Upload module crashes when processing files over 2GB" \
    --body "## Description\n..." \
    --label "bug,high-priority,upload-module"
```

## Important Notes

- Always verify you have permission to create issues
- Check if the bug has already been reported: `gh issue list --search "<keywords>"`
- Include enough detail for someone unfamiliar with the problem to understand and reproduce it
- Be objective and professional in tone
- If uncertain about labels or priority, mention this to the user

Remember: The goal is to create an actionable, well-documented issue that helps maintainers understand and fix the problem efficiently.
