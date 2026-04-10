# Git Commit Conventions

This project strictly follows the [Conventional Commits](https://www.conventionalcommits.org/ "null") specification to ensure a readable, machine-parseable commit history and to facilitate automated changelog generation.

## 1. Commit Message Format

Each commit message consists of a  **header** , an optional  **body** , and an optional  **footer** . The header has a special format that includes a `type`, an optional `scope`, and a `subject`:

```
<type>(<scope>): <subject>
<BLANK LINE>
<body>
<BLANK LINE>
<footer>
```

## 2. Allowed Types

Must be one of the following:

* **`feat`** : A new feature for the user or app.
* **`fix`** : A bug fix for the user or app.
* **`docs`** : Documentation only changes (e.g., README, comments, markdown files in `/docs`).
* **`style`** : Changes that do not affect the meaning of the code (white-space, formatting, missing semi-colons, etc). *Note: Not for UI/CSS changes.*
* **`refactor`** : A code change that neither fixes a bug nor adds a feature (e.g., renaming variables, extracting functions).
* **`perf`** : A code change that improves performance.
* **`test`** : Adding missing tests or correcting existing tests.
* **`build`** : Changes that affect the build system or external dependencies (e.g., Gradle, npm, version updates).
* **`ci`** : Changes to CI configuration files and scripts (e.g., GitHub Actions, Travis).
* **`chore`** : Other changes that don't modify `src` or `test` files (routine tasks, tooling setup).
* **`revert`** : Reverts a previous commit.

## 3. Scope (Optional but Recommended)

The scope provides context for where the change was made. It should be a short, noun-based identifier indicating the section of the codebase.

* *Examples:* `(ui)`, `(db)`, `(parser)`, `(auth)`, `(deps)`.

## 4. Subject Rules (The Summary)

* Use the imperative, present tense: "change" not "changed" nor "changes" (e.g., `feat: add database schema`).
* Don't capitalize the first letter.
* No dot (.) at the end.

## 5. Examples of Good Commits

* `feat(parser): add regex to extract BCA notification amounts`
* `fix(ui): resolve clipping issue on the main dashboard card`
* `chore(deps): update Room database version to 2.6.1`
* `docs: update UI/UX guidelines with empty state definitions`
