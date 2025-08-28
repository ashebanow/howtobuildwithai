---
allowed-tools: create_project, create_issue
description: Stand up a Linear project then populate it with scoped issues.
argument-hint: "<big feature spec / request>"
usage: "/project-from-feature "<big feature spec / request>"
---

“AI models are geniuses who start from scratch on every task.” — Noam Brown

Onboard yourself to the current task:
• Use ultrathink.
• Explore the codebase.
• Ask questions if needed.

Goal: Be fully prepared to start working on the task.

Take as long as you need to prepare. Over-preparation is better than under-preparation.

## 📌 Core metadata (edit if needed)

- **Team ID:** `MC` <!-- Linear team key or UUID -->
- **Default project status:** `Backlog`
- **Default issue status:** `Planned`
- **Priority mapping:** 1 urgent | 2 high | 3 normal | 4 low
- **Default target duration:** 6‑weeks

## 🛠️ Priority rubric (issues)

1. Blocks revenue / compliance → **1**
2. Major customer‑visible value, feasible ≤ 2 weeks → **2**
3. Incremental / internal value → **3**
4. Nice‑to‑have / exploration → **4**

## 🎯 Your task

1. **Summarise** the feature request in ≤ 12‑word project `name`.
2. Draft a succinct **project description**: business goal, scope boundaries, done‑criteria.
3. Pick a realistic **targetDate** (default: today + 6 weeks).
4. **Call `create_project`** exactly once:

````json
{
  "teamId": "MC",
  "name": "<project name>",
  "description": "<project description>",
  "status": "Backlog",
  "targetDate": "<YYYY-MM-DD>"
}

Break the feature into 3‑10 atomic issues (vertical slices or infra tasks).

For each issue:

Craft an 8‑to‑12‑word title.

Write a clear description (acceptance criteria, edge cases, links).

Decide priority via the rubric.

Call create_issue referencing the projectId returned from step 4:

```json
{
  "teamId": "ENG-PROJECTS",
  "title": "<issue title>",
  "description": "<issue description>",
  "priority": <1‑4>,
  "status": "Planned",
  "projectId": "<ID from create_project>"
}
````

## Usage demo

```bash
> /project_from_feature "Redesign onboarding to cut time‑to‑value in half"

# Claude executes:
create_project({ teamId:"ENG-PROJECTS", name:"Faster onboarding 50% TTVal", ... })
# → returns { id:"2c15d3e2‑proj" }

create_issue({ teamId:"ENG-PROJECTS", title:"Self‑serve invite flow", projectId:"2c15d3e2‑proj", priority:2, ... })
create_issue({ teamId:"ENG-PROJECTS", title:"Inline product tour",    projectId:"2c15d3e2‑proj", priority:3, ... })
```
