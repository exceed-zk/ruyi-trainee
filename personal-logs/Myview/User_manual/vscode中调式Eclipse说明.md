# 在 VS Code 中开发 RuyiSDK Eclipse 插件

## 1. 环境准备

*   **VS Code**
*   **Eclipse RCP Application**(最低要求2024-09): 需要在本地安装一个 Eclipse RCP 作为 Target Platform。

### VS Code 插件 (Extensions)
请在 VS Code 插件市场安装：
1.  **Extension Pack for Java**
2.  **Maven for Java**
3.  **Eclipse PDE support** - *核心插件，用于解析 `.target` 和 `.launch` 文件。*

![image-20251219015151379](/C:/Users/86182/AppData/Roaming/Typora/typora-user-images/image-20251219015151379.png)

---

## 2. 配置 Target Platform

本项目使用 Target Platform Definition 来定位 Eclipse 依赖库。

1.  **准备 Target 文件**:
    确保项目根目录下有 `target.target` 文件。

2.  **需要指定${eclipse_home}路径**:

```
<location path="${eclipse_home}" type="Profile"/>

${eclipse_home}指的是eclipse的安装路径，如若系统环境变量没有配置
1、在系统环境变量上配置
2、硬编码指定(只适合本地调式)
```

<img src="/C:/Users/86182/AppData/Roaming/Typora/typora-user-images/image-20251219111036054.png" alt="image-20251219111036054" style="zoom:50%;" />

1. **加载 Target (Reload)**:

   *   在 VS Code 资源管理器中，右键点击 `target.target`。
   *   选择 **Reload Target Platform**。

   <img src="/C:/Users/86182/AppData/Roaming/Typora/typora-user-images/image-20251219015254196.png" alt="image-20251219015254196" style="zoom:50%;" />

---

## 3. 运行与调试 (Run and Debug)

1. **开始调试**:
   *   在 VS Code 资源管理器中，右键点击 `launch/RuyiSDK-IDE.launch`。
   *   选择 **Debug PDE application**。

   <img src="/C:/Users/86182/AppData/Roaming/Typora/typora-user-images/image-20251219015415017.png" alt="image-20251219015415017" style="zoom:50%;" />

2. **故障排查 - "无反应" (No Reaction)**:
   *   **重要**: 如果点击 "Debug" 后没有反应，或者没有生成 `.vscode/launch.json`，请 **重启 VS Code** (Restart VS Code)。
   *   Eclipse PDE 插件有时需要重启窗口才能正确加载配置。

3. **成功样例**:

<img src="/C:/Users/86182/AppData/Roaming/Typora/typora-user-images/image-20251219111208148.png" alt="image-20251219111208148" style="zoom: 33%;" />

## 4. 关键文件说明

*   `target.target`: 定义编译所需的 Eclipse 库文件。
*   `javaConfig.json`: 告诉 VS Code 扩展项目结构和 target 位置。
    ```json
    {
      "projects": [
        "./plugins/org.ruyisdk.core",
        "./plugins/org.ruyisdk.devices",
        "./plugins/org.ruyisdk.intro",
        "./plugins/org.ruyisdk.news",
        "./plugins/org.ruyisdk.packages",
        "./plugins/org.ruyisdk.projectcreator",
        "./plugins/org.ruyisdk.ruyi",
        "./plugins/org.ruyisdk.ui",
        "./features/org.ruyisdk.feature",
        "./tests/org.ruyisdk.ruyi.tests"
      ],
      "targetPlatform": "./target.target"
    }
    ```
*   `launch/RuyiSDK-IDE.launch`: 启动配置脚本。
