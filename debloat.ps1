<#
.SYNOPSIS
    Monadic Windows 11 Business Debloat Protocol
.DESCRIPTION
    A safe, business-grade cleanup script to remove consumer bloatware, 
    telemetry, and sponsored apps from fresh Windows 11 Pro installs.
    
    Philosophy: "Clarity over Complexity." We remove the noise so you can work.
.AUTHOR
    Monadic Engineering (www.monadic-llc.com)
.LICENSE
    MIT
#>

# --- PRE-FLIGHT CHECK ---
# Ensure the script is running as Administrator
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "❌ This script must be run as Administrator!"
    Break
}

Write-Host "🌀 Monadic Debloat Protocol Initiated..." -ForegroundColor Cyan
Write-Host "Creating System Restore Point (Safety First)..." -ForegroundColor Yellow

# Create a Restore Point just in case
Enable-ComputerRestore -Drive "C:\"
Checkpoint-Computer -Description "Monadic_Pre_Debloat" -RestorePointType "MODIFY_SETTINGS"

# --- PART 1: THE JUNK LIST ---
# These are apps that have no place on a business machine.
# We target both "Installed" apps and "Provisioned" (Pre-installed for new users) apps.

$BloatwareList = @(
    "Microsoft.BingNews"             # News & Interests popup
    "Microsoft.GamingApp"            # Xbox Gaming Services
    "Microsoft.MicrosoftSolitaireCollection" # Solitaire
    "Microsoft.People"               # People Bar
    "Microsoft.WindowsFeedbackHub"   # Feedback Telemetry
    "Microsoft.Xbox.TCUI"
    "Microsoft.XboxApp"
    "Microsoft.XboxGameOverlay"
    "Microsoft.XboxGamingOverlay"
    "Microsoft.XboxIdentityProvider"
    "Microsoft.XboxSpeechToTextOverlay"
    "Microsoft.YourPhone"            # Most businesses use Teams/Email, not Phone Link
    "Microsoft.ZuneMusic"            # Groove Music (Legacy)
    "Microsoft.ZuneVideo"            # Movies & TV
    "Microsoft.Todos"                # Consumer ToDo (Not the O365 one)
    "Clipchamp.Clipchamp"            # Consumer Video Editor
    "SpotifyAB.SpotifyMusic"         # Spotify
    "Disney.37853FC22B2CE"           # Disney+
    "Netflix"
    "TikTok"
    "Instagram"
    "Facebook"
)

Write-Host "--- Removing Consumer Bloatware ---" -ForegroundColor Cyan

foreach ($App in $BloatwareList) {
    # 1. Remove from Current User
    Get-AppxPackage -Name "*$App*" | Remove-AppxPackage -ErrorAction SilentlyContinue
    
    # 2. Remove from "Provisioned" (So it doesn't come back for new users)
    Get-AppxProvisionedPackage -Online | Where-Object {$_.DisplayName -like "*$App*"} | Remove-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue
    
    Write-Host "Removed: $App" -ForegroundColor Gray
}

# --- PART 2: PRIVACY & TELEMETRY ---
Write-Host "--- Applying Privacy Hardening ---" -ForegroundColor Cyan

# Disable Advertising ID (Stops targeted ads in Start Menu)
Write-Host "Disabling Advertising ID..."
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" -Name "Enabled" -Value 0

# Disable "Suggested Content" in Settings
Write-Host "Disabling 'Suggested Content'..."
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SystemPaneSuggestionsEnabled" -Value 0
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SoftLandingEnabled" -Value 0

# --- PART 3: CLEANUP ---
Write-Host "--- Finalizing ---" -ForegroundColor Cyan
Write-Host "✅ Debloat Complete. Please restart your machine." -ForegroundColor Green
Write-Host "Monadic Engineering: System Optimized." -ForegroundColor Green
