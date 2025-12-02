# RuyiSDK Eclipse 插件更新指南

## 📦 更新站点配置

### P2 更新站点 URL
```
https://exceed-zk.github.io/ruyisdk-eclipse-plugins/
```

## 🚀 发布新版本流程

### 1. 更新版本号

需要更新以下文件中的版本号：

#### a) Feature 版本
`features/org.ruyisdk.feature/feature.xml`
```xml
<feature
      id="org.ruyisdk.feature"
      label="RuyiSDK IDE Feature"
      version="0.0.5.qualifier"  <!-- 修改这里 -->
      provider-name="RuyiSDK">
```

#### b) 插件版本
更新每个插件的 `META-INF/MANIFEST.MF`：
- `plugins/org.ruyisdk.core/META-INF/MANIFEST.MF`
- `plugins/org.ruyisdk.devices/META-INF/MANIFEST.MF`
- `plugins/org.ruyisdk.intro/META-INF/MANIFEST.MF`
- 等等...

```
Bundle-Version: 0.0.5.qualifier
```

#### c) Category 版本
`repository/category.xml`
```xml
<feature url="features/org.ruyisdk.feature_0.0.5.qualifier.jar" 
         id="org.ruyisdk.feature" 
         version="0.0.5.qualifier">  <!-- 修改这里 -->
   <category name="ruyisdk"/>
</feature>
```

#### d) POM 版本
更新根目录和所有模块的 `pom.xml`：
```xml
<version>0.0.5-SNAPSHOT</version>
```

### 2. 构建和测试

```bash
# 本地构建测试
mvn clean verify

# 检查生成的 P2 仓库
ls -la repository/target/repository/
```

### 3. 提交和发布

```bash
# 1. 提交版本更新
git add .
git commit -m "chore: bump version to 0.0.5"
git push origin main

# 2. 等待 GitHub Actions 构建完成并发布到 GitHub Pages

# 3. 创建 Release Tag
git tag -a v0.0.5 -m "Release version 0.0.5"
git push origin v0.0.5

# 4. GitHub Actions 会自动创建 Release
```

## 👥 用户如何获取更新

### 方法 1：手动检查更新
1. 打开 Eclipse IDE
2. `Help` → `Check for Updates`
3. Eclipse 会自动检查并提示可用更新
4. 点击 "Next" 完成更新

### 方法 2：启用自动更新
1. `Window` → `Preferences`（macOS 上是 `Eclipse` → `Preferences`）
2. `Install/Update` → `Automatic Updates`
3. 勾选 ☑ `Automatically find new updates and notify me`
4. 设置检查频率（例如：每天、每周）
5. 点击 "Apply and Close"

配置后，Eclipse 会：
- 在后台自动检查更新
- 发现新版本时在状态栏显示通知图标
- 点击通知即可安装更新

### 方法 3：首次安装或重新安装
1. `Help` → `Install New Software...`
2. 点击 `Add...` 按钮
3. 输入：
   - **Name**: `RuyiSDK Plugins`
   - **Location**: `https://exceed-zk.github.io/ruyisdk-eclipse-plugins/`
4. 选择 "RuyiSDK IDE" 分类下的所有功能
5. 点击 "Next" 完成安装

## 🔍 验证更新站点

### 检查 GitHub Pages 部署状态
1. 访问：`https://exceed-zk.github.io/ruyisdk-eclipse-plugins/`
2. 应该能看到一个索引页面

### 检查 P2 仓库元数据
访问以下 URL 确认文件存在：
- `https://exceed-zk.github.io/ruyisdk-eclipse-plugins/artifacts.xml`
- `https://exceed-zk.github.io/ruyisdk-eclipse-plugins/content.xml`
- `https://exceed-zk.github.io/ruyisdk-eclipse-plugins/features/`
- `https://exceed-zk.github.io/ruyisdk-eclipse-plugins/plugins/`

## 🛠️ GitHub 仓库设置

### 1. 启用 GitHub Pages
在仓库的 `Settings` → `Pages` 中：
- **Source**: Deploy from a branch
- **Branch**: `gh-pages` / `(root)`
- **Save**

### 2. 分支保护（可选但推荐）
在 `Settings` → `Branches` 中：
- 保护 `main` 分支
- 要求 PR 审核
- 要求状态检查通过

### 3. Secrets 配置
默认使用 `GITHUB_TOKEN`，无需额外配置。

如果需要自定义 token：
`Settings` → `Secrets and variables` → `Actions` → `New repository secret`
- Name: `GH_TOKEN`
- Value: 具有 `repo` 和 `pages` 权限的 Personal Access Token

## 📊 更新机制说明

### Eclipse P2 更新检测原理
1. Eclipse 读取本地已安装插件的版本信息
2. 连接到配置的更新站点（P2 仓库）
3. 比较远程版本和本地版本
4. 如果远程版本号更高，提示用户更新

### 版本号比较规则
- 格式：`major.minor.micro.qualifier`
- 例如：`0.0.4.202410201234` → `0.0.5.202410211456`
- qualifier 通常是时间戳，由 Tycho 自动生成

### 更新频率建议
- **开发阶段**：每个 Sprint 或重要功能完成后发布
- **稳定阶段**：每月或每季度发布
- **紧急修复**：随时发布补丁版本

## 🔗 相关资源

- [Eclipse P2 文档](https://help.eclipse.org/latest/topic/org.eclipse.platform.doc.isv/guide/p2_publisher.html)
- [Tycho 构建指南](https://www.eclipse.org/tycho/)
- [GitHub Pages 文档](https://docs.github.com/en/pages)
- [GitHub Actions 工作流语法](https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions)

