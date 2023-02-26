#MaxThreadsPerHotkey, 2
SetDefaultMouseSpeed, 0
SetBatchLines, -1
ListLines, Off

bFlag := False
global positions := array()

; ####

Esc::ExitApp

#IfWinActive ahk_class Chrome_WidgetWin_1
; Define a hotkey that will trigger when the space bar is pressed
$Space::
  ; Get the current mouse position
  MouseGetPos, xpos, ypos
  ; Add the current mouse position to the array
  positions.Push(xpos "x" ypos)
  
  tooltipText := "Saved Positions (" positions.Length() "): "
  Loop % positions.Length()
  {
    pos := positions[A_Index]
    tooltipText .= pos ", "
  }
  ; Show a message box indicating that the position has been saved
  ToolTip, % positions tooltipText, 10, 115, 1
return
#IfWinActive

#IfWinActive ahk_class Chrome_WidgetWin_1
; Define a hotkey that will trigger when the Enter key is pressed
$Enter::
  ; Loop through the array of saved mouse positions
  ;Sleep 10000
  bFlag := !bFlag
  While bFlag
	  Loop % positions.Length()
	  {
  		if (bFlag != 1)
			break

		; Get the x and y coordinates from the current position in the array
		pos := positions[A_Index]
		x := SubStr(pos, 1, InStr(pos, "x") - 1)
		y := SubStr(pos, InStr(pos, "x") + 1)
		
		; Move the mouse to the current position and click
		ToolTip, %x% %y% %bFlag%, 10, 115, 1
		MouseMove, %x%, %y%
		Loop, 25
		{
		  Click
		}
	  }
return
#IfWinActive

; Define a hotkey that will trigger when the Numpad 0 key is pressed
Numpad0::
  ; Clear the array of saved mouse positions
  positions := []
return

#IfWinActive ahk_class Chrome_WidgetWin_1
RButton::
    bFlag := !bFlag
    While bFlag
        Click
Return
#IfWinActive

F12::
    bFlag := !bFlag
    While bFlag
        Click
Return
