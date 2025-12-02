# RuyiSDK 实习周报 第 01 期·2025 年 10 月 12 日

## 本周工作概述

本周主要完成了以下工作：
- 初步演示 Maven 构建
- 学习 Git 提交规范
- 阅读官网实习生需求文档
- 修改 plugins PR 中的问题

---

## 提交的 patch

本周（2025-10-11 ~ 10-12）无代码提交，主要进行项目调研和技术栈选型工作。

---

## Eclipse 插件

### Maven 构建支持

**目标任务**：
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
- ✅ 生成 P2 更新站点配置

**相关文档**：
- [RUYISDK_BUILD_GUIDE.md](other-doc/RUYISDK_BUILD_GUIDE.md) - 构建指南
- [TESTING_GUIDE.md](other-doc/TESTING_GUIDE.md) - 测试指南
- [安装指南-Linux.md](other-doc/安装指南-Linux.md) - Linux 安装说明

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
- 详见：[市面上大部分插件jdk和mvn使用情况.md](other-doc/市面上大部分插件jdk和mvn使用情况.md)
