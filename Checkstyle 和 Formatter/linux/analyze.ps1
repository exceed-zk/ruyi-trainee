$file = "d:\ruyiSDK\plugins\logs\linux\check-linux.txt"
$content = Get-Content $file

Write-Host "=== Checkstyle 错误统计分析 ===" -ForegroundColor Cyan
Write-Host ""

# 总警告数
$totalWarnings = ($content | Select-String "\[WARN\]").Count
Write-Host "总违规数: $totalWarnings" -ForegroundColor Yellow
Write-Host ""

# 各类错误统计
$errorTypes = @{
    "FileTabCharacter" = "包含 Tab 字符"
    "Indentation" = "缩进错误"
    "MissingJavadocMethod" = "缺少方法 JavaDoc"
    "MissingJavadocType" = "缺少类 JavaDoc"
    "MissingJavadocPackage" = "缺少包 JavaDoc"
    "LineLength" = "行长度超限"
    "MethodName" = "方法命名不规范"
    "ParameterName" = "参数命名不规范"
    "LocalVariableName" = "局部变量命名不规范"
    "MemberName" = "成员变量命名不规范"
    "TypeName" = "类型命名不规范"
    "WhitespaceAround" = "运算符周围空格"
    "WhitespaceAfter" = "符号后缺少空格"
    "LeftCurly" = "左大括号位置"
    "RightCurly" = "右大括号位置"
    "NeedBraces" = "缺少大括号"
    "EmptyBlock" = "空代码块"
    "UnusedImports" = "未使用的 import"
    "RedundantImport" = "冗余的 import"
    "ImportOrder" = "Import 顺序"
    "AvoidStarImport" = "使用星号 import"
    "EmptyLineSeparator" = "缺少空行分隔"
    "SummaryJavadoc" = "JavaDoc 摘要格式"
    "AtclauseOrder" = "JavaDoc 标签顺序"
    "NonEmptyAtclauseDescription" = "JavaDoc 标签描述为空"
    "JavadocParagraph" = "JavaDoc 段落格式"
    "JavadocTagContinuationIndentation" = "JavaDoc 标签缩进"
    "SingleLineJavadoc" = "单行 JavaDoc"
    "InvalidJavadocPosition" = "JavaDoc 位置错误"
}

$stats = @{}
foreach ($key in $errorTypes.Keys) {
    $pattern = "\[$key\]"
    $count = ($content | Select-String $pattern).Count
    if ($count -gt 0) {
        $stats[$key] = @{
            "Count" = $count
            "Desc" = $errorTypes[$key]
            "Percentage" = [math]::Round(($count / $totalWarnings) * 100, 2)
        }
    }
}

# 按数量排序
$sortedStats = $stats.GetEnumerator() | Sort-Object { $_.Value.Count } -Descending

Write-Host "错误类型详细统计:" -ForegroundColor Green
Write-Host ("=" * 80)
Write-Host ("{0,-35} {1,10} {2,12} {3,10}" -f "错误类型", "数量", "占比", "说明")
Write-Host ("-" * 80)

foreach ($item in $sortedStats) {
    $type = $item.Key
    $count = $item.Value.Count
    $percentage = $item.Value.Percentage
    $desc = $item.Value.Desc
    
    Write-Host ("{0,-35} {1,10} {2,11}% {3,10}" -f $type, $count, $percentage, $desc)
}

Write-Host ("=" * 80)
Write-Host ""

# 分类汇总
Write-Host "=== 问题分类汇总 ===" -ForegroundColor Cyan
Write-Host ""

$categories = @{
    "格式问题" = @("FileTabCharacter", "Indentation", "WhitespaceAround", "WhitespaceAfter", "LeftCurly", "RightCurly", "EmptyLineSeparator")
    "JavaDoc 问题" = @("MissingJavadocMethod", "MissingJavadocType", "MissingJavadocPackage", "SummaryJavadoc", "AtclauseOrder", "NonEmptyAtclauseDescription", "JavadocParagraph", "JavadocTagContinuationIndentation", "SingleLineJavadoc", "InvalidJavadocPosition")
    "命名规范" = @("MethodName", "ParameterName", "LocalVariableName", "MemberName", "TypeName")
    "代码长度" = @("LineLength")
    "Import 问题" = @("UnusedImports", "RedundantImport", "ImportOrder", "AvoidStarImport")
    "代码结构" = @("NeedBraces", "EmptyBlock")
}

foreach ($category in $categories.Keys) {
    $types = $categories[$category]
    $total = 0
    foreach ($type in $types) {
        if ($stats.ContainsKey($type)) {
            $total += $stats[$type].Count
        }
    }
    if ($total -gt 0) {
        $pct = [math]::Round(($total / $totalWarnings) * 100, 2)
        Write-Host ("{0,-20} {1,10} ({2,6}%)" -f $category, $total, $pct) -ForegroundColor Yellow
    }
}

Write-Host ""
Write-Host "=== 修复优先级建议 ===" -ForegroundColor Magenta
Write-Host ""
Write-Host "优先级 1 (自动修复) - 格式问题" -ForegroundColor Green
Write-Host "  运行: mvn formatter:format"
Write-Host "  可自动修复: Tab字符、缩进、空格、大括号位置等"
Write-Host ""
Write-Host "优先级 2 (半自动) - Import 问题" -ForegroundColor Yellow  
Write-Host "  在 Eclipse/IDEA 中: Ctrl+Shift+O / Organize Imports"
Write-Host ""
Write-Host "优先级 3 (手动) - JavaDoc 问题" -ForegroundColor Red
Write-Host "  需要为公共 API 添加文档注释"
Write-Host ""
Write-Host "优先级 4 (手动) - 其他问题" -ForegroundColor Red
Write-Host "  行长度、命名规范等需要逐个审查修复"
Write-Host ""
