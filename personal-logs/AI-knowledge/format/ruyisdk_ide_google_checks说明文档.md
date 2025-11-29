# RuyiSDK IDE Google Checks 配置文件详细说明

## 文档概述

此文件 `ruyisdk_ide_google_checks.xml` 是基于 Google Java 编码规范的 Checkstyle 配置文件，用于静态代码分析和质量检查。

**配置版本**: Checkstyle Configuration 1.3  
**文件编码**: UTF-8  
**检查文件类型**: java, properties, xml

---

## 根模块配置 (Checker)

### 基本属性
- **severity**: warning - 所有违规默认级别为警告
- **charset**: UTF-8 - 使用 UTF-8 字符集检查文件
- **fileExtensions**: java, properties, xml - 检查这三种类型的文件

---

## TreeWalker 检查模块

TreeWalker 是 Checkstyle 的核心检查器，遍历 Java 抽象语法树（AST）进行检查。

### 1. 文件和类型命名检查

#### OuterTypeFilename
**作用**: 确保外部类型名称与文件名匹配  
**规则**: 公共类/接口名必须与 Java 文件名相同  
**示例**: `public class MyClass` 必须在 `MyClass.java` 文件中

#### OneTopLevelClass
**作用**: 每个文件只能有一个顶级类  
**规则**: 一个 .java 文件中只能定义一个顶级类或接口  
**目的**: 提高代码可读性和可维护性

---

### 2. 字符和转义检查

#### IllegalTokenText
**作用**: 禁止使用某些字面量文本格式  
**检查内容**:
- 禁止使用八进制转义序列
- 禁止使用某些 Unicode 转义值
- **正则表达式**: `\\u00(09|0(a|A)|0(c|C)|0(d|D)|22|27|5(C|c))|\\(0(10|11|12|14|15|42|47)|134)`
- **适用于**: 字符串字面量、字符字面量
- **建议**: 使用特殊转义序列代替八进制值或 Unicode 转义值

#### AvoidEscapedUnicodeCharacters
**作用**: 避免使用转义的 Unicode 字符  
**配置**:
- `allowByTailComment`: true - 允许在行尾注释中使用
- `allowEscapesForControlCharacters`: true - 允许控制字符的转义
- `allowNonPrintableEscapes`: true - 允许不可打印字符的转义
- **目的**: 提高代码可读性

---

### 3. 导入语句检查

#### AvoidStarImport
**作用**: 禁止使用星号导入  
**规则**: 不允许 `import java.util.*;` 这样的导入  
**要求**: 必须明确导入每个类，如 `import java.util.List;`

#### NoLineWrap
**作用**: 某些语句不允许换行  
**适用于**: package 声明、import 语句、static import 语句  
**规则**: 这些语句必须在一行内完成

#### CustomImportOrder
**作用**: 自定义 import 语句的排序规则  
**配置**:
- `customImportOrderRules`: STATIC###THIRD_PARTY_PACKAGE
  - 静态导入在前
  - 第三方包导入在后
- `sortImportsInGroupAlphabetically`: true - 同组内按字母顺序排序

---

### 4. 大括号和代码块检查

#### NeedBraces
**作用**: 强制使用大括号  
**适用于**: do、else、for、if、while 语句  
**规则**: 即使只有一行代码也必须使用大括号
```java
// 错误
if (condition) doSomething();

// 正确
if (condition) {
    doSomething();
}
```

#### LeftCurly (左大括号位置)
**两种规则**:
1. **LeftCurlyEol** (End of Line)
   - **适用于**: 类、接口、方法、构造函数、枚举、try-catch 等
   - **规则**: 左大括号必须在行尾
   ```java
   public class MyClass {  // 正确
   ```

2. **LeftCurlyNl** (New Line)
   - **适用于**: case 和 default 语句
   - **规则**: 左大括号必须在新行

#### RightCurly (右大括号位置)
**两种规则**:
1. **RightCurlySame** (同一行)
   - **适用于**: try、catch、if、else、do
   - **规则**: 右大括号与下一个关键字在同一行
   ```java
   } catch (Exception e) {
   } else {
   ```

2. **RightCurlyAlone** (独立行)
   - **适用于**: 类、方法、构造函数、for、while、switch 等
   - **规则**: 右大括号独占一行

---

### 5. 空格检查

#### WhitespaceAfter
**作用**: 特定标记后必须有空格  
**适用于**: 逗号、分号、类型转换、if、else、return、while、do、for 等  
**示例**:
```java
int a, b;        // 逗号后有空格
if (x) {         // if 后有空格
return x;        // return 后有空格
```

#### WhitespaceAround
**作用**: 特定标记前后都必须有空格  
**适用于**: 赋值运算符、逻辑运算符、比较运算符、大括号等  
**特殊配置**:
- 允许空构造函数: `{}`
- 允许空 lambda: `() -> {}`
- 允许空循环体
- 允许空方法体
- 允许空 switch 块
- 允许空类型声明

#### NoWhitespaceBefore
**作用**: 特定标记前不允许有空格  
**适用于**: 逗号、分号、后置自增/自减、点号等  
**配置**: `allowLineBreaks`: true - 允许在这些标记前换行

#### NoWhitespaceBeforeCaseDefaultColon
**作用**: case 和 default 语句的冒号前不允许有空格  
**示例**:
```java
case 1:  // 正确
case 2 : // 错误
```

#### GenericWhitespace
**作用**: 泛型尖括号的空格规则  
**规则**: 控制泛型声明中的空格使用

---

### 6. 缩进检查

#### Indentation
**作用**: 检查代码缩进是否正确  
**规则**: 使用一致的缩进级别（通常为 2 或 4 个空格）

---

### 7. 命名约定检查

#### PackageName (包名)
**格式**: `^[a-z]+(\.[a-z][a-z0-9]*)*$`  
**规则**: 全小写字母，可以包含数字（但不能以数字开头）  
**示例**: `com.example.myproject`

#### TypeName (类型名)
**适用于**: 类、接口、枚举、注解、记录  
**格式**: UpperCamelCase（大驼峰命名法）  
**示例**: `MyClassName`, `PersonInterface`

#### MemberName (成员变量名)
**格式**: `^[a-z][a-z0-9][a-zA-Z0-9]*$`  
**规则**: 小写字母开头，至少 2 个字符，使用 lowerCamelCase  
**示例**: `userName`, `totalCount`

#### ParameterName (参数名)
**格式**: `^[a-z]([a-z0-9][a-zA-Z0-9]*)?$`  
**规则**: 小写字母开头，可以是单个字符或 lowerCamelCase  
**示例**: `i`, `userName`, `maxValue`

#### LocalVariableName (局部变量名)
**格式**: `^[a-z]([a-z0-9][a-zA-Z0-9]*)?$`  
**规则**: 与参数名相同，小写字母开头  
**示例**: `count`, `tempValue`

#### LambdaParameterName (Lambda 参数名)
**格式**: `^[a-z]([a-z0-9][a-zA-Z0-9]*)?$`  
**规则**: 与普通参数名相同

#### CatchParameterName (异常参数名)
**格式**: `^[a-z]([a-z0-9][a-zA-Z0-9]*)?$`  
**规则**: 小写字母开头  
**示例**: `e`, `exception`, `ioException`

#### PatternVariableName (模式变量名)
**格式**: `^[a-z]([a-z0-9][a-zA-Z0-9]*)?$`  
**规则**: 用于模式匹配的变量命名（Java 14+）

#### MethodName (方法名)
**格式**: `^[a-z][a-z0-9][a-zA-Z0-9]*$`  
**规则**: 小写字母开头，至少 2 个字符，lowerCamelCase  
**示例**: `getUserName()`, `calculateTotal()`  
**特殊**: 测试方法可以使用下划线

#### RecordComponentName (记录组件名)
**格式**: `^[a-z]([a-z0-9][a-zA-Z0-9]*)?$`  
**规则**: 用于 Java 记录类型的组件命名

#### ClassTypeParameterName (类型参数名 - 类)
**格式**: `(^[A-Z][0-9]?)$|([A-Z][a-zA-Z0-9]*[T]$)`  
**规则**: 单个大写字母或大写字母+数字，或以 T 结尾的名称  
**示例**: `T`, `E`, `K`, `V`, `ResultT`

#### MethodTypeParameterName (类型参数名 - 方法)
**格式**: `(^[A-Z][0-9]?)$|([A-Z][a-zA-Z0-9]*[T]$)`  
**示例**: `<T>`, `<E>`, `<K, V>`

#### InterfaceTypeParameterName (类型参数名 - 接口)
**格式**: `(^[A-Z][0-9]?)$|([A-Z][a-zA-Z0-9]*[T]$)`  
**示例**: `interface List<E>`

#### RecordTypeParameterName (类型参数名 - 记录)
**格式**: `(^[A-Z][0-9]?)$|([A-Z][a-zA-Z0-9]*[T]$)`

---

### 8. 代码结构检查

#### OneStatementPerLine
**作用**: 每行只能有一条语句  
**错误示例**: `int a = 1; int b = 2;`  
**正确示例**:
```java
int a = 1;
int b = 2;
```

#### MultipleVariableDeclarations
**作用**: 每个声明只能声明一个变量  
**错误示例**: `int a, b;`  
**正确示例**:
```java
int a;
int b;
```

#### ArrayTypeStyle
**作用**: 数组类型声明的风格  
**推荐**: `String[] args` (Java 风格)  
**不推荐**: `String args[]` (C 风格)

#### OverloadMethodsDeclarationOrder
**作用**: 重载方法必须连续声明  
**规则**: 同名的重载方法应该在代码中连续出现

#### ConstructorsDeclarationGrouping
**作用**: 构造函数应该分组在一起  
**规则**: 所有构造函数应该连续声明

#### VariableDeclarationUsageDistance
**作用**: 变量声明应该靠近使用位置  
**规则**: 减少变量声明与首次使用之间的距离

---

### 9. 控制流检查

#### MissingSwitchDefault
**作用**: switch 语句必须有 default 分支  
**规则**: 所有 switch 语句必须包含 default case

#### FallThrough
**作用**: 检查 switch 的 case 穿透  
**规则**: case 语句必须以 break、return 或注释结束，避免意外穿透

#### EmptyCatchBlock
**作用**: 不允许空的 catch 块  
**例外**: 如果异常变量名为 "expected"，则允许  
**用途**: 防止吞没异常

---

### 10. 格式和分隔符检查

#### SeparatorWrap
**多个配置**:
1. **SeparatorWrapDot** (点号)
   - 选项: nl (new line)
   - 规则: 点号应该在新行的开头
   ```java
   object
       .method1()
       .method2();
   ```

2. **SeparatorWrapComma** (逗号)
   - 选项: EOL (end of line)
   - 规则: 逗号应该在行尾

3. **SeparatorWrapEllipsis** (省略号)
   - 选项: EOL
   - 规则: 省略号应该在行尾

4. **SeparatorWrapArrayDeclarator** (数组声明符)
   - 选项: EOL

5. **SeparatorWrapMethodRef** (方法引用)
   - 选项: nl
   - 规则: 方法引用符号应该在新行

#### EmptyLineSeparator
**作用**: 要求在特定声明之间有空行  
**适用于**: package、import、类、接口、方法、构造函数等  
**配置**: `allowNoEmptyLineBetweenFields`: true - 字段之间可以不加空行

---

### 11. 括号和运算符检查

#### MethodParamPad
**作用**: 方法名和左括号之间不允许有空格  
**适用于**: 构造函数、方法调用、方法定义等  
**正确**: `method()`  
**错误**: `method ()`

#### ParenPad
**作用**: 括号内侧不允许有空格  
**正确**: `(expression)`  
**错误**: `( expression )`

#### OperatorWrap
**作用**: 运算符换行规则  
**选项**: NL (new line)  
**规则**: 运算符应该在新行的开头  
**适用于**: 算术运算符、比较运算符、逻辑运算符等

---

### 12. 注解检查

#### AnnotationLocation
**两种配置**:
1. **AnnotationLocationMostCases**
   - **适用于**: 类、接口、方法、构造函数等
   - **规则**: 注解独占一行

2. **AnnotationLocationVariables**
   - **适用于**: 变量
   - **规则**: 允许多个注解在同一行

---

### 13. JavaDoc 注释检查

#### InvalidJavadocPosition
**作用**: 检查 Javadoc 注释的位置是否正确  
**规则**: Javadoc 必须在类、方法或字段之前

#### JavadocTagContinuationIndentation
**作用**: Javadoc 标签延续行的缩进  
**规则**: 标签内容应该正确缩进

#### SummaryJavadoc
**作用**: 检查 Javadoc 摘要句  
**禁止的片段**:
- `@return the *`
- `This method returns`
- `A {@code xxx} is a`

#### JavadocParagraph
**作用**: 检查 Javadoc 段落格式  
**配置**: `allowNewlineParagraph`: false

#### RequireEmptyLineBeforeBlockTagGroup
**作用**: 块标签组前需要空行  
**规则**: @param、@return 等标签前需要一个空行

#### AtclauseOrder
**作用**: Javadoc 标签的顺序  
**顺序**: @param → @return → @throws → @deprecated

#### NonEmptyAtclauseDescription
**作用**: 标签描述不能为空  
**规则**: @param、@return 等必须有描述文字

#### JavadocMethod
**作用**: 方法的 Javadoc 检查  
**配置**:
- `accessModifiers`: public - 仅检查 public 方法
- `allowMissingParamTags`: true - 允许缺少参数标签
- `allowMissingReturnTag`: true - 允许缺少返回值标签
- `allowedAnnotations`: Override, Test - 这些注解的方法可以省略 Javadoc

#### MissingJavadocMethod
**作用**: 检查缺少 Javadoc 的方法  
**配置**:
- `scope`: protected - 检查 protected 及以上的方法
- `allowedAnnotations`: Override, Test - 例外情况

#### MissingJavadocType
**作用**: 检查缺少 Javadoc 的类型  
**适用于**: 接口、类、枚举、注解、记录  
**配置**: `skipAnnotations`: Generated, Override

#### SingleLineJavadoc
**作用**: 允许单行 Javadoc  
**示例**: `/** Returns the name. */`

---

### 14. 代码质量检查

#### NoFinalizer
**作用**: 禁止使用 finalize() 方法  
**原因**: finalize() 已被废弃，使用 try-with-resources 替代

#### UpperEll
**作用**: long 类型字面量必须使用大写 L  
**正确**: `1000L`  
**错误**: `1000l`

#### ModifierOrder
**作用**: 修饰符的顺序检查  
**标准顺序**: public → protected → private → abstract → static → final → transient → volatile → synchronized → native → strictfp

#### AbbreviationAsWordInName
**作用**: 限制名称中的连续大写字母  
**配置**:
- `allowedAbbreviationLength`: 0 - 不允许缩写
- `allowedAbbreviations`: I - 允许单个 I (如接口命名)
- `ignoreFinal`: false - final 变量也要检查
- **示例**: `XMLParser` 违规，应改为 `XmlParser`

---

### 15. 注释格式检查

#### CommentsIndentation
**作用**: 注释的缩进应该与代码一致  
**适用于**: 单行注释、块注释

---

### 16. 抑制检查的机制

#### SuppressWarningsHolder
**作用**: 支持 @SuppressWarnings 注解  
**用途**: 允许通过注解临时关闭某些检查

#### SuppressionCommentFilter
**作用**: 通过注释控制检查  
**格式**:
- 关闭: `// CHECKSTYLE.OFF: CheckName`
- 开启: `// CHECKSTYLE.ON: CheckName`

#### SuppressWithNearbyCommentFilter
**作用**: 抑制附近行的检查  
**格式**: `// CHECKSTYLE.SUPPRESS: CheckName`  
**影响范围**: 1 行

---

## Checker 级别的模块

### BeforeExecutionExclusionFileFilter
**作用**: 排除特定文件  
**配置**: 排除 `module-info.java` 文件  
**原因**: module-info.java 有特殊的语法规则

### SuppressWarningsFilter
**作用**: 支持 @SuppressWarnings 注解的过滤器

### SuppressWithNearbyTextFilter
**作用**: 基于文本模式的抑制过滤器  
**格式**: `// CHECKSTYLE.SUPPRESS: CheckName for +N/-N lines`  
**示例**: `// CHECKSTYLE.SUPPRESS: LineLength for +3 lines`

### FileTabCharacter
**作用**: 检查文件中的制表符  
**配置**: `eachLine`: true - 检查每一行  
**规则**: 通常不允许使用制表符，应使用空格

### LineLength
**作用**: 检查行长度  
**配置**:
- `max`: 120 - 最大行长度为 120 字符
- `fileExtensions`: java - 仅检查 Java 文件
- **忽略的行**: package 声明、import 语句、URL 链接

---

## 使用方法

### 在 Eclipse 中使用
1. 安装 Checkstyle 插件 (eclipse-cs)
2. Window → Preferences → Checkstyle
3. 导入此配置文件
4. 在项目属性中启用 Checkstyle

### 在命令行使用
```bash
checkstyle -c ruyisdk_ide_google_checks.xml src/main/java
```

### 在 Maven 中使用
```xml
<plugin>
    <groupId>org.apache.maven.plugins</groupId>
    <artifactId>maven-checkstyle-plugin</artifactId>
    <version>3.3.0</version>
    <configuration>
        <configLocation>docs/developer/coding-guidelines/ruyisdk_ide_google_checks.xml</configLocation>
    </configuration>
</plugin>
```

---

## 总结

此配置文件包含 **60+ 个检查模块**，涵盖：

1. **命名规范** - 包、类、方法、变量的命名约定
2. **代码格式** - 缩进、空格、大括号位置
3. **代码结构** - 导入顺序、方法顺序、空行使用
4. **文档注释** - Javadoc 的格式和完整性
5. **代码质量** - 避免常见错误和反模式
6. **可读性** - 行长度、语句分隔等

遵循这些规则可以确保代码风格统一，提高代码质量和可维护性。

---

**文档生成时间**: 2025年  
**适用版本**: Checkstyle 8.0+  
**基于规范**: Google Java Style Guide
