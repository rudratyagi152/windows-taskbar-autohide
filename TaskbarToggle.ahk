; ==============================================================================
; Windows Taskbar Auto-Hide Toggle (AutoHotkey v2)
; ==============================================================================
; Description:
; Toggles Windows native "Automatically hide the taskbar" setting on and off.
; - Auto-Hide ON:  The taskbar slides down and reveals itself when mouse hovers.
; - Auto-Hide OFF: The taskbar is locked in place and always visible.
;
; Shortcut: Ctrl + Alt + A  (Ergonomic single-hand reach for your left hand)
; ==============================================================================

#Requires AutoHotkey v2.0
#SingleInstance Force

A_IconTip := "Taskbar Auto-Hide Toggle (Ctrl+Alt+A)"
startupShortcut := A_Startup "\TaskbarToggle.lnk"

; ------------------------------------------------------------------------------
; SYSTEM TRAY MENU
; ------------------------------------------------------------------------------
A_TrayMenu.Delete()
A_TrayMenu.Add("Toggle Auto-Hide (Ctrl+Alt+A)", (*) => ToggleTaskbarAutohide())
A_TrayMenu.Default := "Toggle Auto-Hide (Ctrl+Alt+A)"
A_TrayMenu.Add()
A_TrayMenu.Add("Run at Windows Startup", (*) => ToggleStartup())
if FileExist(startupShortcut)
    A_TrayMenu.Check("Run at Windows Startup")
A_TrayMenu.Add()
A_TrayMenu.Add("Exit", (*) => ExitApp())

; ------------------------------------------------------------------------------
; HOTKEY: Ctrl + Alt + A
; ------------------------------------------------------------------------------
^!a::ToggleTaskbarAutohide()

; ------------------------------------------------------------------------------
; FUNCTION: Toggle Auto-Hide via Windows Shell AppBar API
; ------------------------------------------------------------------------------
ToggleTaskbarAutohide() {
    static ABM_GETSTATE := 0x00000004
    static ABM_SETSTATE := 0x0000000A
    static ABS_AUTOHIDE := 0x00000001
    static ABS_ALWAYSONTOP := 0x00000002
    static isHidden := false

    size := 2 * A_PtrSize + 2 * 4 + 16 + A_PtrSize
    appBarData := Buffer(size, 0)
    NumPut("UInt", size, appBarData, 0)
    NumPut("Ptr", WinExist("ahk_class Shell_TrayWnd"), appBarData, A_PtrSize)

    state := DllCall("Shell32\SHAppBarMessage", "UInt", ABM_GETSTATE, "Ptr", appBarData)
    if (state != 0) {
        newState := (state & ABS_AUTOHIDE) ? ABS_ALWAYSONTOP : ABS_AUTOHIDE
        isHidden := (newState == ABS_AUTOHIDE)
    } else {
        isHidden := !isHidden
        newState := isHidden ? ABS_AUTOHIDE : ABS_ALWAYSONTOP
    }

    NumPut("UInt", newState, appBarData, size - A_PtrSize)
    DllCall("Shell32\SHAppBarMessage", "UInt", ABM_SETSTATE, "Ptr", appBarData)
}

; ------------------------------------------------------------------------------
; FUNCTION: Toggle Windows Startup Shortcut
; ------------------------------------------------------------------------------
ToggleStartup() {
    if FileExist(startupShortcut) {
        FileDelete(startupShortcut)
        A_TrayMenu.Uncheck("Run at Windows Startup")
    } else {
        targetExe := A_ScriptDir "\AutoHotkey\AutoHotkey64.exe"
        args := '"' A_ScriptFullPath '"'
        FileCreateShortcut(targetExe, startupShortcut, A_ScriptDir, args, "Taskbar Auto-Hide Toggle")
        A_TrayMenu.Check("Run at Windows Startup")
    }
}
