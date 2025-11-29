# Linux 上测试 RuyiSDK Eclipse 插件和 IDE 指南

## 适用场景

✅ **完全适合** Linux 平台测试：
- 测试插件安装（方式 2：单独更新）
- 验证插件功能
- **构建完整 IDE 产品**（方式 1：联合打包）
- 验证最终用户体验
- CI/CD 集成测试

---

## 测试方案概览

### 方案 A：插件快速测试 ⚡
- **时间**: 5-10 分钟
- **空间**: 几乎不占用额外空间
- **目的**: 验证插件功能

### 方案 B：完整 IDE 构建测试 🔥
- **时间**: 30-60 分钟（首次）
- **空间**: 80GB+
- **目的**: 验证完整 IDE 产品

---

## 前提条件

### 系统要求

```bash
# 操作系统
Ubuntu 20.04+ / Debian 11+ / Fedora 35+ / RHEL 8+
或其他主流 Linux 发行版

# 处理器
x86_64 (推荐) 或 aarch64

# 内存
建议 8GB+ （IDE 构建需要 4GB+）

# 磁盘空间
- 插件测试：1GB
- 完整 IDE 构建：80GB+
```

### 必需软件

```bash
# Java 21+
java -version
# 输出应显示: openjdk version "21.x.x" 或更高

# Maven 3.9.0+
mvn -version
# 输出应显示: Apache Maven 3.9.x

# Git（用于克隆代码）
git --version
```

### 安装依赖（如果缺少）

#### CentOS 7 使用方法（含兼容性提示）

重要说明：CentOS 7 已到达生命周期终点（EOL），系统自带软件源较旧。Eclipse 2024-12 / Java 21 / Tycho 4 需要较新的运行环境。建议优先在 RHEL 8+/Rocky 8+/AlmaLinux 8+ 或 Ubuntu 22.04+ 上构建；若必须在 CentOS 7，请按下列方式以“压缩包安装”的方式部署 JDK 与 Maven。

##### 1) 安装 Java 21（Adoptium/Temurin 压缩包）

```bash
sudo mkdir -p /opt/java && cd /opt/java
sudo curl -L -o temurin21.tar.gz \
  https://github.com/adoptium/temurin21-binaries/releases/latest/download/OpenJDK21U-jdk_x64_linux_hotspot.tar.gz
sudo tar -xzf temurin21.tar.gz
JAVA_HOME=$(find /opt/java -maxdepth 2 -type d -name 'jdk-*' | head -n1)
echo "export JAVA_HOME=$JAVA_HOME" | sudo tee /etc/profile.d/java21.sh
echo 'export PATH=$JAVA_HOME/bin:$PATH' | sudo tee -a /etc/profile.d/java21.sh
source /etc/profile.d/java21.sh
java -version    # 应显示 openjdk version "21..."
```

##### 2) 安装 Maven 3.9.9（压缩包）

```bash
sudo mkdir -p /opt/maven && cd /opt/maven
sudo curl -L -o apache-maven-3.9.9-bin.tar.gz \
  https://dlcdn.apache.org/maven/maven-3/3.9.9/binaries/apache-maven-3.9.9-bin.tar.gz
sudo tar -xzf apache-maven-3.9.9-bin.tar.gz
sudo ln -sfn /opt/maven/apache-maven-3.9.9 /opt/maven/current
echo 'export MAVEN_HOME=/opt/maven/current' | sudo tee /etc/profile.d/maven.sh
echo 'export PATH=$MAVEN_HOME/bin:$PATH' | sudo tee -a /etc/profile.d/maven.sh
source /etc/profile.d/maven.sh
mvn -version     # 应显示 Apache Maven 3.9.9
```

可选：更新根证书（避免 HTTPS 访问仓库失败）

```bash
sudo update-ca-trust force-enable
sudo update-ca-trust extract
```

##### 3) 构建步骤（与 Linux 通用步骤一致）

```bash
# 先构建插件，产出本地 p2 仓库
cd ~/ruyisdk/plugins/ruyisdk-eclipse-plugins
mvn clean verify

# 再构建 EPP（将插件集成进 IDE）
cd ~/ruyisdk/package/ruyisdk-eclipse-packages
mvn clean verify \
  -Pepp.p2.common -Pepp.p2.embedcpp -Pepp.product.embedcpp -Pepp.materialize-products \
  -Druyisdk.plugins.repository=file:///home/youruser/ruyisdk/plugins/ruyisdk-eclipse-plugins/repository/target/repository
```

##### 4) 兼容性与运行提示

- 运行最终 IDE：Eclipse 2024-12 在 CentOS 7 上可能因 glibc 版本过低而无法运行。建议将产物拿到 RHEL 8+/Rocky/Alma 8+/Ubuntu 22.04+ 上运行验证。
- 构建网络问题：若访问 `download.eclipse.org` 或 `repo.eclipse.org` 失败，检查公司代理或根证书。可使用 `mvn -U` 强制更新。
- 磁盘/内存：首次构建需要较多磁盘与内存，参考“故障排除”章节。

##### 5) 备选方案：使用容器在新版发行版中构建（推荐）

```bash
# 以 Rocky Linux 8 为例（需安装 podman 或 docker）
podman run --rm -it -v ~/ruyisdk:/workspace -w /workspace \
  docker.io/rockylinux:8 bash -lc '
  dnf -y install git tar gzip unzip curl \
    java-21-openjdk-devel maven && \
  java -version && mvn -version && \
  cd plugins/ruyisdk-eclipse-plugins && mvn clean verify && \
  cd ../../package/ruyisdk-eclipse-packages && \
  mvn clean verify -Pepp.p2.common -Pepp.p2.embedcpp -Pepp.product.embedcpp -Pepp.materialize-products
'
```

#### Ubuntu/Debian

```bash
# 更新包列表
sudo apt update

# 安装 OpenJDK 21
sudo apt install openjdk-21-jdk

# 下载并安装 Maven 3.9.9
cd /tmp
wget https://dlcdn.apache.org/maven/maven-3/3.9.9/binaries/apache-maven-3.9.9-bin.tar.gz
sudo tar xzf apache-maven-3.9.9-bin.tar.gz -C /opt
sudo ln -s /opt/apache-maven-3.9.9 /opt/maven

# 设置环境变量
echo 'export JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64' >> ~/.bashrc
echo 'export MAVEN_HOME=/opt/maven' >> ~/.bashrc
echo 'export PATH=$MAVEN_HOME/bin:$JAVA_HOME/bin:$PATH' >> ~/.bashrc
source ~/.bashrc

# 验证
java -version
mvn -version
```

#### Fedora/RHEL
```bash
# 安装 OpenJDK 21
sudo dnf install java-21-openjdk-devel

# 安装 Maven
sudo dnf install maven

# 或手动安装最新 Maven（推荐）
cd /tmp
wget https://dlcdn.apache.org/maven/maven-3/3.9.9/binaries/apache-maven-3.9.9-bin.tar.gz
sudo tar xzf apache-maven-3.9.9-bin.tar.gz -C /opt
sudo ln -s /opt/apache-maven-3.9.9 /opt/maven

# 设置环境变量
echo 'export MAVEN_HOME=/opt/maven' >> ~/.bashrc
echo 'export PATH=$MAVEN_HOME/bin:$PATH' >> ~/.bashrc
source ~/.bashrc
```

---

## 方案 A：插件快速测试

### 步骤 1: 准备 Eclipse

#### 1.1 下载 Eclipse

```bash
# 创建目录
mkdir -p ~/eclipse-test
cd ~/eclipse-test

# 下载 Eclipse 2024-12 for Linux x86_64
# RCP and RAP Developers 版本（推荐）
wget https://www.eclipse.org/downloads/download.php?file=/technology/epp/downloads/release/2024-12/R/eclipse-rcp-2024-12-R-linux-gtk-x86_64.tar.gz -O eclipse-rcp-2024-12-R-linux-gtk-x86_64.tar.gz

# 或下载 Java EE Developers 版本
# wget https://www.eclipse.org/downloads/download.php?file=/technology/epp/downloads/release/2024-12/R/eclipse-jee-2024-12-R-linux-gtk-x86_64.tar.gz -O eclipse-jee-2024-12-R-linux-gtk-x86_64.tar.gz

# 解压
tar -xzf eclipse-rcp-2024-12-R-linux-gtk-x86_64.tar.gz

# 启动 Eclipse
cd eclipse
./eclipse
```

#### 1.2 选择工作空间

```
首次启动会提示选择工作空间：
推荐：/home/youruser/eclipse-workspace-test

勾选 "Use this as the default and do not ask again"（可选）
点击 "Launch"
```

### 步骤 2: 安装 RuyiSDK 插件

#### 2.1 打开安装向导

```
菜单栏: Help → Install New Software...
```

#### 2.2 添加本地更新站点

```bash
# 假设 ruyiSDK 代码位于 ~/ruyiSDK
# 如果在其他位置，请相应调整路径

点击 "Add..." 按钮

在对话框中：
- Name: RuyiSDK Local Repository
- Location: file:///home/youruser/ruyiSDK/plugins/ruyisdk-eclipse-plugins/repository/target/repository

点击 "Add"
```

**注意**: 
- 使用 `file://` 协议加**绝对路径**
- 可以点击 "Local..." 按钮浏览选择

#### 2.3 安装插件

1. 在列表中勾选 "RuyiSDK IDE Feature"
2. 取消勾选 "Contact all update sites during install to find required software"（加快安装）
3. 点击 "Next"
4. 查看安装详情（应该看到 8 个插件）
5. 点击 "Next"
6. 接受许可协议
7. 点击 "Finish"
8. 如果提示安全警告，点击 "Install anyway"
9. 等待安装完成（1-5 分钟）
10. 点击 "Restart Now" 重启 Eclipse

### 步骤 3: 验证安装

#### 3.1 检查已安装的插件

```
Help → About Eclipse IDE → Installation Details

在 "Installed Software" 标签中：
- 搜索 "ruyisdk"
- 应该看到 "RuyiSDK IDE Feature" 或相关项

在 "Plug-ins" 标签中：
- 搜索 "org.ruyisdk"
- 应该看到 8 个插件，版本 0.0.4.xxx
```

#### 3.2 验证功能

**欢迎界面**:
```
Help → Welcome
应该看到 RuyiSDK 定制的欢迎界面
```

**首选项**:
```
Window → Preferences → 搜索 "RuyiSDK"
应该看到：
- RuyiSDK → Devices
- RuyiSDK → Ruyi
```

**视图**:
```
Window → Show View → Other... → 搜索 "ruyisdk"
应该看到：
- RuyiSDK → Packages
- 其他 RuyiSDK 视图
```

**项目向导**:
```
File → New → Project... → 搜索 "ruyisdk"
应该看到 RuyiSDK 项目创建向导
```

---

## 方案 B：完整 IDE 构建测试

### 步骤 1: 环境准备

#### 1.1 确认磁盘空间

```bash
# 检查可用空间
df -h ~

# 建议至少有 80GB 可用空间
# 如果空间不足，清理或挂载新磁盘
```

#### 1.2 设置 Maven 内存

```bash
# 设置 Maven 内存选项
export MAVEN_OPTS="-Xmx2048m -XX:MaxPermSize=512m"

# 添加到 ~/.bashrc 以便永久生效
echo 'export MAVEN_OPTS="-Xmx2048m -XX:MaxPermSize=512m"' >> ~/.bashrc
```

#### 1.3 确认插件已构建

```bash
# 检查插件 P2 仓库是否存在
ls -la ~/ruyiSDK/plugins/ruyisdk-eclipse-plugins/repository/target/repository/

# 应该看到：
# artifacts.jar
# content.jar
# plugins/
# features/

# 如果不存在，先构建插件
cd ~/ruyiSDK/plugins/ruyisdk-eclipse-plugins
mvn clean verify
```

### 步骤 2: 构建完整 IDE

#### 2.1 执行构建

```bash
cd ~/ruyiSDK/package/ruyisdk-eclipse-packages

# 完整构建（所有平台）- 时间较长
mvn clean verify -Pepp.package.embedcpp -Pepp.materialize-products

# 或只构建 Linux x86_64 平台（更快）
# 需要先编辑 releng/org.eclipse.epp.config/parent/pom.xml
# 注释掉不需要的平台
```

#### 2.2 监控构建进度

```bash
# 在另一个终端监控
tail -f ~/ruyiSDK/package/ruyisdk-eclipse-packages/build.log

# 或查看 Maven 输出
# 构建过程可能需要 30-60 分钟（首次）
```

#### 2.3 构建过程说明

Maven 会依次执行：
1. 下载 Eclipse 平台依赖（首次较慢）
2. 编译各个包模块
3. 从本地 P2 仓库拉取 RuyiSDK 插件
4. 生成 P2 仓库
5. 创建产品（materialize）
6. 打包为 .tar.gz

预计时间：
- 首次构建：30-60 分钟
- 后续增量构建：10-20 分钟

### 步骤 3: 验证构建产物

#### 3.1 检查构建结果

```bash
# 查看最终产物
cd ~/ruyiSDK/package/ruyisdk-eclipse-packages/packages/org.eclipse.epp.package.embedcpp.product/target/products

ls -lh

# 应该看到（取决于配置的平台）：
# ruyisdk-0.0.3-linux.gtk.x86_64.tar.gz
# ruyisdk-0.0.3-linux.gtk.aarch64.tar.gz
# ruyisdk-0.0.3-linux.gtk.riscv64.tar.gz
```

#### 3.2 检查文件大小

```bash
# 查看压缩包大小
du -sh *.tar.gz

# 典型大小：
# x86_64: 约 350-500 MB
# aarch64: 约 350-500 MB
# riscv64: 约 350-500 MB
```

### 步骤 4: 测试 IDE 产品

#### 4.1 解压 IDE

```bash
# 创建测试目录
mkdir -p ~/test-ruyisdk-ide
cd ~/test-ruyisdk-ide

# 解压 IDE
tar -xzf ~/ruyiSDK/package/ruyisdk-eclipse-packages/packages/org.eclipse.epp.package.embedcpp.product/target/products/ruyisdk-0.0.3-linux.gtk.x86_64.tar.gz

# 查看内容
ls -la ruyisdk/
```

#### 4.2 启动 IDE

```bash
cd ruyisdk

# 启动 RuyiSDK IDE
./ruyisdk
```

#### 4.3 验证插件包含

启动后，检查 RuyiSDK 插件是否已集成：

```
Help → About RuyiSDK IDE → Installation Details

在 "Plug-ins" 标签中搜索 "org.ruyisdk"
应该看到所有 8 个 RuyiSDK 插件
```

#### 4.4 功能测试

测试所有 RuyiSDK 功能：
- [ ] 欢迎界面显示正常
- [ ] 设备管理可用
- [ ] Ruyi 配置可用
- [ ] 包浏览器可用
- [ ] 项目创建向导可用
- [ ] 能够创建和编译项目

---

## 自动化测试脚本

### 快速构建脚本

创建 `build-ruyisdk-ide.sh`:

```bash
#!/bin/bash
set -e

echo "=========================================="
echo "RuyiSDK IDE Build Script for Linux"
echo "=========================================="

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 检查环境
echo -e "${YELLOW}检查构建环境...${NC}"

if ! command -v java &> /dev/null; then
    echo -e "${RED}错误: 未找到 Java${NC}"
    exit 1
fi

if ! command -v mvn &> /dev/null; then
    echo -e "${RED}错误: 未找到 Maven${NC}"
    exit 1
fi

JAVA_VERSION=$(java -version 2>&1 | awk -F '"' '/version/ {print $2}' | cut -d'.' -f1)
if [ "$JAVA_VERSION" -lt 21 ]; then
    echo -e "${RED}错误: Java 版本必须 >= 21，当前版本: $JAVA_VERSION${NC}"
    exit 1
fi

echo -e "${GREEN}环境检查通过${NC}"
echo "Java 版本: $(java -version 2>&1 | head -n 1)"
echo "Maven 版本: $(mvn -version | head -n 1)"
echo ""

# 设置变量
PROJECT_ROOT="$HOME/ruyiSDK"
PLUGINS_DIR="$PROJECT_ROOT/plugins/ruyisdk-eclipse-plugins"
PACKAGES_DIR="$PROJECT_ROOT/package/ruyisdk-eclipse-packages"

# 步骤 1: 构建插件
echo -e "${YELLOW}步骤 1/2: 构建 RuyiSDK 插件...${NC}"
cd "$PLUGINS_DIR"

if mvn clean verify; then
    echo -e "${GREEN}✓ 插件构建成功${NC}"
else
    echo -e "${RED}✗ 插件构建失败${NC}"
    exit 1
fi

echo ""

# 步骤 2: 构建 IDE
echo -e "${YELLOW}步骤 2/2: 构建 RuyiSDK IDE...${NC}"
cd "$PACKAGES_DIR"

if mvn clean verify -Pepp.package.embedcpp -Pepp.materialize-products; then
    echo -e "${GREEN}✓ IDE 构建成功${NC}"
else
    echo -e "${RED}✗ IDE 构建失败${NC}"
    exit 1
fi

echo ""

# 显示结果
echo -e "${GREEN}=========================================="
echo "构建完成！"
echo "==========================================${NC}"
echo ""
echo "产物位置："
echo "$PACKAGES_DIR/packages/org.eclipse.epp.package.embedcpp.product/target/products/"
echo ""
echo "生成的文件："
cd "$PACKAGES_DIR/packages/org.eclipse.epp.package.embedcpp.product/target/products/"
ls -lh *.tar.gz 2>/dev/null || echo "未找到 .tar.gz 文件"

echo ""
echo -e "${GREEN}构建成功完成！${NC}"
```

使用方法：
```bash
chmod +x build-ruyisdk-ide.sh
./build-ruyisdk-ide.sh
```

### 测试脚本

创建 `test-ruyisdk-ide.sh`:

```bash
#!/bin/bash
set -e

echo "=========================================="
echo "RuyiSDK IDE Test Script"
echo "=========================================="

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# 配置
IDE_ARCHIVE="$HOME/ruyiSDK/package/ruyisdk-eclipse-packages/packages/org.eclipse.epp.package.embedcpp.product/target/products/ruyisdk-0.0.3-linux.gtk.x86_64.tar.gz"
TEST_DIR="$HOME/test-ruyisdk-ide"

# 检查文件
if [ ! -f "$IDE_ARCHIVE" ]; then
    echo "错误: 未找到 IDE 压缩包: $IDE_ARCHIVE"
    exit 1
fi

# 清理旧测试
rm -rf "$TEST_DIR"
mkdir -p "$TEST_DIR"

echo -e "${YELLOW}解压 IDE...${NC}"
cd "$TEST_DIR"
tar -xzf "$IDE_ARCHIVE"

echo -e "${GREEN}✓ 解压完成${NC}"
echo ""

# 检查结构
echo "IDE 目录结构："
ls -la ruyisdk/

echo ""
echo "插件列表（RuyiSDK 相关）："
ls ruyisdk/plugins/ | grep ruyisdk || echo "未找到 RuyiSDK 插件"

echo ""
echo -e "${GREEN}准备启动 IDE 进行手动测试...${NC}"
echo "执行: cd $TEST_DIR/ruyisdk && ./ruyisdk"
```

---

## CI/CD 集成

### Jenkins Pipeline 示例

```groovy
pipeline {
    agent {
        label 'linux'
    }
    
    tools {
        jdk 'OpenJDK-21'
        maven 'Maven-3.9.9'
    }
    
    environment {
        MAVEN_OPTS = '-Xmx2048m'
    }
    
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        
        stage('Build Plugins') {
            steps {
                dir('plugins/ruyisdk-eclipse-plugins') {
                    sh 'mvn clean verify'
                }
            }
        }
        
        stage('Build IDE') {
            steps {
                dir('package/ruyisdk-eclipse-packages') {
                    sh 'mvn clean verify -Pepp.package.embedcpp -Pepp.materialize-products'
                }
            }
        }
        
        stage('Archive Artifacts') {
            steps {
                archiveArtifacts artifacts: '**/target/products/*.tar.gz', fingerprint: true
            }
        }
        
        stage('Test') {
            steps {
                sh '''
                    cd package/ruyisdk-eclipse-packages/packages/org.eclipse.epp.package.embedcpp.product/target/products
                    mkdir -p test-ide
                    cd test-ide
                    tar -xzf ../ruyisdk-*.tar.gz
                    # 添加自动化测试命令
                '''
            }
        }
    }
    
    post {
        always {
            cleanWs()
        }
    }
}
```

### GitHub Actions 示例

```yaml
name: Build RuyiSDK IDE

on: [push, pull_request]

jobs:
  build:
    runs-on: ubuntu-latest
    
    steps:
    - name: Checkout
      uses: actions/checkout@v3
    
    - name: Set up JDK 21
      uses: actions/setup-java@v3
      with:
        java-version: '21'
        distribution: 'temurin'
    
    - name: Set up Maven
      uses: actions/setup-java@v3
      with:
        java-version: '21'
        distribution: 'temurin'
        cache: 'maven'
    
    - name: Build Plugins
      run: |
        cd plugins/ruyisdk-eclipse-plugins
        mvn clean verify
    
    - name: Build IDE
      run: |
        cd package/ruyisdk-eclipse-packages
        mvn clean verify -Pepp.package.embedcpp -Pepp.materialize-products
    
    - name: Upload Artifacts
      uses: actions/upload-artifact@v3
      with:
        name: ruyisdk-ide
        path: package/ruyisdk-eclipse-packages/packages/org.eclipse.epp.package.embedcpp.product/target/products/*.tar.gz
```

---

## 故障排除

### 问题 1: 构建失败 "Cannot resolve dependencies"

**症状**:
```
[ERROR] Cannot resolve dependencies of project...
[ERROR] Missing requirement: ...
```

**解决**:
```bash
# 1. 检查网络连接
ping download.eclipse.org

# 2. 清理 Maven 缓存
rm -rf ~/.m2/repository/p2

# 3. 使用 -U 强制更新
mvn clean verify -U

# 4. 检查代理设置（如果需要）
vim ~/.m2/settings.xml
```

### 问题 2: 磁盘空间不足

**症状**:
```
[ERROR] No space left on device
```

**解决**:
```bash
# 检查空间
df -h

# 清理 Maven 缓存
mvn clean
rm -rf ~/.m2/repository

# 清理系统缓存
sudo apt clean  # Ubuntu/Debian
sudo dnf clean all  # Fedora

# 或挂载新磁盘
```

### 问题 3: 内存不足

**症状**:
```
java.lang.OutOfMemoryError: Java heap space
```

**解决**:
```bash
# 增加 Maven 内存
export MAVEN_OPTS="-Xmx4096m -XX:MaxPermSize=1024m"

# 或添加到 ~/.bashrc
echo 'export MAVEN_OPTS="-Xmx4096m -XX:MaxPermSize=1024m"' >> ~/.bashrc
source ~/.bashrc
```

### 问题 4: IDE 无法启动

**症状**:
```
./ruyisdk
# 没有反应或报错
```

**解决**:
```bash
# 1. 检查权限
chmod +x ruyisdk

# 2. 查看日志
cat workspace/.metadata/.log

# 3. 检查 Java 版本
java -version

# 4. 尝试调试模式
./ruyisdk -consolelog -debug

# 5. 检查依赖库
ldd ruyisdk
```

### 问题 5: RuyiSDK 插件未包含

**症状**: IDE 启动后没有 RuyiSDK 插件

**解决**:
```bash
# 1. 检查插件是否在 IDE 中
cd ruyisdk/plugins
ls | grep ruyisdk

# 2. 如果没有，检查构建配置
cd ~/ruyiSDK/package/ruyisdk-eclipse-packages
grep "ruyisdk.plugins.repository" -r releng/
grep "org.ruyisdk.feature" packages/org.eclipse.epp.package.embedcpp.product/epp.product

# 3. 确认插件已构建
ls ~/ruyiSDK/plugins/ruyisdk-eclipse-plugins/repository/target/repository/plugins/ | grep ruyisdk

# 4. 重新构建
cd plugins/ruyisdk-eclipse-plugins && mvn clean install
cd ../../package/ruyisdk-eclipse-packages
mvn clean verify -Pepp.package.embedcpp -Pepp.materialize-products
```

---

## 测试清单

### 构建前检查
- [ ] Java 21+ 已安装
- [ ] Maven 3.9.0+ 已安装
- [ ] 磁盘空间足够（80GB+）
- [ ] MAVEN_OPTS 已设置

### 插件构建
- [ ] 构建成功无错误
- [ ] P2 仓库已生成
- [ ] 8 个插件 JAR 存在

### IDE 构建
- [ ] 构建成功无错误
- [ ] .tar.gz 文件已生成
- [ ] 文件大小合理（~350-500MB）

### IDE 测试
- [ ] IDE 能够启动
- [ ] 欢迎界面正常
- [ ] 所有 RuyiSDK 插件已包含
- [ ] 设备管理功能可用
- [ ] Ruyi 配置功能可用
- [ ] 包浏览器功能可用
- [ ] 项目创建功能可用

### 性能测试
- [ ] 启动时间合理（< 30秒）
- [ ] 响应流畅
- [ ] 无内存泄漏
- [ ] 无崩溃

---

## 总结

✅ **Linux 是测试 RuyiSDK IDE 的最佳平台**

**优势**:
- ✅ 可以测试完整的 IDE 构建
- ✅ 可以测试最终用户体验
- ✅ 真实的目标平台环境
- ✅ 易于 CI/CD 集成

**测试流程**:
1. 快速测试：安装插件验证功能（10 分钟）
2. 完整测试：构建 IDE 并测试（60 分钟）

**推荐顺序**:
1. Windows 快速验证插件功能 ✅
2. Linux 完整 IDE 构建和测试 ← **当前**
3. RISC-V64 最终验证（可选）

**构建命令快速参考**:
```bash
# 构建插件
cd ~/ruyiSDK/plugins/ruyisdk-eclipse-plugins
mvn clean verify

# 构建 IDE
cd ~/ruyiSDK/package/ruyisdk-eclipse-packages
mvn clean verify -Pepp.package.embedcpp -Pepp.materialize-products

# 测试 IDE
cd packages/org.eclipse.epp.package.embedcpp.product/target/products
tar -xzf ruyisdk-0.0.3-linux.gtk.x86_64.tar.gz
cd ruyisdk && ./ruyisdk
```

