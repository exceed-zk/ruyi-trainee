# RuyiSDK 使用体验与功能分析

## 一、RuyiSDK 使用截图和感受

### 初次使用体验--Ubuntu Linux x86_64
初次打开 RuyiSDK IDE 界面：

![ef59dc6a7ae6093c5e57a95a2970a55e](https://imgbed.szmckj.cn/uploads/2025/10/19/68f499e20ee05.png)

### 为 Milk-V Duo 编译 HelloWorld 程序

由于无设备，报错仅是upload有问题：

![image-20251019210714422](https://imgbed.szmckj.cn/uploads/2025/10/19/68f4e284c3bc2.png)

### 编译运行示例

按照官网指导，尝试编译 coremark 并用 qemu 运行：

![68a4c46dc3359baad6b3737a03faf7de](https://imgbed.szmckj.cn/uploads/2025/10/19/68f499e85aede.png)

**使用感受**：对于新手用户来说，当前的使用流程不够友好，学习成本较高，介绍资源太过稀少。

## 二、Ruyi 包管理器使用

### Maven 支持功能
当前使用Eclipse官方的tycho去支持 Maven 的初步构想（此前已用于完成 p2 仓库构建），但只能本地压缩包手动更新，对新手用户不够友好，对已经使用的资深用户不够便捷：

![image-20251019172745630](https://imgbed.szmckj.cn/uploads/2025/10/19/68f4af135bb24.png)


## 三、Eclipse 插件功能分析

### 当前问题
了解到 Eclipse 插件功能很丰富，但从新手角度来看，存在以下问题：
- 缺少对插件的详细介绍和直观体验或者说区别
- 对于新用户，不清楚 RuyiSDK 插件的具体功能和应用场景
- 没有说明让用户明显感受到插件带来的便捷性

### 插件说明

*![image-20251019173558441](https://imgbed.szmckj.cn/uploads/2025/10/19/68f4b100f283e.png)

![image-20251019173635571](https://imgbed.szmckj.cn/uploads/2025/10/19/68f4b1255ac31.png)

## 四、具体问题反馈

### SSH 连接问题
样例 SSH 连接不通：

![23cfab993140f2a3cf46c6e71aa05478](https://imgbed.szmckj.cn/uploads/2025/10/19/68f49a00a7799.png)


## 五、CI/CD 集成参考

### GitHub Actions 集成--正在做ing
GitAction CI/CD 介绍参考：
[actions/starter-workflows: Accelerating new GitHub Actions workflows](https://github.com/actions/starter-workflows)

![image-20251020101339667](https://imgbed.szmckj.cn/uploads/2025/10/20/68f59ad4a5250.png)

1. Eclipse 官方插件：

- 主分支：只有源代码

- P2 站点：包含 jar 包

1. VSCode 扩展：

- 主分支：只有源代码

- Releases：包含 .vsix 文件（类似 jar）

1. Maven Central：

- 源代码仓库：不含 jar

- Maven 仓库：全是 jar

## 六、插件更新与分发机制研究

### 核心问题
1. 如何提供插件的更新自动通知？
3. 如何发布插件和扩展，以便让更多人知晓？

### 参考方案分析

#### 参考一：CSDN上的Mozila更新机制

![image-20251019182502140](https://imgbed.szmckj.cn/uploads/2025/10/19/68f4bc80655a4.png)


**总结**：
- 通过 URL 更新，发送请求
- 要么内置，要么官方提供
- Eclipse 提供标准更新路径：Window > Preferences

![image-20251019182749746](https://imgbed.szmckj.cn/uploads/2025/10/19/68f4bd28a261b.png)

![image-20251019182852470](https://imgbed.szmckj.cn/uploads/2025/10/19/68f4bd6633b2e.png)

**现状分析**：目前没有提供，这个原理我还要再学习一些知识搜索一些资料，才能知道原理，目前猜测是就是利用远程仓库地址之类的

![image-20251019183016658](https://imgbed.szmckj.cn/uploads/2025/10/19/68f4bdba7ddfc.png)

#### 参考二：IDEA 方案

![image-20251019183340519](https://imgbed.szmckj.cn/uploads/2025/10/19/68f4be87b677e.png)

**总结**：基于内部 API 或自建远程仓库实现更新机制。

#### 参考三：VS Code 插件机制

![image-20251019184001005](https://imgbed.szmckj.cn/uploads/2025/10/19/68f4c00366b7f.png)


**总结**：
- VS Code 插件使用内部 API
- 支持命令行指令（Eclipse 可能也有类似功能）
- 支持 URL 指定更新，与前述方案类似

#### 参考四：通义灵码参考更新方案

![image-20251019184430687](https://imgbed.szmckj.cn/uploads/2025/10/19/68f4c11172400.png)


**总结**：
- 离不开 IDE 内置的检测接口
- 支持离线安装
- 通过远程 API 发送更新请求，使用 URL 进行更新

## 七、待解决的问题

1. **插件功能明确化**：需要明确 RuyiSDK 插件的具体功能和价值点，以及暴露给用户的思考
2. **新手友好度提升**：降低使用门槛，提供更清晰的使用指引
3. **SSH 连接问题**：解决样例中的连接问题
4. **更新机制建设**：建立完善的插件更新和分发机制
5. **文档完善**：补充详细的插件介绍和使用文档，添加类似搜索功能、常见问题
6. **我的问题**：由于确实是第一次了解到并投入插件开发和Eclipse其他版本的使用，所以目前还在搜索资料学习，也发现网上的资料有些过于古老