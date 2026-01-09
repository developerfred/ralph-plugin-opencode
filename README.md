# Ralph Wiggum Plugin for OpenCode

> "I can't give you the code, but I can give you the courage to code it yourself."
> — Ralph Wiggum

A powerful OpenCode plugin that implements the **Ralph Wiggum pattern** - an autonomous coding agent that runs in infinite loops until task completion. Named after the lovable yet misguided character from The Simpsons, Ralph represents the beauty of deterministic iteration in an unpredictable world.

## Features

- 🔄 **Infinite Loop Execution**: Ralph never gives up until the task is 100% complete
- 📋 **Signs System**: Read and respect project rules via AGENTS.md and .ralph/signs.md
- 🎯 **Deterministic Behavior**: Reliable persistence in an undeterministic world
- 🔧 **Tunable**: When Ralph fails, tune the prompts, don't blame the tools
- 📊 **Metrics Tracking**: Iteration count, success/failure rates, and tuning effectiveness
- ⚡ **Background Execution**: Run Ralph in background while you work on other things

## Quick Start

### Installation

```bash
# Clone or download this plugin
cd ralph-plugin-opencode

# Make the ralph script executable
chmod +x .opencode/ralph.sh

# Run the installer
bun install
bun run install
```

### Basic Usage

```bash
# Create a task file
cat > my-task.md << EOF
# Build a REST API

Build a complete REST API for a todo application with:
- CRUD operations for todos
- User authentication
- SQLite database
- Unit tests
EOF

# Run Ralph loop
./ralph.sh loop my-task.md

# Or run in background
./ralph.sh start my-task.md

# Check status
./ralph.sh status

# Stop when done
./ralph.sh stop my-task
```

## Configuration

### Environment Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `RALPH_MAX_ITERATIONS` | 100 | Maximum iterations before forcing stop |
| `RALPH_PAUSE_MS` | 1000 | Pause between iterations in milliseconds |
| `RALPH_SIGNALS_REQUIRED` | true | Require signals to run |
| `RALPH_TUNING_MODE` | strict | Tuning mode: strict\|permissive |
| `RALPH_MODEL` | claude-sonnet-4-5 | AI model to use |
| `RALPH_TEMPERATURE` | 0.7 | AI temperature (0.0-1.0) |

### OpenCode Configuration

Create or edit `~/.config/opencode/opencode.json`:

```json
{
  "plugin": ["ralph-wiggum"],
  "ralph": {
    "enabled": true,
    "max_iterations": 100,
    "pause_ms": 1000,
    "signs_required": true,
    "tuning_mode": "strict"
  }
}
```

## Commands

### `ralph loop <task_file>`

Run Ralph in loop mode until task completion.

```bash
./ralph.sh loop task.md
```

### `ralph start <task_file>`

Start Ralph in background for a task.

```bash
./ralph.sh start feature.md
```

### `ralph stop [task]`

Stop Ralph (default: all tasks).

```bash
# Stop specific task
./ralph.sh stop feature

# Stop all tasks
./ralph.sh stop
```

### `ralph status`

Show Ralph status and active tasks.

```bash
./ralph.sh status
```

### `ralph tune <instruction>`

Add a tuning instruction for Ralph.

```bash
./ralph.sh tune "Always run tests before committing"
```

## Signs System

Ralph respects the following signs when present in the project:

### Project-level Signs

- `AGENTS.md` - Project-wide context and rules
- `.claude/rules/` - Conditional rules that apply based on file patterns

### Ralph-specific Signs

- `.ralph/signs.md` - Critical rules that Ralph must never violate
- `.ralph/guidance.md` - Guidance for specific task types
- `.ralph/errors.md` - Known error patterns and how to handle them

### Example signs.md

```markdown
# Ralph Signs - Critical Rules

## DO NOT DELETE
Ralph, BEFORE any delete operation:
1. Verify the file is in the cleanup list
2. Check if the file is tracked by git
3. If uncertain, ask for confirmation

## ALWAYS TEST
After implementing any feature:
1. Write unit tests for new functionality
2. Run existing tests to ensure no regressions
3. Verify tests pass before marking complete

## COMMUNICATION
If stuck for more than 3 iterations:
1. Summarize what you've tried
2. Identify the blocker
3. Ask for human guidance
```

## Ralph's Commandments

1. **THOU SHALT NOT STOP** - Ralph never gives up mid-task. Complete the loop.
2. **THOU SHALT LOOK FOR SIGNS** - Read and respect the signs in the project
3. **THOU SHALT BE DETERMINISTIC** - In an undeterministic world, be reliably persistent
4. **THOU SHALT TUNE NOT BLAME** - When Ralph fails, tune the prompts, don't blame the tools
5. **THOU SHALT ITERATE** - Every failure is an opportunity for tuning

## Ralph Keywords

Include these keywords in your prompts to activate Ralph behavior:

- `ralph` or `ralph_loop` - Activates infinite loop execution mode
- `ultrawork` - Aggressive parallel execution until completion
- `relentless` - Never give up until task is 100% complete

Example:

```
ralph Build me a complete e-commerce application with:
- Product catalog
- Shopping cart
- User authentication
- Payment integration
- Order management
relentless
```

## Directory Structure

```
ralph-plugin-opencode/
├── AGENTS.md                    # Main Ralph Wiggum documentation
├── README.md                    # This file
├── package.json                 # Bun package metadata
├── .opencode/
│   ├── opencode.json           # OpenCode plugin configuration
│   └── ralph.sh                # Ralph Wiggum executable script
└── .ralph/                      # Ralph configuration directory (created at runtime)
    ├── signs/                  # Ralph-specific signs
    ├── signals/                # Ralph signal files
    ├── state/                  # Ralph state files
    └── logs/                   # Ralph log files
```

## Files Created at Runtime

When Ralph runs, it creates the following directories:

- `~/.ralph/state/` - Ralph state files (iteration counts, PIDs, etc.)
- `~/.ralph/logs/` - Ralph log files
- `~/.ralph/signals/` - Ralph signal files (pause, stop, etc.)
- `~/.ralph/signs/` - Ralph tuning signs

## Troubleshooting

### Ralph keeps failing the same way

Add a tuning instruction to prevent the error:

```bash
./ralph.sh tune "Ralph, before deleting files: 1. Check git status 2. Verify file is not tracked"
```

### Ralph is stuck in an infinite loop

Send a stop signal:

```bash
./ralph.sh stop <task_name>
```

Or create a stop file:

```bash
touch ~/.ralph/signals/<task_name>.stop
```

### Ralph needs to pause

Send a pause signal:

```bash
touch ~/.ralph/signals/<task_name>.pause
```

To resume, remove the pause file:

```bash
rm ~/.ralph/signals/<task_name>.pause
```

## Examples

### Example 1: Build a REST API

```markdown
# task.md
# Build a REST API

Create a REST API for a todo application with:
- POST /todos - Create a new todo
- GET /todos - List all todos
- PUT /todos/:id - Update a todo
- DELETE /todos/:id - Delete a todo

Use:
- Node.js with Express
- SQLite database
- Jest for testing
- Docker for containerization

After completion, verify the API works with integration tests.
```

```bash
./ralph.sh loop task.md
```

### Example 2: Refactor a codebase

```bash
./ralph.sh start refactor.md
# Check status periodically
./ralph.sh status
# Stop when done
./ralph.sh stop refactor
```

### Example 3: Add tuning mid-execution

```bash
# Ralph is deleting test files accidentally
./ralph.sh tune "Ralph, NEVER delete files with 'test' in the name"

# Ralph is making the same mistake
./ralph.sh tune "Ralph, use camelCase for all JavaScript variables"
```

## Resources

- [Ralph Wiggum as a "software engineer"](https://ghuntley.com/ralph/)
- [Repomirror Ralph Implementation](https://github.com/repomirrorhq/repomirror/blob/main/repomirror.md)
- [Ralph Wiggum Showdown Video](https://twitter.com/dexhorthy/status/2006849540998000796)
- [OpenCode Documentation](https://opencode.ai/docs/)

## Credits

Created by [Geoffrey Huntley](https://ghuntley.com/) and implemented for OpenCode by this community plugin.

---

**Remember:** "I'm in danger!" - Ralph Wiggum, every iteration

![Ralph Wiggum](https://upload.wikimedia.org/wikipedia/en/thumb/1/14/Ralph_Wiggum.png/220px-Ralph_Wiggum.png)
