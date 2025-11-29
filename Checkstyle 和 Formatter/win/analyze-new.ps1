$file = "d:\ruyiSDK\plugins\logs\win\new-log.txt"
$content = Get-Content $file

Write-Host "=== 格式化后的 Checkstyle 剩余违规分析 ===" -ForegroundColor Cyan
Write-Host ""

# 统计各类错误
$stats = @{
    "MissingJavadocType" = ($content | Select-String '\[MissingJavadocType\]').Count
    "MissingJavadocMethod" = ($content | Select-String '\[MissingJavadocMethod\]').Count
    "SummaryJavadoc" = ($content | Select-String '\[SummaryJavadoc\]').Count
    "JavadocParagraph" = ($content | Select-String '\[JavadocParagraph\]').Count
    "CustomImportOrder" = ($content | Select-String '\[CustomImportOrder\]').Count
    "AvoidStarImport" = ($content | Select-String '\[AvoidStarImport\]').Count
    "MultipleVariableDeclarations" = ($content | Select-String '\[MultipleVariableDeclarations\]').Count
    "VariableDeclarationUsageDistance" = ($content | Select-String '\[VariableDeclarationUsageDistance\]').Count
}

$total = 342

Write-Host "错误类型统计:" -ForegroundColor Yellow
Write-Host ("=" * 70)
Write-Host ("{0,-40} {1,10} {2,12}" -f "错误类型", "数量", "占比")
Write-Host ("-" * 70)

$sortedStats = $stats.GetEnumerator() | Sort-Object Value -Descending

foreach ($item in $sortedStats) {
    $type = $item.Key
    $count = $item.Value
    if ($count -gt 0) {
        $percentage = [math]::Round(($count / $total) * 100, 1)
        Write-Host ("{0,-40} {1,10} {2,11}%" -f $type, $count, $percentage)
    }
}

Write-Host ("=" * 70)
Write-Host ""

# 分类汇总
Write-Host "=== 问题分类 ===" -ForegroundColor Green
Write-Host ""

$javadocTotal = $stats["MissingJavadocType"] + $stats["MissingJavadocMethod"] + $stats["SummaryJavadoc"] + $stats["JavadocParagraph"]
$importTotal = $stats["CustomImportOrder"] + $stats["AvoidStarImport"]
$otherTotal = $stats["MultipleVariableDeclarations"] + $stats["VariableDeclarationUsageDistance"]

Write-Host ("JavaDoc 相关:     {0,3} ({1,5}%)" -f $javadocTotal, [math]::Round(($javadocTotal/$total)*100, 1)) -ForegroundColor Yellow
Write-Host ("Import 相关:      {0,3} ({1,5}%)" -f $importTotal, [math]::Round(($importTotal/$total)*100, 1)) -ForegroundColor Cyan
Write-Host ("其他代码问题:    {0,3} ({1,5}%)" -f $otherTotal, [math]::Round(($otherTotal/$total)*100, 1)) -ForegroundColor Magenta
Write-Host ""
Write-Host ("总计:             {0,3}" -f $total) -ForegroundColor White

Write-Host ""
Write-Host "=== 改进成果 ===" -ForegroundColor Green
Write-Host ""
Write-Host "格式化前:  ~3800 violations" -ForegroundColor Red
Write-Host "格式化后:   342 violations" -ForegroundColor Green
Write-Host "减少数量:  ~3458 violations" -ForegroundColor Cyan
Write-Host "改进比例:  ~91%" -ForegroundColor Yellow
Write-Host ""
