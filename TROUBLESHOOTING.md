# 故障排查

## 常见问题

### 1. 命令未找到：hapi-bg

**原因**：未加载 shell 配置

**解决**：
```bash
source ~/.zshrc
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

### 3. tmux session 无法启动

**检查 tmux**：
```bash
which tmux
tmux -V
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

## 获取帮助

- [HAPI 官方文档](https://github.com/tiann/hapi)
- [提交 Issue](https://github.com/your-username/hapi-bg-wrapper/issues)
