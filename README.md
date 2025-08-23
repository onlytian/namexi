# 人名牌制作器 - Nginx部署指南

## 🌐 项目简介
这是一个用于制作人名牌的Web应用，支持批量生成、PDF导出和打印功能。

## 🚀 Nginx部署方案

### Linux服务器部署步骤：

1. **上传项目文件到服务器**
   ```bash
   # 将项目文件上传到服务器
   scp -r ./namexi/ user@120.24.186.159:/tmp/
   ```

2. **运行部署脚本**
   ```bash
   # 连接到服务器
   ssh user@120.24.186.159
   
   # 进入项目目录
   cd /tmp/namexi
   
   # 给部署脚本执行权限
   chmod +x deploy.sh
   
   # 运行部署脚本（需要root权限）
   sudo ./deploy.sh
   ```

3. **手动部署（如果脚本有问题）**
   ```bash
   # 安装Nginx
   sudo apt update
   sudo apt install nginx -y
   
   # 创建网站目录
   sudo mkdir -p /var/www/namexi
   
   # 复制项目文件
   sudo cp -r . /var/www/namexi/
   sudo chown -R www-data:www-data /var/www/namexi
   
   # 配置Nginx
   sudo cp nginx.conf /etc/nginx/sites-available/namexi
   sudo ln -sf /etc/nginx/sites-available/namexi /etc/nginx/sites-enabled/
   sudo rm -f /etc/nginx/sites-enabled/default
   
   # 测试配置
   sudo nginx -t
   
   # 重启Nginx
   sudo systemctl restart nginx
   sudo systemctl enable nginx
   ```

### Windows服务器部署步骤：

1. **安装Nginx for Windows**
   - 下载地址：http://nginx.org/en/download.html
   - 或者使用Chocolatey：`choco install nginx`

2. **运行部署脚本**
   - 以管理员身份运行 `deploy.bat`

3. **手动部署**
   ```cmd
   # 创建网站目录
   mkdir C:\nginx\html\namexi
   
   # 复制项目文件
   xcopy /E /Y /I "." "C:\nginx\html\namexi\"
   
   # 配置Nginx
   copy nginx.conf C:\nginx\conf\sites-available\namexi
   
   # 启动Nginx
   C:\nginx\nginx.exe
   ```

## 🔧 配置文件说明

### nginx.conf
- 监听端口：80
- 服务器名称：120.24.186.159
- 网站根目录：/var/www/namexi
- 启用gzip压缩和静态资源缓存
- 配置安全头

## 🌍 访问地址

部署成功后，您可以通过以下地址访问网站：
- **主页面**：http://120.24.186.159
- **若溪页面**：http://120.24.186.159/ruoxi

## 🔒 安全配置

### 防火墙设置
```bash
# Ubuntu/Debian
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw enable

# CentOS/RHEL
sudo firewall-cmd --permanent --add-port=80/tcp
sudo firewall-cmd --permanent --add-port=443/tcp
sudo firewall-cmd --reload

# Windows
netsh advfirewall firewall add rule name="Nginx HTTP" dir=in action=allow protocol=TCP localport=80
```

### 云服务器安全组
确保在云服务商控制台中开放80端口（HTTP）。

## 📁 目录结构
```
namexi/
├── index.html          # 主页面
├── ruoxi.html         # 若溪页面
├── js/
│   └── manager.png    # 背景图片
├── nginx.conf         # Nginx配置
├── deploy.sh          # Linux部署脚本
├── deploy.bat         # Windows部署脚本
└── README.md          # 部署说明
```

## 🚨 故障排除

### 常见问题：

1. **无法访问网站**
   - 检查Nginx服务状态
   - 检查防火墙设置
   - 检查云服务器安全组

2. **图片无法显示**
   - 检查文件权限
   - 检查文件路径

3. **500错误**
   - 检查配置文件语法
   - 查看错误日志

### 查看日志：
```bash
# Nginx
sudo tail -f /var/log/nginx/error.log
```

## 📞 技术支持

如果遇到部署问题，请检查：
1. 服务器操作系统版本
2. Nginx版本
3. 错误日志信息
4. 网络连接状态

---

**祝您部署顺利！** 🎉
