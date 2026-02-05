# 🛡️ Windows 11 Business Debloat Protocol

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT) [![Monadic Status](https://img.shields.io/badge/Status-Active-brightgreen)](https://www.monadic-llc.com)

> **"A clean machine is a fast machine."**

## 📖 Overview
Fresh installations of Windows 11 Pro often come pre-loaded with "Consumer Bloatware"—apps like TikTok, Solitaire, and Xbox that distract employees and consume system resources.

The **Monadic Debloat Protocol** is a PowerShell script designed to safely strip these non-essential applications while preserving core business functionality (Calculator, Photos, Store, etc.).

## 🚀 How to Run
1.  Download the `debloat.ps1` file.
2.  Right-click the file and select **Run with PowerShell**.
3.  *Note:* You must run this as **Administrator**.

## 🧹 What it Removes
We take a conservative, "Business-First" approach. We do NOT remove the Calculator, Camera, or Microsoft Store.

**Targeted Apps:**
* ❌ **Gaming:** Xbox Console, Solitaire, Gaming Overlay
* ❌ **Social:** TikTok, Instagram, Facebook, People Bar
* ❌ **Media:** Spotify, Disney+, Zune Music/Video, Clipchamp
* ❌ **Telemetry:** Feedback Hub, Advertising ID

## 🛡️ Safety Features
* **System Restore Point:** The script automatically creates a Restore Point named `Monadic_Pre_Debloat` before making changes.
* **Error Handling:** If an app isn't found, the script skips it silently without crashing.

## ↩️ How to Undo (Reversal)
Need to bring the bloat back? We included a reversal script.

1.  Download `restore.ps1`.
2.  Run as **Administrator**.
3.  **What it does:** It flips the registry keys back to default and attempts to re-register all built-in Windows apps.
4.  **The Failsafe:** If the script doesn't restore a specific app you need, use **System Restore**. The `debloat.ps1` script automatically created a restore point named `Monadic_Pre_Debloat` before it touched anything.

## 🤝 Contributing
Found a new piece of bloatware included in the latest Windows update? Submit a Pull Request to add it to the `$BloatwareList`.

## 🔗 About Monadic
We are Strategic IT Partners engineered for resilience.
* **Web:** [www.monadic-llc.com](https://www.monadic-llc.com)
* **Blog:** [The Holographic Business](https://www.monadic-llc.com/blog/the-holographic-business)

---
*Maintained by Monadic Engineering.*
