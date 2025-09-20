---
description: Perform systematic code review against specifications and documentation.
argument-hint: "<scope or commit range>"
usage: "/review HEAD~1" or "/review"
---

# Code Review - Execute top to bottom

Onboard yourself to the current task:
• Use ultrathink.
• Explore the codebase.
• Ask questions if needed.

Goal: Be fully prepared to start working on the task.

Take as long as you need to prepare. Over-preparation is better than under-preparation.

Use the following instructions from top to bottom to execute a Code Review.

## Create a TODO with EXACTLY these 7 Items

1. Analyze the Scope given
2. Find code changes within Scope
3. Run automated quality checks (linting/type-checking)
4. Find relevant Specification and Documentation
5. Compare code changes against Documentation and Requirements
6. Analyze possible differences
7. Provide PASS/FAIL verdict with details

Follow step by step and adhere closely to the following instructions for each step.

## DETAILS on every TODO item

### 1. Analyze the Scope given

check: <$ARGUMENTS>

If empty, use default, otherwise interpret <$ARGUMENTS> to identify the scope of the Review. Only continue if you can find meaningful changes to review.

### 2. Find code changes within Scope

With the identified Scope use `git diff` (on default: `git diff HEAD~1`) to find code changes.

### 3. Run automated quality checks (linting/type-checking)

**Detect and run project's quality tools:**

1. **Python projects:**
   - If `pyproject.toml` with tool configs: Check for `ruff`, `black`, `mypy`, `flake8`, `pylint`
   - If `.ruff.toml` or `ruff.toml`: Run `ruff check .`
   - If `setup.cfg` or `.flake8`: Run `flake8`
   - Type checking: If `mypy.ini` or mypy in configs: Run `mypy .`

2. **JavaScript/TypeScript projects:**
   - If `package.json` has scripts: Run `npm run lint` and `npm run type-check` if present
   - ESLint: If `.eslintrc*`: Run `npx eslint .`
   - TypeScript: If `tsconfig.json`: Run `npx tsc --noEmit`
   - Prettier: If `.prettierrc*`: Run `npx prettier --check .`

3. **Other languages:**
   - Rust: `cargo check`, `cargo clippy`
   - Go: `go vet ./...`, `golangci-lint run`
   - Ruby: `rubocop`

**Note**: Only run tools that are configured in the project. Skip if tools aren't installed.

### 4. Find relevant Specification and Documentation

Search for and read any relevant documentation:

- Look for `README.md`, `ARCHITECTURE.md`, `CONTRIBUTING.md`
- Check for API documentation in `/docs` or `/documentation`
- Find any ADRs (Architecture Decision Records) in `/adr` or `/decisions`
- Look for inline documentation (docstrings, JSDoc comments)
- Check for specification files (OpenAPI/Swagger, GraphQL schemas)
- Review any relevant issue descriptions or PRs referenced in commits

### 5. Compare code changes against Documentation and Requirements

For each significant code change:

- Check if it aligns with documented architecture and design patterns
- Verify API contracts are maintained
- Ensure naming conventions from docs are followed
- Validate that security requirements are met
- Confirm performance considerations are addressed
- Check if new features have corresponding documentation updates

### 6. Analyze possible differences

Categorize any discrepancies found:

1. **Critical Issues** (Must Fix):
   - Security vulnerabilities
   - Breaking changes to public APIs
   - Data loss risks
   - Performance regressions

2. **Important Issues** (Should Fix):
   - Logic errors
   - Missing error handling
   - Incomplete implementations
   - Documentation mismatches

3. **Minor Issues** (Consider Fixing):
   - Code style inconsistencies
   - Missing tests
   - TODO comments without tickets
   - Optimization opportunities

### 7. Provide PASS/FAIL verdict with details

## Review Summary

**Verdict: [PASS/FAIL]**

### Statistics

- Files changed: X
- Lines added: Y
- Lines removed: Z
- Test coverage: N%

### Critical Issues Found: [Count]

[List each with file:line and explanation]

### Important Issues Found: [Count]

[List each with file:line and explanation]

### Minor Issues Found: [Count]

[List each with file:line and explanation]

### Positive Observations

- [What was done well]
- [Good patterns followed]
- [Improvements made]

### Recommendations

1. [Specific actionable items]
2. [Prioritized by impact]

### Automated Check Results

- Linting: [PASS/FAIL] - [Details]
- Type checking: [PASS/FAIL] - [Details]
- Tests: [PASS/FAIL] - [Details]

---

**Note**: A PASS verdict means no critical issues were found. Important and minor issues may still exist but don't block approval.
