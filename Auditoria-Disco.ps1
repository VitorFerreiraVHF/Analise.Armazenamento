param(
    [string]$Drive = "C:\"
)

function Convert-ToGB {
    param ($bytes)
    if ($bytes -eq $null) { return "0.00 GB" }
    return "{0:N2} GB" -f ($bytes / 1GB)
}

Write-Host ""
Write-Host "=========================================" -ForegroundColor Cyan
Write-Host "AUDITORIA COMPLETA DE DISCO - $Drive" -ForegroundColor Cyan
Write-Host "=========================================" -ForegroundColor Cyan
Write-Host ""

# =========================================
# APPS INSTALADOS
# =========================================

Write-Host "Levantando aplicativos instalados..." -ForegroundColor Yellow

$apps = @()

$regPaths = @(
"HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*",
"HKLM:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*",
"HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*"
)

foreach ($path in $regPaths) {
    $apps += Get-ItemProperty $path -ErrorAction SilentlyContinue |
    Where-Object { $_.DisplayName -and $_.EstimatedSize } |
    Select-Object @{
        Name="Nome";Expression={$_.DisplayName}
    }, @{
        Name="Tamanho";Expression={ Convert-ToGB ($_.EstimatedSize * 1KB) }
    }, @{
        Name="Bytes";Expression={ $_.EstimatedSize * 1KB }
    }
}

Write-Host ""
Write-Host "=========================================" -ForegroundColor Green
Write-Host "APLICATIVOS (MAIOR → MENOR)" -ForegroundColor Green
Write-Host "=========================================" -ForegroundColor Green

$apps |
Sort-Object Bytes -Descending |
Select-Object Nome, Tamanho |
Format-Table -AutoSize


# =========================================
# PASTAS DO DISCO
# =========================================

Write-Host ""
Write-Host "Calculando tamanho das pastas do disco..." -ForegroundColor Yellow
Write-Host "Isso pode demorar..." -ForegroundColor DarkYellow

$folders = Get-ChildItem $Drive -Directory -Force -ErrorAction SilentlyContinue

$result = foreach ($folder in $folders) {

    Write-Host "Analisando: $($folder.FullName)" -ForegroundColor DarkGray

    try {

        $size = Get-ChildItem $folder.FullName -Recurse -File -Force -ErrorAction SilentlyContinue |
        Measure-Object -Property Length -Sum

        [PSCustomObject]@{
            Nome = $folder.FullName
            Tamanho = Convert-ToGB $size.Sum
            Bytes = $size.Sum
        }

    } catch {}

}

Write-Host ""
Write-Host "=========================================" -ForegroundColor Green
Write-Host "PASTAS DO DISCO (MAIOR → MENOR)" -ForegroundColor Green
Write-Host "=========================================" -ForegroundColor Green

$result |
Sort-Object Bytes -Descending |
Select-Object Nome, Tamanho |
Format-Table -AutoSize

Write-Host ""
Write-Host "Auditoria finalizada" -ForegroundColor Cyan
