# 故障排查

## 常见问题

### 1. 命令未找到：hapi-bg

**原因**：未加载 shell 配置

**解决**：

**Zsh 用户**：
```bash
source ~/.zshrc
```

**Bash 用户**：
```bash
source ~/.bashrc
```

**检查配置文件**：
```bash
# 查看你使用的 shell
echo $SHELL

# Zsh 用户检查
cat ~/.zshrc | grep hapi-bg

# Bash 用户检查
cat ~/.bashrc | grep hapi-bg
```

### 2. HAPI 连接失败

**检查配置**：
```bash
echo $HAPI_API_URL
echo $CLI_API_TOKEN
```

**验证连接**：
```bash
hapi auth status
```

**常见错误**：
- `Connection refused` - 检查 HAPI_API_URL 是否正确
- `Invalid token` - 检查 CLI_API_TOKEN 是否正确
- `Network timeout` - 检查网络连接和防火墙

### 3. tmux session 无法启动

**检查 tmux**：
```bash
which tmux
tmux -V
```

**安装 tmux**：

**macOS**：
```bash
brew install tmux
```

**Ubuntu/Debian**：
```bash
sudo apt-get install tmux
```

**CentOS/RHEL**：
```bash
sudo yum install tmux
```

**查看错误日志**：
```bash
tmux ls
tmux capture-pane -t <session-name> -p
```

### 4. Runner 未运行

**检查状态**：
```bash
hapi runner status
```

**重启 Runner**：
```bash
hapi runner stop
hapi runner start
```

**清理所有进程**：
```bash
hapi doctor clean
```

### 5. Shell 兼容性问题

**检查当前 shell**：
```bash
echo $SHELL
ps -p $$
```

**切换到 bash**：
```bash
chsh -s /bin/bash
```

**切换到 zsh**：
```bash
chsh -s /bin/zsh
```

### 6. 权限问题

**检查文件权限**：
```bash
ls -la ~/.zshrc
ls -la ~/.bashrc
```

**修复权限**：
```bash
chmod 644 ~/.zshrc
chmod 644 ~/.bashrc
```

## 调试技巧

### 启用调试模式

在 shell 配置文件中添加：

```bash
# 调试模式
hapi-bg-debug() {
  set -x  # 启用命令跟踪
  hapi-bg "$@"
  set +x  # 关闭命令跟踪
}
```

### 查看详细日志

```bash
# 查看 HAPI 日志
ls -la ~/.hapi/logs/
tail -f ~/.hapi/logs/*.log

# 查看 tmux 日志
tmux capture-pane -t <session-name> -p -S -1000
```

## 获取帮助

- [HAPI 官方文档](https://github.com/tiann/hapi)
- [提交 Issue](https://github.com/shouwangzhe/hapi-bg-wrapper/issues)
- [HAPI Discord](https://discord.gg/hapi)
