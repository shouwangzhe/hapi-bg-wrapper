# hapi-bg - HAPI 后台启动工具

一个简单的 shell 函数，用于在 tmux 后台启动 HAPI Claude Code 会话。

## 特性

- 🚀 一键在 tmux 后台启动 Claude Code
- 🔐 自动设置沙箱模式 (`IS_SANDBOX=1`)
- ⚡ 自动跳过权限提示 (`--yolo`)
- 🔄 支持恢复已有 session
- 🌐 自动连接到远程 HAPI 服务器

## 快速开始

### 前置要求

- macOS / Linux
- Node.js 18+
- tmux
- HAPI CLI (`npm install -g @twsxtd/hapi`)

### 安装

查看 [安装指南](INSTALL.md)

### 使用

```bash
# 启动新 session（后台）
hapi-bg

# 恢复已有 session（后台）
hapi-bg resume <session-id>
```

查看 [使用指南](USAGE.md) 了解更多。

## 文档

- [安装指南](INSTALL.md)
- [使用指南](USAGE.md)
- [故障排查](TROUBLESHOOTING.md)

## 相关项目

- [HAPI](https://github.com/tiann/hapi) - Claude Code On the Go

## 许可证

MIT
