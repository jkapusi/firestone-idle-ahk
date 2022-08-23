#SingleInstance, Force
CoordMode, Pixel, Screen

+esc::exitapp
+g:: Gosub, Guild
+f:: Gosub, GuardianTrain
+m:: Gosub, WarMap
+a:: Gosub, Experiments
+w:: Gosub, WMLoot
+l:: Gosub, Library

Numpad0::
~F6::
	BreakLoop = 1
return 

~F4::
	BreakLoop = 0
	LoopCount := 0
	Loop
	{
		if (BreakLoop = 1) {
			MsgBox, Loop stopped
			break
		}
		LoopCount++

		;Gosub, Guild
		;Gosub, Upgrade
		;Gosub, Clicker
		Gosub, WarMap
	}
Return

~F2::
	BreakLoop := 0
	LoopCount := 1
	Loop
	{
		if (BreakLoop = 1) {
			ToolTip, "PAUSED", 35, 250
			break
		}
		LoopCount++
		ToolTip, %LoopCount% %A_TimeIdlePhysical%, 35, 250

		Gosub, Upgrade
		Gosub, Clicker
		if (Mod(LoopCount, 10) = 0) {
			Gosub, Guild
		}
		if (Mod(LoopCount, 30) = 0) {
			Gosub, Experiments
			Sleep, 700
			Gosub, WMLoot
			Sleep, 700
			Gosub, GuardianTrain
			Sleep, 700
			Gosub, Library
		}

	}
Return

Library:
	Send, l
	Sleep, 700
	SetMouseDelay, 50
	
	; Click to Firestone research
	MouseClick, Left, 3019, 1861
	Sleep, 700

	; Detect second slot is active
	PixelGetColor, bgr, 2369, 1815
	;MsgBox, %bgr%
	if (bgr = 0x386992) {
		Send {Escape}
		Return
	}

	Sleep, 700
	
	MouseClick, Left, 1645, 842
	;MouseClick, Left, 2074, 846
	;MouseClick, Left, 1820, 1365

	Sleep, 700

	PixelGetColor, bgr, 1528, 1570
	MouseMove, 1528, 1570
	;MsgBox, %bgr%

	Sleep, 700
	if (bgr = 0x08A10B) {
		MouseClick, Left, 1528, 1570
	} else {
		;MsgBox, %bgr%
		Send {Escape}
	}

	Sleep, 700

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	MouseClick, Left, 1016, 1018

	Sleep, 700

	PixelGetColor, bgr, 1528, 1570
	MouseMove, 1528, 1570
	;MsgBox, %bgr%

	Sleep, 700
	if (bgr = 0x08A10B) {
		MouseClick, Left, 1528, 1570
	} else {
		;MsgBox, %bgr%
		Send {Escape}
	}

	Sleep, 700

	SetMouseDelay, 10
	Send {Escape}
	Sleep, 700
	Send {Escape}
	Sleep, 700
	Send {Escape}
	Sleep, 700
	;RunWait, C:\Users\Joci\Downloads\Capture2Text_v4.6.3_64bit\Capture2Text\Capture2Text_CLI.exe --screen-rect "815 571 946 616" --clipboard, , hide
	;msgbox, %Clipboard%
Return

GuardianTrain:
	Send, g
	Sleep, 700

	PixelGetColor, bgr, 2000, 1555
	MouseMove, 2000, 1555
	IniWrite, %bgr%, C:\Users\Joci\Desktop\fire.ini, GuardianTrain , Last

	;MsgBox, %bgr%
	IniRead, expectedbgr, C:\Users\Joci\Desktop\fire.ini, GuardianTrain, Expected
	if (bgr = expectedbgr) {
		MouseClick, Left, 2000, 1555
		Sleep, 700
	}

	Send {Escape}
Return

Experiments:
	Send, a
	Sleep, 700

	PixelGetColor, bgr, 1724, 1414
	;MouseMove, 1724, 1414
	;MsgBox, %bgr%
	if (bgr = 0x654D38) {
		MouseClick, Left, 1838, 1603
		Sleep, 700
	}

	Send {Escape}
Return

WMLoot:
	Send, m
	Sleep, 700
	
	MouseClick, Left, 3100, 1337
	Sleep, 700
	
	MouseClick, Left, 733, 1860
	Sleep, 700
	
	Send {Escape 2}
Return

WarMap:
	Loop, 2
	{
		PixelGetColor, bgr, 880, 880
		if (bgr = 0x429DF2) {
			MouseClick, Left, 880, 880
			Sleep, 1000
			;Send {Esc}
			Sleep, 2000
		}
	}
	Loop, 1
	{
		ImageSearch, FoundX, FoundY, 1080, 700, 3250, 2000, *10 map%A_Index%.bmp
		MsgBox, %ErrorLevel%
		if (ErrorLevel = 0) {
			MsgBox, %A_Index% %FoundX%x%FoundY%
			MouseClick, Left, FoundX, FoundY
			Sleep, 1000
			PixelGetColor, bgr, 1750, 1650
			;MsgBox, %bgr%
			if (bgr = 0x08A10B)
				MouseClick, Left, 1750, 1650
			Sleep, 1000
			;Send {Esc}
		}
	}

Return

Clicker:
	;if (A_TimeIdlePhysical < 1000)
	;	Return
	
	MouseMove, 2100, 600
	Loop, 5
	{
		if (BreakLoop = 1)
			break

		;Send, {LButton Down}
		SendInput, {Space Down}
		Sleep, 3000
		SendInput, {Space Up}
		;Send, {LButton Up}
	}
Return

Upgrade:
	; is there a pending update
	ForceRun := Mod(LoopCount,2)

	PixelGetColor, bgr, 2910, 1884
	if (bgr != 0xF40000) {
		if (ForceRun != 0) 
			Return
	}

	PixelGetColor, bgr, 3746, 193
	;MsgBox, %bgr%
	if (bgr != 0xCEFAFF) {
		Send, u
		Sleep, 1000
	}

	Pos := [760, 920, 1080, 1249, 1420, 1567, 1720]

	Loop % Pos.Length()
	{
		PixelGetColor, bgr, 2910, Pos[A_Index]
		;IniWrite, %bgr%, C:\Users\Joci\Desktop\fire.ini, Upgrade, A%A_Index%
		IniWrite, %bgr%, C:\Users\Joci\Desktop\fire.ini, UpgradeLast, A%A_Index%
		MouseMove, 2910, Pos[A_Index]
		;MsgBox, %bgr%
		IniRead, expectedbgr, C:\Users\Joci\Desktop\fire.ini, Upgrade, A%A_Index%
		if (bgr = expectedbgr)	{
			MouseClick left, 2910, Pos[A_Index]
			Send {Space}
			Sleep, 300  
		}
	}

	Send, u
	Sleep, 500

Return

Guild:
	Send, t
	Sleep, 700
	MouseClick, Left, 2650, 650
	Sleep, 700
	MouseClick, Left, 990, 1000
	Sleep, 700
    Loop, 3
	{
		MouseClick, Left, 2420, 960
		Sleep, 700
	}
    Loop, 3
	{
		Send {Escape}
		Sleep, 500
	}
Return
