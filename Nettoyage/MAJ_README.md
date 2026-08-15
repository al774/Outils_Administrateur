# Outils Administrateur

Collection de scripts d'automatisation PowerShell développés pour la maintenance et la sécurisation des postes de travail.

## Script : Clean-Windows.ps1

Ce script permet un nettoyage ciblé et interactif du système Windows. Il demande une confirmation utilisateur avant chaque suppression.

### Fonctionnalités :
* Cache des mises à jour Windows Update
* Fichiers temporaires système et utilisateurs
* Fichiers Prefetch et cache des miniatures
* Rapports de plantage (Crash Dumps & WER)
* Vidage de la corbeille et des logs système

### Utilisation :
1. Ouvrir PowerShell en tant qu'**Administrateur**.
2. Lancer le script :
```powershell
.\Clean-WindowsTemp-Interactive.ps1
