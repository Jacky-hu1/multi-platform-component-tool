#!/bin/bash

# 元器件智能查询系统 - 一键部署脚本
# 为 jacky-hu1 定制

echo "🚀 元器件智能查询系统 - 一键部署"
echo "=============================================="
echo "GitHub用户: jacky-hu1"
echo "仓库名称: multi-platform-component-tool"
echo "访问地址: https://jacky-hu1.github.io/multi-platform-component-tool/"
echo "=============================================="

# 颜色定义
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_step() {
    echo -e "${BLUE}[步骤 $1]${NC} $2"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️ $1${NC}"
}

# 检查当前目录
check_directory() {
    print_step "1" "检查部署文件"
    
    if [ -f "index.html" ] && [ -f "README.md" ]; then
        print_success "部署文件完整"
        echo "文件列表:"
        ls -la
        echo ""
    else
        print_error "部署文件不完整"
        echo "请确保包含以下文件:"
        echo "  - index.html"
        echo "  - README.md"
        echo "  - deploy.sh"
        exit 1
    fi
}

# 初始化Git
init_git() {
    print_step "2" "初始化Git仓库"
    
    if [ ! -d ".git" ]; then
        git init
        print_success "Git仓库初始化完成"
    else
        print_warning "Git仓库已存在"
    fi
    
    # 配置Git用户
    git config --local user.name "元器件查询系统"
    git config --local user.email "chip-helper@example.com"
    print_success "Git用户配置完成"
}

# 添加文件到Git
add_files() {
    print_step "3" "添加文件到Git"
    
    git add .
    
    if git diff --cached --quiet; then
        print_warning "没有需要提交的更改"
    else
        git commit -m "部署元器件智能查询系统 - $(date '+%Y-%m-%d %H:%M:%S')"
        print_success "文件提交完成"
    fi
}

# 显示部署指南
show_deploy_guide() {
    print_step "4" "显示部署指南"
    
    echo ""
    echo "🎯 下一步操作："
    echo ""
    echo "1. 📁 创建GitHub仓库（在浏览器中）"
    echo "   访问：${BLUE}https://github.com/new${NC}"
    echo "   仓库名：${GREEN}multi-platform-component-tool${NC}"
    echo "   描述：元器件智能查询系统 - 完整功能版"
    echo "   选择：Public（公开）"
    echo "   ${YELLOW}重要：不要初始化README、.gitignore、许可证${NC}"
    echo "   点击：Create repository"
    echo ""
    echo "2. 🔗 添加远程仓库（在终端执行）"
    echo "   ${GREEN}cd $(pwd)${NC}"
    echo "   ${GREEN}git remote add origin https://github.com/jacky-hu1/multi-platform-component-tool.git${NC}"
    echo ""
    echo "3. 📤 推送到GitHub（在终端执行）"
    echo "   ${GREEN}git branch -M main${NC}"
    echo "   ${GREEN}git push -u origin main${NC}"
    echo ""
    echo "4. ⚙️ 启用GitHub Pages（在浏览器中）"
    echo "   访问：${BLUE}https://github.com/jacky-hu1/multi-platform-component-tool/settings/pages${NC}"
    echo "   分支：选择 ${GREEN}main${NC} 分支"
    echo "   文件夹：选择 ${GREEN}/ (root)${NC} 根目录"
    echo "   点击：${GREEN}Save${NC}"
    echo ""
    echo "5. 🌐 访问网站（等待1-2分钟）"
    echo "   ${BLUE}https://jacky-hu1.github.io/multi-platform-component-tool/${NC}"
    echo ""
    echo "🔍 功能验证："
    echo "   搜索：${GREEN}STM32F103C8T6${NC}"
    echo "   验证四大功能："
    echo "   - 💰 价格对比"
    echo "   - 📊 技术参数"
    echo "   - 🔄 国产替代"
    echo "   - 🔍 智能选型"
    echo ""
    echo "⏱️ 预计时间：6分钟"
    echo "  现在开始 → 2分钟创建仓库"
    echo "  +2分钟上传文件 → 4分钟"
    echo "  +1分钟启用Pages → 5分钟"
    echo "  +1分钟等待生效 → 6分钟完成！"
    echo ""
}

# 创建快捷命令
create_quick_commands() {
    print_step "5" "创建快捷命令"
    
    cat > /tmp/deploy_commands.txt << EOF
# 部署命令（复制执行）
cd $(pwd)
git remote add origin https://github.com/jacky-hu1/multi-platform-component-tool.git
git branch -M main
git push -u origin main

# 验证命令
curl -s https://jacky-hu1.github.io/multi-platform-component-tool/ | grep -o '元器件智能查询系统'

# 测试命令
curl -I https://jacky-hu1.github.io/multi-platform-component-tool/
EOF
    
    print_success "快捷命令已保存到: /tmp/deploy_commands.txt"
    echo "查看命令: cat /tmp/deploy_commands.txt"
    echo ""
}

# 主函数
main() {
    echo ""
    print_step "0" "开始部署元器件智能查询系统"
    echo ""
    
    # 执行部署步骤
    check_directory
    init_git
    add_files
    show_deploy_guide
    create_quick_commands
    
    echo "=============================================="
    print_success "部署准备完成！"
    echo ""
    echo "📋 总结："
    echo "  1. 创建GitHub仓库（2分钟）"
    echo "  2. 执行3条Git命令（1分钟）"
    echo "  3. 启用GitHub Pages（1分钟）"
    echo "  4. 等待生效（1-2分钟）"
    echo "  5. 访问和使用（立即）"
    echo ""
    echo "🎉 总计约6分钟即可完成部署！"
    echo ""
    echo "🚀 现在就开始吧！"
    echo "=============================================="
}

# 执行主函数
main "$@"