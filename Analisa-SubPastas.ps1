param(
    [Parameter(Mandatory=$true)]
    [string]$Path
)

function Convert-ToGB {
    param ($bytes)
    if ($bytes -eq $null) { return "0.00 GB" }
    return "{0:N2} GB" -f ($bytes / 1GB)
}

Write-Host ""
Write-Host "=========================================" -ForegroundColor Cyan
Write-Host "ANÁLISE DE SUBPASTAS" -ForegroundColor Cyan
Write-Host "Caminho: $Path" -ForegroundColor Cyan
Write-Host "=========================================" -ForegroundColor Cyan
Write-Host ""

if (!(Test-Path $Path)) {
    Write-Host "Caminho não encontrado: $Path" -ForegroundColor Red
    exit
}

Write-Host "Calculando tamanho das subpastas..." -ForegroundColor Yellow
Write-Host "Isso pode demorar dependendo da quantidade de arquivos..." -ForegroundColor DarkYellow
Write-Host ""

$folders = Get-ChildItem $Path -Directory -Force -ErrorAction SilentlyContinue

$result = foreach ($folder in $folders) {

    Write-Host "Analisando: $($folder.Name)" -ForegroundColor DarkGray

    try {

        $size = Get-ChildItem $folder.FullName -Recurse -File -Force -ErrorAction SilentlyContinue |
        Measure-Object -Property Length -Sum

        [PSCustomObject]@{
            Nome = $folder.Name
            Caminho = $folder.FullName
            Tamanho = Convert-ToGB $size.Sum
            Bytes = $size.Sum
        }

    } catch {}

}

Write-Host ""
Write-Host "=========================================" -ForegroundColor Green
Write-Host "SUBPASTAS (MAIOR → MENOR)" -ForegroundColor Green
Write-Host "=========================================" -ForegroundColor Green

$result |
Sort-Object Bytes -Descending |
Select-Object Nome, Tamanho, Caminho |
Format-Table -AutoSize

Write-Host ""
Write-Host "Análise finalizada" -ForegroundColor Cyan