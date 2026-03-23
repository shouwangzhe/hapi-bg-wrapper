#!/bin/bash
# hapi-bg - HAPI 后台启动函数

hapi-bg() {
  local session_name="hapi-$(date +%s)"
  local cmd="IS_SANDBOX=1 hapi --yolo"

  if [[ "$1" == "resume" && -n "$2" ]]; then
    cmd="$cmd --resume $2"
    session_name="hapi-$2"
  fi

  tmux new-session -d -s "$session_name" "$cmd"
  echo "✓ Started in tmux session: $session_name"
  echo "  Attach: tmux attach -t $session_name"
}
