# GitHub 配置检查清单

完成以下步骤以启用 Eclipse 插件的远程更新功能。

## ✅ GitHub 仓库设置

### 1. 启用 GitHub Pages

- [ ] 进入仓库的 `Settings` 标签页
- [ ] 点击左侧菜单的 `Pages`
- [ ] 在 **Source** 部分：
  - [ ] 选择 `Deploy from a branch`
  - [ ] **Branch**: 选择 `gh-pages` 分支
  - [ ] **Folder**: 选择 `/ (root)`
  - [ ] 点击 `Save` 按钮
- [ ] 等待部署完成（通常 1-3 分钟）
- [ ] 记录您的 Pages URL：`https://exceed-zk.github.io/ruyisdk-eclipse-plugins/`

### 2. 验证 GitHub Pages 部署

- [ ] 访问 Pages URL（如上）
- [ ] 应该看到一个包含安装说明的网页
- [ ] 检查以下文件是否可访问：
  - [ ] `https://exceed-zk.github.io/ruyisdk-eclipse-plugins/artifacts.xml`
  - [ ] `https://exceed-zk.github.io/ruyisdk-eclipse-plugins/content.xml`
  - [ ] `https://exceed-zk.github.io/ruyisdk-eclipse-plugins/features/`
  - [ ] `https://exceed-zk.github.io/ruyisdk-eclipse-plugins/plugins/`

### 3. 检查 GitHub Actions 权限

- [ ] 进入 `Settings` → `Actions` → `General`
- [ ] 在 **Workflow permissions** 部分：
  - [ ] 选择 `Read and write permissions`
  - [ ] 勾选 ☑ `Allow GitHub Actions to create and approve pull requests`
- [ ] 点击 `Save` 按钮

### 4. 确认 Actions 正常运行

- [ ] 进入 `Actions` 标签页
- [ ] 查看最近的 workflow 运行记录
- [ ] 确认 `Build and Publish P2 Repository` workflow 成功完成
- [ ] 如果失败，查看日志并修复问题

## 🚀 首次发布流程

### 步骤 1: 更新版本号

使用提供的自动化脚本：

**Windows (PowerShell):**
```powershell
.\update-version.ps1 0.0.5
```

**Linux/macOS (Bash):**
```bash
chmod +x update-version.sh
./update-version.sh 0.0.5
```

或者手动更新以下文件：
- [ ] `pom.xml` (根目录)
- [ ] `features/org.ruyisdk.feature/feature.xml`
- [ ] `repository/category.xml`
- [ ] 所有插件的 `META-INF/MANIFEST.MF`
- [ ] 所有模块的 `pom.xml`

### 步骤 2: 本地构建测试

```bash
mvn clean verify
```

- [ ] 构建成功完成
- [ ] 检查 `repository/target/repository/` 目录
- [ ] 确认生成的文件包括：
  - [ ] `artifacts.xml` / `artifacts.jar`
  - [ ] `content.xml` / `content.jar`
  - [ ] `features/` 目录
  - [ ] `plugins/` 目录

### 步骤 3: 提交并推送

```bash
git add .
git commit -m "chore: bump version to 0.0.5"
git push origin main
```

- [ ] 代码已提交
- [ ] 代码已推送到 GitHub
- [ ] GitHub Actions 自动开始构建
- [ ] 等待构建完成（查看 Actions 标签页）

### 步骤 4: 创建 Release Tag

```bash
git tag v0.0.5
git push origin v0.0.5
```

- [ ] Tag 已创建
- [ ] Tag 已推送到 GitHub
- [ ] `Create Release` workflow 自动触发
- [ ] Release 页面出现新的发布版本

### 步骤 5: 验证更新站点

- [ ] 访问 GitHub Pages URL
- [ ] 页面显示最新的时间戳
- [ ] 在浏览器中查看 `artifacts.xml`（可以添加 `.jar` 后缀下载）
- [ ] 确认版本号正确

## 👥 用户端测试

### 在 Eclipse 中测试更新

1. **首次安装测试**
   - [ ] 打开 Eclipse IDE
   - [ ] `Help` → `Install New Software...`
   - [ ] 添加更新站点 URL
   - [ ] 能够看到 "RuyiSDK IDE" 功能
   - [ ] 成功安装插件

2. **更新检测测试**
   - [ ] 发布新版本后，在 Eclipse 中打开 `Help` → `Check for Updates`
   - [ ] Eclipse 能够检测到新版本
   - [ ] 成功更新到新版本

3. **自动更新配置**
   - [ ] 在 Eclipse 中配置自动更新
   - [ ] `Window` → `Preferences` → `Install/Update` → `Automatic Updates`
   - [ ] 勾选自动查找更新选项

## 🔍 故障排查

### GitHub Pages 未显示内容

**可能原因：**
- [ ] gh-pages 分支不存在 → 先推送代码触发 Actions
- [ ] Pages 设置未保存 → 重新配置并保存
- [ ] 部署未完成 → 在 Actions 中检查 "pages-build-deployment" 任务

**解决方法：**
```bash
# 手动触发构建
git commit --allow-empty -m "Trigger GitHub Actions"
git push origin main
```

### Eclipse 看不到更新站点

**可能原因：**
- [ ] URL 输入错误
- [ ] P2 元数据文件缺失
- [ ] Eclipse 缓存问题

**解决方法：**
```bash
# 验证 URL 可访问
curl -I https://exceed-zk.github.io/ruyisdk-eclipse-plugins/artifacts.xml

# 在 Eclipse 中清除缓存
# 删除: workspace/.metadata/.plugins/org.eclipse.equinox.p2.repository/
```

### GitHub Actions 构建失败

**常见错误：**
- [ ] Maven 构建错误 → 检查 pom.xml 配置
- [ ] 权限错误 → 检查 Actions 权限设置
- [ ] 依赖下载失败 → 网络问题，重新运行

**查看日志：**
- [ ] 进入 `Actions` 标签页
- [ ] 点击失败的 workflow
- [ ] 展开失败的步骤查看详细日志

### Eclipse 更新失败

**可能原因：**
- [ ] 版本号未正确更新
- [ ] 依赖冲突
- [ ] 插件签名问题

**解决方法：**
- [ ] 检查所有 MANIFEST.MF 的版本号
- [ ] 确认 feature.xml 中的依赖版本匹配
- [ ] 尝试卸载旧版本后重新安装

## 📊 自动化工作流说明

### `build-and-publish-p2.yml`
- **触发时机**: 推送到 main 分支，修改 plugins/features/pom.xml
- **功能**: 
  - 构建 P2 仓库
  - 发布到 GitHub Pages
  - 上传构建产物
- **部署位置**: `gh-pages` 分支

### `release.yml`
- **触发时机**: 推送版本标签（如 `v0.0.5`）
- **功能**:
  - 构建 P2 仓库
  - 打包 zip 和 tar.gz 文件
  - 创建 GitHub Release
  - 附加下载文件

## 🔗 有用的链接

- [ ] GitHub Pages URL: `https://exceed-zk.github.io/ruyisdk-eclipse-plugins/`
- [ ] GitHub Repository: `https://github.com/exceed-zk/ruyisdk-eclipse-plugins`
- [ ] Actions 页面: `https://github.com/exceed-zk/ruyisdk-eclipse-plugins/actions`
- [ ] Releases 页面: `https://github.com/exceed-zk/ruyisdk-eclipse-plugins/releases`

## 🎉 完成！

完成上述所有检查项后，您的 Eclipse 插件更新系统就已经配置完成了！

用户可以通过以下方式获取更新：
1. ✅ 在 Eclipse 中添加更新站点 URL
2. ✅ 手动检查更新（Help → Check for Updates）
3. ✅ 配置自动更新（在 Eclipse 偏好设置中）
4. ✅ 从 GitHub Releases 下载离线安装包

---

**最后更新**: 2025-10-20
**版本**: 1.0

