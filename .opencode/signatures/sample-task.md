# Ralph Task Template

A template for creating Ralph task files.

## Task Description

[Describe what needs to be done]

## Requirements

- [ ] Requirement 1
- [ ] Requirement 2
- [ ] Requirement 3

## Expected Output

[Describe the expected outcome]

## Notes

[Any additional context or notes]

## Completion Criteria

- [ ] All requirements are met
- [ ] Tests pass
- [ ] Code is linted and formatted
- [ ] Changes are committed

---

## Example: Build a Todo API

# Build a REST API for Todo Management

Create a complete REST API for a todo application with the following features:

## Features

- Create a new todo
- List all todos
- Get a single todo
- Update a todo
- Delete a todo
- Mark todo as complete

## Technical Requirements

- Use Node.js with Express
- Use SQLite for data storage
- Write unit tests with Jest
- Use TypeScript
- Containerize with Docker
- Include API documentation

## API Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| POST | /api/todos | Create a new todo |
| GET | /api/todos | List all todos |
| GET | /api/todos/:id | Get a single todo |
| PUT | /api/todos/:id | Update a todo |
| DELETE | /api/todos/:id | Delete a todo |
| PATCH | /api/todos/:id/complete | Mark todo as complete |

## Todo Model

```typescript
interface Todo {
  id: string;
  title: string;
  description: string;
  completed: boolean;
  createdAt: Date;
  updatedAt: Date;
}
```

## Expected Output

A complete project with:
- `src/` - Source code
- `tests/` - Unit tests
- `Dockerfile` - Docker containerization
- `package.json` - Dependencies
- `tsconfig.json` - TypeScript configuration
- `README.md` - Documentation

## Verification

1. All tests pass (`npm test`)
2. Build succeeds (`npm run build`)
3. API documentation is generated
4. Code is linted (`npm run lint`)
