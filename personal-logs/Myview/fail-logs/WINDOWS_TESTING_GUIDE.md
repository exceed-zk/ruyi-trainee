# Windows 上测试 RuyiSDK Eclipse 插件指南

## 适用场景

✅ **完全适合** Windows 平台测试：
- 测试插件安装（方式 2：单独更新）
- 验证插件功能
- 开发和调试插件

⚠️ **部分限制**：
- 最终的 IDE 产品（.tar.gz）主要面向 Linux
- 但可以在 Windows 上构建和测试插件本身

---

## 快速测试指南（Windows 版）

### 前提条件

1. **已安装 Eclipse IDE**
   - 推荐：Eclipse IDE for Java EE Developers 或 Eclipse IDE for RCP and RAP Developers
   - 版本要求：2024-09 (4.33) 或更高
   - 下载地址：https://www.eclipse.org/downloads/

2. **插件已构建**
   - P2 仓库位于：`D:\ruyiSDK\plugins\ruyisdk-eclipse-plugins\repository\target\repository`

---

## 测试步骤

### 步骤 1: 准备 Eclipse

#### 1.1 下载并安装 Eclipse（如果还没有）

```
访问：https://www.eclipse.org/downloads/packages/

推荐下载：
- Eclipse IDE for RCP and RAP Developers (2024-12)
  或
- Eclipse IDE for Java EE Developers (2024-12)

解压到：C:\eclipse 或任意目录
```

#### 1.2 启动 Eclipse

```
双击 eclipse.exe 启动

选择工作空间（Workspace）：
推荐新建一个测试工作空间：C:\eclipse-workspace-test
```

---

### 步骤 2: 安装 RuyiSDK 插件

#### 2.1 打开安装向导

在 Eclipse 中：
```
菜单栏 → Help → Install New Software...
```

![安装向导](screenshots/install-1.png)

#### 2.2 添加本地更新站点

1. 点击 **"Add..."** 按钮

2. 在弹出的对话框中：
   - **Name**: `RuyiSDK Local Repository`
   - 点击 **"Local..."** 按钮
   - 浏览并选择目录：`D:\ruyiSDK\plugins\ruyisdk-eclipse-plugins\repository\target\repository`
   - 点击 **"Select Folder"**
   - 点击 **"Add"**

![添加仓库](screenshots/install-2.png)

**重要提示**：确保选择的目录包含以下文件：
- `artifacts.jar`
- `content.jar`
- `plugins/` 文件夹
- `features/` 文件夹

#### 2.3 验证更新站点

添加成功后，应该能看到：
- 在下拉列表中显示 "RuyiSDK Local Repository"
- 下方列表中显示 "RuyiSDK IDE" 或 "RuyiSDK IDE Feature"

如果看不到任何内容：
- 取消勾选 "Group items by category"
- 确认路径正确
- 确认 P2 仓库已成功构建

#### 2.4 选择并安装

1. 勾选 **"RuyiSDK IDE Feature"** （或显示的特性名称）

2. 点击 **"Next >"**

3. 查看安装详情，应该看到 8 个插件：
   ```
   ✓ org.ruyisdk.core
   ✓ org.ruyisdk.devices
   ✓ org.ruyisdk.intro
   ✓ org.ruyisdk.news
   ✓ org.ruyisdk.packages
   ✓ org.ruyisdk.projectcreator
   ✓ org.ruyisdk.ruyi
   ✓ org.ruyisdk.ui
   ```

4. 点击 **"Next >"**

5. 接受许可协议
   - 选择 "I accept the terms of the license agreements"
   - 点击 **"Finish"**

#### 2.5 等待安装

- 安装过程可能需要 1-5 分钟
- 可以在右下角看到进度条
- 点击进度条可以展开查看详细信息

#### 2.6 信任证书（如果提示）

如果弹出安全警告：
```
"Warning: You are installing software that contains unsigned content..."
```

- 勾选要信任的内容
- 点击 **"Trust Selected"** 或 **"Install anyway"**

#### 2.7 重启 Eclipse

安装完成后会提示重启：
```
"Software Updates"
要使更改生效需要重启。是否立即重启？
```

点击 **"Restart Now"**

---

### 步骤 3: 验证安装

#### 3.1 检查已安装的软件

重启后：
```
菜单栏 → Help → About Eclipse IDE
点击 "Installation Details" 按钮
```

在 **"Installed Software"** 标签中：
- 搜索 "ruyisdk" 或 "RuyiSDK"
- 应该看到 RuyiSDK 相关的特性和插件

![已安装软件](screenshots/verify-1.png)

#### 3.2 检查插件详情

在 **"Plug-ins"** 标签中：
- 搜索 "org.ruyisdk"
- 应该看到所有 8 个 RuyiSDK 插件
- 版本号应该是 0.0.4.xxx

![插件列表](screenshots/verify-2.png)

---

### 步骤 4: 功能验证

#### 4.1 验证欢迎界面

```
菜单栏 → Help → Welcome
```

应该看到 RuyiSDK 定制的欢迎界面（如果 org.ruyisdk.intro 正常工作）

#### 4.2 验证首选项

```
菜单栏 → Window → Preferences
```

展开左侧树形菜单，查找 "RuyiSDK" 相关项：
- RuyiSDK → Devices（设备管理）
- RuyiSDK → Ruyi（Ruyi 包管理器配置）

![首选项](screenshots/verify-3.png)

#### 4.3 验证视图

```
菜单栏 → Window → Show View → Other...
```

搜索 "ruyisdk"，应该看到：
- RuyiSDK → Packages（包浏览器）
- 其他 RuyiSDK 相关视图

![视图列表](screenshots/verify-4.png)

#### 4.4 验证项目向导

```
菜单栏 → File → New → Project...
```

展开分类，查找 "RuyiSDK"：
- 应该看到 RuyiSDK 项目创建向导

![项目向导](screenshots/verify-5.png)

#### 4.5 测试创建项目（可选）

尝试创建一个 RuyiSDK 项目：
1. File → New → Project → RuyiSDK → RuyiSDK Project
2. 输入项目名称
3. 选择开发板（如 milkv-duo）
4. 完成向导
5. 检查项目是否正常创建

---

## 测试检查清单

### ✅ 必需验证项

- [ ] Eclipse 版本 ≥ 2024-09
- [ ] 插件安装成功（8 个插件）
- [ ] 版本号正确（0.0.4.xxx）
- [ ] 无错误日志

### ✅ 功能验证项

- [ ] 欢迎界面显示正常
- [ ] Preferences 中有 RuyiSDK 配置项
- [ ] 设备管理可以打开
- [ ] Ruyi 配置可以打开
- [ ] 包浏览器视图可以打开
- [ ] 项目创建向导可用
- [ ] 能够创建 RuyiSDK 项目

### ✅ 稳定性验证

- [ ] Eclipse 启动无错误
- [ ] 没有崩溃或异常
- [ ] Error Log 中无严重错误
- [ ] 插件功能响应正常

---

## 常见问题

### 问题 1: 找不到更新站点内容

**症状**: 添加本地仓库后，列表中没有显示任何内容

**原因**:
- P2 仓库路径不正确
- P2 仓库未成功生成

**解决方案**:
1. 确认路径：
   ```
   D:\ruyiSDK\plugins\ruyisdk-eclipse-plugins\repository\target\repository
   ```

2. 检查该目录是否包含：
   ```
   dir D:\ruyiSDK\plugins\ruyisdk-eclipse-plugins\repository\target\repository
   
   应该看到：
   - artifacts.jar
   - content.jar
   - plugins\
   - features\
   ```

3. 如果文件不存在，重新构建：
   ```bash
   cd D:\ruyiSDK\plugins\ruyisdk-eclipse-plugins
   mvn clean verify
   ```

4. 在 Eclipse 安装界面取消勾选 "Group items by category"

### 问题 2: 安装时出现依赖错误

**症状**: 
```
Cannot complete the install because one or more required items could not be found.
Missing requirement: org.ruyisdk.xxx requires 'bundle org.xxx'
```

**原因**: 缺少某些依赖的 Eclipse 组件

**解决方案**:
1. 确保使用的 Eclipse 版本 ≥ 2024-09
2. 安装完整的 Eclipse IDE，推荐：
   - Eclipse IDE for RCP and RAP Developers
   - Eclipse IDE for Java EE Developers

### 问题 3: Eclipse 版本太旧

**症状**: 插件安装后无法启动或报错

**原因**: Eclipse 版本 < 2024-09

**解决方案**:
1. 下载最新的 Eclipse：
   - https://www.eclipse.org/downloads/packages/
   - 选择 2024-12 版本

2. 或者更新现有 Eclipse：
   - Help → Check for Updates

### 问题 4: 插件安装后无法使用

**症状**: 插件显示已安装，但功能菜单找不到

**原因**: 
- 插件未正确激活
- 依赖项缺失
- 工作空间配置问题

**解决方案**:
1. 查看 Error Log：
   ```
   Window → Show View → Other... → General → Error Log
   ```
   查看是否有错误信息

2. 尝试重置透视图：
   ```
   Window → Perspective → Reset Perspective...
   ```

3. 使用新的工作空间：
   ```
   File → Switch Workspace → Other...
   创建新的工作空间
   ```

### 问题 5: 无法创建 RuyiSDK 项目

**症状**: 项目创建向导中缺少选项或创建失败

**原因**: 模板文件或配置缺失

**解决方案**:
1. 检查 org.ruyisdk.projectcreator 插件是否已安装
2. 查看 Error Log 中的具体错误
3. 确认 templates 目录是否正确打包

---

## 查看日志

如果遇到问题，查看详细日志：

### Error Log 视图
```
Window → Show View → Other... → General → Error Log
```

### 工作空间日志文件
```
位置：<workspace>/.metadata/.log

Windows 示例：
C:\eclipse-workspace-test\.metadata\.log
```

### Eclipse 配置信息
```
Help → About Eclipse IDE → Installation Details → Configuration
```

---

## 调试技巧

### 以调试模式启动 Eclipse

1. 创建快捷方式到 `eclipse.exe`
2. 添加参数：`-consolelog -debug`
3. 使用该快捷方式启动 Eclipse
4. 打开控制台查看详细日志

### 启用详细日志

创建文件：`eclipse\configuration\.options`
```
# RuyiSDK 插件调试
org.ruyisdk.core/debug=true
org.ruyisdk.devices/debug=true
org.ruyisdk.ruyi/debug=true
```

重启 Eclipse，会输出更详细的调试信息。

---

## Windows 特定注意事项

### 1. 路径问题

Windows 路径使用反斜杠 `\`，在某些配置中可能需要使用正斜杠 `/` 或双反斜杠 `\\`

**正确的路径格式**:
```
D:\ruyiSDK\plugins\ruyisdk-eclipse-plugins\repository\target\repository
或
D:/ruyiSDK/plugins/ruyisdk-eclipse-plugins/repository/target/repository
```

### 2. 权限问题

确保对以下目录有读写权限：
- Eclipse 安装目录
- 工作空间目录
- P2 仓库目录

### 3. 防火墙/杀毒软件

某些杀毒软件可能会干扰 Eclipse：
- 将 Eclipse 目录添加到白名单
- 临时禁用实时保护进行测试

### 4. 长路径支持

Windows 10/11 可能需要启用长路径支持：
```
运行 regedit
导航到：HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem
修改：LongPathsEnabled = 1
```

---

## 完整测试清单（Windows 版）

### 环境准备
- [ ] 已安装 Java 21+
- [ ] 已安装 Maven 3.9.0+
- [ ] 已下载 Eclipse 2024-09+
- [ ] 插件已成功构建

### 安装测试
- [ ] 成功添加本地更新站点
- [ ] 能看到 RuyiSDK 特性
- [ ] 安装过程无错误
- [ ] Eclipse 重启成功

### 功能测试
- [ ] 所有 8 个插件已安装
- [ ] 欢迎界面显示正常
- [ ] Preferences 配置可用
- [ ] 视图可以打开
- [ ] 项目向导可用
- [ ] 能创建测试项目

### 稳定性测试
- [ ] Eclipse 启动稳定
- [ ] 无严重错误日志
- [ ] 功能响应正常
- [ ] 多次重启正常

---

## 测试报告模板（Windows 版）

```markdown
## RuyiSDK Eclipse 插件 Windows 测试报告

**测试日期**: YYYY-MM-DD
**测试人员**: [您的名字]

### 测试环境
- **操作系统**: Windows 10/11
- **Java 版本**: 21.x.x
- **Maven 版本**: 3.9.x
- **Eclipse 版本**: 2024-09 / 2024-12
- **Eclipse 类型**: [RCP/Java EE/其他]

### 插件构建
- [ ] ✅ 构建成功
- [ ] ✅ P2 仓库生成
- [ ] ✅ 所有 8 个插件 JAR 存在

### 安装测试
- [ ] 成功添加本地更新站点
- [ ] 能看到 RuyiSDK 特性
- [ ] 安装过程：[顺利/有警告/失败]
- [ ] 重启后插件激活：[是/否]

### 功能测试结果

#### 已安装插件验证
- [ ] org.ruyisdk.core - [版本号]
- [ ] org.ruyisdk.devices - [版本号]
- [ ] org.ruyisdk.intro - [版本号]
- [ ] org.ruyisdk.news - [版本号]
- [ ] org.ruyisdk.packages - [版本号]
- [ ] org.ruyisdk.projectcreator - [版本号]
- [ ] org.ruyisdk.ruyi - [版本号]
- [ ] org.ruyisdk.ui - [版本号]

#### 功能验证
- [ ] 欢迎界面：[正常/异常/未测试]
- [ ] 设备管理：[正常/异常/未测试]
- [ ] Ruyi 配置：[正常/异常/未测试]
- [ ] 包浏览器：[正常/异常/未测试]
- [ ] 项目创建：[正常/异常/未测试]

### 发现的问题
1. [问题描述]
   - 重现步骤：
   - 错误信息：
   - 严重程度：[严重/一般/轻微]

2. [问题描述]
   ...

### 截图
[附上关键步骤的截图]

### 总体评价
- [ ] ✅ 完全满足要求，功能正常
- [ ] ⚠️ 基本满足要求，有小问题
- [ ] ❌ 存在严重问题，需要修复

### 建议
[列出改进建议]
```

---

## 下一步

完成 Windows 测试后，您可以：

1. **记录测试结果**
   - 填写测试报告
   - 截图保存关键步骤

2. **修复发现的问题**（如果有）
   - 查看 Error Log
   - 调整插件代码
   - 重新构建和测试

3. **准备 Linux 测试**（可选）
   - 测试完整 IDE 构建
   - 验证 riscv64 平台

4. **准备发布**
   - 发布 P2 更新站点
   - 构建完整 IDE 产品
   - 编写用户文档

---

## 快速命令参考

### 检查 P2 仓库
```cmd
dir D:\ruyiSDK\plugins\ruyisdk-eclipse-plugins\repository\target\repository
dir D:\ruyiSDK\plugins\ruyisdk-eclipse-plugins\repository\target\repository\plugins
```

### 重新构建插件
```cmd
cd D:\ruyiSDK\plugins\ruyisdk-eclipse-plugins
mvn clean verify
```

### 查看日志
```cmd
notepad %WORKSPACE%\.metadata\.log
```

---

## 总结

✅ **在 Windows 上测试 RuyiSDK 插件完全可行**！

**优点**:
- 方便快捷，不需要 Linux 环境
- 图形界面操作，容易截图记录
- 可以完整测试插件所有功能
- 适合快速迭代开发和调试

**限制**:
- 无法测试最终 Linux IDE 产品
- 无法测试 riscv64 平台
- 但这些可以后续在 Linux/riscv64 系统上补充测试

**推荐流程**:
1. ✅ Windows 上测试插件功能（当前）← **从这里开始**
2. ⏭️ Linux 上测试完整 IDE 构建（后续）
3. ⏭️ riscv64 上验证运行（可选）

现在就可以开始在 Windows 的 Eclipse 中测试了！

