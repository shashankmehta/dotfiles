#!/bin/bash

tmux source-file ~/.tmux.conf 2>/dev/null

# Colors
bold="\033[1m"
dim="\033[2m"
reset="\033[0m"
green="\033[32m"
cyan="\033[36m"
yellow="\033[33m"
red="\033[31m"

header() {
    echo ""
    echo -e "  ${bold}Claude Code ${dim}— tmux sessions${reset}"
    echo -e "  ${dim}─────────────────────────${reset}"
    echo ""
}

sessions=$(tmux ls -F "#{session_name}|#{session_windows}" 2>/dev/null)

if [ -z "$sessions" ]; then
    header
    echo -e "  ${dim}No sessions found.${reset}"
    echo ""
    read -p "  Create a new session? Name (default: claude): " name
    name=${name:-claude}
    tmux -u new-session -s "$name" 'claude'
    exit 0
fi

header

# Collect session data: folder, name, yolo, windows
declare -a session_names
declare -a session_folders
declare -a session_yolo
declare -a session_windows
declare -a folder_order

while IFS= read -r line; do
    session_name=$(echo "$line" | cut -d'|' -f1)
    window_count=$(echo "$line" | cut -d'|' -f2)
    session_names+=("$session_name")
    session_windows+=("$window_count")

    # Get the working directory of the active pane
    pane_path=$(tmux display-message -p -t "$session_name" '#{pane_current_path}' 2>/dev/null)
    folder_name=$(basename "$pane_path" 2>/dev/null)
    [ -z "$folder_name" ] && folder_name="unknown"
    session_folders+=("$folder_name")

    # Track folder order (first-seen)
    found=0
    for f in "${folder_order[@]}"; do
        if [ "$f" = "$folder_name" ]; then found=1; break; fi
    done
    [ "$found" -eq 0 ] && folder_order+=("$folder_name")

    # Check if session is running claude in yolo mode
    pane_pid=$(tmux display-message -p -t "$session_name" '#{pane_pid}' 2>/dev/null)
    yolo=""
    if [ -n "$pane_pid" ]; then
        child_pids=$(pgrep -P "$pane_pid" 2>/dev/null)
        for cpid in $child_pids; do
            if ps -o args= -p "$cpid" 2>/dev/null | grep -q "dangerously-skip-permissions"; then
                yolo="yolo"
                break
            fi
        done
    fi
    session_yolo+=("$yolo")
done <<< "$sessions"

# Display grouped by folder
for folder in "${folder_order[@]}"; do
    echo -e "  ${cyan}${bold}${folder}${reset}"

    for idx in "${!session_names[@]}"; do
        if [ "${session_folders[$idx]}" = "$folder" ]; then
            num=$((idx + 1))
            yolo_tag=""
            [ -n "${session_yolo[$idx]}" ] && yolo_tag="  ${yellow}yolo${reset}"
            echo -e "    ${green}${bold}$num)${reset}  ${session_names[$idx]}${yolo_tag}  ${dim}${session_windows[$idx]} window(s)${reset}"
        fi
    done
    echo ""
done

echo -e "  ${cyan}n)${reset}  New session"
echo -e "  ${yellow}y)${reset}  New session ${yellow}(yolo)${reset}"
echo -e "  ${red}d)${reset}  End a session"
echo -e "  ${dim}r)  Reload script${reset}"
echo -e "  ${dim}q)  Quit${reset}"
echo ""
read -p "  > " choice

case "$choice" in
    q)
        exit 0
        ;;
    r)
        exec bash "$0"
        ;;
    n)
        echo ""
        read -p "  Session name (default: claude): " name
        name=${name:-claude}
        tmux -u new-session -s "$name" 'claude'
        ;;
    y)
        echo ""
        read -p "  Session name (default: claude): " name
        name=${name:-claude}
        tmux -u new-session -s "$name" 'claude --dangerously-skip-permissions'
        ;;
    d)
        echo ""
        read -p "  Session number to end: " num
        if [[ "$num" =~ ^[0-9]+$ ]] && [ "$num" -ge 1 ] && [ "$num" -le "${#session_names[@]}" ]; then
            target="${session_names[$((num-1))]}"
            read -p "  End session '${target}'? (y/N): " confirm
            if [[ "$confirm" =~ ^[Yy]$ ]]; then
                tmux kill-session -t "$target"
                echo -e "  ${dim}Session '${target}' ended.${reset}"
            fi
        else
            echo "  Invalid choice."
            exit 1
        fi
        ;;
    *)
        if [[ "$choice" =~ ^[0-9]+$ ]] && [ "$choice" -ge 1 ] && [ "$choice" -le "${#session_names[@]}" ]; then
            tmux -u attach -t "${session_names[$((choice-1))]}"
        else
            echo "  Invalid choice."
            exit 1
        fi
        ;;
esac
