Set WshShell = CreateObject("WScript.Shell")
scriptDir = CreateObject("Scripting.FileSystemObject").GetParentFolderName(WScript.ScriptFullName)
ahkExe = scriptDir & "\AutoHotkey\AutoHotkey64.exe"
ahkScript = scriptDir & "\TaskbarToggle.ahk"
WshShell.Run """" & ahkExe & """ """ & ahkScript & """", 0, False
