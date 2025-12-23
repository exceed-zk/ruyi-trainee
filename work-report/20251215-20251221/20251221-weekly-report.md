# RuyiSDK 实习周报 第 11 期·2025 年 12 月 21 日

## (12-23补)：本周工作概述

本周主要完成了以下工作：
- 重新搭建被封账号的开发环境，验证 target 平台可用性
- 将分支 rebase 到最新 main，断点与索引恢复稳定
- 推进 VSCode 调试配置，梳理 `launch` 与调试所需 JSON 文件
- 调整 Eclipse `.launch` 配置，验证插件启动成功
- 整理并清理不合规提交，发起调试相关 PR，排查 CI 失败

---

## 提交的 patch

本周聚焦环境恢复与调试配置梳理，暂无已合并的新代码；调试配置相关 PR 已提交，等待 CI 通过后再合入。

idea:[Chore/idea dev setup by exceed-zk · Pull Request #71 · ruyisdk/ruyisdk-eclipse-plugins](https://github.com/ruyisdk/ruyisdk-eclipse-plugins/pull/71)

VS Code:[Chore/vscode dev test by exceed-zk · Pull Request #72 · ruyisdk/ruyisdk-eclipse-plugins](https://github.com/ruyisdk/ruyisdk-eclipse-plugins/pull/72)

---

## 关键工作

### 环境恢复与 target 校验

- 在新账号环境中完成全部开发工具链恢复
- 验证 `target.target` 配置可用，确保 PDE 运行与构建基线一致

### 调试稳定性提升

- 分支 rebase 最新 main，解决旧配置导致的断点失效与索引丢失
- 重新验证 IDEA 断点命中路径，调试体验恢复

### VSCode 调试配置推进

- 明确 VSCode 调试需要的 `launch` 及附加配置文件结构
- 遇到配置不生效问题，确认需重启后才加载新配置
- 整理 VSCode 与 Eclipse 调试配置的差异点，为后续文档打底

### Eclipse 启动与 PR 清理

- 在 Eclipse 中完善 `.launch` 文件，验证插件可以正常启动
- 清理不符合要求的提交，提交调试配置相关 PR，但 CI 仍有未通过项

---

## 问题与解决

1. **配置不生效**  
   - 原因：修改 VSCode/Eclipse 配置后未重启。  
   - 处理：重启后配置生效，调试可正常启动。
2. **断点与索引不稳定**  
   - 原因：本地分支落后，索引缓存失效。  
   - 处理：rebase 最新 main 并重建索引，断点恢复命中。
3. **CI 不通过（进行中）**  
   - 现象：调试配置 PR 触发 CI 失败。  
   - 计划：对照 CI 日志检查配置差异，逐项修复后重跑。

---

## 文档整理

- `other-doc/20251217.md`：记录环境恢复、target 校验、VSCode 配置尝试及 CI 问题。

---

## 本周总结

- 新环境完成恢复，调试链路（IDEA/Eclipse）恢复稳定
- VSCode 调试配置取得初步进展，明确重启生效与配置要点
- 调试 PR 待 CI 通过，后续需继续排查并补充文档
