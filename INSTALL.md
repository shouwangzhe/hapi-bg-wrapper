# HAPI 后台启动工具 - 安装指南

## 前置要求

- macOS / Linux
- Node.js 18+
- tmux
- HAPI CLI (`npm install -g @twsxtd/hapi`)

## 安装步骤

### 1. 安装 HAPI CLI

```bash
npm install -g @twsxtd/hapi
```

### 2. 配置环境变量

根据你使用的 shell，编辑对应的配置文件：

**Zsh 用户** (macOS 默认)：
```bash
# 编辑 ~/.zshrc
nano ~/.zshrc
```

**Bash 用户** (Linux 默认)：
```bash
# 编辑 ~/.bashrc
nano ~/.bashrc
```

添加以下内容：

```bash
# HAPI 配置
export HAPI_API_URL="http://your-hapi-server:8300"
export CLI_API_TOKEN="your-cli-api-token"
```

**获取 CLI_API_TOKEN**：
- 在 HAPI 服务器上运行：`cat ~/.hapi/settings.json | grep cliApiToken`
- 或从 HAPI web 界面获取

### 3. 添加 hapi-bg 函数

在配置文件末尾添加（`~/.zshrc` 或 `~/.bashrc`）：

```bash
# HAPI 后台启动函数
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
```

### 4. 重新加载配置

**Zsh 用户**：
```bash
source ~/.zshrc
```

**Bash 用户**：
```bash
source ~/.bashrc
```

### 5. 验证安装

```bash
# 检查 HAPI 连接
hapi auth status

# 测试 hapi-bg 命令
hapi-bg
```

## 快速安装脚本

如果你想一键安装，可以使用以下脚本：

```bash
# 检测 shell 类型并自动配置
if [ -n "$ZSH_VERSION" ]; then
  SHELL_RC="$HOME/.zshrc"
elif [ -n "$BASH_VERSION" ]; then
  SHELL_RC="$HOME/.bashrc"
else
  echo "Unsupported shell. Please manually edit your shell config."
  exit 1
fi

# 添加配置
cat >> "$SHELL_RC" << 'EOF'

# HAPI 配置
export HAPI_API_URL="http://your-hapi-server:8300"
export CLI_API_TOKEN="your-cli-api-token"

# HAPI 后台启动函数
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
EOF

echo "✓ Configuration added to $SHELL_RC"
echo "Run: source $SHELL_RC"
```

## 下一步

查看 [使用指南](USAGE.md) 了解如何使用 `hapi-bg` 命令。
