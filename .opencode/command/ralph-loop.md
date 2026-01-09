# Ralph Loop

Run a task with the Ralph Wiggum pattern - relentless autonomous execution until completion.

## Usage

```
/ralph-loop <task_file>
```

## Description

Starts a Ralph loop that will execute the task repeatedly until completion. Ralph never gives up mid-task and will keep iterating until the work is 100% done.

## Examples

```
/ralph-loop TASK.md
/ralph-loop feature-implementation.md
/ralph-loop bugfix.md
```

## Keywords

- `ralph` - Activate infinite loop execution mode
- `ultrawork` - Aggressive parallel execution
- `relentless` - Never give up until 100% complete

## Notes

- Ralph reads signs from AGENTS.md and .ralph/signs.md
- Ralph will run until completion or max iterations (default: 100)
- Pause between iterations: 1000ms (configurable)
- Check status with: `ralph-status`

## See Also

- `/ralph-start` - Start Ralph in background
- `/ralph-stop` - Stop Ralph
- `/ralph-status` - Check Ralph status
- `/ralph-tune` - Add tuning instructions
