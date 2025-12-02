# RuyiSDK 实习周报 第 03 期·2025 年 10 月 26 日

## 本周工作概述

本周主要完成了以下工作：
- 实现 GitHub Pages P2 自动更新功能
- 优化 GitHub Actions 工作流配置
- 完成 RuyiSDK IDE 品牌化配置
- packages PR #4 成功合并

---

## 提交的 patch

### 2025-10-20（周一）

#### ruyisdk-eclipse-plugins

1. **10:38** - feat: add auto-update functionality via GitHub Pages  
   通过 GitHub Pages 添加自动更新功能  
   作者：exceed-zk ([6fc65ec](https://github.com/ruyisdk/ruyisdk-eclipse-plugins/commit/6fc65ec))

2. **12:14** - chore: add Maven build configuration with unified version 0.0.4  
   添加统一版本号 0.0.4 的 Maven 构建配置  
   作者：exceed-zk ([2090003](https://github.com/ruyisdk/ruyisdk-eclipse-plugins/commit/2090003))

3. **12:15** - feat: add auto-update functionality via GitHub Pages  
   通过 GitHub Pages 添加自动更新功能  
   作者：exceed-zk ([20e09ef](https://github.com/ruyisdk/ruyisdk-eclipse-plugins/commit/20e09ef))

4. **13:05** - feat: allow GitHub Actions to deploy from feature branches  
   允许 GitHub Actions 从 feature 分支部署  
   作者：exceed-zk ([013a955](https://github.com/ruyisdk/ruyisdk-eclipse-plugins/commit/013a955))

5. **15:42** - fix: resolve merge conflict in README.md  
   解决 README.md 的合并冲突  
   作者：exceed-zk ([1d175d8](https://github.com/ruyisdk/ruyisdk-eclipse-plugins/commit/1d175d8))

6. **16:05** - fix: enable shell variable expansion in index.html generation  
   修复 index.html 生成中的 shell 变量扩展问题  
   作者：exceed-zk ([0a68a27](https://github.com/ruyisdk/ruyisdk-eclipse-plugins/commit/0a68a27))

### 2025-10-22（周三）

#### ruyisdk-eclipse-plugins

7. **09:09** - chore: optimize GitHub Actions workflow configuration  
   优化 GitHub Actions 工作流配置  
   作者：exceed-zk ([3d694bd](https://github.com/ruyisdk/ruyisdk-eclipse-plugins/commit/3d694bd))

### 2025-10-24（周五）

#### ruyisdk-eclipse-plugins

8. **16:54** - chore: add Maven JVM config to fix JDK 25 XML parsing limits  
   添加 Maven JVM 配置以修复 JDK 25 XML 解析限制  
   作者：exceed-zk ([fef5eb6](https://github.com/ruyisdk/ruyisdk-eclipse-plugins/commit/fef5eb6))

9. **17:01** - chore: add Maven JVM config to fix JDK 25 XML parsing limits  
   添加 Maven JVM 配置以修复 JDK 25 XML 解析限制  
   作者：exceed-zk ([fa93482](https://github.com/ruyisdk/ruyisdk-eclipse-plugins/commit/fa93482))

---

## IDE 插件

### GitHub Pages P2 更新站点

**实现目标**：
- 建立基于 GitHub Pages 的自动更新机制
- 使用户能够方便地安装和更新插件

**技术方案**：
- **CI/CD**: GitHub Actions 自动构建和发布
- **托管平台**: GitHub Pages（免费 P2 更新站点托管）
- **更新协议**: Eclipse P2 (Provisioning Platform)

**新增文件**：
1. `.github/workflows/build-and-publish-p2.yml` - 自动构建和发布工作流
2. `.github/workflows/release.yml` - 版本发布工作流
3. `repository/category.xml` - P2 更新站点分类配置
4. `repository/p2.inf` - P2 元数据增强配置
5. `.gitignore` - 防止构建产物提交

**关键功能**：
- ✅ 任何分支推送都自动触发构建（支持 feature 分支测试）
- ✅ 构建成功后自动部署到 GitHub Pages
- ✅ 用户通过 Eclipse 的更新站点在线安装和更新
- ✅ 创建版本标签自动生成 GitHub Release

**更新站点地址**：
- https://exceed-zk.github.io/ruyisdk-eclipse-plugins/

**详细文档**：
- [自动更新功能实现文档.md](other-doc/自动更新功能实现文档.md) - 完整实现说明
- [GitHUb Pages站点更新指南(初版).md](other-doc/GitHUb Pages站点更新指南(初版).md) - 使用指南

---

## RuyiSDK IDE 包

### RuyiSDK 品牌化配置（PR #4）

本周主要工作集中在 ruyisdk-eclipse-packages 项目，完成了 RuyiSDK IDE 的品牌化配置和 Update Site 预配置。

**品牌资源**：
- ✅ 添加 RuyiSDK 品牌图标和资源文件
- ✅ 配置产品元数据（名称、版本、描述）
- ✅ 更新启动画面和欢迎页面
- ✅ 添加 RuyiSDK 文档和网站链接

**构建配置**：
- ✅ 配置仅支持 RISC-V Linux 平台构建
- ✅ 重命名根目录为 ruyisdk（原 eclipse）
- ✅ 版本号升级到 0.0.3
- ✅ 完善 .gitignore 配置

**插件集成**：
- ✅ 添加 RuyiSDK plugins repository 配置文件
- ✅ 将 RuyiSDK 功能集成到 embedded C/C++ package
- ✅ 预配置 Update Site 地址

**PR 状态**：
- PR #4 已成功合并到主分支

---

## 用户体验分析

### RuyiSDK IDE 使用体验

完成了 RuyiSDK IDE 的全面体验测试和功能分析：

**主要发现**：
1. **新手友好度不足**：使用流程对新手用户不够友好，学习成本较高
2. **文档资源稀少**：介绍和使用文档不够详细
3. **插件功能说明缺失**：缺少对插件的详细介绍和应用场景说明
4. **更新机制待完善**：需要建立自动更新和分发机制

**测试环境**：
- Ubuntu Linux x86_64
- Milk-V Duo 交叉编译测试
- Coremark + QEMU 运行测试

**详细分析报告**：
- [RuyiSDK 使用体验与功能分析.md](other-doc/RuyiSDK 使用体验与功能分析.md)

---

## 遇到的问题及解决方案

### 问题 1：缺少 feature.xml 导致构建失败
**解决**：从历史提交中恢复 `feature.xml` 文件

### 问题 2：版本号不匹配
**解决**：统一所有插件的版本号为 `0.0.4.qualifier`，确保 Maven 和 OSGi 版本一致

### 问题 3：依赖解析失败
**解决**：移除 `MANIFEST.MF` 中的外部依赖声明，使用 `Bundle-ClassPath` 引入本地 jar

### 问题 4：GitHub Pages 显示 README 而非 P2 站点
**解决**：调整 `gh-pages` 分支配置，确保显示 `index.html`

### 问题 5：main 分支保护限制
**解决**：修改 workflow 支持 feature 分支直接部署，方便开发测试

---
