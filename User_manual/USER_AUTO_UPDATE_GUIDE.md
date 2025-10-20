# RuyiSDK Eclipse 插件 - 用户自动更新配置指南

本指南帮助最终用户在 Eclipse IDE 中配置 RuyiSDK 插件的自动更新功能。

## 📥 首次安装

### 方法 1: 通过更新站点安装（推荐）

1. 打开 Eclipse IDE
2. 点击菜单 `Help` → `Install New Software...`
3. 点击 `Add...` 按钮
4. 在弹出的对话框中输入：
   ```
   Name: RuyiSDK Plugins
   Location: https://exceed-zk.github.io/ruyisdk-eclipse-plugins/
   ```
5. 点击 `Add` 确认
6. 在可用软件列表中，勾选 `RuyiSDK IDE` 下的所有功能
7. 点击 `Next` 按钮
8. 接受许可协议
9. 点击 `Finish` 开始安装
10. 安装完成后重启 Eclipse

### 方法 2: 离线安装

如果您的环境无法访问互联网：

1. 从 [GitHub Releases](https://github.com/exceed-zk/ruyisdk-eclipse-plugins/releases) 下载最新的 `.zip` 或 `.tar.gz` 文件
2. 解压到本地目录（例如：`C:\ruyisdk-plugins` 或 `/opt/ruyisdk-plugins`）
3. 在 Eclipse 中，`Help` → `Install New Software...` → `Add...`
4. 点击 `Local...` 按钮，选择解压后的 `repository` 目录
5. 按照上述在线安装的步骤 6-10 完成安装

## 🔔 配置自动更新通知

### 启用自动更新检查

1. 打开 Eclipse IDE
2. 点击菜单：
   - **Windows/Linux**: `Window` → `Preferences`
   - **macOS**: `Eclipse` → `Preferences`
3. 在左侧树形菜单中展开 `Install/Update` → 点击 `Automatic Updates`
4. 勾选以下选项：
   ```
   ☑ Automatically find new updates and notify me
   ```
5. 配置更新检查频率：
   - **On every startup** - 每次启动时检查（推荐用于开发环境）
   - **On schedule** - 按计划检查：
     - `Every day at:` - 每天在指定时间
     - `Every Monday at:` - 每周一在指定时间
     - `Every 1st of month at:` - 每月1号在指定时间
6. 建议设置：
   ```
   检查频率: Every day at: 09:00
   ```
7. 点击 `Apply and Close` 保存设置

### 更新通知的工作方式

配置完成后，Eclipse 会：

1. **后台检查**: 在指定的时间或启动时在后台检查更新
2. **通知显示**: 如果发现新版本，会在 Eclipse 右下角显示一个更新图标 🔄
3. **点击安装**: 点击通知图标，会打开更新对话框
4. **选择更新**: 选择要更新的组件（通常全选）
5. **自动安装**: Eclipse 会自动下载并安装更新
6. **重启应用**: 更新完成后，重启 Eclipse 以应用更改

## 🔍 手动检查更新

如果您想立即检查是否有新版本：

1. 打开 Eclipse IDE
2. 点击菜单 `Help` → `Check for Updates`
3. Eclipse 会连接到更新站点检查
4. 如果有可用更新，会显示更新对话框
5. 选择要更新的组件
6. 点击 `Next` → `Next` → `Finish`
7. 等待下载和安装完成
8. 重启 Eclipse

## ⚙️ 高级设置

### 管理更新站点

如果需要查看或修改已配置的更新站点：

1. `Window` → `Preferences` → `Install/Update` → `Available Software Sites`
2. 在列表中可以看到所有已配置的更新站点
3. 找到 `RuyiSDK Plugins` 条目
4. 可以进行以下操作：
   - **Enable/Disable**: 启用或禁用该站点
   - **Edit**: 修改站点 URL
   - **Remove**: 删除站点
   - **Reload**: 重新加载站点信息

### 配置更新下载选项

1. `Window` → `Preferences` → `Install/Update`
2. 配置以下选项：
   ```
   ☑ Show all versions - 显示所有可用版本
   ☑ Show only the latest versions of available software - 仅显示最新版本（推荐）
   ☑ Contact all update sites during install to find required software - 在安装时联系所有站点
   ```

### 配置网络代理（如果需要）

如果您的网络环境需要代理：

1. `Window` → `Preferences` → `General` → `Network Connections`
2. **Active Provider** 选择：
   - `Direct` - 直接连接
   - `Manual` - 手动配置代理
   - `Native` - 使用系统代理设置
3. 如果选择 `Manual`，配置代理服务器：
   ```
   Scheme: HTTP
   Host: your-proxy-server.com
   Port: 8080
   Authentication: (如果需要，输入用户名和密码)
   ```
4. 对 HTTPS 执行相同操作
5. 点击 `Apply and Close`

## 🛠️ 故障排查

### 问题 1: 看不到更新通知

**可能原因：**
- 自动更新未启用
- 网络连接问题
- 更新站点未正确配置

**解决方法：**
1. 检查自动更新设置是否已启用（见上文）
2. 手动执行 `Help` → `Check for Updates` 测试
3. 检查网络连接和代理设置
4. 在 `Available Software Sites` 中验证 RuyiSDK 站点 URL 是否正确

### 问题 2: 更新检查失败

**错误信息示例：**
```
Unable to access "https://exceed-zk.github.io/ruyisdk-eclipse-plugins/"
```

**解决方法：**
1. 检查网络连接
2. 在浏览器中访问更新站点 URL，确认可以访问
3. 清除 Eclipse 缓存：
   - 关闭 Eclipse
   - 删除目录：`workspace/.metadata/.plugins/org.eclipse.equinox.p2.repository/`
   - 重新启动 Eclipse
4. 检查防火墙和杀毒软件设置

### 问题 3: 更新安装失败

**错误信息示例：**
```
Cannot complete the install because of a conflicting dependency
```

**解决方法：**
1. 检查 Eclipse 版本是否满足要求（需要 2024-9 或更高）
2. 检查 Java 版本（需要 Java 21 或更高）
3. 尝试卸载旧版本后重新安装：
   - `Help` → `About Eclipse IDE` → `Installation Details`
   - 选择 RuyiSDK 相关组件
   - 点击 `Uninstall...`
   - 重启后重新安装

### 问题 4: 更新后功能不正常

**解决方法：**
1. 尝试清理工作区：
   - 关闭 Eclipse
   - 使用 `-clean` 参数启动：
     ```bash
     eclipse.exe -clean
     ```
2. 重置透视图：
   - `Window` → `Perspective` → `Reset Perspective`
3. 如果问题持续，考虑回滚：
   - 卸载当前版本
   - 安装旧版本（从 GitHub Releases 下载）

## 📊 更新历史查看

查看已安装的更新和版本历史：

1. `Help` → `About Eclipse IDE`
2. 点击 `Installation Details` 按钮
3. 切换到 `Installed Software` 标签页
4. 找到以 `org.ruyisdk` 开头的组件
5. 可以看到：
   - **Identifier**: 插件 ID
   - **Version**: 当前安装的版本号
   - **Provider**: 提供者信息

切换到 `Installation History` 标签页可以查看：
- 所有安装和更新的历史记录
- 每次更新的时间戳
- 可以选择历史配置并回滚（高级功能）

## 🔐 安全性说明

### 验证更新来源

RuyiSDK Eclipse 插件通过 GitHub Pages 提供更新，这是一个安全可信的平台。

- **官方更新站点**: `https://exceed-zk.github.io/ruyisdk-eclipse-plugins/`
- **GitHub 仓库**: `https://github.com/exceed-zk/ruyisdk-eclipse-plugins`

**警告**：不要从非官方来源安装插件或更新！

### 证书和签名

Eclipse P2 更新机制支持数字签名验证。如果在更新过程中看到证书警告：

1. 仔细检查证书信息
2. 确认证书来自可信来源
3. 如果不确定，请访问官方 GitHub 仓库确认

## 📞 获取帮助

如果您在配置自动更新时遇到问题：

1. **查看文档**: 
   - [GitHub 仓库 README](https://github.com/exceed-zk/ruyisdk-eclipse-plugins/blob/main/README.md)
   - [安装指南](https://github.com/exceed-zk/ruyisdk-eclipse-plugins)

2. **报告问题**:
   - 在 [GitHub Issues](https://github.com/exceed-zk/ruyisdk-eclipse-plugins/issues) 创建问题
   - 提供以下信息：
     - Eclipse 版本
     - Java 版本
     - 操作系统
     - 错误日志（在 `workspace/.metadata/.log`）

3. **社区支持**:
   - 查看已有的 Issues 和讨论
   - 参与 GitHub Discussions（如果启用）

## 📋 快速检查清单

安装和配置完成后，检查以下项目：

- [ ] 插件已成功安装
- [ ] 可以在 Eclipse 中看到 RuyiSDK 相关功能
- [ ] 自动更新已启用
- [ ] 更新检查频率已设置
- [ ] 手动检查更新功能正常
- [ ] 网络连接和代理（如需要）已配置

## 🎉 享受开发！

配置完成后，您将自动收到 RuyiSDK 插件的更新通知，始终使用最新的功能和修复。

---

**官方网站**: https://exceed-zk.github.io/ruyisdk-eclipse-plugins/  
**GitHub**: https://github.com/exceed-zk/ruyisdk-eclipse-plugins  
**最后更新**: 2025-10-20

