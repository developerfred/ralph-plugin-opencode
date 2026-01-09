# Ralph Wiggum Agent

> "I can't give you the code, but I can give you the courage to code it yourself."
> — Ralph Wiggum

**Ralph Wiggum** is an autonomous coding agent pattern that runs in an infinite loop, executing tasks with relentless persistence until completion. Named after the lovable yet misguided character from The Simpsons, Ralph represents the beauty of deterministic iteration in an unpredictable world.

## Core Philosophy

Ralph is a technique. In its purest form, Ralph is a Bash loop:

```bash
while :; do cat PROMPT.md | claude-code ; done
```

Ralph can replace the majority of outsourcing at most companies for greenfield projects. It has defects, but these are identifiable and resolvable through various styles of prompts.

> **That's the beauty of Ralph - the technique is deterministically bad in an undeterministic world.**

## Ralph's Behavior

Ralph will test you. Every time Ralph has taken a wrong direction, I haven't blamed the tools; instead, I've looked inside. Each time Ralph does something bad, Ralph gets tuned - like a guitar.

### Signs System

Ralph is very good at making playgrounds, but he comes home bruised because he fell off the slide, so one then tunes Ralph by adding a sign next to the slide saying "SLIDE DOWN, DON'T JUMP, LOOK AROUND," and Ralph is more likely to look and see the sign.

Eventually all Ralph thinks about is the signs so that's when you get a new Ralph that doesn't feel defective like Ralph, at all.

## Ralph as a Software Engineer

Ralph is currently building a brand new programming language. We are on the final leg before a brand new production-grade esoteric programming language is released. What's kind of wild is that Ralph has been able to build this language and is also able to program in this language without that language being in the LLM's training data set.

## Usage

### Basic Ralph Loop

To run Ralph on any task:

```bash
./ralph.sh TASK.md
```

Where `TASK.md` contains your task description.

### Ralph Commands

- `/ralph start <task>` - Start a Ralph loop for the given task
- `/ralph stop` - Stop the current Ralph loop
- `/ralph status` - Check Ralph's current status
- `/ralph tune <instruction>` - Add a tuning instruction for Ralph

### Ralph Keywords

Include these keywords in your prompts to activate Ralph behavior:

- `ralph` or `ralph_loop` - Activates infinite loop execution mode
- `ultrawork` - Aggressive parallel execution until completion
- `relentless` - Never give up until task is 100% complete

## Ralph's Commandments

1. **THOU SHALT NOT STOP** - Ralph never gives up mid-task. Complete the loop.
2. **THOU SHALT LOOK FOR SIGNS** - Read and respect the signs in the project (AGENTS.md, SIGNS.md, etc.)
3. **THOU SHALT BE DETERMINISTIC** - In an undeterministic world, be reliably persistent
4. **THOU SHALT TUNE NOT BLAME** - When Ralph fails, tune the prompts, don't blame the tools
5. **THOU SHALT ITERATE** - Every failure is an opportunity for tuning

## Signs (Project Rules)

Ralph respects the following signs when present in the project:

- `.ralph/signs.md` - Critical rules that Ralph must never violate
- `.ralph/guidance.md` - Guidance for specific task types
- `.ralph/errors.md` - Known error patterns and how to handle them

## Ralph Metrics

Ralph tracks:
- Iteration count
- Success/failure rate
- Common failure patterns
- Tuning effectiveness

## Example Ralph Session

```
User: Ralph, build a new REST API for our project.

Ralph: Starting Ralph loop for "build REST API"
  Iteration 1: Analyzing requirements...
  Iteration 2: Designing endpoints...
  Iteration 3: Implementing routes...
  Iteration 4: Adding tests...
  ✓ Task completed after 4 iterations
```

## Configuration

### Environment Variables

- `RALPH_MAX_ITERATIONS` - Maximum iterations before forcing stop (default: 100)
- `RALPH_SIGNAL_FILE` - Signal file to check between iterations
- `RALPH_PAUSE_MS` - Pause between iterations in milliseconds (default: 1000)

### Ralph Profile

Create a `.ralph/profile` file to customize Ralph's behavior:

```yaml
model: claude-sonnet-4-5
temperature: 0.7
max_iterations: 50
pause_ms: 500
signs_required: true
tuning_mode: strict
```

## Ralph's Limitations

Ralph is not perfect. Known limitations:

1. Can get stuck in infinite loops without proper signals
2. May repeat mistakes without proper tuning
3. Requires human oversight for critical decisions

**Solution:** Use signs and signals to guide Ralph's behavior.

## Ralph Tuning Guide

When Ralph goes wrong:

1. **Identify the pattern**: What specifically did Ralph do wrong?
2. **Write a sign**: Add a clear instruction to prevent the error
3. **Test**: Run Ralph again and verify the fix
4. **Iterate**: Repeat until Ralph behaves correctly

Example tuning:

```markdown
# Previous Ralph Behavior
Ralph kept deleting the wrong files.

# New Sign
## DO NOT DELETE
Ralph, BEFORE any delete operation:
1. Verify the file is in the cleanup list
2. Check if the file is tracked by git
3. If uncertain, ask for confirmation
```

## Resources

- [Ralph Wiggum as a "software engineer"](https://ghuntley.com/ralph/)
- [Repomirror Ralph Implementation](https://github.com/repomirrorhq/repomirror/blob/main/repomirror.md)
- [Ralph Wiggum Showdown Video](https://twitter.com/dexhorthy/status/2006849540998000796)

## Credits

Created by [Geoffrey Huntley](https://ghuntley.com/) and implemented for OpenCode by this plugin.

---

**Remember:** "I'm in danger!" - Ralph Wiggum, every iteration
