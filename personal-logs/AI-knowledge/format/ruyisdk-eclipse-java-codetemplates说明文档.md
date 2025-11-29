# RuyiSDK Eclipse Java 代码模板配置文件详细说明

## 文档概述

此文件 `ruyisdk-eclipse-java-codetemplates.xml` 是 Eclipse IDE 的 Java 代码模板配置文件，用于自动生成标准化的代码注释、代码结构和代码片段。

**文件格式**: Eclipse Code Templates XML  
**用途**: 统一项目的代码风格和注释规范  
**配置项数量**: 21 个模板

---

## 模板配置属性说明

每个模板包含以下属性：

- **autoinsert**: 是否自动插入模板（true/false）
- **context**: 模板应用的上下文环境
- **deleted**: 是否被删除（false 表示启用）
- **description**: 模板描述
- **enabled**: 是否启用（true/false）
- **id**: Eclipse 内部唯一标识符
- **name**: 模板名称

---

## 一、注释模板（Comment Templates）

### 1. gettercomment - Getter 方法注释

**配置属性**:
- **autoinsert**: false（需要手动触发）
- **context**: gettercomment_context
- **用途**: 为 getter 方法自动生成标准 JavaDoc 注释

**模板内容**:
```java
/**
 * Returns the ${bare_field_name}.
 *
 * @return the ${bare_field_name}
 */
```

**可用变量**:
- `${bare_field_name}`: 不带前缀的字段名（如 userName）

**生成示例**:
```java
private String userName;

/**
 * Returns the userName.
 *
 * @return the userName
 */
public String getUserName() {
    return userName;
}
```

---

### 2. settercomment - Setter 方法注释

**配置属性**:
- **autoinsert**: false
- **context**: settercomment_context
- **用途**: 为 setter 方法自动生成标准 JavaDoc 注释

**模板内容**:
```java
/**
 * Sets the ${bare_field_name}.
 *
 * @param ${param} the ${bare_field_name} to set
 */
```

**可用变量**:
- `${bare_field_name}`: 不带前缀的字段名
- `${param}`: 方法参数名

**生成示例**:
```java
private String userName;

/**
 * Sets the userName.
 *
 * @param userName the userName to set
 */
public void setUserName(String userName) {
    this.userName = userName;
}
```

---

### 3. constructorcomment - 构造函数注释

**配置属性**:
- **autoinsert**: false
- **context**: constructorcomment_context
- **用途**: 为构造函数自动生成 JavaDoc 注释

**模板内容**:
```java
/**
 * Constructs a new ${enclosing_type}.
 *
 * ${tags}
 */
```

**可用变量**:
- `${enclosing_type}`: 包含该构造函数的类名
- `${tags}`: 自动生成的 @param 标签（如果构造函数有参数）

**生成示例**:
```java
/**
 * Constructs a new Person.
 *
 * @param name the person's name
 * @param age the person's age
 */
public Person(String name, int age) {
    this.name = name;
    this.age = age;
}
```

---

### 4. filecomment - 文件头注释（版权声明）

**配置属性**:
- **autoinsert**: false
- **context**: filecomment_context
- **用途**: 为新创建的 Java 文件添加版权和许可证信息

**模板内容**:
```java
/*
 * Copyright (c) 2025 ISCAS.
 *
 * SPDX-License-Identifier: EPL-2.0
 *
 * Contributors:
 *     ${user} - initial version
 */
```

**可用变量**:
- `${user}`: 当前用户名（从系统获取）

**版权信息说明**:
- **版权所有者**: ISCAS (中国科学院软件研究所)
- **许可证**: EPL-2.0 (Eclipse Public License 2.0)
- **SPDX标识**: 标准的开源许可证标识符

**生成示例**:
```java
/*
 * Copyright (c) 2025 ISCAS.
 *
 * SPDX-License-Identifier: EPL-2.0
 *
 * Contributors:
 *     zhangsan - initial version
 */
package com.example.demo;

public class MyClass {
    // ...
}
```

---

### 5. typecomment - 类型注释

**配置属性**:
- **autoinsert**: false
- **context**: typecomment_context
- **用途**: 为类、接口、枚举等类型生成 JavaDoc 注释

**模板内容**:
```java
/**
 * ${type_name}.
 *
 * ${tags}
 */
```

**可用变量**:
- `${type_name}`: 类型名称（类名、接口名等）
- `${tags}`: 自动生成的标签（如 @author、@since、@param 等）

**生成示例**:
```java
/**
 * Person.
 *
 * @author zhangsan
 * @since 1.0
 */
public class Person {
    // ...
}
```

---

### 6. fieldcomment - 字段注释

**配置属性**:
- **autoinsert**: false
- **context**: fieldcomment_context
- **用途**: 为类的成员变量生成注释

**模板内容**:
```java
/**
 * The ${field}.
 */
```

**可用变量**:
- `${field}`: 字段名

**生成示例**:
```java
/**
 * The userName.
 */
private String userName;

/**
 * The age.
 */
private int age;
```

---

### 7. methodcomment - 方法注释

**配置属性**:
- **autoinsert**: false
- **context**: methodcomment_context
- **用途**: 为非重写方法生成 JavaDoc 注释

**模板内容**:
```java
/**
 * ${enclosing_method}.
 *
 * ${tags}
 */
```

**可用变量**:
- `${enclosing_method}`: 方法名
- `${tags}`: 自动生成的标签（@param、@return、@throws 等）

**生成示例**:
```java
/**
 * calculateTotal.
 *
 * @param price the unit price
 * @param quantity the quantity
 * @return the total amount
 */
public double calculateTotal(double price, int quantity) {
    return price * quantity;
}
```

---

### 8. modulecomment - 模块注释

**配置属性**:
- **autoinsert**: false
- **context**: modulecomment_context
- **用途**: 为 Java 9+ 的 module-info.java 文件生成注释

**模板内容**:
```java
/**
 * ${enclosing_module}.
 *
 * ${tags}
 */
```

**可用变量**:
- `${enclosing_module}`: 模块名
- `${tags}`: 相关标签

**生成示例**:
```java
/**
 * com.example.mymodule.
 *
 * @since 1.0
 */
module com.example.mymodule {
    exports com.example.api;
    requires java.base;
}
```

---

### 9. overridecomment - 重写方法注释

**配置属性**:
- **autoinsert**: true（自动插入）
- **context**: overridecomment_context
- **用途**: 为重写的方法生成注释

**模板内容**: **空**（不生成注释）

**说明**: 
此模板为空，意味着带有 `@Override` 注解的方法不会自动生成 JavaDoc 注释。这符合 Google Java 编码规范，因为重写方法的文档应该参考父类/接口的文档。

**生成示例**:
```java
@Override
public String toString() {
    return "Person[name=" + name + "]";
}
// 不生成额外的 JavaDoc 注释
```

---

### 10. delegatecomment - 委托方法注释

**配置属性**:
- **autoinsert**: false
- **context**: delegatecomment_context
- **用途**: 为委托方法生成注释

**模板内容**:
```java
/**
 * ${enclosing_method}.
 *
 * ${tags}
 * ${see_to_target}
 */
```

**可用变量**:
- `${enclosing_method}`: 方法名
- `${tags}`: 标签（@param、@return 等）
- `${see_to_target}`: 指向被委托目标的 @see 标签

**生成示例**:
```java
private List<String> list = new ArrayList<>();

/**
 * add.
 *
 * @param e the element to add
 * @return true if added successfully
 * @see java.util.List#add(Object)
 */
public boolean add(String e) {
    return list.add(e);
}
```

---

## 二、代码结构模板（Structure Templates）

### 11. newtype - 新文件结构

**配置属性**:
- **autoinsert**: true（自动插入）
- **context**: newtype_context
- **用途**: 定义新建 Java 文件时的整体结构

**模板内容**:
```java
${filecomment}
${package_declaration}

${typecomment}
${type_declaration}
```

**可用变量**:
- `${filecomment}`: 文件头注释（版权声明）
- `${package_declaration}`: package 声明
- `${typecomment}`: 类型注释
- `${type_declaration}`: 类型声明

**生成示例**:
```java
/*
 * Copyright (c) 2025 ISCAS.
 *
 * SPDX-License-Identifier: EPL-2.0
 *
 * Contributors:
 *     zhangsan - initial version
 */
package com.example.demo;

/**
 * MyClass.
 *
 */
public class MyClass {

}
```

---

### 12. classbody - 类体内容

**配置属性**:
- **autoinsert**: true
- **context**: classbody_context
- **用途**: 定义新建类时类体内的默认内容

**模板内容**: **空**（不添加任何默认内容）

**说明**: 
新建的类内部默认为空，不添加任何默认方法或字段。

---

### 13. interfacebody - 接口体内容

**配置属性**:
- **autoinsert**: true
- **context**: interfacebody_context
- **用途**: 定义新建接口时接口体内的默认内容

**模板内容**: **空**

**说明**: 
新建的接口内部默认为空。

---

### 14. enumbody - 枚举体内容

**配置属性**:
- **autoinsert**: true
- **context**: enumbody_context
- **用途**: 定义新建枚举时枚举体内的默认内容

**模板内容**: **空**

**说明**: 
新建的枚举内部默认为空。

---

### 15. recordbody - 记录体内容

**配置属性**:
- **autoinsert**: true
- **context**: recordbody_context
- **用途**: 定义新建记录类型（Java 14+）时的默认内容

**模板内容**: **空**

**说明**: 
新建的 record 内部默认为空。Java 14 引入的 record 类型。

---

### 16. annotationbody - 注解体内容

**配置属性**:
- **autoinsert**: true
- **context**: annotationbody_context
- **用途**: 定义新建注解类型时的默认内容

**模板内容**: **空**

**说明**: 
新建的注解类型内部默认为空。

---

## 三、代码片段模板（Code Snippet Templates）

### 17. catchblock - catch 块代码

**配置属性**:
- **autoinsert**: true
- **context**: catchblock_context
- **用途**: 自动生成 catch 块的默认代码

**模板内容**:
```java
// ${todo} Auto-generated catch block
${exception_var}.printStackTrace();
```

**可用变量**:
- `${todo}`: TODO 标记（通常是 "TODO"）
- `${exception_var}`: 异常变量名（如 e、ex、exception）

**生成示例**:
```java
try {
    // some code
} catch (IOException e) {
    // TODO Auto-generated catch block
    e.printStackTrace();
}
```

**说明**: 
这是一个占位代码，开发者应该替换 `printStackTrace()` 为适当的异常处理逻辑。

---

### 18. methodbody - 方法体代码

**配置属性**:
- **autoinsert**: true
- **context**: methodbody_context
- **用途**: 自动生成方法体的默认代码

**模板内容**:
```java
// ${todo} Auto-generated method stub
${body_statement}
```

**可用变量**:
- `${todo}`: TODO 标记
- `${body_statement}`: 默认的返回语句（如果方法有返回值）

**生成示例**:

**有返回值的方法**:
```java
public String getName() {
    // TODO Auto-generated method stub
    return null;
}
```

**无返回值的方法**:
```java
public void doSomething() {
    // TODO Auto-generated method stub
    
}
```

**说明**: 
提醒开发者这是自动生成的代码，需要实现具体逻辑。

---

### 19. constructorbody - 构造函数体代码

**配置属性**:
- **autoinsert**: true
- **context**: constructorbody_context
- **用途**: 自动生成构造函数体的默认代码

**模板内容**:
```java
${body_statement}
// ${todo} Auto-generated constructor stub
```

**可用变量**:
- `${body_statement}`: 调用父类构造函数的语句（如果需要）
- `${todo}`: TODO 标记

**生成示例**:

**普通构造函数**:
```java
public MyClass() {
    
    // TODO Auto-generated constructor stub
}
```

**子类构造函数**:
```java
public ChildClass(String name) {
    super(name);
    // TODO Auto-generated constructor stub
}
```

---

### 20. getterbody - Getter 方法体

**配置属性**:
- **autoinsert**: true
- **context**: getterbody_context
- **用途**: 自动生成 getter 方法的方法体

**模板内容**:
```java
return ${field};
```

**可用变量**:
- `${field}`: 字段名

**生成示例**:
```java
private String userName;

public String getUserName() {
    return userName;
}
```

**说明**: 
标准的 getter 方法实现，直接返回字段值。

---

### 21. setterbody - Setter 方法体

**配置属性**:
- **autoinsert**: true
- **context**: setterbody_context
- **用途**: 自动生成 setter 方法的方法体

**模板内容**:
```java
${field} = ${param};
```

**可用变量**:
- `${field}`: 字段名
- `${param}`: 参数名

**生成示例**:
```java
private String userName;

public void setUserName(String userName) {
    this.userName = userName;
}
```

**说明**: 
标准的 setter 方法实现，将参数值赋给字段。注意这里使用 `this.` 来区分字段和参数。

---

## 变量参考表

### 常用模板变量

| 变量名 | 说明 | 示例 |
|--------|------|------|
| `${user}` | 当前系统用户名 | zhangsan |
| `${date}` | 当前日期 | 2025-11-17 |
| `${time}` | 当前时间 | 10:30:00 |
| `${year}` | 当前年份 | 2025 |
| `${file_name}` | 文件名 | MyClass.java |
| `${package_name}` | 包名 | com.example.demo |
| `${project_name}` | 项目名 | my-project |
| `${type_name}` | 类型名称 | MyClass |
| `${enclosing_type}` | 包含的类型名 | OuterClass |
| `${enclosing_method}` | 包含的方法名 | doSomething |
| `${enclosing_module}` | 包含的模块名 | my.module |
| `${field}` | 字段名 | userName |
| `${bare_field_name}` | 不带前缀的字段名 | name (from mName) |
| `${param}` | 参数名 | value |
| `${exception_var}` | 异常变量名 | e, exception |
| `${tags}` | 自动生成的标签 | @param, @return, @throws |
| `${todo}` | TODO 标记 | TODO |
| `${body_statement}` | 方法体默认语句 | return null; |
| `${see_to_target}` | @see 链接 | @see List#add |
| `${package_declaration}` | package 声明 | package com.example; |
| `${type_declaration}` | 类型声明 | public class MyClass |
| `${filecomment}` | 文件头注释 | 版权声明 |
| `${typecomment}` | 类型注释 | JavaDoc 注释 |

---

## 使用方法

### 在 Eclipse 中配置

1. **导入模板文件**
   - 打开 Eclipse
   - 菜单: Window → Preferences
   - 导航: Java → Code Style → Code Templates
   - 点击 "Import..." 按钮
   - 选择 `ruyisdk-eclipse-java-codetemplates.xml` 文件
   - 点击 "OK" 应用配置

2. **启用自动代码生成**
   - 在同一配置页面中
   - 勾选 "Automatically add comments for new methods and types"
   - 配置具体的模板启用/禁用状态

3. **使用模板生成代码**
   - **生成 Getter/Setter**: 右键字段 → Source → Generate Getters and Setters
   - **生成构造函数**: 右键类 → Source → Generate Constructor using Fields
   - **创建新类**: File → New → Class（自动应用文件头和类注释）
   - **添加方法**: 输入方法签名后，Eclipse 自动填充方法体

### 快捷键

- **生成 Getter/Setter**: `Alt + Shift + S` → `R`
- **生成构造函数**: `Alt + Shift + S` → `O`
- **生成委托方法**: `Alt + Shift + S` → `D`
- **添加方法注释**: 在方法上方输入 `/**` 然后按 `Enter`

---

## 自定义模板

### 修改现有模板

1. 打开 Eclipse Preferences → Java → Code Style → Code Templates
2. 选择要修改的模板
3. 点击 "Edit..." 按钮
4. 修改模板内容
5. 点击 "OK" 保存

### 添加自定义变量

可以在模板中使用以下语法添加自定义内容：
- `${cursor}`: 生成后光标位置
- `${word_selection}`: 当前选中的文字
- `${line_selection}`: 当前选中的行

### 导出模板

1. Java → Code Style → Code Templates
2. 点击 "Export..." 按钮
3. 保存为 XML 文件

---

## 最佳实践

### 1. 注释规范
- **文件头注释**: 每个文件都应包含版权声明和许可证信息
- **类注释**: 简要说明类的用途和职责
- **方法注释**: 对 public 和 protected 方法提供清晰的文档
- **重写方法**: 不需要重复父类的文档，使用 `@Override` 即可

### 2. 代码生成
- **Getter/Setter**: 使用 Eclipse 工具生成，保持一致性
- **构造函数**: 优先使用"使用字段生成构造函数"功能
- **异常处理**: 不要保留自动生成的 `printStackTrace()`，应该使用日志框架

### 3. TODO 标记
- 自动生成的代码包含 `// TODO` 标记
- 实现完成后应删除这些标记
- 可以使用 Eclipse 的 Tasks 视图查看所有 TODO

### 4. 版权信息
- **ISCAS**: 中国科学院软件研究所
- **EPL-2.0**: Eclipse Public License 2.0
  - 宽松的开源许可证
  - 允许商业使用
  - 需要保留版权声明
  - 修改后的文件需要声明修改

---

## 与 Google Java Style Guide 的关系

此模板配置与 Google Java 编码规范保持一致：

1. **JavaDoc 要求**
   - Public API 必须有文档
   - 重写方法不需要重复文档
   - 自解释的方法可以省略文档

2. **版权声明**
   - 文件顶部包含版权和许可证信息
   - 使用 SPDX 标识符

3. **代码结构**
   - 文件结构: 版权 → 包声明 → 导入 → 类声明
   - 空行分隔不同部分

4. **命名约定**
   - 配合 Checkstyle 规则使用
   - 方法名: lowerCamelCase
   - 字段名: lowerCamelCase

---

## 常见问题

### Q1: 如何禁用某个模板？
**A**: 在 Code Templates 配置中，取消勾选对应模板的 "enabled" 复选框。

### Q2: 为什么重写方法没有生成注释？
**A**: 这是设计行为。`overridecomment` 模板为空，符合 Google Java 规范。

### Q3: 如何修改版权年份？
**A**: 编辑 `filecomment` 模板，将 "2025" 改为所需年份，或使用 `${year}` 变量。

### Q4: 可以添加自己的模板吗？
**A**: 不能直接在 Eclipse 中添加新的模板类型，但可以修改现有模板的内容。

### Q5: 如何让所有团队成员使用相同的模板？
**A**: 将此 XML 文件分享给团队成员，让他们导入到各自的 Eclipse 中。

### Q6: 模板支持哪些 Java 版本？
**A**: 支持 Java 8 到 Java 17+，包括新特性（如 record、module）。

---

## 总结

此配置文件包含 **21 个代码模板**，分为三大类：

### 📝 注释模板（10个）
用于生成标准化的 JavaDoc 注释，确保代码文档的完整性和一致性。

### 🏗️ 结构模板（6个）
定义新建文件和类型时的基本结构，包括版权声明和默认布局。

### 💻 代码片段模板（5个）
自动生成常用代码片段，如 getter/setter、catch 块、方法体等。

### 核心特点

1. ✅ **符合 Google Java Style Guide**
2. ✅ **包含 ISCAS 版权声明和 EPL-2.0 许可证**
3. ✅ **自动化代码生成，提高开发效率**
4. ✅ **统一团队代码风格**
5. ✅ **支持最新 Java 特性**

---

**文档生成时间**: 2025年11月  
**适用版本**: Eclipse 4.6+  
**配合工具**: 与 Checkstyle 和代码格式化配置协同使用
