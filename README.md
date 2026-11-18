# Windows Taskbar Auto-Hide Toggle

A lightweight utility for Windows 10 and 11 to toggle taskbar auto-hide with an ergonomic left-hand keyboard shortcut.

## Features

- **Ergonomic Shortcut**: Default `Ctrl + Alt + A`, easily reached with only your left hand.
- **Minimal Footprint**: Runs via AutoHotkey v2 (~2 MB RAM, 0% CPU at idle).
- **Smooth Auto-Hide**: Hides the taskbar when enabled, smoothly reappearing when you move your cursor to the bottom edge.
- **Startup Integration**: Includes a simple toggle to launch automatically when Windows boots.

---

## Getting Started

### Quick Start (Portable)

1. Download or clone this repository to your computer.
2. Double-click `Start Taskbar Toggle.lnk` (or run `Launch-TaskbarToggle.vbs`).
3. Press `Ctrl + Alt + A` to toggle auto-hide on or off.

### Running with an Existing AutoHotkey v2 Installation

If you already have AutoHotkey v2 installed globally on your PC:
- Double-click `TaskbarToggle.ahk` directly.

---

## How to Customize the Shortcut

If you wish to change the key binding:
1. Open `TaskbarToggle.ahk` with any text editor (like Notepad).
2. Locate line 31:
   ```autohotkey
   ^!a::ToggleTaskbarAutohide()
   ```
3. Update the key symbols:
   - `^` represents `Ctrl`
   - `!` represents `Alt`
   - `#` represents `Windows Key`
   - `+` represents `Shift`
   *(Example: to change to `Win + Z`, use `#z::ToggleTaskbarAutohide()`)*.
4. Save the file and restart the script.

---

## Setting Up Run at Startup

- **Method 1**: Right-click the green tray icon (`H`) near your Windows clock and select **Run at Windows Startup**.
- **Method 2**: Place a shortcut to `TaskbarToggle.ahk` in your Windows Startup directory (`shell:startup`).

---

## License

This project is distributed under the MIT License.
