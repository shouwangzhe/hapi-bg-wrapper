# HAPI 后台启动工具 - 使用指南

## 基本用法

### 启动新 session（后台）

```bash
hapi-bg
```

这会：
- ✅ 在 tmux 后台启动 Claude Code
- ✅ 自动设置 `IS_SANDBOX=1`
- ✅ 自动添加 `--yolo` (跳过权限提示)
- ✅ 连接到配置的 HAPI 服务器

### 恢复已有 session（后台）

```bash
hapi-bg resume <session-id>
```

示例：
```bash
hapi-bg resume 2d5071f1-b6f2-49c4-a0cd-06f5877dcb18
```

## 管理后台 session

### 查看所有后台 session

```bash
tmux ls
```

输出示例：
```
hapi-1711234567: 1 windows (created Mon Mar 23 20:50:07 2026)
hapi-2d5071f1: 1 windows (created Mon Mar 23 20:55:12 2026)
```

### 连接到后台 session

```bash
tmux attach -t hapi-1711234567
```

### 断开连接（session 继续运行）

在 tmux 内按：`Ctrl-B` 然后按 `D`

### 关闭 session

```bash
tmux kill-session -t hapi-1711234567
```

## 与 HAPI Web 界面配合使用

### 1. 启动 HAPI Runner

```bash
hapi runner start
```

Runner 会在后台监听 web 界面的"spawn session"请求。

### 2. 访问 Web 界面

打开：`https://app.hapi.run/?hub=<your-relay-url>&token=<your-token>`

### 3. 查看所有 session

在 web 界面左侧可以看到：
- 🟢 在线的 session
- ⚪ 离线的 session

### 4. 从 Web 创建新 session

点击左上角 **+** 按钮，Runner 会自动在本地后台启动。

## 常见场景

### 场景 1：快速启动一个后台 Claude

```bash
hapi-bg
```

### 场景 2：恢复昨天的工作

```bash
# 查看历史 session
hapi --resume

# 选择一个 session ID，后台恢复
hapi-bg resume abc123...
```

### 场景 3：同时运行多个 session

```bash
hapi-bg                    # session 1
hapi-bg                    # session 2
hapi-bg resume xyz789...   # session 3

tmux ls                    # 查看所有
```

### 场景 4：远程管理所有 CLI

1. 在每台机器上运行 `hapi runner start`
2. 打开 web 界面，看到所有在线机器
3. 点击 + 创建新 session，自动在对应机器后台启动

## 下一步

- 查看 [故障排查](TROUBLESHOOTING.md)
- 查看 [HAPI 官方文档](https://github.com/tiann/hapi)
