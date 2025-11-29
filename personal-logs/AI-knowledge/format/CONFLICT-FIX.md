# Formatter与Checkstyle冲突修复指南

> **创建时间**: 2025-11-23  
> **状态**: 待确认  

## 问题描述

`formatter:format` 和 `checkstyle:check` 之间存在配置冲突，会导致代码在两个检查之间无限循环修复。

## 冲突根源

### 1. Javadoc `<p>`标签格式

**Checkstyle要求** (`ruyisdk_ide_google_checks.xml` 第227-229行):
```xml
<module name="JavadocParagraph">
  <property name="allowNewlineParagraph" value="false"/>
</module>
```
- 要求: `<p>`标签后不允许换行
- 正确格式: `* <p>文本内容`

**Formatter行为** (`ruyisdk-eclipse-java-google-style.xml` 第8行):
```xml
<setting id="org.eclipse.jdt.core.formatter.comment.new_lines_at_block_boundaries" value="true"/>
```
- 会在`<p>`标签后自动添加换行
- 格式化结果: 
  ```java
  * <p>
  * 文本内容
  ```

### 2. 数组初始化缩进

**Checkstyle要求** (第179行):
```xml
<module name="Indentation"/>
```
- 数组元素缩进: 12个空格 (基础缩进4 × 3层)

**Formatter行为** (第16, 20, 329行):
```xml
<setting id="org.eclipse.jdt.core.formatter.indentation.size" value="4"/>
<setting id="org.eclipse.jdt.core.formatter.continuation_indentation" value="4"/>
<setting id="org.eclipse.jdt.core.formatter.continuation_indentation_for_array_initializer" value="4"/>
```
- 数组元素缩进: 16-20个空格

---

## 目前解决方案

### 修改 1: JavaDoc 段落格式规则

**文件**: `docs/developer/coding-guidelines/ruyisdk_ide_google_checks.xml`  
**行号**: 227-229

#### 修改前

```xml
<module name="JavadocParagraph">
  <property name="allowNewlineParagraph" value="false"/>
</module>
```

#### 修改后

```xml
<module name="JavadocParagraph">
  <property name="allowNewlineParagraph" value="true"/>
</module>
```

#### 修改原因

- **冲突描述**: 

  - Eclipse Formatter 会在 JavaDoc 的 `<p>` 标签后自动添加换行
  - Checkstyle 原配置要求 `<p>` 标签必须紧邻文字，不允许换行
  - 导致格式化后的代码无法通过 checkstyle 检查

- **具体表现**:

  ```java
  // Formatter 格式化结果
  /**
   * Description.
   *
   * <p>
   * Additional paragraph content.
   */
  
  // Checkstyle 期望格式
  /**
   * Description.
   *
   * <p>Additional paragraph content.
   */
  ```

- **解决方案**: 放宽规则，允许 `<p>` 标签后换行

### 修改 2: 禁用缩进检查

**文件**: `docs/developer/coding-guidelines/ruyisdk_ide_google_checks.xml`  
**行号**: 179-180

#### 修改前

```xml
<module name="Indentation"/>
<module name="SuppressionXpathSingleFilter">
  <property name="checks" value="Indentation"/>
  <property name="query" value="//SLIST[not(parent::CASE_GROUP)]/SLIST | //SLIST[not(parent::CASE_GROUP)]/SLIST/RCURLY"/>
</module>
```

#### 修改后

```xml
<!-- Indentation check disabled to avoid conflicts with formatter -->
<!-- <module name="Indentation"/> -->
<module name="SuppressionXpathSingleFilter">
  <property name="checks" value="Indentation"/>
  <property name="query" value="//SLIST[not(parent::CASE_GROUP)]/SLIST | //SLIST[not(parent::CASE_GROUP)]/SLIST/RCURLY | //ARRAY_INIT"/>
</module>
```

#### 修改原因

- **冲突描述**:

  - Checkstyle Indentation 默认要求数组初始化缩进 12 个空格（3×基础缩进4）
  - Eclipse Formatter 使用 continuation indentation，产生 24 个空格（6×基础缩进4）
  - 无法通过配置参数完全对齐两者的缩进计算逻辑

- **具体表现**:

  ```java
  // Formatter 格式化结果（24空格）
  String[][] array = {
                          {"a", "b"},
                          {"c", "d"}};
  
  // Checkstyle 期望（12空格）
  String[][] array = {
            {"a", "b"},
            {"c", "d"}};
  ```

- **尝试的方案**:

  1. ❌ 调整 `arrayInitIndent` 参数 - 无效
  2. ❌ 调整 `lineWrappingIndentation` 参数 - 部分有效但不全面
  4. ✅ 完全禁用 Indentation 检查 - 最终方案
  
- **解决方案**: 完全禁用 Indentation 模块，由 formatter 统一管理缩进

---

## 冲突影响范围

| 冲突类型 | 受影响文件数 | 严重程度 |
|---------|------------|---------|
| JavaDoc `<p>`标签 | ~10个 | 中等 |
| 数组缩进 | ~5个 | 低 |
| **总计** | **~15个** | **中等** |

---

## 验证步骤

修改配置后，运行以下命令验证:

```bash
# 1. 清理项目
mvn clean

# 2. 运行formatter
mvn formatter:format

# 3. 检查checkstyle
mvn checkstyle:check

# 4. 验证formatter
mvn formatter:validate

# 5. 完整验证
mvn clean checkstyle:check formatter:validate
```

**预期结果**: 

![image-20251124110201952](https://cdn.jsdelivr.net/gh/exceed-zk/BlogImages@main/zk/image-20251124110201952.png)

---

## 参考资料

- [Checkstyle JavadocParagraph](https://checkstyle.sourceforge.io/config_javadoc.html#JavadocParagraph)
- [Checkstyle Indentation](https://checkstyle.sourceforge.io/config_misc.html#Indentation)
- [Eclipse Formatter Guide](https://help.eclipse.org/latest/topic/org.eclipse.jdt.doc.user/reference/preferences/java/codestyle/ref-preferences-formatter.htm)
- [Google Java Style Guide](https://google.github.io/styleguide/javaguide.html)

