# RuyiSDK 实习周报 第 04 期·2025 年 11 月 2 日

## 本周工作概述

本周主要完成了以下工作：
- 深入研究 Eclipse 插件调试方法
- 配置 Update Site 自动添加功能
- 提交 PR #5 并 rebase 到个人分支
- 完善调试文档（多个版本迭代）
- 解决 CI 工作流问题

---

## 提交的 patch

### 2025-10-27（周一）

#### ruyisdk-eclipse-plugins

1. **13:37** - build: downgrade minimum JDK requirement from 21 to 17  
   将最低 JDK 要求从 21 降级到 17  
   作者：exceed-zk ([b05fc5b](https://github.com/ruyisdk/ruyisdk-eclipse-plugins/commit/b05fc5b))

2. **14:30** - chore: trigger CI build  
   触发 CI 构建  
   作者：exceed-zk ([9dd7045](https://github.com/ruyisdk/ruyisdk-eclipse-plugins/commit/9dd7045))

3. **14:49** - fix: remove invalid XML comment placement in pom.xml  
   修复 pom.xml 中的无效 XML 注释位置  
   作者：exceed-zk ([9297043](https://github.com/ruyisdk/ruyisdk-eclipse-plugins/commit/9297043))

4. **15:02** - security: pin third-party GitHub Actions to full commit SHA  
   将第三方 GitHub Actions 固定到完整的 commit SHA  
   作者：exceed-zk ([af0ae3a](https://github.com/ruyisdk/ruyisdk-eclipse-plugins/commit/af0ae3a))

#### ruyisdk-eclipse-packages

5. **15:50** - feat(branding): add RuyiSDK brand icons and assets  
   添加 RuyiSDK 品牌图标和资源文件  
   作者：exceed-zk ([9c700455](https://github.com/ruyisdk/ruyisdk-eclipse-packages/commit/9c700455))

6. **15:51** - feat(product): configure RuyiSDK product branding and metadata  
   配置 RuyiSDK 产品品牌和元数据  
   作者：exceed-zk ([f65c8058](https://github.com/ruyisdk/ruyisdk-eclipse-packages/commit/f65c8058))

7. **15:52** - chore(build): configure build for RISC-V Linux platform only  
   配置构建仅支持 RISC-V Linux 平台  
   作者：exceed-zk ([e7f02b9c](https://github.com/ruyisdk/ruyisdk-eclipse-packages/commit/e7f02b9c))

8. **15:55** - chore(build): rename root folder from eclipse to ruyisdk  
   将根目录从 eclipse 重命名为 ruyisdk  
   作者：exceed-zk ([ea133229](https://github.com/ruyisdk/ruyisdk-eclipse-packages/commit/ea133229))

9. **15:56** - feat(welcome): update splash screen and intro page assets  
   更新启动画面和欢迎页面资源  
   作者：exceed-zk ([052d00b1](https://github.com/ruyisdk/ruyisdk-eclipse-packages/commit/052d00b1))

10. **15:57** - docs(welcome): add RuyiSDK documentation and website links  
    添加 RuyiSDK 文档和网站链接  
    作者：exceed-zk ([c1b77873](https://github.com/ruyisdk/ruyisdk-eclipse-packages/commit/c1b77873))

11. **15:58** - chore(release): bump version to 0.0.3  
    版本号升级到 0.0.3  
    作者：exceed-zk ([8042ea60](https://github.com/ruyisdk/ruyisdk-eclipse-packages/commit/8042ea60))

### 2025-10-29（周二）

#### ruyisdk-eclipse-plugins

12. **16:11** - build: revert to JDK 21 as minimum requirement  
    恢复 JDK 21 作为最低要求  
    作者：exceed-zk ([9d83a25](https://github.com/ruyisdk/ruyisdk-eclipse-plugins/commit/9d83a25))

13. **18:43** - Update README.md  
    更新 README.md  
    作者：exceed-zk ([5612c92](https://github.com/ruyisdk/ruyisdk-eclipse-plugins/commit/5612c92))

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

1. **终版** - 调试方法总结
   - [调试方式(终版).pdf](../20251103-20251109/other-doc/调试方式(终版).pdf)

2. **CI 问题解决** - GitHub Actions 相关问题
   - [2025-11-09-CI问题.pdf](../20251103-20251109/other-doc/2025-11-09-CI问题.pdf)

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
- 调整磁盘空间需求说明（也就是删除这个说明）
- 准备正式提交 PR
