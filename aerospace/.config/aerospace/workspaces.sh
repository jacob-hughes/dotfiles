#!/bin/bash

LOG_FILE="$HOME/.local/share/aerospace/workspace.log"
LOG_ENABLED=0

# Ensure log directory exists
mkdir -p "$(dirname "$LOG_FILE")" 2>/dev/null

declare -A WORKSPACES
WORKSPACES=(
    [1]="Ghostty"
    [2]="Google Chrome"
    [4]="Google Chat"
    [6]="Google Calendar"
    [7]="Gmail"
    [S]="Secondary"
)

SCRATCH_WORKSPACE=5

# Display usage information and exit
usage() {
    cat << EOF
Usage: workspaces.sh [OPTIONS]

Aerospace workspace management script.

OPTIONS:
    --move-node-between-monitors    Move focused window between primary and secondary monitors
    --init                          Initialize the focused workspace with its default app
    --merge WORKSPACE               Merge windows from WORKSPACE into focused workspace
    --reset                         Reset all windows on focused workspace to their expected workspaces
    --help                          Show this help message

EXAMPLES:
    workspaces.sh --init
    workspaces.sh --merge 2
    workspaces.sh --reset
EOF
    exit 0
}

log() {
    [[ $LOG_ENABLED -eq 1 ]] || return
    local level=$1
    shift
    local message="$*"
    local timestamp=$(date +"%Y-%m-%d %H:%M:%S")
    echo "[$timestamp] [LINE:${BASH_LINENO[0]}] [$level] $message" >> "$LOG_FILE"
}

expected_workspace() {
    log "INFO" "Checking expected workspace for $1 | $2"
    for ws in "${!WORKSPACES[@]}"; do
        if [[ "$1" == "Ghostty" ]]; then
            if [[ "$2" == "main-terminal" ]]; then
                log "INFO" "main terminal"
                echo "1"
                return 0
            else
                log "INFO" "scratch terminal"
                echo "$SCRATCH_WORKSPACE"
                return 0
            fi
        elif [[ "$1" == ${WORKSPACES[$ws]} ]]; then
            log "INFO" "$ws"
            echo "$ws"
            return 0
        fi
    done

    echo "$SCRATCH_WORKSPACE"
    return 0
}

focused_app() {
    echo "$(trim "$(aerospace list-windows --focused | awk -F'|' '{print $2}')")"
}

focused_win() {
    echo "$(trim "$(aerospace list-windows --focused | awk -F'|' '{print $1}')")"
}

focused_title() {
    echo "$(trim "$(aerospace list-windows --focused | awk -F'|' '{print $3}')")"
}

focused_workspace() {
    echo "$(aerospace list-workspaces --focused)"
}

focused_monitor() {
    if [[ "$(focused_workspace)" != "S" ]]; then
        echo "primary"
    else
        echo "secondary"
    fi
}

# Move focused window between monitors; primary→secondary goes to workspace S,
# secondary→primary goes to app's expected workspace
move_node_between_monitors() {
    local app="$(focused_app)"
    local title="$(focused_title)"
    if [[ "$(focused_monitor)" == "primary" ]]; then
        log "INFO" "Moving $app to workspace S"
        aerospace move-node-to-workspace "S"
        aerospace workspace "S"
        return 0
    else
        local dest="$(expected_workspace "$app" "$title")"
        log "INFO" "Moving $app to workspace $dest"
        aerospace move-node-to-workspace "$dest"
        aerospace workspace "$dest"
        return 0
    fi
}

# Initialize the focused workspace by launching its default application
init() {
    local ws="$(focused_workspace)"
    local app=${WORKSPACES[$ws]}
    
    if [[ -z "$app" ]]; then
        log "INFO" "workspace $ws has no app to init"
        return 0;
    fi

    if [[ "$app" == "Ghostty" && "$ws" == "1" ]]; then
        open -a Ghostty --args --maximize --title='main-terminal'
        log "INFO" "workspace $ws init with Ghostty main terminal"
        return 0;
    fi
    log "INFO" "workspace $ws init with $app"

    open -a "$app"
}

trim() {
    local var="$*"
    var="${var#"${var%%[![:space:]]*}"}"
    var="${var%"${var##*[![:space:]]}"}"   
    printf '%s' "$var"
}

# Merge windows from specified workspace into the focused workspace
merge() {
    local app=${WORKSPACES[$1]}
    # Find the first matching window for app
    local win="$(aerospace list-windows --workspace "$1" | grep -F "$app" | sort | awk '{ print $1 }')"
    log "INFO" "Merging workspace $1 [app: $app] [win: $win]"
    move "$win" "$(focused_workspace)" 
}

move() {
    local win=$1
    local workspace=$2
    aerospace move-node-to-workspace --window-id "$win" "$workspace" 
}

# Reset all windows on focused workspace to their expected workspaces
reset() {
    log "INFO" "Starting reset of all windows on focused workspace"
    while IFS='|' read -r win app title; do
        win="$(trim "$win")"
        app="$(trim "$app")"
        title="$(trim "$title")"

        local dest="$(expected_workspace "$app" "$title")"
        log "INFO" "Moving $app to workspace $dest"
        move "$win" "$dest"
    done < <(aerospace list-windows --workspace focused)
}

for arg in "$@"; do
    case "$arg" in
        --move-node-between-monitors)  move_node_between_monitors ;;
        --init) init ;;
        --merge) merge "$2" ;;
        --reset) reset ;;
        --help)   usage ;;
        *)        usage ;;
    esac
done
