# RuyiSDK 实习周报 第 02 期·2025 年 10 月 19 日

## 本周工作概述

本周主要完成了以下工作：
- 初步演示 Maven 构建
- 学习 Git 提交规范
- 阅读官网实习生需求文档
- 修改 plugins PR 中的问题
- 实施 Maven + Tycho 构建配置

---

## 提交的 patch

### 2025-10-13（周一）

#### ruyisdk-eclipse-plugins

1. **13:08** - feat: Add Maven build support for RuyiSDK Eclipse plugins  
   为 RuyiSDK Eclipse 插件添加 Maven 构建支持  
   作者：exceed-zk ([a6318e0](https://github.com/ruyisdk/ruyisdk-eclipse-plugins/commit/a6318e0))

2. **15:55** - add some other  
   添加其他配置文件  
   作者：exceed-zk ([dd43190](https://github.com/ruyisdk/ruyisdk-eclipse-plugins/commit/dd43190))

### 2025-10-14（周二）

#### ruyisdk-eclipse-plugins

3. **13:18** - chore: remove build artifacts from Git and add .gitignore  
   从 Git 中移除构建产物并添加 .gitignore  
   作者：exceed-zk ([57fb6bc](https://github.com/ruyisdk/ruyisdk-eclipse-plugins/commit/57fb6bc))

#### ruyisdk-eclipse-packages

4. **14:06** - chore: improve .gitignore  
   改进 .gitignore 配置  
   作者：exceed-zk ([86bbef0c](https://github.com/ruyisdk/ruyisdk-eclipse-packages/commit/86bbef0c))

---

## Eclipse 插件

### Maven 构建实施

**任务目标**：
- 尝试 Eclipse 自研插件的构建
- 在插件工程中加入 Maven 工具
- 将构建集成到 packages 工程（[ruyisdk-eclipse-packages](https://github.com/ruyisdk/ruyisdk-eclipse-packages/)）

**技术要点**：
- Maven 版本需兼容 Eclipse 2024-09 及以后版本（支持 RISC-V 64）
- 通过 fork 仓库到个人账号，在个人仓库提交修改

**完成情况**：
- ✅ 完成 Maven + Tycho 构建配置
- ✅ 创建根目录 `pom.xml` 管理所有子模块
- ✅ 配置各插件的 `pom.xml` 和 `build.properties`
- ✅ 添加 .gitignore 防止构建产物提交

---

## 开发规范

### Git 提交规范

学习并应用 Conventional Commits 规范：
- `feat:` 新功能
- `fix:` Bug 修复
- `docs:` 文档更新
- `chore:` 构建/工具链变更
- 所有提交需要 DCO 签名（`git commit -s`）

### JDK 和 Maven 兼容性调研

完成了市面上主流 IDE 插件的 JDK 和 Maven 使用情况调研：
- 详见：[市面上大部分插件jdk和mvn使用情况.md](../20251011-20251012/other-doc/市面上大部分插件jdk和mvn使用情况.md)

**主要发现**：
- 大多数插件使用 Tycho 进行构建
- JDK 17 是当前主流 LTS 版本
- Maven 3.8+ 与 Tycho 4.0+ 配合较好
- Eclipse 2024-09 开始支持 RISC-V 64 架构
