# Ralph Status

Check the current status of Ralph.

## Usage

```
/ralph-status
```

## Description

Displays information about running Ralph instances, including:
- Version information
- Configuration settings
- Active tasks and their iteration counts
- PID information for background tasks

## Examples

```
/ralph-status
```

## Output Example

```
Ralph Wiggum Status
====================

Version: 1.0.0
Max Iterations: 100
Pause: 1000ms
Signs Required: true
Tuning Mode: strict

Active Tasks:
-------------
  ● feature-x (PID: 12345, Iteration: 42)
  ● refactor (PID: 67890, Iteration: 15)
```

## Notes

- Shows all active Ralph instances
- Indicates zombie processes (dead PIDs)
- Displays current iteration count per task

## See Also

- `/ralph-start` - Start Ralph in background
- `/ralph-stop` - Stop Ralph
- `/ralph-loop` - Run Ralph synchronously
