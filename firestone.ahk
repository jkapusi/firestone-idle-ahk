#SingleInstance, Force
SetTitleMatchMode, 2
CoordMode, Pixel, Screen
#include <FindText>

+esc::exitapp
+g:: Gosub, Guild
+f:: Gosub, GuardianTrain
+m:: Gosub, WarMap
+a:: Gosub, Experiments
+w:: Gosub, WMLoot
+l:: Gosub, Library
+i:: Gosub, Liberation
^+l::
	Record := 2
	Gosub, Library
Return

+p::
Numpad0::
~F6::
	BreakLoop = 1
return 

~F2::
	BreakLoop := 0
	LoopCount := 1
	Loop
	{
		if (BreakLoop = 1) {
			ToolTip, "PAUSED", 10, 115, 1
			break
		}
		if not WinActive("Firestone Idle RPG") {
			ToolTip, "PAUSED (Inactive window)", 10, 115, 1
			Sleep, 3000
			Continue
		}	
		LoopCount++
		ToolTip, %LoopCount% %A_TimeIdlePhysical%, 10, 115, 1

		if (Mod(LoopCount, 4) = 0) {
			Gosub, Upgrade
		}	
		Gosub, Clicker
		if (Mod(LoopCount, 40) = 0) {
			Gosub, WarMap
			Sleep, 700
		}
		if (Mod(LoopCount, 40) = 0) {
			; Gosub, Experiments
			Sleep, 700
			Gosub, Guild
			Sleep, 700
			Gosub, GuardianTrain
			Sleep, 700
			Gosub, Library
			Sleep, 700
			Gosub, WMLoot
			Sleep, 700
			Gosub, Experiments
		}
	}
Return

#If (Record > 0)
~RButton::
	Record -= 1
	MouseGetPos,X,Y
	IniWrite, %X%, C:\Users\Joci\Desktop\fire.ini, Library, Pos%Record%X
	IniWrite, %Y%, C:\Users\Joci\Desktop\fire.ini, Library, Pos%Record%Y
	ToolTip, Recording position %Record% %X% %Y%, 10, 115, 1
Return

Library:
	Send, l
	Sleep, 700
	SetMouseDelay, 50
	
	; Click to Firestone research
	Click2Pos("Library.FirestoneButton", 0)
	Sleep, 700

	if (Record > 0) {
		ToolTip, Recording position, 10, 115, 1
		Return
	}

	; Detect second slot is active
	;PixelGetColor, bgr, 2369, 1815
	;MsgBox, %bgr%
	;if (bgr = 0x386992a) {
	;	Send {Escape}
	;	Return
	;}

	;Sleep, 700
	
	;; 1st slot
	IniRead, X, C:\Users\Joci\Desktop\fire.ini, Library, Pos1X
	IniRead, Y, C:\Users\Joci\Desktop\fire.ini, Library, Pos1Y
	MouseClick, Left, X, Y

	MouseMove, 1000, 1000
	Sleep, 700

	PixelGetColor, bgr, 765, 786
	MouseMove, 765, 786
	;MsgBox, %bgr%

	Sleep, 700
	if (bgr = 0x08A10B) {
		MouseClick, Left, 765, 786
	} else {
		;MsgBox, %bgr%
		Send {Escape}
	}

	Sleep, 700

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	; 2nd slot
	IniRead, X, C:\Users\Joci\Desktop\fire.ini, Library, Pos0X
	IniRead, Y, C:\Users\Joci\Desktop\fire.ini, Library, Pos0Y
	MouseClick, Left, X, Y

	MouseMove, 1000, 1000
	Sleep, 700

	PixelGetColor, bgr, 765, 786
	MouseMove, 765, 786
	;MsgBox, %bgr%

	Sleep, 700
	if (bgr = 0x08A10B) {
		MouseClick, Left, 765, 786
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

LibraryNew:
	Send, l
	Sleep, 700
	SetMouseDelay, 50
	
	; Click to Firestone research
	MouseClick, Left, 3019, 1861
	Sleep, 500

	; Detect second slot is active
	PixelGetColor, bgr, 2369, 1815
	;MsgBox, %bgr%
	if (bgr = 0x386992) {
		Send {Escape}
		Return
	}

	;Text:="|<>*144$45.zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz000007zs00000zz000007zs00000zz000007zs00000zz000007zs00000zz000007zs00000zz000007zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzU"
	Text:="|<>*91$35.zzzk01zzzk03zzzw07zzzw0Dzzzw0Tzzzw0zzzzs001zzs000Tzk000Dzk000TzU000zz0001zy0003zw0007zs000Dzk000TzU001zz0007zy1zzzzw3zzzzs7zzzzkDzzzzUTzzzz0U"

	ok:=FindText(X,Y,,,,,0.15,0.15,Text)
	for k, v in ok {
		; MouseMove, v.x+27, v.y+15
		MouseClick, Left, v.x, v.y
		Sleep, 300
		MouseMove, 1000, 1000
		Sleep, 300

		PixelGetColor, bgr, 1528, 1570
		MouseMove, 1528, 1570

		Sleep, 700
		if (bgr = 0x08A10B) {
			MouseClick, Left, 1528, 1570
		} else {
			;MsgBox, %bgr%
			Send {Escape}
		}

		MouseClick, Left, 2100, 600
		Sleep, 700
		MouseClick, Left, 2100, 600
		Sleep, 700
	}

	;RunWait, C:\Users\Joci\Downloads\Capture2Text_v4.6.3_64bit\Capture2Text\Capture2Text_CLI.exe --screen-rect "815 571 946 616" --clipboard, , hide
	;msgbox, %Clipboard%
	Send {Escape}
	Send {Escape}
Return

Liberation:
	Send, m
	Sleep, 700
	Click2Pos("WMLoot.WarmachineButton", 0)

	if Click2Pos("WMLoot.DailyMission") {
		if Click2Pos("WMLoot.LiberationOpenBtn") {
			Pos := [425, 725, 1000, 1275]
			MouseMove, Pos[A_Index], 800

			Loop % Pos.Length()
			{
				PixelGetColor, bgr, Pos[A_Index], 800
				if (bgr = 0x6590C0)	{
					; There is no button here
					Continue
				}
				MouseMove, Pos[A_Index], 800
				Sleep, 300  
			}
			MouseClickDrag, Left, 1500, 640, 200, 640, 10
			Sleep, 1000
			MouseClickDrag, Left, 450, 640, 1700, 640, 10
			Sleep, 1000
			Send {Escape}
		}
	}
	Send {Escape}
	Send {Escape}

Return

GuardianTrain:
	Send, g
	Sleep, 700

	Click2Pos("GuardianTrain.TrainButton")

	Send {Escape}
Return

Experiments:
	Send, a
	Sleep, 700

	Click2Pos("Experiments.DragonBlood")

	Send {Escape}
Return

WMLoot:
	Send, m
	Sleep, 700
	
	Click2Pos("WMLoot.WarmachineButton")
	Sleep, 700
	
	Click2Pos("WMLoot.LootButton")
	Sleep, 700
	
	Send {Escape 2}
Return

WarMap:
	Send, m
	Sleep, 700

	Loop
	{
		if not Click2Pos("WarMap.Claim") {
			Break
		}
		Sleep, 700
	}
	Sleep, 700
	MouseClick, Left, 529, 448
	Sleep, 700
	
	;Text.="|<nagyito>*170$57.0Tjy0000007bzs000001wyTU00000D7lz000003sy3zU0000TDwDy00007tzkQk0000zzDV700007zkT0w0001zy0Q7s000Dzw1szU001zzs36z000Dzzk3nzU03zzzUS7z00TzzzlsDc03TzzyBktU0NzzzX3XA01zzzwMD1k07zzz3UCT00Tzzsy0nw00zzyDw4Ts00zzXzwXzU00zszzwzy000y7zzDys001lzzlzrY"
    Text:="|<nagyito>**60$27.1k000HU004K001WM00BVs03i500FU602A5M0G88s40B2U81E43UG2s3ak5U7g5W07lN803vG002iE000QU"
	;Text.="|<sarkany>**50$34./w03008M0q04EU5g0100As0Dn04k9cBklko00U0Uk1y021UJw0420JM0G81LU18U7n02U0CG4+40C01c00004E0U71l410o64k0tmM/U0070U000k9LA030W7Tzs2"
	Text.="|<sarkany>**50$32.E1C0043ss023U3007k0A0040RU0V0580AE1r07tc3A10MUlkk0006A0TU0V09c08E2x0340pM4F07p0Y00v0FX0000EE000A000w630Mt12"
	Text.="|<terkep>**50$23.0001s0027s060Tc6+0E4q00ss00lq11aq234046048A08EM0EUk01Fk66FUNkF0w0WA0zAsDsNvzsnTU0ws01300E"
	;Text.="|<kard>*138$35.001U0600200M00801U00k0600300M0CA01U0zk0601X00M03U01U07U0200700A00700k00DU3000DkA000zkk003zkk00DzkU00zztU0DzzzU0zzzz03Vzzy071zrs061z300C1w000C1k001"
	Text.="|<kard>**50$21.003k01n00MM06300UE08O037k0Ea049U13M0Mq02BU6XM1cq065U0lM03W00yE0AT07Xs0br07Q00R004"
	;Text.="|<kormany>*138$53.000007k0000000Tk0000001nU000700370000z006C0001r00Cs0003D1zzU0007Tzzz00007zzzz00007zzzz00007zzbz0000Dzznz0000wzzxz0003zzztz0007zsTvy000TzUyTy001zzXszw003zjzkzs007y87kjs00TsDrlDzk1zVzbaTznzz1zjwzXzzzrzTtT3tzzjyzmzznzzTtzZzz"
	;Text.="|<mancs>*126$43.20T0T0810TkTkA0kTsDs60sDw7y3UQ7y3z1kC7z1zUs73zUzsQ01zkTw000zsDy00MTw7z10yDy3zXsz7z1zlyTlzUzlzTszUTszzwDk7sTzz1U1kTzzU000Dzzk0007zzs0C03zzy1zs3zzz1zz1zzz1zzkztzVzzsDwzkzzy7wDkzzzXyE"

	ok:=FindText(X,Y,,,,,0.33,0.33,Text)
	for k, v in ok {
		ToolTip, % v.x "x" v.y " id: " v.id, 10, 115, 1
		; MouseMove, v.x, v.y
		MouseClick, Left, v.x, v.y
		Sleep, 700

		; If not have enough squads (brown letter)
		PixelGetColor, bgr, 900, 903
		if (bgr = 0x102754) {
			Sleep, 1000
			MouseMove, 880, 880
			Send {Escape 3}
            Break
		}

		; Start mission if green
		Click2Pos("WarMap.StartMission")

		; Claim rewards
		Click2Pos("WarMap.ClaimReward")

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
	
	MouseMove, 1150, 275

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
	PixelGetColor, bgr, 3746, 193
	;MsgBox, %bgr%
	if (bgr != 0xCEFAFF) {
		Send, u
		Sleep, 1000
	}

	Pos := [380, 460, 550, 620, 700, 790, 860]

	Loop % Pos.Length()
	{
		PixelGetColor, bgr, 1460, Pos[A_Index]
		;IniWrite, %bgr%, C:\Users\Joci\Desktop\fire.ini, Upgrade, A%A_Index%
		IniWrite, %bgr%, C:\Users\Joci\Desktop\fire.ini, UpgradeLast, A%A_Index%
		MouseMove, 1460, Pos[A_Index]
		;MsgBox, %bgr%
		IniRead, expectedbgr, C:\Users\Joci\Desktop\fire.ini, Upgrade, A%A_Index%
		if (bgr = expectedbgr)	{
			MouseClick left, 1460, Pos[A_Index]
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
	Click2Pos("Guild.Guild", 0)
	Sleep, 700
	Click2Pos("Guild.Expeditions", 0)
	Sleep, 700
    Loop, 3
	{
		Click2Pos("Guild.ClaimAndStart", 0)
		Sleep, 700
	}
    Loop, 3
	{
		Send {Escape}
		Sleep, 500
	}
Return

WaitForColor(color, X, Y) {
	PixelGetColor, color, X, Y
	While !(color = "0xDCDCDC") {
		PixelGetColor, color, X, Y
		Sleep, 250
	}
}

NamedPos(name) {
	If InStr(name, ".") {
		tmp := StrSplit(name, ".")
		name := tmp[2]
		grp := tmp[1]
	} else {
		grp := "Click2Pos"
	}
	IniRead, values, C:\Users\Joci\Desktop\fire.ini, %grp%, %name%
	if (values = "ERROR") {
		ToolTip, %grp%.%name% please right click to the position, 10, 115, 1
		KeyWait, RButton, D
		MouseGetPos, x, y
		ToolTip, %grp%.%name% position %x% %y% Right click anywhere to store the color, 10, 115, 1
		Sleep, 700
		KeyWait, RButton, D
		PixelGetColor, bgr, x, y
		IniWrite, %x%/%y%/%bgr%, C:\Users\Joci\Desktop\fire.ini, %grp%, %name%
	}

	IniRead, values, C:\Users\Joci\Desktop\fire.ini, %grp%, %name%
	tmp := StrSplit(values, "/")
	r := {X: tmp[1], Y: tmp[2], color: tmp[3]}
	Return r
}

Click2Pos(name, colormatching=1) {
	If InStr(name, ".") {
		tmp := StrSplit(name, ".")
		name := tmp[2]
		grp := tmp[1]
	} else {
		grp := "Click2Pos"
	}

	IniRead, values, C:\Users\Joci\Desktop\fire.ini, %grp%, %name%
	if (values = "ERROR") {
		ToolTip, %grp%.%name% please right click to the position, 10, 115, 1
		KeyWait, RButton, D
		MouseGetPos, x, y
		ToolTip, %grp%.%name% position %x% %y% Right click anywhere to store the color, 10, 115, 1
		Sleep, 700
		KeyWait, RButton, D
		PixelGetColor, bgr, x, y
		IniWrite, %x%/%y%/%bgr%, C:\Users\Joci\Desktop\fire.ini, %grp%, %name%
	} else {
		tmp := StrSplit(values, "/")
		;MsgBox % "Click2Pos value for " . grp . "/" . name . " is " . tmp[1] . "x" . tmp[2] . " - " . tmp[3]
		if (colormatching != 0) {
			MouseMove, tmp[1] - 100, tmp[2] - 100
			Sleep, 300
			PixelGetColor, bgr, tmp[1], tmp[2]
			MouseMove, tmp[1], tmp[2]
		}
		if (bgr = tmp[3] OR colormatching = 0) {
			MouseClick, Left, tmp[1], tmp[2]
			Sleep, 1000
			Return 1
		} else {
			Return 0
		}
	}
}
