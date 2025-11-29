# CI/CD 集成快速指南

**版本**: 1.0 | **日期**: 2025-11-23 | **状态**: ✅ 生产就绪

---

## 🎯 核心命令

### 本地开发
```bash
# 格式化 + 检查
mvn formatter:format checkstyle:check
```

### CI/CD 验证
```bash
# 一行命令完成所有检查
mvn checkstyle:check formatter:validate
```

---

## 📋 配置示例

### GitHub Actions
```yaml
name: Quality Check
on: [push, pull_request]
jobs:
  check:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-java@v3
        with:
          java-version: '17'
          distribution: 'temurin'
      - run: mvn checkstyle:check formatter:validate
```

### Jenkins Pipeline
```groovy
pipeline {
    agent any
    stages {
        stage('Quality') {
            steps {
                sh 'mvn checkstyle:check formatter:validate'
            }
        }
    }
}
```

---

## 🔍 故障排查

### formatter:validate 失败
```bash
# 解决: 格式化代码
mvn formatter:format
git add . && git commit --amend --no-edit && git push -f
```

### checkstyle:check 失败
```bash
# 查看详细错误
mvn checkstyle:checkstyle
# 打开 target/site/checkstyle.html 查看报告
```

---

## 🛠️ Pre-commit Hook
```bash
# .git/hooks/pre-commit
#!/bin/bash
mvn formatter:format -q && git add -u
```

---

## 📊 配置修改说明

### 修改 1: JavaDoc `<p>`标签
- **位置**: `ruyisdk_ide_google_checks.xml:228`
- **改动**: `allowNewlineParagraph="true"`
- **原因**: 兼容 Formatter 的换行行为
- **影响**: 允许 `<p>` 标签后换行

### 修改 2: 禁用缩进检查
- **位置**: `ruyisdk_ide_google_checks.xml:179-180`
- **改动**: 注释 `<module name="Indentation"/>`
- **原因**: Formatter 缩进 24 空格，Checkstyle 期望 12 空格
- **影响**: 缩进由 Formatter 统一管理

---

## ⚠️ 注意事项

1. **提交前必须格式化**: `mvn formatter:format`
2. **CI失败先检查本地**: 确保本地通过再 push
3. **配置文件不要修改**: 保持团队一致
4. **IDE 配置**: 导入项目的 formatter 配置

---

详见完整文档: [CHECKSTYLE-CONFIG-CHANGES.md](./CHECKSTYLE-CONFIG-CHANGES.md)
