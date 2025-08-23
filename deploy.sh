#!/bin/bash

echo "🚀 开始部署人名牌制作器网站..."

# 检查是否为root用户
if [ "$EUID" -ne 0 ]; then
    echo "❌ 请使用root权限运行此脚本"
    exit 1
fi

# 更新系统包
echo "📦 更新系统包..."
apt update && apt upgrade -y

# 安装必要的软件包
echo "🔧 安装必要的软件包..."
apt install -y nginx curl wget unzip

# 创建网站目录
echo "📁 创建网站目录..."
mkdir -p /var/www/namexi
chown -R www-data:www-data /var/www/namexi

# 复制项目文件到服务器
echo "📋 复制项目文件..."
cp -r . /var/www/namexi/
chown -R www-data:www-data /var/www/namexi

# 配置Nginx
echo "⚙️ 配置Nginx..."
cp nginx.conf /etc/nginx/sites-available/namexi
ln -sf /etc/nginx/sites-available/namexi /etc/nginx/sites-enabled/

# 删除默认站点
rm -f /etc/nginx/sites-enabled/default

# 测试Nginx配置
echo "🧪 测试Nginx配置..."
nginx -t

if [ $? -eq 0 ]; then
    echo "✅ Nginx配置测试通过"
    
    # 重启Nginx
    echo "🔄 重启Nginx服务..."
    systemctl restart nginx
    systemctl enable nginx
    
    echo "🎉 部署完成！"
    echo "🌐 网站地址: http://120.24.186.159"
    echo "📁 网站目录: /var/www/namexi"
    echo "📊 Nginx状态: $(systemctl is-active nginx)"
else
    echo "❌ Nginx配置测试失败，请检查配置文件"
    exit 1
fi

# 显示防火墙配置建议
echo ""
echo "🔒 防火墙配置建议:"
echo "ufw allow 80/tcp"
echo "ufw allow 443/tcp"
echo "ufw enable"
