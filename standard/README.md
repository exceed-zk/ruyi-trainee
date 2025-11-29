# RuyiSDK 代码质量保障体系

## 📋 概述

RuyiSDK Eclipse Plugins 项目采用**双重代码质量检查机制**，确保代码同时符合**编码规范**和**格式标准**。

```
┌─────────────────────────────────────────────┐
│         RuyiSDK 代码质量保障体系             │
├─────────────────────────────────────────────┤
│                                              │
│  1️⃣ Checkstyle 代码规范检查                 │
│     ├─ 命名规范（类、方法、变量）             │
│     ├─ JavaDoc 要求                          │
│     ├─ 代码结构                              │
│     └─ 复杂度控制                            │
│                                              │
│  2️⃣ Formatter 代码格式验证                  │
│     ├─ 缩进和空格                            │
│     ├─ 换行和大括号                          │
│     ├─ 行长度限制                            │
│     └─ 格式一致性                            │
│                                              │
└─────────────────────────────────────────────┘
        ↓                      ↓
   Eclipse IDE            CI 自动检查
```

## 🗂️ 配置文件清单

| 文件名 | 用途 | CI 检查 | IDE 使用 |
|--------|------|---------|---------|
| `ruyisdk_ide_google_checks.xml` | Checkstyle 代码规范配置 | ✅ 是 | ✅ 是 |
| `ruyisdk-eclipse-java-google-style.xml` | Eclipse 代码格式化器配置 | ✅ 是 | ✅ 是 |
| `ruyisdk-eclipse-java-codetemplates.xml` | Eclipse 代码模板配置 | ❌ 否 | ✅ 是 |

## 🚀 快速开始

### 方式 1：仅关注 CI 配置（开发者）

如果您只关心 CI 如何检查代码，请查看：

1. **[CI代码风格检查配置说明.md](./CI代码风格检查配置说明.md)** ⭐ 推荐
   - Checkstyle 配置详解
   - pom.xml 修改说明
   - 本地命令使用

2. **[CI代码格式验证配置说明.md](./CI代码格式验证配置说明.md)** ⭐ 推荐
   - Formatter 配置详解
   - 格式验证说明
   - 常见问题解决

### 方式 2：完整配置（新加入团队）

如果您是新加入团队，需要完整配置开发环境：

#### Step 1: Eclipse IDE 配置

##### 1.1 导入 Checkstyle 配置
```
Window → Preferences → Checkstyle
    ↓
New... → External Configuration File
    Name: RuyiSDK Google Checks
    Location: ruyisdk_ide_google_checks.xml
    ↓
激活到项目:
    右键项目 → Properties → Checkstyle
    ☑ Checkstyle active for this project
    选择 "RuyiSDK Google Checks"
```

##### 1.2 导入代码格式化器
```
Window → Preferences → Java → Code Style → Formatter
    ↓
Import... → 选择 ruyisdk-eclipse-java-google-style.xml
    Active profile: GoogleStyle
```

**使用**: `Ctrl + Shift + F` (Windows/Linux) 或 `Cmd + Shift + F` (Mac)

##### 1.3 导入代码模板
```
Window → Preferences → Java → Code Style → Code Templates
    ↓
Import... → 选择 ruyisdk-eclipse-java-codetemplates.xml
```

**使用**: 输入 `/**` 后按 Enter 自动生成 JavaDoc

##### 1.4 配置保存时自动操作（推荐）
```
Window → Preferences → Java → Editor → Save Actions
    ↓
☑ Perform the selected actions on save
☑ Format source code
☑ Organize imports
☑ Additional actions → Configure
    ☑ Remove trailing whitespace
    ☑ Add missing '@Override' annotations
```

#### Step 2: 验证配置

**本地验证**:
```bash
# 1. 检查代码规范
mvn checkstyle:check

# 2. 验证代码格式
mvn formatter:validate

# 3. 完整检查
mvn clean verify
```

## 📚 详细文档索引

### CI 配置文档（给开发者）

| 文档 | 内容 | 适用场景 |
|------|------|---------|
| **[CI代码风格检查配置说明.md](./CI代码风格检查配置说明.md)** | Checkstyle 配置和使用 | 了解代码规范检查 |
| **[CI代码格式验证配置说明.md](./CI代码格式验证配置说明.md)** | Formatter 配置和使用 | 了解代码格式验证 |

### 规则详解文档（给代码审查者）

| 文档 | 内容 | 适用场景 |
|------|------|---------|
| **[ruyisdk_ide_google_checks说明文档.md](./ruyisdk_ide_google_checks说明文档.md)** | Checkstyle 每条规则详解 | 理解为什么代码不符合规范 |
| **[ruyisdk-eclipse-java-codetemplates说明文档.md](./ruyisdk-eclipse-java-codetemplates说明文档.md)** | 代码模板详解 | 定制代码模板 |

## 🔧 常用操作

### 检查代码

| 操作 | 命令 | 说明 |
|------|------|------|
| 检查代码规范 | `mvn checkstyle:check` | 不修改文件 |
| 验证代码格式 | `mvn formatter:validate` | 不修改文件 |
| 完整检查 | `mvn clean verify` | 包含所有检查 |

### 修复问题

| 操作 | 方法 | 说明 |
|------|------|------|
| 格式化代码 | Eclipse: `Ctrl+Shift+F` | 推荐 |
| 自动格式化 | `mvn formatter:format` | 修改文件 |
| 整理 imports | Eclipse: `Ctrl+Shift+O` | - |
| 生成 JavaDoc | 输入 `/**` 后按 Enter | - |

### 跳过检查（不推荐）

| 操作 | 命令 |
|------|------|
| 跳过 Checkstyle | `mvn clean verify -Dcheckstyle.skip=true` |
| 跳过 Formatter | `mvn clean verify -Dformatter.skip=true` |
| 跳过所有检查 | `mvn clean verify -Dcheckstyle.skip=true -Dformatter.skip=true` |

## 🎯 代码规范核心要点

### Google Java Style 关键规则

| 类别 | 规则 | 示例 |
|------|------|------|
| **缩进** | 4 个空格，不使用 Tab | `    ` |
| **行长度** | 代码最大 120 字符<br>注释最大 100 字符 | - |
| **大括号** | K&R 风格（行尾） | `if (x) {` |
| **空格** | 运算符前后有空格 | `a + b` |
| **命名** | 类: PascalCase<br>方法: camelCase | `MyClass`<br>`myMethod()` |
| **JavaDoc** | 公共 API 必须有 | `/** ... */` |

### 代码示例对比

#### ✅ 正确的代码

```java
/*
 * Copyright (c) 2025 ISCAS.
 *
 * SPDX-License-Identifier: EPL-2.0
 */
package com.example;

import java.util.List;
import java.util.ArrayList;

/**
 * Example class demonstrating Google Java Style.
 *
 * @author developer
 * @since 1.0
 */
public class MyClass {
    private static final int MAX_SIZE = 100;
    private String name;
    
    /**
     * Constructor.
     *
     * @param name the name
     */
    public MyClass(String name) {
        this.name = name;
    }
    
    /**
     * Gets the name.
     *
     * @return the name
     */
    public String getName() {
        return name;
    }
}
```

#### ❌ 错误的代码

```java
// 问题 1: 缺少版权声明
package com.example;

import java.util.*;  // 问题 2: 不要使用通配符 import

public class myClass {  // 问题 3: 类名应该用 PascalCase
    private String name;  // 问题 4: 缺少 JavaDoc
    
    // 问题 5: 构造函数缺少 JavaDoc
    public myClass(String name){  // 问题 6: 大括号前缺少空格
        this.name=name;  // 问题 7: = 前后应该有空格
    }
    
    public String getName(){return name;}  // 问题 8: 不应该在一行
}
```

## 🐛 常见问题

### Q1: CI 构建失败，如何快速修复？

**步骤**:
```bash
# 1. 查看 CI 日志，确定是 Checkstyle 还是 Formatter 失败

# 2. 本地重现问题
mvn checkstyle:check      # 如果是规范问题
mvn formatter:validate    # 如果是格式问题

# 3. 在 Eclipse 中打开有问题的文件

# 4. 修复问题
Ctrl+Shift+F              # 格式化
Ctrl+Shift+O              # 整理 imports
手动添加缺少的 JavaDoc     # 规范问题

# 5. 再次验证
mvn clean verify

# 6. 提交修复
git add .
git commit -m "fix: code style and format issues"
git push
```

### Q2: Checkstyle 和 Formatter 有什么区别？

| 维度 | Checkstyle | Formatter |
|------|-----------|-----------|
| **检查内容** | 代码规范（逻辑） | 代码格式（视觉） |
| **典型检查** | 命名、JavaDoc、复杂度 | 缩进、空格、换行 |
| **能否自动修复** | ❌ 大部分不能 | ✅ 完全可以 |
| **配置文件** | `ruyisdk_ide_google_checks.xml` | `ruyisdk-eclipse-java-google-style.xml` |
| **Maven 插件** | maven-checkstyle-plugin | formatter-maven-plugin |

### Q3: 如何在 Eclipse 中查看 Checkstyle 警告？

**步骤**:
1. 右键项目 → Checkstyle → Check Code with Checkstyle
2. 查看 Problems 视图（Window → Show View → Problems）
3. 筛选 Checkstyle 警告

### Q4: 格式化会破坏代码吗？

**A**: 不会。格式化只修改：
- ✅ 空格和缩进
- ✅ 换行位置
- ✅ 大括号位置

**不会修改**:
- ❌ 变量名
- ❌ 方法逻辑
- ❌ 注释内容

**建议**: 格式化前先提交代码到 Git，可以随时回滚。

### Q5: 某些文件需要排除检查怎么办？

**在 pom.xml 中配置**:

```xml
<!-- Checkstyle 排除 -->
<plugin>
  <groupId>org.apache.maven.plugins</groupId>
  <artifactId>maven-checkstyle-plugin</artifactId>
  <configuration>
    <excludes>**/generated/**/*,**/target/**/*</excludes>
  </configuration>
</plugin>

<!-- Formatter 排除 -->
<plugin>
  <groupId>net.revelc.code.formatter</groupId>
  <artifactId>formatter-maven-plugin</artifactId>
  <configuration>
    <excludes>
      <exclude>**/generated/**/*.java</exclude>
    </excludes>
  </configuration>
</plugin>
```

## 📊 CI 工作流程

```
┌────────────────────────────────────────────────┐
│  Developer Push/PR                              │
└──────────────────┬─────────────────────────────┘
                   ↓
┌────────────────────────────────────────────────┐
│  GitHub Actions Triggered                       │
└──────────────────┬─────────────────────────────┘
                   ↓
┌────────────────────────────────────────────────┐
│  mvn clean verify                               │
│    ↓                                            │
│  validate 阶段                                  │
│    ↓                                            │
│  ┌──────────────────────────────────────────┐  │
│  │ 1️⃣ Checkstyle 检查                       │  │
│  │    - 命名规范 ✓                          │  │
│  │    - JavaDoc ✓                          │  │
│  │    - 代码结构 ✓                          │  │
│  └──────────────────────────────────────────┘  │
│    ↓                                            │
│  ✅ 通过 / ❌ 失败 → 构建中断                   │
│    ↓                                            │
│  ┌──────────────────────────────────────────┐  │
│  │ 2️⃣ Formatter 验证                        │  │
│  │    - 缩进格式 ✓                          │  │
│  │    - 空格位置 ✓                          │  │
│  │    - 换行规则 ✓                          │  │
│  └──────────────────────────────────────────┘  │
│    ↓                                            │
│  ✅ 通过 / ❌ 失败 → 构建中断                   │
│    ↓                                            │
│  compile, test, package...                     │
└────────────────────────────────────────────────┘
```

## 🔗 相关资源

### 官方文档
- [Google Java Style Guide](https://google.github.io/styleguide/javaguide.html)
- [Checkstyle 官方文档](https://checkstyle.sourceforge.io/)
- [Eclipse Code Formatter](https://help.eclipse.org/latest/topic/org.eclipse.jdt.doc.user/reference/preferences/java/codestyle/ref-preferences-formatter.htm)

### Maven 插件
- [maven-checkstyle-plugin](https://maven.apache.org/plugins/maven-checkstyle-plugin/)
- [formatter-maven-plugin](https://code.revelc.net/formatter-maven-plugin/)

### 项目文档
- [CI代码风格检查配置说明](./CI代码风格检查配置说明.md)
- [CI代码格式验证配置说明](./CI代码格式验证配置说明.md)
- [Checkstyle 规则说明](./ruyisdk_ide_google_checks说明文档.md)
- [代码模板说明](./ruyisdk-eclipse-java-codetemplates说明文档.md)

## 📝 更新历史

| 日期 | 版本 | 更新内容 |
|------|------|---------|
| 2025-11-17 | 1.1 | 添加 Formatter 格式验证 |
| 2025-11-17 | 1.0 | 添加 Checkstyle 规范检查 |
| 2025-11 | 0.9 | 初始配置文件创建 |

---

**维护者**: RuyiSDK Team  
**最后更新**: 2025-11-17  
**文档版本**: 1.1
