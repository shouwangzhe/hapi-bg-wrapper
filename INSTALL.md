# HAPI 后台启动工具 - 安装指南

## 前置要求

- macOS / Linux
- tmux

## 安装步骤

### 1. 安装 tmux

**macOS**:
```bash
brew install tmux
```

**Linux (Ubuntu/Debian)**:
```bash
sudo apt-get install tmux
```

**CentOS 7**:
```bash
sudo yum install -y tmux
```

### 2. 安装 nvm (Node Version Manager)

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
```

重新加载 shell 配置：
```bash
source ~/.zshrc  # macOS
# 或
source ~/.bashrc  # Linux
```

### 3. 安装 Node.js

```bash
nvm install 18
nvm use 18
```

### 4. 安装 HAPI CLI

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
  local full_cmd="export HAPI_API_URL='$HAPI_API_URL' && export CLI_API_TOKEN='$CLI_API_TOKEN' && IS_SANDBOX=1 hapi --permission-mode bypassPermissions"

  if [[ "$1" == "resume" && -n "$2" ]]; then
    full_cmd="$full_cmd --resume $2"
    session_name="hapi-$2"
  fi

  tmux new-session -d -s "$session_name" "$full_cmd"
  echo "✓ Started in tmux session: $session_name"
  echo "  Attach: tmux attach -t $session_name"
  echo "  HAPI URL: $HAPI_API_URL"
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

  # 构建完整的命令，包含环境变量
  local full_cmd="export HAPI_API_URL='$HAPI_API_URL' && export CLI_API_TOKEN='$CLI_API_TOKEN' && IS_SANDBOX=1 hapi --permission-mode bypassPermissions"

  if [[ "$1" == "resume" && -n "$2" ]]; then
    full_cmd="$full_cmd --resume $2"
    session_name="hapi-$2"
  fi

  tmux new-session -d -s "$session_name" "$full_cmd"
  echo "✓ Started in tmux session: $session_name"
  echo "  Attach: tmux attach -t $session_name"
  echo "  HAPI URL: $HAPI_API_URL"
}
EOF

echo "✓ Configuration added to $SHELL_RC"
echo "Run: source $SHELL_RC"
```

## CentOS 7 一键安装脚本

如果你在 CentOS 7 上安装，可以使用以下完整脚本：

```bash
#!/bin/bash
# CentOS 7 一键安装脚本

# 1. 安装 tmux
sudo yum install -y tmux

# 2. 安装 nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash

# 3. 加载 nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# 4. 安装 Node.js
nvm install 18
nvm use 18

# 5. 安装 HAPI CLI
npm install -g @twsxtd/hapi

# 6. 配置环境变量和函数
cat >> ~/.bashrc << 'EOF'

# HAPI 配置
export HAPI_API_URL="http://your-hapi-server:8300"
export CLI_API_TOKEN="your-cli-api-token"

# HAPI 后台启动函数
hapi-bg() {
  local session_name="hapi-$(date +%s)"
  local full_cmd="export HAPI_API_URL='$HAPI_API_URL' && export CLI_API_TOKEN='$CLI_API_TOKEN' && IS_SANDBOX=1 hapi --permission-mode bypassPermissions"

  if [[ "$1" == "resume" && -n "$2" ]]; then
    full_cmd="$full_cmd --resume $2"
    session_name="hapi-$2"
  fi

  tmux new-session -d -s "$session_name" "$full_cmd"
  echo "✓ Started in tmux session: $session_name"
  echo "  Attach: tmux attach -t $session_name"
  echo "  HAPI URL: $HAPI_API_URL"
}
EOF

echo "✓ 安装完成！"
echo "请编辑 ~/.bashrc 修改 HAPI_API_URL 和 CLI_API_TOKEN"
echo "然后运行: source ~/.bashrc"
```

## 下一步

查看 [使用指南](USAGE.md) 了解如何使用 `hapi-bg` 命令。
