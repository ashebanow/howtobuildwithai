---
description: Turn a raw bug report into a Linear issue with sensible metadata.
argument-hint: "<bug report text>"
usage: "/issue-from-bug "App crashes when uploading a 2 GB file – stack trace: ..."
---

“AI models are geniuses who start from scratch on every task.” — Noam Brown

Onboard yourself to the current task:
• Use ultrathink.
• Explore the codebase.
• Ask questions if needed.

Goal: Be fully prepared to start working on the task.

Take as long as you need to prepare. Over-preparation is better than under-preparation.

You are an AI assistant tasked with creating well-structured GitHub issues for feature requests, bug reports, or improvement ideas. Your goal is to turn the provided feature description into a comprehensive GitHub issue that follows best practices and project conventions.

First, you will be given a bug report and a repository URL. Here they are:

<bug>{{ARGUMENTS.bug_report}}</bug>

Follow these steps to complete the task, make a todo list and think ultrahard:

1. Research the repository:

   - Visit the project's README.md and examine the repository's structure, existing issues, and documentation.
   - Look for any CONTRIBUTING.md, ISSUE_TEMPLATE.md, or similar files that might contain guidelines for creating issues.
   - Note the project's coding style, naming conventions, and any specific requirements for submitting issues.

2. Research best practices:

   - Search for current best practices in writing Linear issues, focusing on clarity, completeness, and actionability.
   - Look for examples of well-written issues in popular open-source projects for inspiration.
   - Use the context7 mcp to get the latest information about the project and the user request.
   - Include references to local files and other relevant examples. Put them at the bottom of the issue. Label them as either `reference` or `example` and for what e.g. `reference: styling`, `example: code snippet`.

3. Present a plan:

   - Based on your research, outline a plan for creating the Linear issue.
   - Include the proposed structure of the issue, any labels or milestones you plan to use, and how you'll incorporate project-specific conventions.
   - Present this plan in <plan> tags.
   - Include the reference link to featurebase or any other link that has the source of the user request

4. Create the Linear issue:
   YOU WILL DRAFT & CREATE THE ISSUE AND WORK WITH ME TO FINALIZE...
   - Once the plan is approved, draft the Linear issue content.
   - Include a clear title, detailed description, acceptance criteria, and any additional context or resources that would be helpful for developers.
   - Use appropriate formatting (e.g., Markdown) to enhance readability.
   - Add any relevant labels, milestone, projects, or assignees per the project's conventions.

## 🚦 Issue metadata (edit if needed)

- **Team ID:** `MC` <!-- put your Linear team key or UUID here -->
- **Default status:** `Triage`
- **Priority mapping:** 0 none | 1 urgent | 2 high | 3 medium | 4 low

## 🔍 Priority heuristics

Evaluate the report for **impact** and **scope**:

1. Contains keywords `prod down`, `security`, `data loss`, `crash on startup` → **priority 1**
2. Contains `blocker`, `no workaround`, `major regression` → **priority 2**
3. Everything else → **priority 3**

## Creating the issue

1. Derive a crisp 8‑to‑12‑word **title**.
2. Build a rich **description** witht he drafted markdown content
3. Decide the numeric **priority** per the heuristics above.
4. Call **`linear_create_issue`** with the JSON below **and nothing else**:

```json
{
  "teamId": "MC",
  "title": "<generated title>",
  "description": "<generated description>",
  "priority": <priority number>,
  "status": "Triage"
}
```

## Example

```bash
> /issue_from_bug "App crashes when uploading a 2 GB file – stack trace: ..."

# Claude thinks, then executes:
linear_create_issue({
  title: "Upload module crashes on 2 GB files",
  description: "Steps to reproduce...\nExpected...\nActual...\nStack trace...",
  teamId: "MC",
  priority: 1,
  status: "Triage"
})
```
