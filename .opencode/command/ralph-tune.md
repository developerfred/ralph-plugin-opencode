# Ralph Tune

Add a tuning instruction for Ralph.

## Usage

```
/ralph-tune <instruction>
```

## Description

Adds a tuning instruction that Ralph will follow. This is the primary way to correct Ralph's behavior when he makes mistakes.

## Examples

```
/ralph-tune Always run tests before committing
/ralph-tune Use TypeScript for all new files
/ralph-tune Never delete files with "test" in the name
/ralph-tune Check git status before any write operation
```

## Tuning Guide

When Ralph goes wrong:

1. **Identify the pattern**: What specifically did Ralph do wrong?
2. **Write a sign**: Add a clear instruction to prevent the error
3. **Test**: Run Ralph again and verify the fix
4. **Iterate**: Repeat until Ralph behaves correctly

### Example Tuning

```markdown
# Previous Ralph Behavior
Ralph kept deleting the wrong files.

# New Tuning Instruction
Ralph, BEFORE any delete operation:
1. Verify the file is in the cleanup list
2. Check if the file is tracked by git
3. If uncertain, ask for confirmation
```

## Notes

- Tuning instructions are saved to `~/.ralph/signs/`
- Apply to all tasks or specific tasks
- Can be combined with signs.md for complex rules

## See Also

- `/ralph-loop` - Run Ralph with new tuning
- `.ralph/signs.md` - Persistent tuning file
- `.ralph/guidance.md` - Task-specific guidance
