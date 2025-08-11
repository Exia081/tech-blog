# 双语技术博客

基于Hugo和PaperMod主题构建的中英文双语技术博客，专注于分享日常思考、技术要点和经验总结。

## ✨ 特性

- 🌍 **双语支持**: 完整的中文和英文界面
- 📱 **响应式设计**: 适配各种设备屏幕
- 🔍 **全文搜索**: 基于Fuse.js的快速搜索功能
- 📊 **语法高亮**: 支持代码块语法高亮
- 🏷️ **分类标签**: 灵活的文章分类和标签系统
- 📈 **SEO优化**: 搜索引擎友好
- 🌙 **暗色主题**: 支持明暗主题切换

## 🚀 快速开始

### 环境要求

- Hugo Extended版本 >= 0.146.0
- Git

### 安装Hugo

```bash
# macOS
brew install hugo

# 或者使用Makefile
make install-hugo
```

### 启动开发服务器

```bash
# 克隆仓库
git clone <your-repo-url>
cd blog

# 启动开发服务器
make run
# 或者
hugo server

# 浏览器访问 http://localhost:1313
```

## 📝 内容管理

### 创建新文章

```bash
# 创建技术文章（会同时创建中英文版本）
make new-tech-post TITLE="文章标题"

# 创建文化文章
make new-culture-post TITLE="文章标题"

# 自定义分类文章
make new-post TITLE="文章标题" CATEGORY="custom"
```

### 文章结构

文章使用以下目录结构：

```
content/
├── technology/          # 技术文章
│   ├── article.zh.md   # 中文版本
│   └── article.en.md   # 英文版本
├── culture/            # 文化文章
│   ├── article.zh.md
│   └── article.en.md
├── archives/           # 归档页面
└── search/            # 搜索页面
```

### 文章Front Matter

```yaml
---
title: "文章标题"
date: 2024-01-15T10:00:00+08:00
categories: ["技术"]
tags: ["Go", "编程"]
author: "作者名"
description: "文章描述"
---
```

## 🛠️ 开发命令

### 服务器相关

```bash
make run              # 启动开发服务器
make serve-drafts     # 显示草稿文章
make serve-future     # 显示未来日期文章
```

### 构建相关

```bash
make build            # 构建静态网站
make build-minify     # 构建并压缩
make build-production # 生产环境构建
```

### 内容管理

```bash
make list-drafts      # 列出草稿文章
make list-zh-posts    # 列出中文文章
make list-en-posts    # 列出英文文章
make check-translations # 检查缺失翻译
```

### 统计分析

```bash
make stats           # 显示博客统计信息
make word-count      # 统计字数
```

### 清理和维护

```bash
make clean           # 清理构建文件
make clean-cache     # 清理缓存
make backup          # 备份内容
```

## 🎨 主题配置

博客使用PaperMod主题，主要配置在`hugo.toml`文件中：

### 多语言配置

```toml
defaultContentLanguage = 'zh'
defaultContentLanguageInSubdir = false

[languages]
  [languages.zh]
    languageCode = 'zh-CN'
    languageName = '中文'
    title = '技术博客 | 思考与分享'
    weight = 1

  [languages.en]
    languageCode = 'en-US'
    languageName = 'English'
    title = 'Tech Blog | Thoughts & Sharing'
    weight = 2
```

### 主要功能配置

```toml
[params]
  ShowReadingTime = true      # 显示阅读时间
  ShowShareButtons = true     # 分享按钮
  ShowPostNavLinks = true     # 文章导航
  ShowBreadCrumbs = true      # 面包屑导航
  ShowCodeCopyButtons = true  # 代码复制按钮
  ShowToc = true             # 目录
```

## 🚀 部署

### Vercel部署

```bash
# 安装Vercel CLI
npm i -g vercel

# 部署
make deploy-vercel
```

### Netlify部署

```bash
# 安装Netlify CLI
npm install -g netlify-cli

# 部署
make deploy-netlify
```

### 手动部署

```bash
make build-production
# 将public/目录内容上传到服务器
```

## 📂 目录结构

```
blog/
├── content/           # 内容文件
├── static/           # 静态资源
├── themes/           # 主题文件
├── public/           # 构建输出
├── hugo.toml         # 主配置文件
├── Makefile          # 自动化脚本
└── README.md         # 说明文档
```

## 🔧 自定义

### 修改主题样式

如需自定义样式，可以在`assets/css/`目录下创建自定义CSS文件。

### 添加新的语言

1. 在`hugo.toml`中添加新语言配置
2. 创建对应的内容文件（如`.fr.md`）
3. 更新菜单配置

### 集成评论系统

在`hugo.toml`中配置Disqus：

```toml
[params]
  disqusShortname = "your-disqus-shortname"
```

## 📊 统计示例

运行`make stats`查看博客统计：

```
=== 双语博客统计 ===
总文章数: 8
中文文章: 4
英文文章: 4
技术文章: 4
文化文章: 4
草稿文章: 0
已发布文章: 8
```

## 🤝 贡献

欢迎提交Issue和Pull Request来改进这个博客模板！

## 📄 许可证

此项目基于MIT许可证开源。