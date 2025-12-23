# RuyiSDK 实习周报 第 10 期·2025 年 12 月 14 日

## (12-23补)：本周工作概述

本周主要完成了以下工作：

- 修复 Maven 编译器版本配置，统一强制使用 Java 17
- 梳理 IDEA + Eclipse 插件调试流程，补全缺失的简化 POM 配置
- 解决 IDEA 断点不生效、类加载缺失等调试问题
- 学习 jclasslib 使用方式，完善调试工具链
- 开始准备 VSCode 端的调试配置，评估跨 IDE 体验

---

## 提交的 patch

本周以环境修复和调试流程梳理为主，未向主仓库提交新的代码变更。

---

## 关键工作

### Maven 编译器版本修复

**背景**：Maven 构建报 “不支持发行版本 5”，与实际 Java 17 环境不符。  
**处理**：
- 在根 `pom.xml` 的 `<properties>` 中新增 `maven.compiler.source/target/release`，统一到 17
- 依据各插件 `MANIFEST.MF` 的 `JavaSE-17` 声明，保证构建和运行时一致
- `mvn clean verify` 验证通过，版本错误消失

### IDEA 调试与类加载问题

**诊断**：`dev.properties` 依赖 `out/production` 类文件，但 IDEA 未生成，导致断点不触发、`ClassNotFoundException`。  
**解决**：
- 为 8 个插件模块补全简化 `pom.xml`，输出目录统一指向 `out/production/out/test`
- 在 Project Structure 中将 `src` 目录标记为 Sources Root，必要时 Invalidate Caches & Restart
- 重新 Rebuild Project 后断点可命中，类加载恢复正常

### 调试工具与补全

- 探索 jclasslib 用于查看字节码与调用栈，确认可辅助调试
- 讨论补全插件需求，评估 OSGi 依赖在 IDEA 中的解析差异与可行方案

### VSCode 调试准备

- 启动 VSCode 配置工作，整理所需 `launch` 与调试配置文件
- 记录 IDEA 中索引易丢失的场景，为后续跨 IDE 调试做对比

---

## 问题与解决

1. **Maven 使用默认编译级别 5**  
   - 通过在根 POM 配置编译器属性统一为 17，构建恢复正常。
2. **IDEA 不产出 `out/production` 导致断点失效**  
   - 补全简化 POM、重新标记源目录并 Rebuild，`dev.properties` 可被正确解析。
3. **IDEA 显示 Eclipse API 丢失但构建可过**  
   - 说明 OSGi 依赖与 Maven classpath 差异，接受编辑器误报或通过添加 Eclipse 库缓解。

---

## 文档整理

- 更新并沉淀调试配置与问题记录：
  - `other-doc/20251208(初版).md`
  - `other-doc/20251209-idea-debug-setup.md`

---

## 本周总结

- 完成 Maven 编译器版本统一，解决核心构建错误
- 梳理 IDEA + Eclipse 调试链路，断点与类加载问题得到闭环
- 初步尝试 VSCode 调试准备，为后续跨 IDE 调试打基础
