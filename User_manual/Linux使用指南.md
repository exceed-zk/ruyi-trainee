# RuyiSDK Eclipse IDE - Linux 使用指南

## 📦 您已经构建好的包

在 `packages/org.eclipse.epp.package.embedcpp.product/target/products/` 目录下，您有以下三个 Linux 版本：

```
✅ ruyisdk-0.0.3-linux.gtk.x86_64.tar.gz    (401MB) - Intel/AMD 64位
✅ ruyisdk-0.0.3-linux.gtk.aarch64.tar.gz   (400MB) - ARM 64位
✅ ruyisdk-0.0.3-linux.gtk.riscv64.tar.gz   (399MB) - RISC-V 64位
```

---

## 🚀 快速开始 - 3 步安装使用

### 步骤 1：选择适合您系统的包

```bash
# 查看您的系统架构
uname -m

# 输出结果对应的包：
# x86_64  → 使用 ruyisdk-0.0.3-linux.gtk.x86_64.tar.gz
# aarch64 → 使用 ruyisdk-0.0.3-linux.gtk.aarch64.tar.gz
# riscv64 → 使用 ruyisdk-0.0.3-linux.gtk.riscv64.tar.gz
```

### 步骤 2：解压安装包

```bash
# 进入构建产物目录
cd packages/org.eclipse.epp.package.embedcpp.product/target/products/

# 解压对应的包（以 x86_64 为例）
tar -xzf ruyisdk-0.0.3-linux.gtk.x86_64.tar.gz

# 这会创建一个 ruyisdk 目录
ls -la ruyisdk/
```

### 步骤 3：运行 IDE

```bash
# 进入解压后的目录
cd ruyisdk

# 运行 IDE
./ruyisdk
```

就这么简单！IDE 会启动并显示欢迎界面。

---

## 📋 前置要求确认

### 1. Java 环境检查

RuyiSDK Eclipse IDE **要求 Java 21 或更高版本**：

```bash
# 检查 Java 版本
java -version

# 应该看到类似输出：
# openjdk version "21.0.1" 2023-10-17 LTS
# 或
# java version "21.0.1" 2023-10-17 LTS
```

**如果 Java 版本低于 21**：

```bash
# Ubuntu/Debian
sudo apt update
sudo apt install openjdk-21-jdk

# Fedora/RHEL
sudo dnf install java-21-openjdk-devel

# 或从 Adoptium 下载
wget https://adoptium.net/temurin/releases/

# 设置 JAVA_HOME（如果需要）
export JAVA_HOME=/usr/lib/jvm/java-21-openjdk
export PATH=$JAVA_HOME/bin:$PATH
```

### 2. 系统依赖（通常已安装）

RuyiSDK IDE 需要 GTK 图形库：

```bash
# Ubuntu/Debian
sudo apt install libgtk-3-0 libwebkit2gtk-4.0-37

# Fedora/RHEL
sudo dnf install gtk3 webkit2gtk3

# Arch Linux
sudo pacman -S gtk3 webkit2gtk
```

---

## 📍 推荐安装位置

### 选项 1：用户目录安装（推荐，无需 root）

```bash
# 复制到用户 opt 目录
mkdir -p ~/opt
cp -r ruyisdk ~/opt/

# 创建桌面快捷方式（可选）
cat > ~/.local/share/applications/ruyisdk.desktop << 'EOF'
[Desktop Entry]
Type=Application
Name=RuyiSDK Eclipse IDE
Comment=Eclipse IDE for Embedded C/C++ with RISC-V Support
Exec=/home/YOUR_USERNAME/opt/ruyisdk/ruyisdk
Icon=/home/YOUR_USERNAME/opt/ruyisdk/icon.xpm
Terminal=false
Categories=Development;IDE;
EOF

# 替换 YOUR_USERNAME 为您的用户名
sed -i "s/YOUR_USERNAME/$USER/g" ~/.local/share/applications/ruyisdk.desktop
```

### 选项 2：系统全局安装（需要 root）

```bash
# 复制到系统目录
sudo cp -r ruyisdk /opt/

# 创建系统级快捷方式
sudo cat > /usr/share/applications/ruyisdk.desktop << 'EOF'
[Desktop Entry]
Type=Application
Name=RuyiSDK Eclipse IDE
Comment=Eclipse IDE for Embedded C/C++ with RISC-V Support
Exec=/opt/ruyisdk/ruyisdk
Icon=/opt/ruyisdk/icon.xpm
Terminal=false
Categories=Development;IDE;
EOF

# 创建命令行快捷方式（可选）
sudo ln -s /opt/ruyisdk/ruyisdk /usr/local/bin/ruyisdk
```

---

## 🎯 首次启动和配置

### 1. 启动 IDE

```bash
cd ~/opt/ruyisdk  # 或 /opt/ruyisdk
./ruyisdk
```

### 2. 选择工作空间

首次启动时，会提示选择工作空间目录：

```
推荐路径：~/eclipse-workspace
或：      ~/workspace/ruyisdk
```

✅ **提示**：勾选 "Use this as the default and do not ask again" 可以避免每次启动都询问。

### 3. 欢迎页面

IDE 会显示欢迎页面，您可以：
- 查看教程
- 创建新项目
- 导入现有项目

---

## 💻 创建第一个 RISC-V 项目

### 方法 1：使用项目模板（推荐）

1. **创建新项目**
   ```
   File → New → C/C++ Project
   ```

2. **选择项目类型**
   - 查找 RISC-V 相关的项目模板
   - 或选择 "Empty Project" 手动配置

3. **配置项目名称和位置**
   ```
   Project name: hello-riscv
   Location: [默认工作空间位置]
   ```

### 方法 2：导入现有项目

```bash
# 在 IDE 中
File → Import → General → Existing Projects into Workspace
→ 选择项目目录 → Finish
```

---

## 🔧 配置 RISC-V 工具链

### 1. 安装 RISC-V GCC 工具链

```bash
# Ubuntu/Debian
sudo apt install gcc-riscv64-linux-gnu g++-riscv64-linux-gnu

# 或使用 ruyisdk 工具链（如果有）
# 或从 https://github.com/riscv-collab/riscv-gnu-toolchain 编译
```

### 2. 在 Eclipse 中配置工具链路径

```
Window → Preferences → C/C++ → Build → Environment

添加环境变量：
Name: PATH
Value: /usr/bin:/path/to/riscv-toolchain/bin:$PATH
```

### 3. 配置交叉编译

```
Project → Properties → C/C++ Build → Settings

Cross GCC Compiler:
Command: riscv64-linux-gnu-gcc

Cross GCC Linker:
Command: riscv64-linux-gnu-gcc
```

---

## 🐛 调试配置

### 使用 QEMU 进行模拟调试

1. **安装 QEMU**
   ```bash
   sudo apt install qemu-system-riscv64  # Ubuntu/Debian
   sudo dnf install qemu-system-riscv    # Fedora/RHEL
   ```

2. **创建调试配置**
   ```
   Run → Debug Configurations → C/C++ Remote Application
   → New Configuration
   ```

3. **配置 QEMU**
   ```
   Main Tab:
     C/C++ Application: /path/to/your/binary
   
   Debugger Tab:
     GDB debugger: riscv64-linux-gnu-gdb
   
   Commands Tab:
     → 配置 QEMU 启动命令
   ```

### 使用 OpenOCD 进行硬件调试

```bash
# 安装 OpenOCD
sudo apt install openocd

# 启动 OpenOCD（根据您的开发板配置）
openocd -f board/your-board.cfg
```

在 Eclipse 中配置 OpenOCD 调试器（通过 Debug Configurations）。

---

## ⚙️ 性能优化建议

### 1. 调整内存设置

编辑 `ruyisdk.ini` 文件：

```bash
cd ~/opt/ruyisdk
nano ruyisdk.ini

# 找到并修改以下行：
-Xms256m        # 初始堆内存，可改为 512m 或 1024m
-Xmx2048m       # 最大堆内存，可改为 4096m 或更多
```

### 2. 启用索引加速

```
Window → Preferences → C/C++ → Indexer
✅ Enable project specific settings
✅ Index source files not included in the build
```

### 3. 禁用不需要的插件

```
Window → Preferences → General → Startup and Shutdown
→ 取消勾选不需要的插件
```

---

## 📦 如果需要重新构建

如果您修改了源码或配置，想重新构建：

```bash
# 返回项目根目录
cd /path/to/ruyisdk-eclipse-packages

# 清理旧构建
mvn clean

# 仅构建 embedcpp 包（更快）
mvn verify \
  -Pepp.p2.common \
  -Pepp.p2.embedcpp \
  -Pepp.product.embedcpp \
  -Pepp.materialize-products

# 构建产物在：
# packages/org.eclipse.epp.package.embedcpp.product/target/products/
```

**构建时间**：根据机器性能，首次构建可能需要 10-30 分钟。

---

## 🔍 常见问题排查

### 问题 1：启动失败，提示 Java 版本问题

```bash
# 症状
./ruyisdk
Error: A JNI error has occurred...
Unsupported major.minor version 65.0

# 解决方案：升级到 Java 21
java -version  # 检查当前版本
# 安装 Java 21（见前面的安装说明）
```

### 问题 2：图形界面无法显示

```bash
# 检查 GTK 库
ldd ruyisdk | grep gtk

# 如果有缺失的库，安装：
sudo apt install libgtk-3-0 libwebkit2gtk-4.0-37
```

### 问题 3：无法访问串口设备

```bash
# 将用户添加到 dialout 组
sudo usermod -a -G dialout $USER

# 重新登录生效
```

### 问题 4：IDE 运行缓慢

```bash
# 1. 增加内存（编辑 ruyisdk.ini）
# 2. 检查系统资源
htop

# 3. 禁用实时扫描
Window → Preferences → C/C++ → Indexer
→ Build configuration for the indexer: Use active build configuration
```

---

## 📚 更新和插件管理

### 检查更新

```
Help → Check for Updates
```

### 安装额外插件

```
Help → Install New Software
→ Work with: https://download.eclipse.org/releases/2024-12/
→ 选择需要的插件 → Next → Finish
```

### 卸载插件

```
Help → About Eclipse IDE → Installation Details
→ 选择插件 → Uninstall
```

---

## 🎨 自定义主题和外观

### 切换暗色主题

```
Window → Preferences → General → Appearance
→ Theme: Dark
```

### 调整字体大小

```
Window → Preferences → General → Appearance → Colors and Fonts
→ C/C++ → C/C++ Editor Text Font → Edit
```

---

## 📁 目录结构说明

```
ruyisdk/
├── ruyisdk              # 启动脚本
├── ruyisdk.ini          # 配置文件（内存、JVM参数等）
├── icon.xpm             # 图标
├── configuration/       # Eclipse 配置
├── features/            # 功能单元
├── plugins/             # 插件
├── readme/              # 说明文档
└── dropins/             # 手动安装插件的目录
```

---

## 🌐 推荐的 RISC-V 开发资源

### 工具链

- **官方 GNU 工具链**: https://github.com/riscv-collab/riscv-gnu-toolchain
- **预编译工具链**: https://github.com/xpack-dev-tools/riscv-none-elf-gcc-xpack

### 模拟器

- **QEMU**: https://www.qemu.org/
- **Spike**: https://github.com/riscv-software-src/riscv-isa-sim

### 开发板

- **SiFive HiFive Unmatched**: https://www.sifive.com/boards
- **StarFive VisionFive 2**: https://www.starfivetech.com/

### 文档

- **RISC-V 规范**: https://riscv.org/technical/specifications/
- **Eclipse CDT 文档**: https://help.eclipse.org/latest/topic/org.eclipse.cdt.doc.user/

---

## 💡 最佳实践

### 1. 使用独立工作空间

为不同的项目使用不同的工作空间，避免配置冲突：

```bash
~/workspace/
├── riscv-project-1/
├── riscv-project-2/
└── arm-project/
```

### 2. 定期备份工作空间

```bash
# 备份工作空间设置
tar -czf workspace-backup-$(date +%Y%m%d).tar.gz ~/eclipse-workspace/.metadata
```

### 3. 使用版本控制

在 IDE 中集成 Git：

```
Window → Show View → Other → Git → Git Repositories
```

---

## 🆘 获取帮助

### 官方资源

- Eclipse CDT 论坛: https://www.eclipse.org/forums/index.php/f/80/
- RISC-V 社区: https://riscv.org/community/

### 日志文件位置

如果遇到问题，查看日志：

```bash
# Eclipse 日志
cat ~/eclipse-workspace/.metadata/.log

# 或在 IDE 中查看
Window → Show View → Other → General → Error Log
```

---

## 🎓 下一步学习

1. **熟悉 Eclipse CDT 基础操作**
   - 代码编辑、导航、重构
   - 构建配置和管理
   - 调试技巧

2. **掌握 RISC-V 开发**
   - 交叉编译配置
   - 远程调试
   - 性能分析

3. **探索嵌入式开发功能**
   - 设备驱动开发
   - 实时操作系统集成
   - 硬件调试工具使用

---

## 📝 总结

您现在拥有：

✅ 完整的 RuyiSDK Eclipse IDE（3 个 Linux 架构版本）  
✅ 已有的 Java 21 和 Maven 环境  
✅ 详细的安装和使用指南  

**立即开始**：

```bash
cd packages/org.eclipse.epp.package.embedcpp.product/target/products/
tar -xzf ruyisdk-0.0.3-linux.gtk.x86_64.tar.gz
cd ruyisdk
./ruyisdk
```

祝您开发顺利！🚀

---

*最后更新: 2024-12*  
*适用版本: RuyiSDK Eclipse IDE 0.0.3*

