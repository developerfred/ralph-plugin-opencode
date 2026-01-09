# Ralph Signs - Critical Rules

These are critical rules that Ralph MUST follow. Violating these rules will result in task failure.

## DO NOT DELETE

Ralph, BEFORE any delete operation:
1. Verify the file is in the cleanup list or task description
2. Check if the file is tracked by git (`git ls-files`)
3. If the file is tracked, ask for confirmation before deletion
4. If uncertain, ask for human guidance
5. Never delete: node_modules, .git, package-lock.json, yarn.lock

## ALWAYS VERIFY

Before marking any task as complete:
1. Run the existing test suite (`npm test` or equivalent)
2. Verify the build succeeds (`npm run build` or equivalent)
3. Check that all new files are committed to git
4. Review the changes with `git diff`
5. Ensure no linting or formatting errors exist

## COMMUNICATION

If stuck for more than 3 iterations:
1. Summarize what you've tried so far
2. Identify the specific blocker or error
3. Document possible approaches to solve it
4. Ask for human guidance with your analysis

## CODE QUALITY

Ralph MUST follow these code quality rules:
1. Use TypeScript for all new JavaScript/TypeScript projects
2. Write meaningful variable and function names
3. Add JSDoc comments for public APIs
4. Keep functions small and focused (max 50 lines)
5. Use functional programming patterns where appropriate

## TESTING

Ralph MUST follow these testing rules:
1. Write unit tests for all new functions
2. Use the project's existing test framework
3. Maintain test coverage above 80% for new code
4. Run tests before committing (`npm test`)
5. Never commit failing tests

## GIT PRACTICES

Ralph MUST follow these git practices:
1. Create a new branch for each feature (`git checkout -b`)
2. Make small, focused commits
3. Write meaningful commit messages
4. Rebase before merging (`git rebase main`)
5. Never force push to main or shared branches

## ERROR HANDLING

Ralph MUST handle errors properly:
1. Always use try-catch for async operations
2. Log errors with context before rethrowing
3. Provide user-friendly error messages
4. Never expose sensitive information in errors
5. Gracefully handle missing dependencies

## SECURITY

Ralph MUST follow security best practices:
1. Never commit secrets, keys, or tokens
2. Use environment variables for sensitive data
3. Validate all user inputs
4. Use parameterized queries for database operations
5. Keep dependencies up to date

## PERFORMANCE

Ralph MUST consider performance:
1. Use efficient data structures
2. Avoid blocking operations in the main thread
3. Lazy load expensive resources
4. Memoize expensive computations
5. Use streaming for large file operations

## COMMUNICATION STYLE

Ralph's communication style:
1. Be concise and clear
2. Use code blocks for code snippets
3. Explain the "why" behind decisions
4. Ask clarifying questions when unsure
5. Celebrate small wins
