# RISC-V64 平台测试 RuyiSDK Eclipse IDE 指南

## 概述

本指南专门针对 **RISC-V 64 位（riscv64）**平台的测试，这是 RuyiSDK 的核心目标平台之一。

## 重要性

✅ **为什么需要在 riscv64 上测试**：
1. **目标平台验证**：RuyiSDK 主要面向 RISC-V 开发
2. **架构兼容性**：确保 IDE 在 riscv64 上正常运行
3. **真实用户体验**：验证实际使用场景
4. **生态完整性**：展示 Eclipse 对 riscv64 的支持

⚠️ **挑战**：
- riscv64 硬件较少
- 软件生态相对不成熟
- 性能可能较慢

---

## 测试环境选项

### 选项 1: 真实 RISC-V 硬件 🔥（推荐）

#### 1.1 支持的开发板

**推荐开发板**：

| 开发板 | CPU | 内存 | 适合度 | 获取难度 |
|--------|-----|------|--------|----------|
| **VisionFive 2** | StarFive JH7110 | 8GB | ⭐⭐⭐⭐⭐ | 容易 |
| **Milk-V Pioneer** | SG2042 | 16GB+ | ⭐⭐⭐⭐⭐ | 中等 |
| **BeagleV Ahead** | TH1520 | 4GB | ⭐⭐⭐⭐ | 容易 |
| **Lichee Pi 4A** | TH1520 | 8GB | ⭐⭐⭐⭐ | 容易 |
| **Milk-V Mars** | StarFive JH7110 | 8GB | ⭐⭐⭐⭐ | 容易 |

**最低要求**：
- CPU: RISC-V 64-bit with RV64GC
- 内存: 4GB+（推荐 8GB+）
- 存储: 32GB+（推荐 128GB+）
- 操作系统: Debian/Ubuntu/Fedora for RISC-V

#### 1.2 推荐配置：VisionFive 2

```
硬件：
- CPU: StarFive JH7110 (RISC-V U74 x4)
- 内存: 8GB
- 存储: 128GB+ microSD 或 NVMe SSD

操作系统选项：
- Debian for RISC-V
- Ubuntu for RISC-V
- Fedora for RISC-V

价格: ~$75-150
购买: https://www.starfivetech.com/en/site/boards
```

### 选项 2: QEMU 虚拟化 💻（备选）

如果没有 riscv64 硬件，可以使用 QEMU 模拟：

⚠️ **注意**：
- 性能较慢（10-20 倍）
- 不适合完整 IDE 构建
- 仅适合功能验证

```bash
# 安装 QEMU RISC-V
sudo apt install qemu-system-riscv64

# 下载 RISC-V 镜像（以 Debian 为例）
# https://wiki.debian.org/RISC-V
```

### 选项 3: 远程访问 🌐（最简单）

使用远程 riscv64 服务器或 CI 平台：

**免费/开放资源**：
- PLCT Lab 的 RISC-V 资源
- 部分云服务商提供的测试环境

---

## 前提条件

### 硬件要求

```
CPU: RISC-V 64-bit (RV64GC)
内存: 8GB+（最低 4GB）
存储: 64GB+（推荐 128GB+）
```

### 软件要求

```bash
# 操作系统
Debian 或 Ubuntu for RISC-V（推荐）
或 Fedora for RISC-V

# Java 21+
java -version

# Maven 3.9.0+（可选，如果在 riscv64 上构建）
mvn -version
```

---

## 测试方案

### 方案 A: 使用预构建的 IDE（推荐）⚡

从 x86_64 或 aarch64 系统构建 IDE，然后在 riscv64 上测试。

**优点**：
- 构建快速（在高性能机器上）
- 适合常规测试

**流程**：
1. 在 x86_64/aarch64 Linux 上构建 riscv64 版本
2. 传输到 riscv64 设备
3. 在 riscv64 上测试运行

### 方案 B: 在 riscv64 上本地构建 🔥（完整验证）

在 riscv64 系统上完整构建和测试。

**优点**：
- 完整验证整个工具链
- 发现架构特定问题

**缺点**：
- 耗时很长（数小时）
- 需要大量磁盘和内存

---

## 方案 A 详细步骤（推荐）

### 步骤 1: 在 x86_64 Linux 上构建 riscv64 IDE

#### 1.1 确保 riscv64 平台已配置

检查 `package/ruyisdk-eclipse-packages/releng/org.eclipse.epp.config/parent/pom.xml`:

```xml
<environment>
  <os>linux</os>
  <ws>gtk</ws>
  <arch>riscv64</arch>  <!-- ✓ 确保存在 -->
</environment>
```

#### 1.2 构建插件

```bash
cd ~/ruyiSDK/plugins/ruyisdk-eclipse-plugins
mvn clean verify
```

#### 1.3 构建 riscv64 IDE

```bash
cd ~/ruyiSDK/package/ruyisdk-eclipse-packages

# 构建所有平台（包括 riscv64）
mvn clean verify -Pepp.package.embedcpp -Pepp.materialize-products

# 或者只构建 riscv64（需修改 pom.xml 只保留 riscv64 环境）
```

#### 1.4 验证构建产物

```bash
cd packages/org.eclipse.epp.package.embedcpp.product/target/products
ls -lh ruyisdk-0.0.3-linux.gtk.riscv64.tar.gz

# 应该看到 riscv64 版本的 IDE 包
```

### 步骤 2: 传输到 RISC-V 设备

#### 2.1 通过网络传输（推荐）

```bash
# 在 x86_64 机器上
cd packages/org.eclipse.epp.package.embedcpp.product/target/products

# 使用 scp 传输
scp ruyisdk-0.0.3-linux.gtk.riscv64.tar.gz user@riscv64-board:~/

# 或使用 rsync
rsync -avz --progress ruyisdk-0.0.3-linux.gtk.riscv64.tar.gz user@riscv64-board:~/
```

#### 2.2 通过存储介质

```bash
# 复制到 USB 或 SD 卡
cp ruyisdk-0.0.3-linux.gtk.riscv64.tar.gz /media/usb/

# 然后在 riscv64 设备上挂载并复制
```

### 步骤 3: 在 RISC-V 设备上测试

#### 3.1 准备环境

SSH 连接到 RISC-V 设备：

```bash
# 从开发机连接
ssh user@riscv64-board-ip

# 在 riscv64 设备上
uname -m
# 应该输出: riscv64
```

#### 3.2 安装依赖

```bash
# 更新包列表
sudo apt update

# 安装 Java 21（如果没有）
# Debian/Ubuntu for RISC-V
sudo apt install openjdk-21-jdk

# 或者使用 RuyiSDK 提供的工具链
# ruyi install openjdk-21

# 验证
java -version
```

#### 3.3 解压和测试 IDE

```bash
# 创建测试目录
mkdir -p ~/ruyisdk-test
cd ~/ruyisdk-test

# 解压 IDE
tar -xzf ~/ruyisdk-0.0.3-linux.gtk.riscv64.tar.gz

# 查看内容
ls -la ruyisdk/

# 检查是否包含 RuyiSDK 插件
ls ruyisdk/plugins/ | grep ruyisdk
```

#### 3.4 启动 IDE

```bash
cd ruyisdk

# 首次启动（可能较慢）
./ruyisdk

# 或者使用 GUI 通过 VNC/X11 转发
```

**注意事项**：
- 首次启动可能需要 1-3 分钟
- 如果是无头系统，需要 X11 转发：
  ```bash
  ssh -X user@riscv64-board
  ./ruyisdk
  ```

#### 3.5 功能验证

启动后测试：

**基本功能**：
- [ ] IDE 成功启动
- [ ] 欢迎界面显示
- [ ] 菜单和工具栏响应

**RuyiSDK 功能**：
- [ ] Help → About → Installation Details 中看到 RuyiSDK 插件
- [ ] Window → Preferences → RuyiSDK 配置可用
- [ ] 能够创建 RuyiSDK 项目
- [ ] 设备管理功能可用
- [ ] Ruyi 包管理器可用

**性能测试**：
- [ ] 响应时间可接受
- [ ] 无明显卡顿
- [ ] 内存使用合理

---

## 方案 B：在 riscv64 上本地构建

### 前提条件

```bash
# 在 riscv64 设备上

# 确认架构
uname -m
# 输出: riscv64

# 安装完整开发环境
sudo apt install openjdk-21-jdk maven git build-essential

# 设置内存（如果可用内存 < 4GB，使用 swap）
sudo fallocate -l 8G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile

# 设置 Maven 内存
export MAVEN_OPTS="-Xmx1024m"  # 根据可用内存调整
```

### 构建步骤

```bash
# 克隆代码（如果还没有）
cd ~
git clone https://github.com/ruyisdk/ruyisdk-eclipse-plugins.git
git clone https://github.com/ruyisdk/ruyisdk-eclipse-packages.git

# 构建插件
cd ~/ruyisdk-eclipse-plugins
mvn clean verify
# ⚠️ 预计时间: 15-30 分钟

# 构建 IDE
cd ~/ruyisdk-eclipse-packages
mvn clean verify -Pepp.package.embedcpp -Pepp.materialize-products
# ⚠️ 预计时间: 2-4 小时（首次）

# 测试
cd packages/org.eclipse.epp.package.embedcpp.product/target/products
tar -xzf ruyisdk-0.0.3-linux.gtk.riscv64.tar.gz
cd ruyisdk && ./ruyisdk
```

**优化建议**：
1. 使用 SSD 而不是 SD 卡
2. 确保充足的内存和 swap
3. 只构建必要的平台
4. 使用本地 Maven 镜像

---

## 性能基准

### 预期性能（VisionFive 2 8GB）

| 操作 | 时间 |
|------|------|
| IDE 启动 | 30-60 秒 |
| 创建项目 | 5-10 秒 |
| 编译小项目 | 10-30 秒 |
| 响应点击 | < 1 秒 |

### 构建时间对比

| 平台 | 插件构建 | IDE 构建 |
|------|----------|----------|
| x86_64 (高端) | 5-10 分钟 | 30-60 分钟 |
| riscv64 (VisionFive 2) | 15-30 分钟 | 2-4 小时 |

---

## 特定问题和解决方案

### 问题 1: IDE 无法启动

**症状**:
```
Unrecognized VM option 'UseStringDeduplication'
```

**原因**: 某些 riscv64 JVM 不支持所有 JVM 选项

**解决**:
```bash
# 编辑 ruyisdk.ini
vim ruyisdk/ruyisdk.ini

# 移除或注释不支持的选项：
# -XX:+UseStringDeduplication
```

### 问题 2: 性能问题

**症状**: IDE 运行缓慢

**解决**:
```bash
# 1. 减少 JVM 内存占用
vim ruyisdk/ruyisdk.ini
# 修改: -Xmx2048m → -Xmx1024m

# 2. 关闭不需要的插件

# 3. 增加系统 swap

# 4. 使用更快的存储（NVMe SSD）
```

### 问题 3: 缺少依赖库

**症状**:
```
error while loading shared libraries: xxx.so.x
```

**解决**:
```bash
# 查找缺少的库
ldd ruyisdk/ruyisdk

# 安装缺少的包
sudo apt install libgtk-3-0 libwebkit2gtk-4.0-37

# 或使用 RuyiSDK 包管理器
ruyi install gtk3 webkit2gtk
```

### 问题 4: 图形显示问题

**症状**: 界面显示异常或无法启动图形界面

**解决**:
```bash
# 1. 确认 X11 正常工作
echo $DISPLAY
xhost +

# 2. 通过 VNC 访问（如果是远程）
# 在 riscv64 设备上安装 VNC server
sudo apt install tigervnc-standalone-server

# 启动 VNC
vncserver :1

# 从客户端连接
vncviewer riscv64-board-ip:1

# 3. 使用 X11 转发
ssh -X user@riscv64-board
./ruyisdk
```

---

## 测试清单

### 环境准备
- [ ] riscv64 硬件或虚拟环境就绪
- [ ] 操作系统安装完成
- [ ] Java 21+ 已安装
- [ ] 足够的存储空间（32GB+）

### IDE 部署
- [ ] riscv64 版本 IDE 已构建
- [ ] 成功传输到 riscv64 设备
- [ ] 成功解压

### 启动测试
- [ ] IDE 能够启动
- [ ] 启动时间可接受（< 2 分钟）
- [ ] 无严重错误

### 功能测试
- [ ] 所有 RuyiSDK 插件已安装
- [ ] 欢迎界面正常
- [ ] 首选项配置可用
- [ ] 设备管理可用
- [ ] Ruyi 包管理器可用
- [ ] 项目创建可用
- [ ] 代码编辑响应正常
- [ ] 构建功能正常

### 性能测试
- [ ] UI 响应流畅
- [ ] 内存使用合理（< 2GB）
- [ ] CPU 使用正常
- [ ] 无明显卡顿

### 稳定性测试
- [ ] 运行 30 分钟无崩溃
- [ ] 创建和编译项目无问题
- [ ] 可以正常退出和重启

---

## 自动化测试脚本

### riscv64 性能测试脚本

创建 `test-riscv64-performance.sh`:

```bash
#!/bin/bash

echo "========================================"
echo "RuyiSDK IDE RISC-V64 Performance Test"
echo "========================================"

# 确认架构
ARCH=$(uname -m)
if [ "$ARCH" != "riscv64" ]; then
    echo "错误: 当前架构是 $ARCH，不是 riscv64"
    exit 1
fi

# 配置
IDE_DIR="$HOME/ruyisdk-test/ruyisdk"
WORKSPACE="$HOME/ruyisdk-workspace-test"

# 检查 IDE
if [ ! -d "$IDE_DIR" ]; then
    echo "错误: 未找到 IDE 目录: $IDE_DIR"
    exit 1
fi

# 测试 1: 启动时间
echo ""
echo "测试 1: IDE 启动时间"
START_TIME=$(date +%s)
timeout 180 "$IDE_DIR/ruyisdk" -data "$WORKSPACE" -nosplash -application org.eclipse.ui.ide.workbench &
IDE_PID=$!
sleep 60  # 等待启动
END_TIME=$(date +%s)
STARTUP_TIME=$((END_TIME - START_TIME))
kill $IDE_PID 2>/dev/null

echo "启动时间: ${STARTUP_TIME} 秒"

# 测试 2: 内存使用
echo ""
echo "测试 2: 内存使用"
free -h

# 测试 3: 系统信息
echo ""
echo "测试 3: 系统信息"
echo "CPU: $(cat /proc/cpuinfo | grep 'model name' | head -1 | cut -d: -f2)"
echo "内存: $(free -h | grep Mem | awk '{print $2}')"
echo "Java: $(java -version 2>&1 | head -1)"

echo ""
echo "测试完成"
```

---

## 与其他架构对比

### 启动时间对比

| 架构 | CPU 示例 | 启动时间 | 相对速度 |
|------|----------|----------|----------|
| x86_64 | Intel i7 | 10-15 秒 | 1.0x |
| aarch64 | Apple M1 | 8-12 秒 | 1.2x |
| **riscv64** | **JH7110** | **30-60 秒** | **0.3x** |

### 功能完整性

| 功能 | x86_64 | aarch64 | riscv64 |
|------|--------|---------|---------|
| 基本 IDE | ✅ | ✅ | ✅ |
| RuyiSDK 插件 | ✅ | ✅ | ✅ |
| CDT 支持 | ✅ | ✅ | ✅ |
| Git 集成 | ✅ | ✅ | ✅ |
| 调试功能 | ✅ | ✅ | ⚠️ 部分 |
| 性能分析 | ✅ | ✅ | ⚠️ 有限 |

---

## 最佳实践

### 1. 硬件选择

✅ **推荐**：
- VisionFive 2 (8GB)：性价比高，社区支持好
- Milk-V Pioneer：性能最强，但价格较高

❌ **不推荐**：
- 内存 < 4GB 的开发板
- 使用 SD 卡作为主存储（太慢）

### 2. 系统优化

```bash
# 禁用不必要的服务
sudo systemctl disable bluetooth
sudo systemctl disable cups

# 使用轻量级桌面环境
# 推荐 LXDE 或 Xfce 而不是 GNOME

# 增加 swap
sudo fallocate -l 4G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
```

### 3. IDE 优化

```bash
# 在 ruyisdk.ini 中调整：

# 减少内存占用
-Xms256m
-Xmx1024m

# 优化垃圾回收
-XX:+UseG1GC
-XX:MaxGCPauseMillis=50

# 禁用不需要的功能
# 关闭自动构建
# 减少编辑器功能
```

---

## 文档和报告

### 测试报告模板

```markdown
## RuyiSDK IDE RISC-V64 测试报告

**测试日期**: YYYY-MM-DD
**测试人员**: [姓名]

### 测试环境
- **硬件**: [开发板型号]
- **CPU**: [CPU 型号]
- **内存**: [容量]
- **存储**: [类型和容量]
- **操作系统**: [发行版和版本]
- **Java**: [版本]

### IDE 信息
- **版本**: ruyisdk-0.0.3-linux.gtk.riscv64
- **大小**: [文件大小]
- **包含插件**: [列出 RuyiSDK 插件]

### 测试结果

#### 部署测试
- [ ] 传输到设备：[成功/失败]
- [ ] 解压：[成功/失败]
- [ ] 权限设置：[正常/异常]

#### 启动测试
- [ ] 首次启动：[成功/失败]，时间：[秒]
- [ ] 二次启动：[成功/失败]，时间：[秒]
- [ ] 启动错误：[无/列出错误]

#### 功能测试
- [ ] 欢迎界面：[正常/异常]
- [ ] 项目创建：[正常/异常]
- [ ] 代码编辑：[正常/异常]
- [ ] 编译构建：[正常/异常]
- [ ] 设备管理：[正常/异常]
- [ ] Ruyi 集成：[正常/异常]

#### 性能测试
- 启动时间：[秒]
- 内存使用：[MB]
- CPU 使用：[%]
- 响应时间：[流畅/一般/卡顿]

#### 稳定性测试
- 运行时间：[小时]
- 崩溃次数：[次]
- 严重错误：[无/列出]

### 发现的问题
1. [问题描述]
   - 严重程度：[严重/一般/轻微]
   - 重现步骤：
   - 截图/日志：

### 总体评价
- [ ] ✅ 完全满足要求
- [ ] ⚠️ 基本满足，有小问题
- [ ] ❌ 存在严重问题

### 建议
[改进建议]

### 截图
[附上关键步骤截图]
```

---

## 总结

### RISC-V64 测试的意义

✅ **关键验证点**：
1. 证明 RuyiSDK IDE 真正支持 riscv64
2. 验证 Eclipse 2024-09+ 的 riscv64 支持
3. 为 RISC-V 生态做出贡献
4. 发现架构特定问题

### 测试策略

**推荐流程**：
1. ✅ Windows：快速插件功能验证
2. ✅ Linux (x86_64)：完整 IDE 构建测试
3. ✅ RISC-V64：最终用户体验验证 ← **当前**

**时间安排**：
- 如果有 riscv64 硬件：必须测试
- 如果没有硬件：可选（在 x86_64/aarch64 上构建 riscv64 版本已足够）

### 下一步

完成 riscv64 测试后：
1. ✅ 记录测试结果和性能数据
2. ✅ 提交问题报告（如果发现问题）
3. ✅ 更新文档和最佳实践
4. ✅ 准备发布 riscv64 版本

---

## 资源链接

- **RISC-V 开发板信息**: https://riscv.org/exchange/
- **Debian for RISC-V**: https://wiki.debian.org/RISC-V
- **Ubuntu for RISC-V**: https://wiki.ubuntu.com/RISC-V
- **Eclipse riscv64 支持**: https://riscv.org/blog-chinese/2024/09/eclipse-riscv64-support-upstreamed/
- **RuyiSDK**: https://ruyisdk.org/

---

**RISC-V 是未来！🚀 RuyiSDK 让 RISC-V 开发更简单！**

