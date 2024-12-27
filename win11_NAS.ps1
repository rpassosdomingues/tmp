# Variáveis de configuração
$POOL_NAME = "raid0pool"
$DISK1 = "PhysicalDisk1"
$DISK2 = "PhysicalDisk2"
$MOUNT_POINT = "C:\$POOL_NAME"
$MAIN_PATH = "$MOUNT_POINT\main"
$CACHE_PATH = "$MOUNT_POINT\cache"
$MAX_SIZE = 500GB
$LOCAL_DIR = "C:\local\dir"
$TIMESTAMP_FILE = "ultima_execucao.txt"

# Função para configurar o RAID 0 com Storage Spaces
function Configurar-RAID0 {
    Write-Output "Configurando RAID 0 com Storage Spaces..."
    $pool = New-StoragePool -FriendlyName $POOL_NAME -StorageSubsystemFriendlyName "Storage Spaces*" -PhysicalDisks (Get-PhysicalDisk -CanPool $true | Where-Object { $_.DeviceID -eq $DISK1 -or $_.DeviceID -eq $DISK2 })
    $virtualDisk = New-VirtualDisk -StoragePoolFriendlyName $POOL_NAME -FriendlyName $POOL_NAME -ResiliencySettingName Simple -Size $MAX_SIZE
    Initialize-Disk -Number $virtualDisk.Number -PartitionStyle GPT
    New-Partition -DiskNumber $virtualDisk.Number -UseMaximumSize -AssignDriveLetter
    Format-Volume -DriveLetter (Get-Partition -DiskNumber $virtualDisk.Number).DriveLetter -FileSystem NTFS -NewFileSystemLabel $POOL_NAME
    Write-Output "RAID 0 configurado com sucesso."
}

# Função para otimizar o armazenamento
function Otimizar-Armazenamento {
    Write-Output "Otimizando o armazenamento..."
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem" -Name "NtfsDisableLastAccessUpdate" -Value 1
    Write-Output "Armazenamento otimizado."
}

# Função para verificar o espaço disponível
function Monitorar-Espaco {
    $usado = (Get-Volume -FileSystemLabel $POOL_NAME).SizeRemaining
    $quota = $MAX_SIZE

    if ($usado -lt $quota) {
        Write-Output "Erro: Espaço em disco insuficiente para copiar cache"
        return $false
    } else {
        return $true
    }
}

# Função para verificar o estado das unidades do pool
function Verificar-Estado-Unidades {
    Write-Output "Verificando o estado das unidades do pool..."
    $status = (Get-PhysicalDisk | Where-Object { $_.DeviceID -eq $DISK1 -or $_.DeviceID -eq $DISK2 }).OperationalStatus

    if ($status -contains "OK") {
        Write-Output "Todas as unidades do pool estão saudáveis."
    } else {
        Write-Output "Erro: Uma ou mais unidades do pool estão com defeito. Status: $status"
        exit 1
    }
}

# Função para copiar os arquivos
function Copiar-Arquivos {
    param (
        [string]$Source,
        [string]$Destination
    )

    Write-Output "Copiando arquivos de $Source para $Destination..."
    robocopy $Source $Destination /E /R:3 /W:5
    Write-Output "Cópia de arquivos concluída."
}

# Função principal
function Main {
    # Verifica o estado das unidades antes de qualquer operação
    Verificar-Estado-Unidades

    # Configura o RAID 0 e otimiza o armazenamento
    Configurar-RAID0
    Otimizar-Armazenamento

    # Cria as pastas principais
    New-Item -Path $MAIN_PATH -ItemType Directory -Force
    New-Item -Path $CACHE_PATH -ItemType Directory -Force

    # Copia e organiza os arquivos
    Copiar-Arquivos -Source "$LOCAL_DIR\root" -Destination $CACHE_PATH

    # Monitora o espaço em disco antes de copiar a main
    if (Monitorar-Espaco) {
        Copiar-Arquivos -Source "$LOCAL_DIR\root" -Destination $MAIN_PATH
    }
}

# Executa a função principal
Main
