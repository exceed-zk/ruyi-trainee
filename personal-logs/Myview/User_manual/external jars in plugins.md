![image-20251114093835724](https://cdn.jsdelivr.net/gh/exceed-zk/BlogImages@main/zk/image-20251114093835724.png)

### 1. 第一个文件修改（plugins/org.ruyisdk.packages/build.properties）

- •**修改内容**：将特定的JAR包 `lib/javax.json-1.1.4.jar`从 `bin.includes`和 `jars.extra.classpath`中移除，并替换为包含整个 `lib/`目录。
- •**目的**：这个修改旨在简化依赖管理。原本只包含单个JAR文件（`javax.json-1.1.4.jar`），现在改为包含整个 `lib/`目录，这意味着构建时会自动包含该目录下的所有JAR文件，而不仅限于特定版本。这样做可以提高灵活性，避免因版本更新或添加新库时需要手动修改配置，同时确保所有依赖库都被正确打包到构建输出中。可能的原因是项目依赖从单一JAR扩展到了多个库，或者为了统一管理lib目录下的资源。

### 2. 第二个文件修改（plugins/org.ruyisdk.projectcreator/build.properties）

- •**修改内容**：在 `bin.includes`列表中，将单独列出的当前目录（`.`）调整为先列出 `META-INF/`目录，然后再列出当前目录（`.`）。这改变了资源打包的顺序。
- •**目的**：这个修改是为了调整资源在构建输出中的打包顺序。`bin.includes`定义了哪些文件和目录会被包含在最终的插件或JAR中。通过将 `META-INF/`目录优先列出，可以确保元数据文件（如MANIFEST.MF等）在其他资源之前被处理。这有助于避免类加载冲突或启动问题，因为META-INF目录通常包含插件清单、服务定义等重要元数据，优先处理能保证插件在运行时正确初始化和加载依赖。

### 3. 第三个文件修改（plugins/org.ruyisdk.ruyi/build.properties）

- •**修改内容**：向 `bin.includes`中添加 `lib/`目录，并在 `jars.extra.classpath`中新增对两个JAR包（`gson-2.12.1.jar`和 `json-20250107.jar`）的引用。
- •**目的**：这个修改是为了引入新的库依赖并确保它们被正确包含在构建和运行时类路径中。添加 `lib/`目录到 `bin.includes`意味着在构建输出中包含整个lib目录，确保所有库文件都被打包到最终产物中。同时，在 `jars.extra.classpath`中添加 `gson-2.12.1.jar`（Google的Gson库，用于JSON序列化/反序列化）和 `json-20250107.jar`（可能是一个通用的JSON处理库），表示项目需要这些库来支持新的JSON处理功能。这可能是为了扩展项目的JSON解析能力，例如处理API响应或配置文件。

总结来说，这些修改分别优化了依赖管理、资源打包顺序和功能扩展，目的是提高构建的灵活性、可靠性和功能支持。