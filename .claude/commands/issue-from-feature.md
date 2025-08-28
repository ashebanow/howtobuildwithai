---
allowed-tools: linear_create_issue
description: Turn a feature idea or request into a Linear issue with sensible metadata.
argument-hint: "<feature request text>"
usage: '/issue-from-feature "Add dark‑mode toggle to settings"'
---

“AI models are geniuses who start from scratch on every task.” — Noam Brown

Onboard yourself to the current task:
• Use ultrathink.
• Explore the codebase.
• Ask questions if needed.

Goal: Be fully prepared to start working on the task.

Take as long as you need to prepare. Over-preparation is better than under-preparation.

You are an AI assistant tasked with creating well-structured Linear issues for feature requests, bug reports, or improvement ideas. Your goal is to turn the provided feature description into a comprehensive Linear issue that follows best practices and project conventions.

First, you will be given a feature description. Here they are:

<feature>{{ARGUMENTS.feature_request}}</feature>

---

## 1 — Research the repository

- Read `README.md`, `ROADMAP.md`, or `PRODUCT_VISION.md` to confirm alignment with strategy.
- Check `CONTRIBUTING.md`, `FEATURE_REQUEST_TEMPLATE.md`, or similar for formatting rules.
- Inspect the directory tree (`ls -R` or git) to locate components that the feature should extend, not duplicate.

## 2 — Research best practices

- Review public feature‑request templates (GitHub, Jira, etc.) for structure inspiration.
- Apply **RICE scoring** (Reach, Impact, Confidence, Effort) to gauge priority quantitatively.
- Collect examples of clear acceptance‑criteria formats and adapt.
- Use the context7 mcp to get the latest information about the project and the user request.
- Include references to local files and other relevant examples. Put them at the bottom of the issue. Label them as either `reference` or `example` and for what e.g. `reference: styling`, `example: code snippet`.

## 3 — Present a plan

Enclose your proposal in `<plan>` tags containing:

- **Problem / Opportunity** – user pain or business value.
- **Proposed Solution** – concise approach or alternative options.
- **Acceptance Criteria** – bullet‑point, testable.
- **RICE calculation** – show numbers and final score.
- **Reference Links** – PRD, Featurebase thread, customer tickets, design mocks.

## 4 — Draft the Linear issue (after plan approval)

Once I type **approve**, build the issue with:

1. A crisp 8‑to‑12‑word **title** focused on value delivered.
2. A rich **description** mirroring the plan sections.
3. A numeric **priority** based on RICE buckets.
4. Call **`linear_create_issue`**:

```json
{
  "teamId": "MC",
  "title": "<generated title>",
  "description": "<generated description>",
  "priority": <1‑4>,
  "status": "Backlog",
  "labels": ["feature"]
}
```

## 🚦 Issue metadata (edit if needed)

- **Team ID:** `MC`
- **Default status:** `Backlog`
- **Priority mapping:** 1 urgent | 2 high | 3 normal | 4 low

### Example

```bash
> /issue_from_feature "Add dark‑mode toggle to settings"

# Claude thinks, presents <plan>, I reply "approve"

# Claude then executes:
linear_create_issue({
  "teamId": "MC",
  "title": "Dark‑mode toggle in settings",
  "description": "Problem… Solution… Acceptance criteria… RICE: 210",
  "priority": 2,
  "status": "Backlog",
  "labels": ["feature"]
})
```
