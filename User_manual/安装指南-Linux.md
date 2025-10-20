# RuyiSDK Eclipse 插件 - Linux 安装指南

## 📦 插件功能说明

RuyiSDK 插件为 Eclipse 添加了专门的 RISC-V 开发功能：

| 插件 | 功能描述 |
|------|---------|
| **org.ruyisdk.core** | 核心功能库，提供其他插件调用的公共API |
| **org.ruyisdk.devices** | RISC-V 设备管理和配置 |
| **org.ruyisdk.packages** | SDK 包和依赖管理 |
| **org.ruyisdk.projectcreator** | 项目创建向导，支持多种 RISC-V 开发板模板 |
| **org.ruyisdk.ruyi** | Ruyi 包管理器集成，自动安装工具链 |
| **org.ruyisdk.intro** | 定制化的 RuyiSDK 欢迎界面 |

---

## 🎯 安装方法选择

### 方法对比

| 方法 | 适用场景 | 优点 | 缺点 |
|------|---------|------|------|
| **方法一：本地 P2 仓库** | 已有 Eclipse IDE | 简单快速，无需重新构建 | 需要手动更新 |
| **方法二：重新构建 IDE** | 需要定制 IDE | 插件完全集成 | 构建时间长 |
| **方法三：在线更新站点** | 有网络环境 | 自动更新 | 需要部署更新站点 |

**推荐**：如果您已经有运行的 RuyiSDK IDE，使用**方法一**最简单。

---

## 方法一：通过本地 P2 仓库安装 ⭐

### 前置条件

- ✅ 已安装并运行 RuyiSDK Eclipse IDE
- ✅ Java 21 和 Maven 3.9+ 环境
- ✅ 访问 ruyisdk-eclipse-plugins 源码

### 步骤 1：构建插件仓库

#### 选项 A：在 Windows 上构建

```powershell
# 打开 PowerShell 或 Git Bash
cd D:\ruyiSDK\plugins\ruyisdk-eclipse-plugins

# 构建所有插件
mvn clean verify

# 检查构建结果
ls repository\target\repository\
# 应该看到：
# - features/
# - plugins/
# - artifacts.jar
# - content.jar
```

#### 选项 B：在 Linux 上构建（推荐）

```bash
# 假设项目在 /path/to/ruyisdk-eclipse-plugins
cd /path/to/ruyisdk-eclipse-plugins

# 构建
mvn clean verify

# 检查结果
ls -la repository/target/repository/
```

构建时间：首次约 5-15 分钟（取决于网络和机器性能）

### 步骤 2：传输插件仓库到 Linux

#### 如果在 Windows 上构建：

**打包方式 1：ZIP 格式（推荐，Windows 原生支持）**

```powershell
# 在 Windows PowerShell 中
cd repository\target

# 使用 PowerShell 打包
Compress-Archive -Path repository -DestinationPath ruyisdk-plugins.zip

# 传输到 Linux
scp ruyisdk-plugins.zip root@192.168.1.100:/tmp/
```

**打包方式 2：TAR.GZ 格式（Linux 标准格式）**

```bash
# 在 Windows 上（需要 Git Bash 或 WSL）
cd repository\target
tar -czf ruyisdk-plugins.tar.gz repository\

# 传输到 Linux（替换 IP 和用户名）
scp ruyisdk-plugins.tar.gz root@192.168.1.100:/tmp/
```

#### 如果在 Linux 上构建：

直接进入下一步，使用本地路径。

### 步骤 3：在 Linux 上准备仓库

```bash
cd /tmp

# 如果是 ZIP 格式
unzip ruyisdk-plugins.zip

# 或者如果是 TAR.GZ 格式
# tar -xzf ruyisdk-plugins.tar.gz

# 移到合适的位置
sudo mkdir -p /plugins/ruyisdk-plugins
sudo mv repository /plugins/ruyisdk-plugins/
sudo chmod -R 755 /plugins/ruyisdk-plugins

# 记住路径
PLUGIN_REPO=/opt/ruyisdk-plugins/repository
```

### 步骤 4：在 Eclipse 中安装插件

1. **启动 RuyiSDK Eclipse IDE**
   ```bash
   cd ~/opt/ruyisdk  # 或您的安装路径
   ./ruyisdk
   ```

2. **打开安装对话框**
   ```
   Help → Install New Software...
   ```

3. **添加插件仓库**
   - 点击 **"Add..."** 按钮
   - 在弹出的对话框中填写：
     ```
     Name: RuyiSDK Plugins
     Location: file:///opt/ruyisdk-plugins/repository
     ```
   - 点击 **"Add"**

4. **选择要安装的插件**
   - 等待几秒钟，插件列表会显示
   - 勾选：
     ```
     ☑ RuyiSDK Feature (0.0.4 或当前版本)
     ```
   - 可以展开查看包含的具体插件

5. **安装**
   - 点击 **"Next"**
   - 再次点击 **"Next"**（审查安装详情）
   - 接受许可协议
   - 点击 **"Finish"**

6. **重启 IDE**
   - 安装完成后会提示重启
   - 点击 **"Restart Now"**

### 步骤 5：验证安装

重启后：

1. **检查欢迎界面**
   - 应该看到 RuyiSDK 定制的欢迎界面
   - 有 Ruyi 标志和 RuyiSDK 品牌

2. **检查菜单**
   - 顶部菜单栏应该有 **"RuyiSDK"** 菜单项

3. **测试项目创建**
   ```
   File → New → Project...
   → C/C++ → RuyiSDK C/C++ Project
   ```
   应该能看到 RISC-V 项目模板选项

4. **检查已安装插件**
   ```
   Help → About Eclipse IDE → Installation Details
   → Installed Software 标签
   ```
   应该能看到所有 `org.ruyisdk.*` 插件

---

## 方法二：重新构建包含插件的 IDE

### 适用场景

- 需要分发给其他用户
- 想要插件完全集成
- 定制 IDE 外观和功能

### 在 Linux 上完整构建

#### 步骤 1：准备源码

```bash
# 创建工作目录
mkdir -p ~/ruyisdk-build
cd ~/ruyisdk-build

# 假设您已经有源码，或通过 git clone 获取
# 目录结构应该是：
# ~/ruyisdk-build/
#   ├── plugins/ruyisdk-eclipse-plugins/
#   └── package/ruyisdk-eclipse-packages/
```

#### 步骤 2：构建插件

```bash
cd ~/ruyisdk-build/plugins/ruyisdk-eclipse-plugins

# 设置 Maven 内存
export MAVEN_OPTS="-Xmx2048m"

# 构建
mvn clean verify

# 验证构建
ls -lh repository/target/repository/
```

#### 步骤 3：构建包含插件的 IDE

```bash
cd ~/ruyisdk-build/package/ruyisdk-eclipse-packages

# 构建（仅 x86_64，更快）
mvn clean verify \
  -Pepp.p2.common \
  -Pepp.p2.embedcpp \
  -Pepp.product.embedcpp \
  -Pepp.materialize-products

# 或构建所有架构（x86_64, aarch64, riscv64）
mvn clean verify
```

构建时间：
- 首次构建：30-60 分钟
- 增量构建：10-20 分钟

#### 步骤 4：安装新构建的 IDE

```bash
# 进入产物目录
cd packages/org.eclipse.epp.package.embedcpp.product/target/products/

# 列出构建的包
ls -lh *.tar.gz

# 解压
tar -xzf ruyisdk-0.0.3-linux.gtk.x86_64.tar.gz

# 移到安装位置
sudo mv ruyisdk /opt/ruyisdk-with-plugins

# 创建启动链接
sudo ln -s /opt/ruyisdk-with-plugins/ruyisdk /usr/local/bin/ruyisdk

# 运行
ruyisdk
```

这个 IDE 已经完全集成了所有 RuyiSDK 插件！

---

## 方法三：从 Windows 构建并传输

### 步骤 1：在 Windows 上构建

```powershell
# 打开 PowerShell
cd D:\ruyiSDK

# 1. 构建插件
cd plugins\ruyisdk-eclipse-plugins
mvn clean verify

# 2. 构建 IDE
cd ..\..\package\ruyisdk-eclipse-packages
mvn clean verify -Pepp.p2.embedcpp -Pepp.product.embedcpp -Pepp.materialize-products
```

### 步骤 2：传输到 Linux

```powershell
# 找到构建的包
cd packages\org.eclipse.epp.package.embedcpp.product\target\products\

# 传输到 Linux
scp ruyisdk-0.0.3-linux.gtk.x86_64.tar.gz root@linux-vm:/tmp/
```

### 步骤 3：在 Linux 上安装

```bash
# 解压并安装
cd /tmp
tar -xzf ruyisdk-0.0.3-linux.gtk.x86_64.tar.gz

# 修复权限（重要！）
cd ruyisdk
chmod +x ruyisdk
find . -type f -name "*.so" -exec chmod +x {} \;
find . -path "*/bin/*" -type f -exec chmod +x {} \;

# 移到安装位置
cd ..
sudo mv ruyisdk /opt/ruyisdk-with-plugins

# 运行
/opt/ruyisdk-with-plugins/ruyisdk
```

**注意**：从 Windows 传输时一定要修复权限！

---

## 🔍 故障排除

### 问题 1：Eclipse 找不到插件仓库

**症状**：添加仓库后列表为空

**解决**：
```bash
# 检查路径是否正确
ls -la /opt/ruyisdk-plugins/repository/

# 确保有这些文件：
# - artifacts.jar
# - content.jar
# - features/
# - plugins/

# 检查权限
chmod -R 755 /opt/ruyisdk-plugins/
```

### 问题 2：安装时出现依赖错误

**症状**：`Cannot complete the install because of a conflicting dependency`

**原因**：Eclipse 版本不匹配

**解决**：
- 确保 Eclipse IDE 是 2024-12 (4.34.0) 版本
- 或重新构建插件匹配您的 Eclipse 版本

### 问题 3：插件安装后不显示

**症状**：安装成功但看不到插件功能

**解决**：
```bash
# 1. 确认插件已安装
Help → About → Installation Details
→ 查找 org.ruyisdk.*

# 2. 清理工作空间缓存
cd ~/eclipse-workspace
rm -rf .metadata/.plugins/org.eclipse.core.runtime/.settings/
rm -rf .metadata/.plugins/org.eclipse.e4.workbench/

# 3. 重启 IDE
./ruyisdk -clean
```

### 问题 4：构建失败 - 内存不足

**症状**：`java.lang.OutOfMemoryError: Java heap space`

**解决**：
```bash
# 增加 Maven 内存
export MAVEN_OPTS="-Xmx4096m -XX:MaxPermSize=1024m"

# 重新构建
mvn clean verify
```

### 问题 5：找不到 org.ruyisdk.feature

**症状**：构建 IDE 时报错找不到 RuyiSDK 特性

**解决**：
```bash
# 确保先构建插件
cd plugins/ruyisdk-eclipse-plugins
mvn clean install  # 注意是 install 不是 verify

# 然后构建 IDE
cd ../../package/ruyisdk-eclipse-packages
mvn clean verify -Pepp.package.embedcpp
```

---

## 🎓 插件使用指南

### 创建 RISC-V 项目

安装插件后，可以使用项目创建向导：

```
1. File → New → Project...

2. 展开 C/C++

3. 选择 "RuyiSDK C/C++ Project"

4. 选择开发板模板：
   - Generic RISC-V
   - Milk-V Duo
   - (其他支持的开发板)

5. 配置项目名称和位置

6. 完成 → 自动生成项目结构和 Makefile
```

### 使用 Ruyi 包管理器

```
1. RuyiSDK → Ruyi Package Manager

2. 浏览可用的工具链和 SDK

3. 点击安装需要的包

4. 工具链会自动下载和配置
```

### 设备管理

```
1. Window → Show View → Other...

2. RuyiSDK → Devices

3. 添加 RISC-V 设备配置

4. 配置调试连接
```

---

## 📚 更多资源

### 文档

- [插件开发文档](docs/developer/)
- [构建指南](RUYISDK_BUILD_GUIDE.md)
- [兼容性说明](COMPATIBILITY.md)

### 示例项目

- 插件包含的项目模板位于：
  ```
  plugins/org.ruyisdk.projectcreator/templates/
  ```

### 获取帮助

- 提交问题：https://github.com/ruyisdk/ruyisdk-eclipse-plugins/issues
- 讨论区：https://github.com/ruyisdk/ruyisdk-eclipse-plugins/discussions

---

## ✅ 安装验证清单

安装完成后，请检查：

- [ ] 欢迎界面显示 RuyiSDK 品牌
- [ ] 顶部菜单栏有 "RuyiSDK" 菜单
- [ ] 可以创建 "RuyiSDK C/C++ Project"
- [ ] Help → About 中显示所有 RuyiSDK 插件
- [ ] Ruyi 包管理器功能可用
- [ ] 设备视图可以显示

---

**祝您使用愉快！** 🎉

如有问题，请查看故障排除部分或在 GitHub 上提问。

