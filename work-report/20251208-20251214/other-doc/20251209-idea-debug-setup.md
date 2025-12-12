# IDEA 中调试 Eclipse 插件配置指南

**日期**：2024年12月9日  
**问题**：IDEA 中调试 Eclipse 插件时断点无法触发  
**根本原因**：IDEA 未正确编译源代码，导致 Eclipse 开发模式无法加载类文件

---

## 1. 问题诊断

### 1.1 核心问题

Eclipse 插件开发模式（`-dev` 模式）通过 `dev.properties` 文件加载开发中的类文件：

```properties
# classes/partial-runtime/config/dev.properties
org.ruyisdk.core=out/production,out/test
org.ruyisdk.ruyi=out/production,out/test
# ...
```

**问题现象**：
- 启动 Eclipse 后出现 `ClassNotFoundException`
- IDEA 中设置的断点不会被触发
- `out/production` 目录为空或不存在

**根本原因**：
1. IDEA 没有将 `src` 目录标记为源代码目录
2. Maven 重新加载时覆盖了模块配置
3. 简化的 `pom.xml` 文件被删除，导致 IDEA 不识别模块

---

## 2. 解决方案

### 2.1 确保简化 POM 文件存在

每个插件模块需要一个简化的 `pom.xml`（与 `pom.tycho` 并存）：

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0
         http://maven.apache.org/xsd/maven-4.0.0.xsd">
  <modelVersion>4.0.0</modelVersion>

  <parent>
    <groupId>org.ruyisdk</groupId>
    <artifactId>plugins</artifactId>
    <version>0.0.5-SNAPSHOT</version>
  </parent>

  <artifactId>org.ruyisdk.core</artifactId>
  <packaging>eclipse-plugin</packaging>

  <build>
    <directory>${project.basedir}/out</directory>
    <outputDirectory>${project.basedir}/out/production</outputDirectory>
    <testOutputDirectory>${project.basedir}/out/test</testOutputDirectory>
  </build>

</project>
```

**注意**：
- ❌ **不要**在简化 POM 中添加 `<dependencies>`
- ✅ 模块间依赖由 `MANIFEST.MF` 中的 `Require-Bundle` 定义
- ✅ 编译输出目录指向模块本地的 `out/production`

### 2.2 清除缓存并重新索引

当 IDEA 无法识别模块或配置混乱时：

```
File → Invalidate Caches...
→ 勾选所有选项
→ Invalidate and Restart
```

等待 IDEA 重新启动并完成索引（5-10 分钟）。

### 2.3 配置源代码目录

打开项目结构：`File → Project Structure → Modules`

对每个插件模块（8个）：
1. 选择模块（如 `org.ruyisdk.core`）
2. 切换到 **Sources** 标签
3. 确认 `src` 目录显示为**蓝色**（已标记为 Sources Root）
4. 如果不是蓝色：右键 `src` → **Mark Directory as → Sources Root**

### 2.4 添加 Eclipse SDK 依赖（可选但推荐）

为了永久解决代码补全和依赖识别问题：

1. `File → Project Structure → Libraries`
2. 点击 `+` → **Java**
3. 浏览到 Eclipse 安装目录的 `plugins` 文件夹：
   ```
   D:\Eclipse\new\eclipse-rcp-2025-09-R-win32-x86_64\eclipse\plugins
   ```
4. 命名为 `Eclipse-SDK-2025-09`
5. 将库应用到所有插件模块
6. 设置 **Scope** 为 **Provided**

### 2.5 处理模块内的 JAR 依赖

某些模块（如 `org.ruyisdk.packages`）包含 `lib` 目录中的 jar 文件：

**方法 1：代码快速修复**
1. 打开有错误的 Java 文件
2. 将光标放在红色错误的 import 语句上
3. 按 `Alt + Enter`
4. 选择 "Add library ... to classpath"

**方法 2：手动编辑 .iml 文件**
```xml
<!-- plugins/org.ruyisdk.packages/org.ruyisdk.packages.iml -->
<orderEntry type="module-library">
  <library>
    <CLASSES>
      <root url="jar://$MODULE_DIR$/lib/javax.json-1.1.4.jar!/" />
    </CLASSES>
    <JAVADOC />
    <SOURCES />
  </library>
</orderEntry>
```

### 2.6 重新构建项目

```
Build → Rebuild Project
```

等待构建完成，验证：
- `plugins/*/out/production` 目录存在
- 包含编译后的 `.class` 文件

---

## 3. 启动调试

### 3.1 设置断点

在 `Activator.java` 的 `start()` 方法中设置断点：

```java
@Override
public void start(BundleContext context) throws Exception {
    super.start(context);  // ← 在此行设置断点
    plugin = this;
}
```

### 3.2 启动调试模式

点击 IDEA 右上角的 **Debug** 按钮（虫子图标🐛）

或：`Run → Debug 'RuyiSDK Eclipse Plugins'`

### 3.3 验证成功

- Eclipse 窗口启动
- IDEA 在断点处暂停
- 可以查看变量、单步执行等

---

## 4. 常见问题

### 4.1 Maven 重新加载后配置丢失

**原因**：Maven 管理的模块配置会被覆盖

**解决方案**：
- 添加 Eclipse SDK 为项目库（Scope: Provided）
- 避免频繁重新加载 Maven
- 必要时手动重新配置源代码目录

### 4.2 编译产物仍然不存在

**检查清单**：
1. ✅ `src` 目录是否标记为 Sources Root（蓝色）
2. ✅ `.iml` 文件是否存在
3. ✅ Maven 工具窗口中是否能看到所有模块
4. ✅ 是否执行了 `Rebuild Project`

**终极解决方案**：
1. 关闭项目
2. 删除 `.idea` 目录
3. 重新打开项目
4. 重新配置 Eclipse PDE Partial
5. 按照本文档 2.3-2.6 步骤操作

### 4.3 dev.properties 路径不正确

**问题**：路径为相对路径，Eclipse 找不到类

**检查**：
```properties
# classes/partial-runtime/config/dev.properties
# 正确：相对路径即可
org.ruyisdk.core=out/production,out/test
```

Eclipse PDE Partial 插件会自动处理相对路径。

---

## 5. 工作流程总结

### 5.1 一次性配置（首次设置）

1. ✅ 确保所有插件模块有简化的 `pom.xml`
2. ✅ Invalidate Caches 并重启
3. ✅ 标记所有 `src` 目录为 Sources Root
4. ✅ 添加 Eclipse SDK 为项目库（推荐）
5. ✅ Rebuild Project

### 5.2 日常开发工作流

```
编写代码 → Build → Debug → 修改 → Build → Debug
```

**不需要**每次都 Maven Clean 或重新配置！

### 5.3 遇到问题时

1. 检查 `out/production` 是否有 `.class` 文件
2. 检查 `src` 目录是否仍为蓝色
3. 如有疑问，执行 `Build → Rebuild Project`

---

## 6. 与 Maven/Tycho 构建的关系

| 构建方式 | 配置文件 | 输出目录 | 用途 |
|---------|---------|---------|------|
| **IDEA 编译** | pom.xml | `out/production` | **开发调试** ⭐ |
| **Maven/Tycho** | pom.tycho | `target` | 正式构建、CI/CD |

**重要**：
- 开发调试使用 IDEA 编译
- 正式构建使用 Maven/Tycho
- 两者互不干扰

---

## 7. 参考资料

- Eclipse PDE Partial 插件文档
- `MANIFEST.MF` 中的 `Bundle-ClassPath` 配置
- `dev.properties` 文件格式

---

**文档版本**：v1.0  
**最后更新**：2024-12-09  
**维护者**：exceed-zk
