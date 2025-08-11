# Hugo Paper 主题设置说明

## 已完成的设置

✅ **主题安装**: 已成功将 `hugo-paper` 主题作为 git 子模块添加到项目中
✅ **配置更新**: 已更新 `hugo.toml` 配置文件以使用新主题
✅ **测试验证**: 主题已通过本地服务器测试，运行正常

## 主题信息

- **主题名称**: Paper
- **仓库地址**: https://github.com/nanxiaobei/hugo-paper.git
- **演示站点**: https://hugo-paper.vercel.app
- **安装方式**: Git 子模块

## 当前配置

主题已配置为使用以下设置：

```toml
theme = 'paper'

[params]
  # 颜色主题
  color = 'linen'  # 可选: linen, wheat, gray, light
  
  # 社交图标 (需要自定义)
  twitter = 'your_twitter_id'
  github = 'your_github_id'
  instagram = 'your_instagram_id'
  linkedin = 'your_linkedin_id'
  mastodon = 'your_mastodon_link'
  threads = '@your_threads_id'
  bluesky = 'your_bluesky_id'
  rss = true
  
  # 首页个人信息 (需要自定义)
  avatar = 'your_gravatar_email_or_image_url'
  name = '你的名字'
  bio = '你的个人简介'
```

## 需要自定义的配置

请根据你的个人信息更新以下配置项：

1. **社交媒体链接**: 更新 `twitter`, `github`, `instagram` 等字段
2. **个人信息**: 更新 `avatar`, `name`, `bio` 字段
3. **颜色主题**: 可选择 `linen`, `wheat`, `gray`, `light` 四种颜色主题

## 常用命令

### 启动开发服务器
```bash
hugo server --bind 0.0.0.0 --port 1313 --disableFastRender
```

### 构建静态文件
```bash
hugo --minify
```

### 更新主题
```bash
git submodule update --remote themes/paper
```

### 初始化子模块 (新环境)
```bash
git submodule init
git submodule update
```

## 主题特性

- ⚡️ 快速加载
- 👒 高度可定制
- 🫙 平滑动画
- 📱 响应式设计
- 🌙 支持暗色模式
- 📝 支持数学公式 (KaTeX)
- 💬 支持多种评论系统

## 更多配置选项

详细配置选项请参考：
- [主题文档](https://github.com/nanxiaobei/hugo-paper)
- [演示站点](https://hugo-paper.vercel.app) 