#!/bin/bash

# 元器件智能查询系统 - GitHub Pages一键部署脚本
# 作者：小吴同学
# 日期：2026-04-03

set -e  # 遇到错误立即退出

echo "🚀 元器件智能查询系统 - GitHub Pages一键部署"
echo "=============================================="

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 函数：打印带颜色的消息
print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# 检查Git是否安装
check_git() {
    print_info "检查Git安装..."
    if command -v git &> /dev/null; then
        print_success "Git已安装: $(git --version)"
    else
        print_error "Git未安装，请先安装Git"
        echo "安装命令:"
        echo "  Ubuntu/Debian: sudo apt-get install git"
        echo "  CentOS/RHEL: sudo yum install git"
        echo "  macOS: brew install git"
        exit 1
    fi
}

# 检查当前目录
check_directory() {
    print_info "检查当前目录..."
    if [ -f "index.html" ]; then
        print_success "当前目录包含部署文件"
    else
        print_warning "当前目录不包含部署文件，请确保在正确目录运行"
        echo "建议在包含 index.html 的目录运行此脚本"
        read -p "是否继续？(y/n): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            exit 1
        fi
    fi
}

# 初始化Git仓库
init_git() {
    print_info "初始化Git仓库..."
    
    if [ ! -d ".git" ]; then
        git init
        print_success "Git仓库初始化完成"
    else
        print_info "Git仓库已存在"
    fi
}

# 配置Git用户
setup_git_user() {
    print_info "配置Git用户..."
    
    # 检查是否已配置
    if git config --get user.name &> /dev/null && git config --get user.email &> /dev/null; then
        print_info "Git用户已配置: $(git config --get user.name) <$(git config --get user.email)>"
        return
    fi
    
    # 提示用户输入
    echo "请配置Git用户信息（用于提交记录）："
    read -p "用户名: " git_username
    read -p "邮箱: " git_email
    
    if [ -z "$git_username" ] || [ -z "$git_email" ]; then
        print_warning "未提供用户信息，使用默认配置"
        git config --global user.name "元器件查询系统"
        git config --global user.email "chip-helper@example.com"
    else
        git config --local user.name "$git_username"
        git config --local user.email "$git_email"
        print_success "Git用户配置完成"
    fi
}

# 添加远程仓库
setup_remote() {
    print_info "设置远程仓库..."
    
    # 检查是否已设置远程仓库
    if git remote | grep -q "origin"; then
        print_info "远程仓库已设置: $(git remote get-url origin)"
        return
    fi
    
    echo "请输入GitHub仓库URL（例如：https://github.com/jacky-hu1/multi-platform-component-tool.git）"
    echo "如果还没有创建仓库，请先访问 https://github.com/new 创建"
    echo "仓库名建议：multi-platform-component-tool"
    echo ""
    read -p "GitHub仓库URL: " repo_url
    
    if [ -z "$repo_url" ]; then
        print_warning "未提供仓库URL，跳过远程设置"
        return
    fi
    
    git remote add origin "$repo_url"
    print_success "远程仓库设置完成: $repo_url"
}

# 提交更改
commit_changes() {
    print_info "提交更改到Git..."
    
    # 添加所有文件
    git add .
    
    # 检查是否有更改
    if git diff --cached --quiet; then
        print_info "没有需要提交的更改"
        return
    fi
    
    commit_message="部署元器件智能查询系统 - $(date '+%Y-%m-%d %H:%M:%S')"
    
    git commit -m "$commit_message"
    print_success "更改提交完成: $commit_message"
}

# 推送到远程仓库
push_to_remote() {
    print_info "推送到远程仓库..."
    
    # 检查是否有远程仓库
    if ! git remote | grep -q "origin"; then
        print_warning "未设置远程仓库，跳过推送"
        return
    fi
    
    # 尝试推送
    if git push -u origin main 2>/dev/null; then
        print_success "推送成功"
    elif git push -u origin master 2>/dev/null; then
        print_success "推送成功"
    else
        print_warning "推送失败，可能需要先拉取远程更改"
        echo "尝试强制推送..."
        read -p "是否强制推送？(y/n): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            git push -u origin main --force || git push -u origin master --force
            print_success "强制推送成功"
        else
            print_warning "跳过推送，请手动推送更改"
        fi
    fi
}

# 显示部署信息
show_deploy_info() {
    echo ""
    echo "🎉 部署完成！"
    echo "=============================================="
    echo ""
    echo "📁 项目文件已提交到Git"
    echo ""
    echo "🚀 下一步：启用GitHub Pages"
    echo "1. 访问你的GitHub仓库：$(git remote get-url origin 2>/dev/null || echo '你的仓库URL')"
    echo "2. 点击 Settings → Pages"
    echo "3. 分支选择：main 或 master"
    echo "4. 文件夹选择：/ (root)"
    echo "5. 点击 Save"
    echo ""
    echo "🌐 访问地址（部署后1-2分钟生效）："
    echo "   https://<你的用户名>.github.io/multi-platform-component-tool/"
    echo ""
    echo "🔧 示例地址："
    echo "   https://jacky-hu1.github.io/multi-platform-component-tool/"
    echo ""
    echo "✅ 功能验证："
    echo "1. 访问上述URL"
    echo "2. 搜索：STM32F103C8T6"
    echo "3. 验证四大功能："
    echo "   - 💰 价格对比"
    echo "   - 📊 技术参数"
    echo "   - 🔄 国产替代"
    echo "   - 🔍 智能选型"
    echo ""
    echo "📞 技术支持："
    echo "如有问题，请查看 README.md 或联系开发者"
    echo ""
    echo "=============================================="
}

# 主函数
main() {
    echo ""
    print_info "开始部署元器件智能查询系统到GitHub Pages"
    echo ""
    
    # 执行部署步骤
    check_git
    check_directory
    init_git
    setup_git_user
    setup_remote
    commit_changes
    push_to_remote
    
    # 显示部署信息
    show_deploy_info
    
    # 创建部署完成标记
    date > .deployed
    print_success "部署脚本执行完成 $(date '+%Y-%m-%d %H:%M:%S')"
}

# 执行主函数
main "$@"