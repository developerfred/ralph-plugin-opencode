# Ralph Stop

Stop a running Ralph loop.

## Usage

```
/ralph-stop [task_name]
```

## Description

Stops a currently running Ralph loop. If no task name is provided, stops all running Ralph instances.

## Examples

```
/ralph-stop feature-x
/ralph-stop
```

## Notes

- Gracefully stops Ralph by sending a stop signal
- Current iteration state is preserved in logs
- Can restart with `/ralph-start` or `/ralph-loop`

## See Also

- `/ralph-start` - Start Ralph in background
- `/ralph-loop` - Run Ralph synchronously
- `/ralph-status` - Check Ralph status
