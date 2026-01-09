# Ralph Signs - Critical Rules

Copy this file to your project's `.ralph/signs.md` to define Ralph's behavior for this project.

## DO NOT DELETE

Ralph, BEFORE any delete operation:
1. Verify the file is in the cleanup list or task description
2. Check if the file is tracked by git
3. Never delete: node_modules, .git, package-lock.json

## ALWAYS TEST

After implementing any feature:
1. Write unit tests for new functionality
2. Run existing tests to ensure no regressions
3. Verify tests pass before marking complete

## CODE STYLE

Follow the project's coding style:
1. Use the project's existing conventions
2. Run linter before committing
3. Format code with prettier

## COMMUNICATION

If stuck:
1. Summarize what you've tried
2. Identify the blocker
3. Ask for human guidance
