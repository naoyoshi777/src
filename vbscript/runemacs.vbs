'===============================================================================
' Run Emacs on WSL
'
' Arguments:
'   %1  path to file [OPTIONAL]
'===============================================================================
cmd = "bash -lc ""emacs --chdir=${HOME}"""

If Wscript.Arguments.Count <> 0 Then
   Set fs = CreateObject("Scripting.FileSystemObject")
   If fs.FileExists(Wscript.Arguments(0)) Then
      path = Replace(fs.GetFile(Wscript.Arguments(0)), "\", "\\")
      cmd = "bash -lc ""emacs --chdir=${HOME} $(wslpath " & path & ")"""
   End If
End If

Set oShell = CreateObject("Wscript.shell")
oShell.Run cmd, 0, false
