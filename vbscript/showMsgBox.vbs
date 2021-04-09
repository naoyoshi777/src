'===============================================================================
' Show a message in dialog box
'
' Arguments:
'   %1  message
'   %2  title [OPTIONAL]
'===============================================================================
Set args = WScript.Arguments

buttons = vbOkOnly + vbInformation + vbSystemModal

If args.Count = 0 Then
  MsgBox "(No message)", buttons
ElseIf args.Count = 1 Then
  MsgBox args(0), buttons
ElseIf args.Count >= 2 Then
  MsgBox args(0), buttons, args(1)
End If
