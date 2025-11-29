

RuyiSDK使用截图和感受，另外还有ruyi包管理器的使用



了解到Eclipse插件功能很丰富，但我以新手的角度来看，就是发现缺少对插件的介绍，以至于现在对于现在Ruyisdk插件是做什么体现在什么地方，具体能便捷干什么还没发现

**![image-20251019173558441](https://imgbed.szmckj.cn/uploads/2025/10/19/68f4b100f283e.png)**![image-20251019173635571](https://imgbed.szmckj.cn/uploads/2025/10/19/68f4b1255ac31.png)



这个样例ssh连接不通

![23cfab993140f2a3cf46c6e71aa05478](https://imgbed.szmckj.cn/uploads/2025/10/19/68f49a00a7799.png)

初次打开RuyiSDK IDE界面

![ef59dc6a7ae6093c5e57a95a2970a55e](https://imgbed.szmckj.cn/uploads/2025/10/19/68f499e20ee05.png)

按照官网，编译coremark用qemu运行
对我这个小白其实不太友好

![68a4c46dc3359baad6b3737a03faf7de](https://imgbed.szmckj.cn/uploads/2025/10/19/68f499e85aede.png)

这个是支持maven的一个想法，之前就是用这个完成p2仓库构建，但现在仅列举

![image-20251019172745630](https://imgbed.szmckj.cn/uploads/2025/10/19/68f4af135bb24.png)

gitAction--CI介绍

[actions/starter-workflows: Accelerating new GitHub Actions workflows](https://github.com/actions/starter-workflows)





- 如何提供插件的更新自动通知？
- 如何将扩展和插件捆绑在一起让用户安装？（因为可能你不仅仅要安装插件，还希望在用户的FF工具栏或菜单上添加一些扩展功能）
- 如何发布你的插件和扩展，以便让更多人知晓？



参考：

![image-20251019182502140](https://imgbed.szmckj.cn/uploads/2025/10/19/68f4bc80655a4.png)

总结：URL更新，发送请求，要么内置，要么官方提供，Eclipse有一个
Window > Preferences
![image-20251019182749746](https://imgbed.szmckj.cn/uploads/2025/10/19/68f4bd28a261b.png)

![image-20251019182852470](https://imgbed.szmckj.cn/uploads/2025/10/19/68f4bd6633b2e.png)

目前没有提供，这个原理我还要在学习一些知识，才能知道原理，目前猜测是就是利用远程仓库地址之类的
![image-20251019183016658](https://imgbed.szmckj.cn/uploads/2025/10/19/68f4bdba7ddfc.png)

参考二：

![image-20251019183340519](https://imgbed.szmckj.cn/uploads/2025/10/19/68f4be87b677e.png)

总结：

也是基于内部api，或者自己搭建远程仓库



参考三：
![image-20251019184001005](https://imgbed.szmckj.cn/uploads/2025/10/19/68f4c00366b7f.png)

总结：Vscode插件的话也是内部api，不过还支持指令（Eclipse或许也有？），还有就是URL指定更新，与上述类似

参考4：

![image-20251019184430687](https://imgbed.szmckj.cn/uploads/2025/10/19/68f4c11172400.png)

总结：可以看出还是离不开IDE内置的检测接口
		离线安装
	 远程api发送更新请求用URL更新