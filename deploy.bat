@echo off
chcp 65001 >nul
echo 🚀 开始部署人名牌制作器网站到Nginx...

REM 检查管理员权限
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo ❌ 请使用管理员权限运行此脚本
    pause
    exit /b 1
)

echo 📦 检查Nginx是否已安装...
nginx -v >nul 2>&1
if %errorLevel% neq 0 (
    echo ❌ 未检测到Nginx，请先安装Nginx for Windows
    echo 📥 下载地址: http://nginx.org/en/download.html
    echo 💡 或者使用Chocolatey安装: choco install nginx
    pause
    exit /b 1
)

echo ✅ Nginx版本:
nginx -v

echo 📁 创建网站目录...
if not exist "C:\nginx\html\namexi" mkdir "C:\nginx\html\namexi"

echo 📋 复制项目文件到Nginx目录...
xcopy /E /Y /I "." "C:\nginx\html\namexi\"

echo ⚙️ 配置Nginx...
copy "nginx.conf" "C:\nginx\conf\sites-available\namexi" >nul 2>&1

echo 🔄 重启Nginx服务...
taskkill /f /im nginx.exe >nul 2>&1
timeout /t 2 /nobreak >nul
start "" "C:\nginx\nginx.exe"

echo 🧪 测试Nginx配置...
timeout /t 3 /nobreak >nul
curl -s http://localhost >nul 2>&1
if %errorLevel% equ 0 (
    echo ✅ 部署完成！
    echo 🌐 网站地址: http://120.24.186.159
    echo 📁 网站目录: C:\nginx\html\namexi
    echo 📊 Nginx状态: 运行中
) else (
    echo ❌ 部署可能有问题，请检查Nginx配置
)

echo.
echo 🔒 防火墙配置建议:
echo netsh advfirewall firewall add rule name="Nginx HTTP" dir=in action=allow protocol=TCP localport=80
echo.
echo 💡 如果无法访问，请检查:
echo    1. 防火墙设置
echo    2. 云服务器安全组设置
echo    3. Nginx配置文件路径是否正确

pause
