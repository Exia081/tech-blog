# Hugo 博客 Makefile
# 包含常用的 Hugo 命令和操作

# 变量定义
HUGO_VERSION := $(shell hugo version | head -n 1)
SITE_TITLE := $(shell grep 'title =' hugo.toml | cut -d'"' -f2)
THEME_NAME := $(shell grep 'theme =' hugo.toml | cut -d'"' -f2)

# 默认目标
.PHONY: help
help: ## 显示帮助信息
	@echo "Hugo 博客管理工具"
	@echo "=================="
	@echo "当前配置:"
	@echo "  Hugo 版本: $(HUGO_VERSION)"
	@echo "  网站标题: $(SITE_TITLE)"
	@echo "  主题: $(THEME_NAME)"
	@echo ""
	@echo "可用命令:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}'

# 开发服务器相关命令
.PHONY: run
run: ## 启动开发服务器（默认端口 1313）
	hugo server

.PHONY: serve-drafts
serve-drafts: ## 启动开发服务器并显示草稿文章
	hugo server -D

.PHONY: serve-future
serve-future: ## 启动开发服务器并显示未来日期的文章
	hugo server -F

.PHONY: serve-live
serve-live: ## 启动实时重载的开发服务器
	hugo server --liveReloadPort=443 --bind=0.0.0.0

.PHONY: serve-https
serve-https: ## 启动 HTTPS 开发服务器
	hugo server --bind=0.0.0.0 --baseURL=https://localhost:1313

# 构建相关命令
.PHONY: build
build: ## 构建静态网站到 public 目录
	hugo

.PHONY: build-minify
build-minify: ## 构建并压缩静态网站
	hugo --minify

.PHONY: build-production
build-production: ## 生产环境构建（启用所有优化）
	hugo --minify --gc --cleanDestinationDir

.PHONY: build-drafts
build-drafts: ## 构建包含草稿文章的网站
	hugo -D

.PHONY: build-future
build-future: ## 构建包含未来日期文章的网站
	hugo -F

# 内容管理命令
.PHONY: new-post
new-post: ## 创建新文章（用法: make new-post TITLE="文章标题" CATEGORY="technology"）
	@if [ -z "$(TITLE)" ]; then \
		echo "请提供文章标题: make new-post TITLE=\"文章标题\" CATEGORY=\"technology\""; \
		exit 1; \
	fi
	@CATEGORY=$${CATEGORY:-technology}; \
	SLUG=$(shell echo "$(TITLE)" | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g' | sed 's/[^a-z0-9\-]//g'); \
	echo "创建中文文章: content/$$CATEGORY/$$SLUG.zh.md"; \
	hugo new $$CATEGORY/$$SLUG.zh.md; \
	echo "创建英文文章: content/$$CATEGORY/$$SLUG.en.md"; \
	hugo new $$CATEGORY/$$SLUG.en.md

.PHONY: new-tech-post
new-tech-post: ## 创建技术文章（用法: make new-tech-post TITLE="文章标题"）
	@$(MAKE) new-post TITLE="$(TITLE)" CATEGORY=technology

.PHONY: new-culture-post
new-culture-post: ## 创建文化文章（用法: make new-culture-post TITLE="文章标题"）
	@$(MAKE) new-post TITLE="$(TITLE)" CATEGORY=culture

.PHONY: new-page
new-page: ## 创建新页面（用法: make new-page TITLE="页面标题"）
	@if [ -z "$(TITLE)" ]; then \
		echo "请提供页面标题: make new-page TITLE=\"页面标题\""; \
		exit 1; \
	fi
	hugo new $(TITLE).md

.PHONY: list-drafts
list-drafts: ## 列出所有草稿文章
	@find content -name "*.md" -exec grep -l "draft: true" {} \;

.PHONY: list-posts
list-posts: ## 列出所有已发布的文章
	@find content -name "*.md" -exec grep -L "draft: true" {} \;

# 主题管理命令
.PHONY: theme-info
theme-info: ## 显示当前主题信息
	@echo "当前主题: $(THEME_NAME)"
	@if [ -d "themes/$(THEME_NAME)" ]; then \
		echo "主题目录存在: themes/$(THEME_NAME)"; \
		ls -la themes/$(THEME_NAME); \
	else \
		echo "主题目录不存在: themes/$(THEME_NAME)"; \
	fi

.PHONY: update-theme
update-theme: ## 更新主题（如果是 git 子模块）
	@if [ -f ".gitmodules" ] && grep -q "$(THEME_NAME)" .gitmodules; then \
		echo "更新主题 $(THEME_NAME)..."; \
		git submodule update --remote --merge themes/$(THEME_NAME); \
	else \
		echo "主题 $(THEME_NAME) 不是 git 子模块，无法自动更新"; \
	fi

# 清理和维护命令
.PHONY: clean
clean: ## 清理构建文件
	rm -rf public/
	rm -rf resources/
	rm -rf .hugo_build.lock

.PHONY: clean-cache
clean-cache: ## 清理 Hugo 缓存
	rm -rf .hugo_build.lock
	hugo --gc

.PHONY: check
check: ## 检查网站配置和内容
	hugo check

.PHONY: check-ulimit
check-ulimit: ## 检查系统文件描述符限制
	@echo "当前文件描述符限制:"
	@ulimit -n

# 部署相关命令
.PHONY: deploy
deploy: build-production ## 构建并部署（需要配置部署脚本）
	@echo "网站已构建完成，位于 public/ 目录"
	@echo "请配置您的部署脚本"

.PHONY: deploy-vercel
deploy-vercel: build-production ## 部署到 Vercel
	@if command -v vercel >/dev/null 2>&1; then \
		vercel --prod; \
	else \
		echo "Vercel CLI 未安装，请先安装: npm i -g vercel"; \
	fi

.PHONY: deploy-netlify
deploy-netlify: build-production ## 部署到 Netlify
	@if command -v netlify >/dev/null 2>&1; then \
		netlify deploy --prod --dir=public; \
	else \
		echo "Netlify CLI 未安装，请先安装: npm install -g netlify-cli"; \
	fi

# 分析和统计命令
.PHONY: stats
stats: ## 显示网站统计信息
	@echo "=== 双语博客统计 ==="
	@echo "总文章数:"
	@find content -name "*.md" | wc -l
	@echo "中文文章:"
	@find content -name "*.zh.md" | wc -l
	@echo "英文文章:"
	@find content -name "*.en.md" | wc -l
	@echo "技术文章:"
	@find content/technology -name "*.md" | wc -l
	@echo "文化文章:"
	@find content/culture -name "*.md" | wc -l
	@echo "草稿文章:"
	@find content -name "*.md" -exec grep -l "draft: true" {} \; | wc -l
	@echo "已发布文章:"
	@find content -name "*.md" -exec grep -L "draft: true" {} \; | wc -l

.PHONY: word-count
word-count: ## 统计所有文章的字数
	@echo "=== 字数统计 ==="
	@echo "中文文章总字数:"
	@find content -name "*.zh.md" -exec wc -w {} \; | awk '{sum += $$1} END {print sum " 字"}'
	@echo "英文文章总字数:"
	@find content -name "*.en.md" -exec wc -w {} \; | awk '{sum += $$1} END {print sum " 字"}'
	@echo "技术文章总字数:"
	@find content/technology -name "*.md" -exec wc -w {} \; | awk '{sum += $$1} END {print sum " 字"}'
	@echo "文化文章总字数:"
	@find content/culture -name "*.md" -exec wc -w {} \; | awk '{sum += $$1} END {print sum " 字"}'

.PHONY: check-translations
check-translations: ## 检查缺失的翻译文章
	@echo "=== 检查缺失翻译 ==="
	@echo "缺少英文翻译的文章:"
	@for zh_file in $$(find content -name "*.zh.md"); do \
		en_file=$$(echo $$zh_file | sed 's/.zh.md/.en.md/'); \
		if [ ! -f "$$en_file" ]; then \
			echo "  $$zh_file -> $$en_file (缺失)"; \
		fi; \
	done
	@echo "缺少中文翻译的文章:"
	@for en_file in $$(find content -name "*.en.md"); do \
		zh_file=$$(echo $$en_file | sed 's/.en.md/.zh.md/'); \
		if [ ! -f "$$zh_file" ]; then \
			echo "  $$en_file -> $$zh_file (缺失)"; \
		fi; \
	done

.PHONY: list-zh-posts
list-zh-posts: ## 列出所有中文文章
	@find content -name "*.zh.md" | sort

.PHONY: list-en-posts
list-en-posts: ## 列出所有英文文章
	@find content -name "*.en.md" | sort

# 备份和恢复命令
.PHONY: backup
backup: ## 备份网站内容
	@mkdir -p backups
	@tar -czf backups/backup-$(shell date +%Y%m%d-%H%M%S).tar.gz content/ static/ data/ hugo.toml

.PHONY: list-backups
list-backups: ## 列出所有备份文件
	@ls -la backups/ 2>/dev/null || echo "没有找到备份文件"

# 开发工具命令
.PHONY: install-hugo
install-hugo: ## 安装 Hugo（macOS）
	@if command -v brew >/dev/null 2>&1; then \
		brew install hugo; \
	else \
		echo "请手动安装 Hugo: https://gohugo.io/installation/"; \
	fi

.PHONY: update-hugo
update-hugo: ## 更新 Hugo（macOS）
	@if command -v brew >/dev/null 2>&1; then \
		brew upgrade hugo; \
	else \
		echo "请手动更新 Hugo"; \
	fi

# 默认目标
.DEFAULT_GOAL := help 