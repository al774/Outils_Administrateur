# Fonction pour demander une confirmation valide (Oui / Non)
function Confirm-Action {
    param ([string]$Message)
    
    do {
        $Response = Read-Host "$Message [O/N]"
        $Response = $Response.Trim().ToLower()

        if ($Response -eq 'o' -or $Response -eq 'oui') {
            return $true
        }
        elseif ($Response -eq 'n' -or $Response -eq 'non') {
            return $false
        }
        else {
            Write-Host "Réponse invalide. Veuillez répondre par 'Oui' (O) ou 'Non' (N)." -ForegroundColor Red
        }
    } while ($true)
}

# 1. Cache Windows Update
if (Confirm-Action "Voulez-vous supprimer le cache Windows Update ?") {
    Stop-Service -Name wuauserv -Force -ErrorAction SilentlyContinue
    Remove-Item -Path "$env:SystemRoot\SoftwareDistribution\Download\*" -Recurse -Force -ErrorAction SilentlyContinue
    Start-Service -Name wuauserv -ErrorAction SilentlyContinue
    Write-Host "-> Cache Windows Update supprimé." -ForegroundColor Green
}

# 2. Fichiers temporaires Système et Utilisateurs
if (Confirm-Action "Voulez-vous supprimer les fichiers temporaires (Système & Utilisateurs) ?") {
    Remove-Item -Path "$env:SystemRoot\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item -Path "C:\Users\*\AppData\Local\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item -Path "C:\Users\*\AppData\Local\Microsoft\Windows\INetCache\*" -Recurse -Force -ErrorAction SilentlyContinue
    Write-Host "-> Fichiers temporaires supprimés." -ForegroundColor Green
}

# 3. Cache de démarrage rapide (Prefetch)
if (Confirm-Action "Voulez-vous supprimer les fichiers Prefetch ?") {
    Remove-Item -Path "$env:SystemRoot\Prefetch\*" -Recurse -Force -ErrorAction SilentlyContinue
    Write-Host "-> Prefetch supprimé." -ForegroundColor Green
}

# 4. Fichiers de pannes Windows (Crash Dumps)
if (Confirm-Action "Voulez-vous supprimer les fichiers de plantage (Crash Dumps) ?") {
    Remove-Item -Path "$env:SystemRoot\MEMORY.DMP" -Force -ErrorAction SilentlyContinue
    Remove-Item -Path "$env:SystemRoot\Minidump\*" -Recurse -Force -ErrorAction SilentlyContinue
    Write-Host "-> Crash Dumps supprimés." -ForegroundColor Green
}

# 5. Rapports d'erreurs Windows (WER)
if (Confirm-Action "Voulez-vous supprimer les rapports d'erreurs Windows (WER) ?") {
    Remove-Item -Path "C:\ProgramData\Microsoft\Windows\WER\*" -Recurse -Force -ErrorAction SilentlyContinue
    Write-Host "-> Rapports d'erreurs supprimés." -ForegroundColor Green
}

# 6. Cache des miniatures d'images (Thumbnails)
if (Confirm-Action "Voulez-vous supprimer le cache des miniatures d'images ?") {
    Remove-Item -Path "C:\Users\*\AppData\Local\Microsoft\Windows\Explorer\thumbcache_*.db" -Force -ErrorAction SilentlyContinue
    Write-Host "-> Cache des miniatures supprimé." -ForegroundColor Green
}

# 7. Corbeille
if (Confirm-Action "Voulez-vous vider la corbeille ?") {
    Clear-RecycleBin -Force -ErrorAction SilentlyContinue
    Write-Host "-> Corbeille vidée." -ForegroundColor Green
}

# 8. Journaux de logs
if (Confirm-Action "Voulez-vous supprimer les journaux de logs ?") {
    Remove-Item -Path "$env:SystemRoot\Logs\*" -Recurse -Force -ErrorAction SilentlyContinue
    Write-Host "-> Journaux de logs supprimés." -ForegroundColor Green
}
