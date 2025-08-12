#!/bin/bash

# Netlify Hugo构建脚本
# 用于确保正确的构建环境和依赖处理

set -e  # 遇到错误时退出

echo "🚀 开始Hugo博客构建..."

# 检查Hugo版本
echo "📋 检查Hugo版本..."
hugo version

# 更新git子模块（主题）
echo "🔄 更新主题子模块..."
if [ -f ".gitmodules" ]; then
    git submodule update --init --recursive
    echo "✅ 主题子模块更新完成"
else
    echo "⚠️  未发现.gitmodules文件，跳过子模块更新"
fi

# 清理可能的缓存
echo "🧹 清理构建缓存..."
rm -rf public/
rm -rf resources/_gen/

# 检查必要的文件
echo "🔍 检查必要的配置文件..."
if [ ! -f "hugo.toml" ] && [ ! -f "config.toml" ] && [ ! -f "config.yaml" ]; then
    echo "❌ 错误: 未找到Hugo配置文件"
    exit 1
fi

# 检查主题
echo "🎨 检查主题配置..."
if [ -d "themes" ]; then
    theme_count=$(find themes -maxdepth 1 -type d | wc -l)
    if [ $theme_count -gt 1 ]; then
        echo "✅ 发现主题目录"
    else
        echo "⚠️  主题目录为空，请确保主题已正确安装"
    fi
fi

# 检查内容目录
echo "📝 检查内容目录..."
if [ -d "content" ]; then
    content_count=$(find content -name "*.md" | wc -l)
    echo "📄 发现 $content_count 个markdown文件"
else
    echo "⚠️  未发现content目录"
fi

# 构建站点
echo "🔨 开始构建Hugo站点..."
if [ "$NETLIFY" = "true" ]; then
    echo "🌐 Netlify环境构建"
    hugo --gc --minify --enableGitInfo
else
    echo "🏠 本地环境构建"
    hugo --gc --minify
fi

# 检查输出
echo "✅ 检查构建结果..."
if [ -d "public" ]; then
    file_count=$(find public -type f | wc -l)
    echo "📦 构建完成! 生成了 $file_count 个文件"
    
    # 显示主要文件
    echo "📁 主要生成文件:"
    find public -maxdepth 1 -name "*.html" -o -name "*.xml" | head -10
else
    echo "❌ 错误: 构建失败，未生成public目录"
    exit 1
fi

echo "🎉 Hugo博客构建成功完成!"