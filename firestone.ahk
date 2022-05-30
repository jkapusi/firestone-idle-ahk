#SingleInstance, Force
CoordMode, Pixel, Screen

esc::exitapp

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
		Gosub, Upgrade
		Gosub, Clicker
	}
Return

Guild:
	ForceRun := Mod(LoopCount,20)
	Loop, 10
	{
		ImageSearch, FoundX, FoundY, 10, 40, 1000, 1400, guild.png
		if (ErrorLevel = 0) {
			MouseClick, Left, FoundX, FoundY
			Sleep, 1000
			MouseClick, Left, 2440, 630
			Sleep, 1000
			MouseClick, Left, 400, 1000
			Break
		}
		Sleep, 1000
	}
Return

Clicker:
	MouseMove, 2100, 600
	Loop, 5
	{
		if (BreakLoop = 1)
			break

		Send, {LButton Down}
		Sleep, 3000
		Send, {LButton Up}
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

	PixelGetColor, bgr, 3440, 350
	if (bgr = 0x28742B)	{
		MouseClick left, 3400, 350
		Sleep, 500
	}

	PixelGetColor, bgr, 3440, 590
	if (bgr = 0x28742B)	{
		MouseClick left, 3400, 590
		Sleep, 500
	}

	PixelGetColor, bgr, 3440, 830
	if (bgr = 0x28742B)	{
		MouseClick left, 3400, 830
		Sleep, 500
	}

	PixelGetColor, bgr, 3440, 1060
	if (bgr = 0x28742B)	{
		MouseClick left, 3400, 1060
		Sleep, 500
	}

	PixelGetColor, bgr, 3440, 1300
	if (bgr = 0x28742B)	{
		MouseClick left, 3400, 1300
		Sleep, 500
	}

	PixelGetColor, bgr, 3440, 1550
	if (bgr = 0x28742B)	{
		MouseClick left, 3400, 1550
		Sleep, 500
	}

	PixelGetColor, bgr, 3440, 1780
	if (bgr = 0x28742B)	{
		MouseClick left, 3400, 1780
		Sleep, 500
	}

	Send, u
	Sleep, 500

Return
