<#
.SYNOPSIS
    Monadic Windows 11 Reversal Protocol (Undo)
.DESCRIPTION
    Reverses the actions of the Debloat Protocol. 
    1. Re-enables Advertising ID and Start Menu suggestions.
    2. Attempts to re-register all default Windows Store applications.
    
    NOTE: If apps were completely de-provisioned from the OS image, 
    you may need to download them manually from the Microsoft Store.
.AUTHOR
    Monadic Engineering (www.monadic-llc.com)
.LICENSE
    MIT
#>

# --- PRE-FLIGHT CHECK ---
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "❌ This script must be run as Administrator!"
    Break
}

Write-Host "🔄 Monadic Reversal Protocol Initiated..." -ForegroundColor Cyan

# --- PART 1: REVERT REGISTRY SETTINGS ---
Write-Host "--- Restoring Telemetry & Suggestions ---" -ForegroundColor Cyan

# Re-enable Advertising ID
Write-Host "Enabling Advertising ID..."
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" -Name "Enabled" -Value 1 -ErrorAction SilentlyContinue

# Re-enable "Suggested Content" in Settings
Write-Host "Enabling 'Suggested Content'..."
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SystemPaneSuggestionsEnabled" -Value 1 -ErrorAction SilentlyContinue
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SoftLandingEnabled" -Value 1 -ErrorAction SilentlyContinue

# --- PART 2: RE-REGISTER APPS ---
Write-Host "--- Re-Registering Default Apps ---" -ForegroundColor Cyan
Write-Host "NOTE: You may see red error text for apps that are currently running (like Cortana or Edge). This is normal." -ForegroundColor Yellow

# This command attempts to re-install all built-in apps found in the Windows Image
Get-AppxPackage -AllUsers | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" -ErrorAction SilentlyContinue}

# --- PART 3: THE FAILSAFE ---
Write-Host "--- Finalizing ---" -ForegroundColor Cyan
Write-Host "✅ Reversal process complete." -ForegroundColor Green
Write-Host " "
Write-Host "⚠️ IF THIS DID NOT FIX YOUR ISSUE:" -ForegroundColor Red
Write-Host "The Debloat Protocol created a System Restore Point named 'Monadic_Pre_Debloat'."
Write-Host "You can roll back fully by searching for 'Recovery' in the Start Menu -> Open System Restore."
