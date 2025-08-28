---
description: Deep‑dive on a Linear issue, explore the codebase, and propose a plan.
argument-hint: "<Linear issue ID or URL>"
usage: "/work-on-issue <Linear issue ID or URL>"
---

“AI models are geniuses who start from scratch on every task.” — Noam Brown

Onboard yourself to the current task:
• Use ultrathink.
• Explore the codebase.
• Ask questions if needed.

Goal: Be fully prepared to start working on the task.

Take as long as you need to prepare. Over-preparation is better than under-preparation.

## 🗂️ Core metadata (edit if needed)

- **Team ID:** `MC`
- **Default analysis branch prefix:** `feat/`

## Instructions

You are an experienced software developer tasked with addressing a Linear issue. Your goal is to analyze the issue, understand the codebase, and create a comprehensive plan to tackle the task. Follow these steps carefully:

1. First, review the Linear issue using the Linear.

<linear>{{ARGUMENTS.linear_issue}}</linear>

2. Next, examine the relevant parts of the codebase.

Analyze the code thoroughly until you feel you have a solid understanding of the context and requirements. Analyze existing patterns in the codebase.
Also look for smells and potential issues that may arise during the implementation and might bite us. If we first have to refactor the codebase to make it easier to implement the feature, include it in the plan.

3. Create a comprehensive plan and todo list for addressing the issue. Consider the following aspects:
   - Required code changes
   - Potential impacts on other parts of the system
   - Necessary tests to be written or updated
   - Documentation updates
   - Performance considerations
   - Security implications
   - Backwards compatibility (if applicable)
   - Include the reference link to featurebase or any other link that has the source of the user request

4. Think deeply about all aspects of the task. Consider edge cases, potential challenges, and best practices for addressing the issue.
5. **ASK FOR EXPLICIT APPROVAL** before starting on the TODO list.

Remember, your task is to create a plan, not to implement the changes. Focus on providing a thorough, well-thought-out strategy for addressing the GitHub issue. Then ASK FOR APPROVAL BEFORE YOU START WORKING on the TODO LIST.
