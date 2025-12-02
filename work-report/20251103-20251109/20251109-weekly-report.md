# RuyiSDK 实习周报 第 05 期·2025 年 11 月 9 日

## 本周工作概述

本周主要完成了以下工作：
- 深入研究 Eclipse 插件调试方法
- 配置 Update Site 自动添加功能
- 提交 PR #5 并 rebase 到个人分支
- 完善调试文档（多个版本迭代）
- 解决 CI 工作流问题

---

## 提交的 patch

### 2025-11-05（周三）

#### ruyisdk-eclipse-plugins

1. **17:05** - fix(build): resolve m2e lifecycle mapping conflicts and .project errors  
   解决 m2e 生命周期映射冲突和 .project 错误  
   作者：exceed-zk ([e58d0bd](https://github.com/ruyisdk/ruyisdk-eclipse-plugins/commit/e58d0bd))

### 2025-11-08（周六）

#### ruyisdk-eclipse-plugins

2. **12:07** - docs: update README for zip installation and pom-less builds  
   更新 README 以说明 zip 安装和 pom-less 构建  
   作者：exceed-zk ([4681ab5](https://github.com/ruyisdk/ruyisdk-eclipse-plugins/commit/4681ab5))

3. **16:42** - docs: refine README build requirements and remove outdated sections  
   优化 README 构建要求并移除过时章节  
   作者：exceed-zk ([8cbfc6d](https://github.com/ruyisdk/ruyisdk-eclipse-plugins/commit/8cbfc6d))

4. **16:48** - docs: update README and remove blank BUILD.md file  
   更新 README 并移除空白的 BUILD.md 文件  
   作者：exceed-zk ([b5de48c](https://github.com/ruyisdk/ruyisdk-eclipse-plugins/commit/b5de48c))

5. **18:42** - docs: update README  
   更新 README 文档  
   作者：exceed-zk ([1a2e877](https://github.com/ruyisdk/ruyisdk-eclipse-plugins/commit/1a2e877))

### 2025-11-09（周日）

#### ruyisdk-eclipse-plugins

6. **15:10** - fix(ci): remove hardcoded test repository checkout  
   移除 CI 中硬编码的测试仓库检出  
   作者：exceed-zk ([d19f664](https://github.com/ruyisdk/ruyisdk-eclipse-plugins/commit/d19f664))

**说明**：本周除了直接代码提交外，还参与了 PR #5 的审阅工作。PR #5 由团队其他成员提交，包含 pom-less 构建、JDK 17 降级、CI/CD 改进等优化内容。

---

## Eclipse 插件

### Update Site 自动添加

**任务目标**：
给 Eclipse 添加新的 Update Site，使用户使用 RuyiSDK IDE 时无需手动添加更新站点。

**配置信息**：
- Name: RuyiSDK Updates (GitHub)
- Location: https://ruyisdk.github.io/ruyisdk-eclipse-plugins/

**完成情况**：
- ✅ 开启 PR 并附带配置截图
- ✅ 提供详细的配置说明文档
- ✅ 列出参考资料供后人查阅

---

### PR #5 合并与 Rebase

**PR 内容**：
chore: pom-less builds; rm unused stuff; sync version to 0.0.5; downgrade to JDK 17 for multiple JDK LTS builds; use CI to make releases and website conditional; add DCO check by pzhlkj6612

**主要工作**：
- 阅读并理解 PR #5 的所有变更
- 将代码 rebase 到个人分支
- 解决合并冲突
- 确保构建通过

**技术要点**：
- Pom-less builds 配置
- JDK 版本降级到 17（支持多个 LTS 版本）
- CI 条件化发布和网站构建
- DCO 签名检查

**PR 链接**：
https://github.com/exceed-zk/ruyisdk-eclipse-plugins/pull/5

---

## 调试方法完善

### Eclipse 插件调试完整步骤

完成了 Eclipse 插件在 Maven/Tycho 环境下的调试方法研究，输出了多个版本的调试文档：

**文档迭代**：
1. **初版** - 基础调试思路
   - [在 Eclipse 中调试 MavenTycho 插件的步骤（初版）.pdf](other-doc/在 Eclipse 中调试 MavenTycho 插件的步骤（初版）.pdf)

2. **第二版** - 完善配置步骤
   - [在 Eclipse 中调试 MavenTycho 插件的完整步骤(第二版).pdf](other-doc/在 Eclipse 中调试 MavenTycho 插件的完整步骤(第二版).pdf)

3. **终版** - 调试方法总结
   - [调试方式(终版).pdf](other-doc/调试方式(终版).pdf)

4. **CI 问题解决** - GitHub Actions 相关问题
   - [2025-11-09-CI问题.pdf](other-doc/2025-11-09-CI问题.pdf)

**核心内容**：
- Eclipse SDK IDE 的安装和配置
- Launch Configuration 的设置方法
- OSGi Framework 调试技巧
- 断点调试和日志查看
- Maven/Tycho 集成环境下的特殊配置

---

## CI/CD 改进

### 解决 CI 工作流问题

**主要问题**：
- GitHub Actions 构建失败
- 依赖解析错误
- 权限配置问题

**解决方案**：
- 调整 workflow 配置
- 优化依赖管理
- 配置正确的 GitHub Actions 权限

---

## 开发规范

### 日常开发流程规范

建立了每日开发流程规范：
```bash
# 每天起床第一件事
git fetch --tags --all
```

这确保了本地仓库始终与远程保持同步，避免代码冲突。

---

## 磁盘空间管理

### 开发环境优化

**问题**：原文档要求"足够的磁盘空间 (建议 40GB+)"

**优化**：
- 删除不必要的临时文件
- 优化构建缓存管理
- 经过多次迭代，文档逐步完善和规范化
- 准备正式提交 PR
