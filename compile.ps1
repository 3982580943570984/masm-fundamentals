$filename = $args[0] -replace '\.asm$', ''
$asmPath = "C:\masm32\include\"
$libPath = "C:\masm32\lib"

if ($filename -eq $null) {
    Write-Host "Error: No filename provided."
    exit 1
}

& ml /c /coff /Cp /nologo /I"$asmPath" ".\$filename.asm"
if ($LASTEXITCODE -ne 0) {
    Write-Host "Assembly failed."
    exit 1
}

& link /SUBSYSTEM:CONSOLE /RELEASE /LIBPATH:"$libPath" ".\$filename.obj"
if ($LASTEXITCODE -ne 0) {
    Write-Host "Linking failed."
    exit 1
}

Write-Host "Assembly and linking succeeded."
