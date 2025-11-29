# 2025-11-09

## 在 Eclipse 中调试 Maven/Tycho 插件的完整步骤

### 方法一：使用 Eclipse Application 启动配置（推荐）

1. **导入项目到 Eclipse**
   
   - `File` → `Open Projects from File System` → `Directory` 
   
   - 选择 `ruyisdk-eclipse-plugins` 目录
   
   - 确保所有子模块都被导入
   
     <img src="https://imgbed.szmckj.cn/uploads/2025/11/09/69108953966d3.png" alt="image-20251109203009813" style="zoom:50%;" />
   
   <img src="https://imgbed.szmckj.cn/uploads/2025/11/09/69108a31bc568.png" alt="image-20251109203353232" style="zoom:50%;" />
   
   
   
   - 右键点击任意一个插件项目（如 `org.ruyisdk.core`）
   
   - 选择 `Debug As` → `Eclipse Application`
   
     <img src="https://imgbed.szmckj.cn/uploads/2025/11/08/690ef4d11a450.png" alt="image-20251108154415494" style="zoom:50%;" />
   
   - 完成：
   
     <img src="https://imgbed.szmckj.cn/uploads/2025/11/08/690ef5f2e7d34.png" alt="image-20251108154906041" style="zoom:50%;" />
   
   
   
   

### 方法二：自定义启动配置

> 导入参考方法一，是一样的

1. **打开运行配置**
   
   - `Debug As` → `Debug Configurations...`
   
   - 双击 `Eclipse Application` 创建新配置
   
2. **配置参数-参照上图**
   
   - **Name**: 给配置起个名字，如 "RuyiSDK Debug"   
   
   - **Main** 标签页：
     
     - Program to Run: `Run an application: org.eclipse.ui.ide.workbench`
     
     <img src="https://imgbed.szmckj.cn/uploads/2025/11/08/690f00acb8b82.png" alt="image-20251108163451552" style="zoom:50%;" />
     
   - **Plug-ins** 标签页：
   
     <img src="https://imgbed.szmckj.cn/uploads/2025/11/08/690f005fb22b2.png" alt="image-20251108163334183" style="zoom:50%;" />
   
     - 选择 `Launch with: plug-ins selected below`
     
     - 点击（可选） `Include Required Plug-ins ...` 自动添加依赖
     
     - ## 配置
     
       ![image-20251109211917953](https://imgbed.szmckj.cn/uploads/2025/11/09/691094d93162a.png)
     
       ### 方式 A：全选依赖（推荐）
     
       <img src="https://imgbed.szmckj.cn/uploads/2025/11/09/691095b19ba29.png" alt="image-20251109212257022" style="zoom:50%;" />
     
       ❌ Include required Plug-ins automatically while launching
     
       ✅ 默认全选中 669/669 个插件
     
       结果：
     
       - ✅ 不会报错（因为所有插件都在）
     
       ------
     
       ### 方式 B：自动依赖
     
       ![image-20251109212150670](https://imgbed.szmckj.cn/uploads/2025/11/09/6910956fed50f.png)
     
       ✅ Include required Plug-ins automatically while launching
     
       ✅ 只勾选你的 8 个 RuyiSDK 插件
     
       结果：
     
       - ✅ 启动快（只加载必需的插件）
     
       - ✅ 类似于启动"最小化的 Eclipse + 插件"
     
       点击 `Debug` 按钮后控制台报错：
       
       - ✅ 其他功能正常
       - Eclipse PDE UI 插件相关的图标加载失败
       
       ```
       Cannot invoke "org.eclipse.ui.intro.IIntroPart.getTitle()" 
       because "this.introPart" is null
       ```
       
       这些错误只是：
       
       - Eclipse 平台的某些 UI 元素加载失败
       
       - 不影响插件功能测试
       
       ### 方式C：上述两种都勾选也可以
       
       ![image-20251109214352243](https://imgbed.szmckj.cn/uploads/2025/11/09/69109a9e327cb.png)
   
3. **启动调试**
   
   - 点击 `Debug` 按钮
   - 新的 Eclipse 实例将以调试模式启动

> 文档更新时间：2025/11/09
>
> 参考Eclipse版本：2025.9
