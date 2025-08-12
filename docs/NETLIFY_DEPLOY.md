# Netlify 部署指南

## 快速部署步骤

### 1. 连接Git仓库
- 登录 [Netlify](https://netlify.com)
- 点击 "Add new site" > "Import an existing project"
- 选择你的Git提供商（GitHub/GitLab/Bitbucket）
- 选择这个博客仓库

### 2. 配置构建设置
Netlify会自动检测到 `netlify.toml` 配置文件，如果需要手动配置：

- **构建命令**: `hugo --gc --minify`
- **发布目录**: `public`
- **生产分支**: `main` 或 `master`

### 3. 环境变量设置
在Netlify仪表板中设置以下环境变量：
- `HUGO_VERSION`: `0.148.2`
- `NODE_VERSION`: `18`

### 4. 域名配置
- 在Netlify中配置自定义域名
- 更新 `hugo.toml` 中的 `baseURL` 为你的实际域名

## 文件说明

### netlify.toml
主要的Netlify配置文件，包含：
- 构建设置和命令
- 缓存策略
- 安全headers
- 重定向规则
- 多环境配置

### build.sh
可选的构建脚本，提供：
- 详细的构建日志
- 错误检查
- 主题子模块处理
- 构建验证

## 特性说明

### 🚀 性能优化
- 启用了资源压缩和合并
- 配置了适当的缓存策略
- 图片自动压缩

### 🔒 安全配置
- 设置了安全HTTP headers
- 配置了内容安全策略
- 防止XSS攻击

### 🌐 多语言支持
- 根据浏览器语言自动重定向
- 支持中文和英文版本

### 📱 SEO友好
- 启用了Pretty URLs
- 配置了适当的meta信息
- 支持RSS feed

## 常见问题

### Q: 构建失败怎么办？
A: 检查以下几点：
1. Hugo版本是否正确
2. 主题子模块是否正确加载
3. 内容文件格式是否正确

### Q: 如何更新Hugo版本？
A: 更新 `netlify.toml` 中的 `HUGO_VERSION` 环境变量

### Q: 如何添加自定义重定向？
A: 在 `netlify.toml` 的 `[[redirects]]` 部分添加新规则

## 部署后检查清单

- [ ] 网站可以正常访问
- [ ] 多语言切换功能正常
- [ ] 静态资源（CSS/JS/图片）加载正常
- [ ] RSS feed可以访问
- [ ] 移动端显示正常
- [ ] SEO信息正确显示

## 开发工作流

### 本地开发
```bash
# 启动开发服务器
hugo server -D

# 构建生产版本
./build.sh
```

### 部署流程
1. 推送代码到main分支
2. Netlify自动触发构建
3. 构建成功后自动部署
4. 检查部署结果

---

需要帮助？查看 [Netlify文档](https://docs.netlify.com/configure-builds/get-started/) 或 [Hugo文档](https://gohugo.io/hosting-and-deployment/hosting-on-netlify/)