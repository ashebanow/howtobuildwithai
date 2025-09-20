---
description: Analyze completed work and generate a reusable slash command for similar tasks.
argument-hint: ""
usage: "/command-gen"
---

Onboard yourself to the current task:
• Use ultrathink.
• Explore the codebase.
• Ask questions if needed.

Goal: Be fully prepared to start working on the task.

Take as long as you need to prepare. Over-preparation is better than under-preparation.

**Please analyze our conversation thread and create a reusable slash command based on the work we just completed.**

Review everything we've accomplished in this session and design a slash command that would automate or replicate this workflow. Provide:

## Command Specification

**1. Command name**

- What should follow `/project:` (based on our work)

**2. Purpose**

- One-line description capturing the core value we just delivered

**3. Key actions**

- 2-4 bullet points of the main steps we performed
- Focus on the repeatable workflow elements

**4. Parameters**

- What `$ARGUMENTS` would be needed to make this reusable
- How would different inputs change the behavior
- Any optional flags or configuration options

**5. Example usage**

- 2-3 realistic examples showing how someone would invoke this command
- Include different parameter combinations if relevant

**6. Prerequisites**

- Any setup, dependencies, or context required
- File structures, environment variables, etc.

## Implementation Notes

- What parts could be fully automated vs. need human review
- Edge cases or variations to handle

Based on our work, create a complete markdown file ready to save as `/project:{{command-name}}.md` that captures this workflow for future use.
