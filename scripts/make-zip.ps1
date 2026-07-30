# dist/ 폴더를 카페24 업로드용 zip 으로 압축합니다.
#
# Compress-Archive 대신 .NET CreateFromDirectory 를 쓰는 이유:
# Compress-Archive 는 경로 구분자를 역슬래시(\)로 기록해서,
# 리눅스 서버(카페24)에서 압축 해제 시 폴더가 아닌 이상한 파일명으로
# 풀리는 문제가 있습니다. CreateFromDirectory 는 슬래시(/)로 기록합니다.

$ErrorActionPreference = 'Stop'

$root = Split-Path -Parent $PSScriptRoot
$dist = Join-Path $root 'dist'
$zip  = Join-Path $root 'creaton-korea-deploy.zip'

if (-not (Test-Path $dist)) {
  Write-Error "dist 폴더가 없습니다. 먼저 'npm run build' 를 실행하세요."
  exit 1
}

if (Test-Path $zip) { Remove-Item $zip -Force }

Add-Type -AssemblyName System.IO.Compression.FileSystem
[System.IO.Compression.ZipFile]::CreateFromDirectory(
  $dist,
  $zip,
  [System.IO.Compression.CompressionLevel]::Optimal,
  $false   # dist 폴더 자체는 포함하지 않고, 내용물만 담습니다
)

# 검증
$archive = [System.IO.Compression.ZipFile]::OpenRead($zip)
$count     = $archive.Entries.Count
$backslash = ($archive.Entries | Where-Object { $_.FullName -like '*\*' }).Count
$htaccess  = ($archive.Entries | Where-Object { $_.FullName -eq '.htaccess' }).Count
$archive.Dispose()

$sizeMb = [math]::Round((Get-Item $zip).Length / 1MB, 2)

Write-Output "생성됨: creaton-korea-deploy.zip ($sizeMb MB, $count개 파일)"
if ($backslash -gt 0) { Write-Error "경고: 역슬래시 경로 $backslash 건 발견"; exit 1 }
if ($htaccess -ne 1)  { Write-Error "경고: .htaccess 가 누락되었습니다"; exit 1 }
Write-Output "검증 통과: 경로 구분자 정상 / .htaccess 포함"
