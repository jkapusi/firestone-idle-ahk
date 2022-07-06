#SingleInstance, Force
CoordMode, Pixel, Screen

+esc::exitapp
+g:: Gosub, Guild
+m:: Gosub, WarMap
+a:: Gosub, Experiments

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
	BreakLoop = 0
	LoopCount := 0
	Loop
	{
		if (BreakLoop = 1) {
			MsgBox, Loop stopped
			break
		}
		LoopCount++
		ToolTip, %LoopCount% %A_TimeIdlePhysical% , 35, 250

		Gosub, Upgrade
		Gosub, Clicker
		if (Mod(LoopCount, 10) = 0) {
			Gosub, Guild
		}
	}
Return

Experiments:
	Send, a
	Sleep, 700

	PixelGetColor, bgr, 1728, 1441
	if (bgr = 0x384D65) {
		MouseClick, Left, 1760, 1614
		Sleep, 1000
	}

	Send {Escape}
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

	Pos := [750, 920, 1080, 1250, 1420, 1570, 1720]

	Loop % Pos.Length()
	{
		PixelGetColor, bgr, 2900, Pos[A_Index]
		if (bgr = 0x28742B)	{
			MouseClick left, 2900, Pos[A_Index]
			Sleep, 500
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
