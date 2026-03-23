#!/bin/bash
# hapi-bg - HAPI 后台启动函数

hapi-bg() {
  local session_name="hapi-$(date +%s)"

  # 构建完整的命令，包含环境变量
  local full_cmd="export HAPI_API_URL='$HAPI_API_URL' && export CLI_API_TOKEN='$CLI_API_TOKEN' && IS_SANDBOX=1 hapi --yolo"

  if [[ "$1" == "resume" && -n "$2" ]]; then
    full_cmd="$full_cmd --resume $2"
    session_name="hapi-$2"
  fi

  tmux new-session -d -s "$session_name" "$full_cmd"
  echo "✓ Started in tmux session: $session_name"
  echo "  Attach: tmux attach -t $session_name"
  echo "  HAPI URL: $HAPI_API_URL"
}
