#!/bin/bash

# Ralph Wiggum - Autonomous Coding Agent Loop
# https://ghuntley.com/ralph/

set -e

RALPH_VERSION="1.0.0"
RALPH_DIR="${RALPH_DIR:-$HOME/.ralph}"
RALPH_LOG_DIR="$RALPH_DIR/logs"
RALPH_STATE_DIR="$RALPH_DIR/state"
RALPH_SIGNALS_DIR="$RALPH_DIR/signals"
RALPH_SIGNS_DIR="$RALPH_DIR/signs"

# Default configuration
MAX_ITERATIONS="${RALPH_MAX_ITERATIONS:-100}"
PAUSE_MS="${RALPH_PAUSE_MS:-1000}"
SIGNALS_REQUIRED="${RALPH_SIGNALS_REQUIRED:-true}"
TUNING_MODE="${RALPH_TUNING_MODE:-strict}"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Logging functions
log_info() {
    echo -e "${BLUE}[RALPH]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[RALPH]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[RALPH]${NC} $1"
}

log_error() {
    echo -e "${RED}[RALPH]${NC} $1"
}

log_ralph() {
    echo -e "${CYAN}[Ralph Wiggum]${NC} $1"
}

# Ensure directories exist
ensure_dirs() {
    mkdir -p "$RALPH_LOG_DIR"
    mkdir -p "$RALPH_STATE_DIR"
    mkdir -p "$RALPH_SIGNALS_DIR"
    mkdir -p "$RALPH_SIGNS_DIR"
}

# Get current timestamp
timestamp() {
    date +"%Y-%m-%d %H:%M:%S"
}

# Get iteration count for a task
get_iteration() {
    local task_name="$1"
    cat "$RALPH_STATE_DIR/$task_name.iteration" 2>/dev/null || echo "0"
}

# Increment iteration count
increment_iteration() {
    local task_name="$1"
    local current=$(get_iteration "$task_name")
    echo $((current + 1)) > "$RALPH_STATE_DIR/$task_name.iteration"
}

# Save task status
save_status() {
    local task_name="$1"
    local status="$2"
    local message="$3"
    echo "{\"timestamp\": \"$(timestamp)\", \"status\": \"$status\", \"message\": \"$message\"}" >> "$RALPH_LOG_DIR/$task_name.log"
}

# Check if task is complete
check_completion() {
    local task_file="$1"
    local completion_marker="${RALPH_STATE_DIR}/$(basename "$task_file" .md).complete"

    if [ -f "$completion_marker" ]; then
        return 0
    fi
    return 1
}

# Mark task as complete
mark_complete() {
    local task_file="$1"
    local completion_marker="${RALPH_STATE_DIR}/$(basename "$task_file" .md).complete"
    touch "$completion_marker"
    log_success "Task marked as complete!"
}

# Check for signals
check_signals() {
    local task_file="$1"
    local task_name=$(basename "$task_file" .md)

    # Check for stop signal
    if [ -f "$RALPH_SIGNALS_DIR/$task_name.stop" ]; then
        log_warn "Stop signal received for task: $task_name"
        rm -f "$RALPH_SIGNALS_DIR/$task_name.stop"
        return 1
    fi

    # Check for pause signal
    if [ -f "$RALPH_SIGNALS_DIR/$task_name.pause" ]; then
        log_info "Pause signal received. Waiting..."
        while [ -f "$RALPH_SIGNALS_DIR/$task_name.pause" ]; do
            sleep 1
        done
        log_info "Resuming task: $task_name"
    fi

    return 0
}

# Read and display signs
read_signs() {
    local task_file="$1"
    local task_dir=$(dirname "$task_file")

    log_info "Reading signs..."

    # Project-level signs
    if [ -f "AGENTS.md" ]; then
        log_info "Found AGENTS.md - reading project rules..."
    fi

    # Ralph-specific signs
    if [ -f ".ralph/signs.md" ]; then
        log_info "Found .ralph/signs.md - reading Ralph-specific rules..."
        cat .ralph/signs.md
    fi

    # Task-specific signs
    if [ -f ".ralph/signs-$(basename "$task_file" .md).md" ]; then
        log_info "Found task-specific signs..."
        cat ".ralph/signs-$(basename "$task_file" .md).md"
    fi
}

# Execute a single iteration
execute_iteration() {
    local task_file="$1"
    local iteration="$2"

    log_ralph "Iteration $iteration"

    # Read the task
    local task_content=$(cat "$task_file")

    # Log the iteration
    save_status "$(basename "$task_file" .md)" "iteration" "Starting iteration $iteration"

    # Execute via opencode
    if command -v opencode &> /dev/null; then
        opencode --task "$task_file" --model "${RALPH_MODEL:-claude-sonnet-4-5}" --temperature "${RALPH_TEMPERATURE:-0.7}"
    else
        # Fallback: run with the AI CLI
        if command -v claude-code &> /dev/null; then
            cat "$task_file" | claude-code
        elif command -v claude &> /dev/null; then
            claude --task-file "$task_file"
        else
            log_error "No compatible AI CLI found. Please install opencode, claude-code, or claude."
            return 1
        fi
    fi

    # Check if task is complete
    if check_completion "$task_file"; then
        return 0
    fi

    return 1
}

# Main Ralph loop
ralph_loop() {
    local task_file="$1"

    if [ ! -f "$task_file" ]; then
        log_error "Task file not found: $task_file"
        exit 1
    fi

    local task_name=$(basename "$task_file" .md)
    local iteration=0

    ensure_dirs

    log_ralph "Starting Ralph loop for: $task_name"
    log_ralph "Max iterations: $MAX_ITERATIONS"
    log_ralph "Pause between iterations: ${PAUSE_MS}ms"
    log_ralph "Signs required: $SIGNALS_REQUIRED"

    # Initial sign reading
    if [ "$SIGNALS_REQUIRED" = "true" ]; then
        read_signs "$task_file"
    fi

    # Main loop
    while [ $iteration -lt $MAX_ITERATIONS ]; do
        iteration=$((iteration + 1))
        increment_iteration "$task_name"

        # Check signals
        if ! check_signals "$task_file"; then
            log_warn "Ralph loop stopped by signal"
            save_status "$task_name" "stopped" "Loop stopped by signal"
            exit 0
        fi

        log_info "--- Iteration $iteration of $MAX_ITERATIONS ---"

        # Execute iteration
        if execute_iteration "$task_file" "$iteration"; then
            log_success "Task completed successfully!"
            save_status "$task_name" "success" "Completed in $iteration iterations"
            mark_complete "$task_file"
            return 0
        fi

        # Pause between iterations
        if [ $iteration -lt $MAX_ITERATIONS ]; then
            sleep $((PAUSE_MS / 1000))
        fi
    done

    log_error "Max iterations reached ($MAX_ITERATIONS). Task not complete."
    save_status "$task_name" "failed" "Max iterations reached"
    return 1
}

# Start Ralph in background
ralph_start() {
    local task_file="$1"
    local task_name=$(basename "$task_file" .md)

    if [ -f "$RALPH_STATE_DIR/$task_name.pid" ]; then
        local existing_pid=$(cat "$RALPH_STATE_DIR/$task_name.pid")
        if kill -0 "$existing_pid" 2>/dev/null; then
            log_warn "Ralph is already running for this task (PID: $existing_pid)"
            return 1
        fi
    fi

    log_info "Starting Ralph in background for: $task_name"
    nohup bash "$0" loop "$task_file" > "$RALPH_LOG_DIR/$task_name.out" 2>&1 &
    local pid=$!
    echo "$pid" > "$RALPH_STATE_DIR/$task_name.pid"
    echo "$task_file" > "$RALPH_STATE_DIR/$task_name.task"

    log_success "Ralph started with PID: $pid"
    echo "$pid"
}

# Stop Ralph
ralph_stop() {
    local task_name="${1:-*}"

    for state_file in "$RALPH_STATE_DIR"/$task_name.pid; do
        if [ -f "$state_file" ]; then
            local pid=$(cat "$state_file")
            local task=$(basename "$state_file" .pid)

            if kill -0 "$pid" 2>/dev/null; then
                log_info "Stopping Ralph for: $task"
                kill "$pid" 2>/dev/null || true
                rm -f "$state_file"
                touch "$RALPH_SIGNALS_DIR/$task.stop"
                log_success "Ralph stopped for: $task"
            else
                log_warn "Ralph not running for: $task"
            fi
        fi
    done
}

# Get Ralph status
ralph_status() {
    log_info "Ralph Wiggum Status"
    echo "===================="
    echo ""
    echo "Version: $RALPH_VERSION"
    echo "Max Iterations: $MAX_ITERATIONS"
    echo "Pause: ${PAUSE_MS}ms"
    echo "Signs Required: $SIGNALS_REQUIRED"
    echo "Tuning Mode: $TUNING_MODE"
    echo ""
    echo "Active Tasks:"
    echo "-------------"

    for state_file in "$RALPH_STATE_DIR"/*.pid; do
        if [ -f "$state_file" ]; then
            local task=$(basename "$state_file" .pid)
            local pid=$(cat "$state_file")
            local iteration=$(get_iteration "$task")

            if kill -0 "$pid" 2>/dev/null; then
                echo -e "  ${GREEN}●${NC} $task (PID: $pid, Iteration: $iteration)"
            else
                echo -e "  ${YELLOW}●${NC} $task (PID: $pid, Iteration: $iteration) - Zombie"
            fi
        fi
    done

    if [ ! -f "$RALPH_STATE_DIR"/*.pid ] 2>/dev/null || [ -z "$(ls -A "$RALPH_STATE_DIR"/*.pid 2>/dev/null)" ]; then
        echo "  No active Ralph tasks"
    fi
}

# Add tuning instruction
ralph_tune() {
    local instruction="$1"
    local task="${2:-*}"

    log_info "Adding tuning instruction..."
    echo "# Tuning Instruction ($(timestamp))" >> "$RALPH_SIGNS_DIR/${task}.tuning"
    echo "$instruction" >> "$RALPH_SIGNS_DIR/${task}.tuning"
    echo "---" >> "$RALPH_SIGNS_DIR/${task}.tuning"

    log_success "Tuning instruction added!"
    echo ""
    echo "Current tuning instructions:"
    cat "$RALPH_SIGNS_DIR/${task}.tuning"
}

# Show help
show_help() {
    cat << EOF
Ralph Wiggum - Autonomous Coding Agent Loop

USAGE:
    ralph.sh <command> [arguments]

COMMANDS:
    loop <task_file>    Run Ralph in loop mode until task completion
    start <task_file>   Start Ralph in background
    stop [task]         Stop Ralph (default: all tasks)
    status              Show Ralph status
    tune <instruction>  Add tuning instruction
    help                Show this help message

ENVIRONMENT VARIABLES:
    RALPH_MAX_ITERATIONS   Maximum iterations before stopping (default: 100)
    RALPH_PAUSE_MS         Pause between iterations in ms (default: 1000)
    RALPH_SIGNALS_REQUIRED Require signals to run (default: true)
    RALPH_TUNING_MODE      Tuning mode: strict|permissive (default: strict)
    RALPH_MODEL            AI model to use (default: claude-sonnet-4-5)
    RALPH_TEMPERATURE      AI temperature (default: 0.7)

EXAMPLES:
    ralph.sh loop task.md
    ralph.sh start feature.md
    ralph.sh stop feature
    ralph.sh status
    ralph.sh tune "Always run tests before committing"

FILES:
    ~/.ralph/state/         Ralph state files
    ~/.ralph/logs/          Ralph log files
    ~/.ralph/signals/       Ralph signal files
    ~/.ralph/signs/         Ralph tuning signs

EOF
}

# Main entry point
main() {
    local command="${1:-help}"
    shift || true

    case "$command" in
        loop)
            ralph_loop "$@"
            ;;
        start)
            ralph_start "$@"
            ;;
        stop)
            ralph_stop "$@"
            ;;
        status)
            ralph_status
            ;;
        tune)
            ralph_tune "$@"
            ;;
        help|--help|-h)
            show_help
            ;;
        *)
            log_error "Unknown command: $command"
            show_help
            exit 1
            ;;
    esac
}

main "$@"
