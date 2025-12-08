# RuyiSDK 实习周报 第 09 期·2025 年 12 月 07 日

## 本周工作概述

本周主要完成了以下工作：
- 在 IntelliJ IDEA 中配置 Eclipse 插件开发环境
- 调研并解决 IDEA 与 Eclipse 插件开发的兼容性问题
- 完成 Eclipse PDE Partial 插件配置
- 建立完整的开发调试工作流

---

## 提交的 patch

### 本周提交情况

本周主要进行开发环境调研和配置工作，未产生代码提交。

**说明**：由于本周专注于解决 IDEA 开发环境配置问题，包括插件兼容性调研、Maven 配置优化、运行调试环境搭建等基础设施工作，暂无功能性代码提交。

---

## 开发环境配置

### IDEA 插件安装

**任务目标**：在 IntelliJ IDEA 中配置 Eclipse 插件开发环境

**完成情况**：
- ✅ 安装 Eclipse PDE Partial 插件
- ✅ 配置 Maven 支持（IDEA 内置）
- ✅ 安装 Jclasslib 调试工具

**插件说明**：

1. **Eclipse PDE Partial** -- 核心插件
   - 提供 MANIFEST.MF 和 plugin.xml 编辑增强
   - 支持本地运行配置（Eclipse Application Partial）
   - 提供目标平台配置（Eclipse Target）
   - **限制**：v1.6.8 后不支持远程调试

2. **Maven 插件**（IDEA 内置 -- 需要改一些配置）
   - 支持 Maven/Tycho 项目构建
   - 提供依赖管理
   - 集成生命周期命令

3. **Jclasslib**（目前不知道为什么不行）
   - 调试时查看线程调用栈
   - 查看变量值（包括复杂类型如 List）

---

## 技术调研

### Polyglot Maven 兼容性调研

**问题**：项目使用 `.polyglot.pom.tycho` 文件，IDEA 无法直接识别

**调研结论**：
- ❌ Polyglot Maven 插件 0.8.1 不支持 Maven 3.9.x
- ❌ 项目要求 Maven 3.9.0+，版本不兼容
- ✅ 解决方案：为 IDEA 创建简化的 `pom.xml` 文件

**参考资料**：
- [takari/polyglot-maven](https://github.com/takari/polyglot-maven)
- [Polyglot Translate Plugin](https://mvnrepository.com/artifact/io.takari.polyglot/polyglot-translate-plugin)

### IDEA 中开发 Eclipse 插件的方案调研

**参考文章**：
- [如何使用IntelliJ IDEA进行Eclipse插件开发？](https://dev59.com/RV8e5IYBdhLWcg3wEG7A)
- [Eclipse与IntelliJ IDEA插件完美融合](https://www.oryoy.com/news/jie-mi-eclipse-yu-intellij-idea-cha-jian-wan-mei-rong-he-gao-xiao-kai-fa-yi-bu-dao-wei.html)

**方案选择**：
采用 Eclipse PDE Partial 本地运行配置方式，配合 Maven/Tycho 构建

---

## 问题解决

### 问题 1：插件未加载到运行的 Eclipse

**问题现象**：
- Eclipse IDE 启动成功
- 但自定义插件未加载

**原因分析**：
- Eclipse PDE Partial 无法直接从 `.class` 文件加载插件
- 需要先通过 Maven/Tycho 构建生成 jar 包需要配置[路径](..\ruyisdk-eclipse-plugins\sites\repository\target\repository\plugins)

**解决方案**：
1. 运行 `mvn clean verify` 构建插件
2. 确保 Eclipse Target 包含构建输出目录
3. 重启 Eclipse Application 配置

**验证方法**：
- `Help → About Eclipse → Installation Details → Plugins`
- 搜索 "ruyisdk"
- ✅ 能看到 8 个 RuyiSDK 插件

---

## 文档整理

### 开发日志归档

**创建的文档**：

- [20251204（初版）.md](./other-doc/20251204（初版）.md)- 详细的配置过程记录
- 包含每日工作内容（12/4、12/6、12/7）

**文档内容**：
- Eclipse PDE Partial 插件配置
- Eclipse Target 配置步骤
- Facet 和运行配置详解
- 问题解决方案

---

## 本周总结

### 主要

1. **开发环境搭建完成**
   - ✅ IDEA 中成功配置 Eclipse 插件开发环境
   - ✅ 建立完整的开发调试工作流
   - ✅ 解决多个关键配置问题
2. **技术理解深入**
   - ✅ 掌握 Maven/Tycho 构建流程
   - ✅ 理解 IDEA 与 Eclipse 的差异

### 经验教训

1. **工具兼容性很重要**
   - Polyglot Maven 版本不兼容导致调研方向调整
   - 需要提前验证工具链的兼容性
2. **问题定位要准确**
   - 编辑器报错不一定是真实问题
   - 需要区分编辑器检查和实际构建

### 下周计划

**功能开发和优化**

- 基于已建立的开发环境开始功能开发
- 找寻Jclasslib不生效的原因，和自动补全的替代
- 优化一些临时方案

---

## 附录

### 参考资料

**调研文章**：
1. [如何使用IntelliJ IDEA进行Eclipse插件开发？](https://dev59.com/RV8e5IYBdhLWcg3wEG7A)
2. [Eclipse与IntelliJ IDEA插件完美融合](https://www.oryoy.com/news/jie-mi-eclipse-yu-intellij-idea-cha-jian-wan-mei-rong-he-gao-xiao-kai-fa-yi-bu-dao-wei.html)
3. [takari/polyglot-maven](https://github.com/takari/polyglot-maven)

