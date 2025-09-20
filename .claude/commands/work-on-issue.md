---
description: Deep-dive on a GitHub issue, explore the codebase, and propose a plan.
argument-hint: "<GitHub issue number, #number, or URL>"
usage: "/work-on-github-issue <issue number or URL>"
---

Onboard yourself to the current task:
• Use ultrathink.
• Explore the codebase.
• Ask questions if needed.

Goal: Be fully prepared to start working on the task.

Take as long as you need to prepare. Over-preparation is better than under-preparation.

## Instructions

You are an experienced software developer tasked with addressing a GitHub issue. Your goal is to analyze the issue, understand the codebase, and create a comprehensive plan to tackle the task. Follow these steps carefully:

1. First, retrieve and review the GitHub issue:

<issue_reference>{{ARGUMENTS.github_issue}}</issue_reference>

Parse the issue reference:

- If it's a number or starts with #, use it as the issue number
- If it's a URL, extract the issue number from it
- If --repo is provided, use that repository, otherwise use the current repository

Use the gh CLI to fetch the issue details:

```bash
gh issue view <issue_number> --json title,body,labels,assignees,milestone,state,url,comments
```

If MCP GitHub tools are available, you can also use:

- mcp**github**get_issue for detailed issue information
- mcp**github**get_issue_comments for discussion context

2. Analyze the issue thoroughly:
   - Understand the problem or feature request
   - Review any linked issues or PRs
   - Check comments for additional context or clarifications
   - Note any labels that indicate priority or type (bug, enhancement, etc.)

3. Examine the relevant parts of the codebase:
   - Use grep, find, and other tools to locate relevant code
   - Analyze existing patterns and conventions
   - Identify files that will need modification
   - Look for similar implementations or patterns already in the codebase
   - Check for tests that might need updating

4. Identify potential challenges:
   - Look for code smells or technical debt that might complicate implementation
   - Consider if refactoring is needed before implementing the feature
   - Identify potential breaking changes or compatibility issues
   - Note any performance or security implications

5. Create a comprehensive plan and todo list for addressing the issue. Consider:
   - Required code changes (be specific about files and functions)
   - Potential impacts on other parts of the system
   - Necessary tests to be written or updated
   - Documentation updates needed
   - Performance considerations
   - Security implications
   - Backwards compatibility (if applicable)
   - Any dependencies or prerequisites
   - Estimated complexity and time requirements

6. Structure your plan clearly:
   - Start with a summary of your understanding of the issue
   - List any assumptions you're making
   - Present the implementation plan as a numbered todo list
   - Include any risks or concerns
   - Note any questions that need clarification from maintainers

7. **ASK FOR EXPLICIT APPROVAL** before starting on the TODO list implementation.

## Output Format

Present your analysis and plan in this structure:

### Issue Summary

[Your understanding of the issue]

### Current State Analysis

[What you found in the codebase]

### Implementation Plan

[Numbered todo list with specific tasks]

### Considerations & Risks

[Any concerns, edge cases, or potential issues]

### Questions for Clarification

[Any ambiguities that need resolution]

---

Remember: Your task is to create a thorough plan, not to implement the changes yet. Focus on providing a well-thought-out strategy for addressing the GitHub issue. Then ASK FOR APPROVAL BEFORE YOU START WORKING on the TODO LIST.
