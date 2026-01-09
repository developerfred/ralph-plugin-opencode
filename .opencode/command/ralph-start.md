# Ralph Start

Start a Ralph loop in the background for a task.

## Usage

```
/ralph-start <task_file>
```

## Description

Starts Ralph in background mode, allowing you to continue working while Ralph executes the task. Useful for long-running tasks.

## Examples

```
/ralph-start large-feature.md
/ralph-start refactoring-project.md
```

## Notes

- Ralph runs in background with its own PID
- Check status with: `/ralph-status`
- Stop with: `/ralph-stop <task_name>`

## See Also

- `/ralph-loop` - Run Ralph synchronously
- `/ralph-stop` - Stop Ralph
- `/ralph-status` - Check Ralph status
