#SingleInstance, Force
CoordMode, Pixel, Screen
#include <FindText>

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
	LoopCount := 8
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
			Sleep, 700
			Gosub, WarMap
			Sleep, 700
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

		if (Mod(LoopCount, 60) = 0) {
			Gosub, WarMap
			Sleep, 700
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
	
	;; 1st slot
	MouseClick, Left, 959, 1016
	;MouseClick, Left, 2074, 846
	;MouseClick, Left, 1820, 1365

	MouseMove, 1000, 1000
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

	; 2nd slot
	;MouseClick, Left, 959, 1343
	MouseClick, Left, 1737, 1192

	MouseMove, 1000, 1000
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
	Send, m
	Sleep, 700

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
	;Text.="|<nagyito>*170$57.0Tjy0000007bzs000001wyTU00000D7lz000003sy3zU0000TDwDy00007tzkQk0000zzDV700007zkT0w0001zy0Q7s000Dzw1szU001zzs36z000Dzzk3nzU03zzzUS7z00TzzzlsDc03TzzyBktU0NzzzX3XA01zzzwMD1k07zzz3UCT00Tzzsy0nw00zzyDw4Ts00zzXzwXzU00zszzwzy000y7zzDys001lzzlzrY"
	Text:="|<nagyito>*160$52.03D0000000Mz00000033y000000Tjw000003Wzw00000C/7s00001siDk00007XkDw0000yTkD80007tzUQU000Tj0030001zw1UD0007zk00y000zzk13y003zzU4Nw00DzzU1Vz01jzz063x06zzyMM3q0NzzzX8680bzzyA01U3zzzkU0707zzy60CT0Dzzsw0Fy8"
	Text.="|<sarkany>*144$71.Tzk0Dq000601zzsDzs000601zzyzzs000A01zzzzzs000M01zzyzzw000M03zzxzww000k03zzzzts001U07zkTzzs001U0DvUTzzk00300TnUTzzk0860BzlkzzzU08S0DzXkzzv018w0zzk0TzzU71w1zzU0Tzz003k3zz10Tzz007U77y3U00y00S087w3001y00w007s7003z07k007sDU0Dzzz000DsDw3zzzy001zsDzztzzs007zs7zzVzzk00Tzk3zz3zz000zzs0000Ty00Xzzw0000Ds01"
	Text.="|<terkep>*155$43.7zy00007kzzU007w01z0T3z003zynzU00009zs20004zy33002Dz3nk017zVzs00VzkDk00MDs3t00A0w1ws020S1yD010D3znU0U7Vtsk0E3kQM00A1s001020w001k10S000Q0k"
	Text.="|<kard>*138$35.001U0600200M00801U00k0600300M0CA01U0zk0601X00M03U01U07U0200700A00700k00DU3000DkA000zkk003zkk00DzkU00zztU0DzzzU0zzzz03Vzzy071zrs061z300C1w000C1k001"
	Text.="|<mancs>*126$43.20T0T0810TkTkA0kTsDs60sDw7y3UQ7y3z1kC7z1zUs73zUzsQ01zkTw000zsDy00MTw7z10yDy3zXsz7z1zlyTlzUzlzTszUTszzwDk7sTzz1U1kTzzU000Dzzk0007zzs0C03zzy1zs3zzz1zz1zzz1zzkztzVzzsDwzkzzy7wDkzzzXyE"

	ok:=FindText(X,Y,,,,,0.15,0.15,Text)
	for k, v in ok {
		; MouseMove, v.x, v.y
		MouseClick, Left, v.x, v.y
		Sleep, 700

		; If not have enough squads (brown letter)
		PixelGetColor, bgr, 1726, 1824
		if (bgr = 0x102754) {
			Sleep, 1000
			MouseMove, 880, 880
			Send {Escape 3}
            Break
		}

		; Start mission if green
		PixelGetColor, bgr, 1922, 1771
		if (bgr = 0x059F0B) {
			MouseClick, Left, 1922, 1771
			Sleep, 1000
		}

		; Claim rewards
		PixelGetColor, bgr, 1882, 1766
		if (bgr = 0xFFFFFF) {
			MouseClick, Left, 1882, 1766
			Sleep, 1000
		}

		MouseMove, 880, 880
		Send {Esc}
		Sleep, 700
	}
	
	Send {Escape}
	Sleep, 700
	Send {Escape}
	Sleep, 700
	Send {Escape}
	Sleep, 700

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
