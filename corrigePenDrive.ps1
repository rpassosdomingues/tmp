# Script PowerShell para automatizar o chkdsk no disco D:
$disk = "D:"
$command = "chkdsk /r /f $disk"

# Executa o comando
Start-Process powershell -ArgumentList "-NoProfile -Command $command" -Verb RunAs

# Aguarda a conclusão do chkdsk
Write-Host "Aguardando a conclusão do chkdsk..."
Start-Sleep -Seconds 10
