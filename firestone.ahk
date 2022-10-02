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
	LoopCount := 8
	Loop
	{
		if (BreakLoop = 1) {
			ToolTip, "PAUSED", 35, 250
			break
		}
		LoopCount++
		ToolTip, %LoopCount% %A_TimeIdlePhysical%, 35, 250

		if (Mod(LoopCount, 4) = 0) {
			Gosub, Upgrade
		}	
		Gosub, Clicker
		if (Mod(LoopCount, 40) = 0) {
			Gosub, WarMap
			Sleep, 700
		}
		if (Mod(LoopCount, 80) = 0) {
			Gosub, Experiments
			Sleep, 700
			Gosub, Guild
			Sleep, 700
			Gosub, GuardianTrain
			Sleep, 700
			Gosub, Library
			Sleep, 700
			Gosub, WMLoot
		}
	}
Return

#If (Record > 0)
~RButton::
	Record -= 1
	MouseGetPos,X,Y
	IniWrite, %X%, C:\Users\Joci\Desktop\fire.ini, Library, Pos%Record%X
	IniWrite, %Y%, C:\Users\Joci\Desktop\fire.ini, Library, Pos%Record%Y
	ToolTip, Recording position %Record% %X% %Y%, 35, 250
Return

Library:
	Send, l
	Sleep, 700
	SetMouseDelay, 50
	
	; Click to Firestone research
	MouseClick, Left, 3019, 1861
	Sleep, 700

	if (Record > 0) {
		ToolTip, Recording position, 35, 250
		Return
	}

	; Detect second slot is active
	PixelGetColor, bgr, 2369, 1815
	;MsgBox, %bgr%
	if (bgr = 0x386992a) {
		Send {Escape}
		Return
	}

	Sleep, 700
	
	;; 1st slot
	IniRead, X, C:\Users\Joci\Desktop\fire.ini, Library, Pos1X
	IniRead, Y, C:\Users\Joci\Desktop\fire.ini, Library, Pos1Y
	MouseClick, Left, X, Y

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
	IniRead, X, C:\Users\Joci\Desktop\fire.ini, Library, Pos0X
	IniRead, Y, C:\Users\Joci\Desktop\fire.ini, Library, Pos0Y
	MouseClick, Left, X, Y

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

GuardianTrain:
	Send, g
	Sleep, 700

	PixelGetColor, bgr, 2030, 1600
	MouseMove, 2030, 1600
	IniWrite, %bgr%, C:\Users\Joci\Desktop\fire.ini, GuardianTrain , Last

	;MsgBox, %bgr%
	IniRead, expectedbgr, C:\Users\Joci\Desktop\fire.ini, GuardianTrain, Expected
	if (bgr = expectedbgr) {
		MouseClick, Left, 2030, 1600
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

	Numbers:="|<1>**100$14.3zVUBk1k0M0601U0Q05w110Ek4A120kUA8220UU88220UU88220UU88220UU88221UkE7wU"
	Numbers.="|<2>**100$22.07w07kS0k0A600Mk00m001M0050C0I1g1EAE50X0K2A1A9U4Tg0k1U20A0M1U30A0M3U10Q0A303UM0Q303080TyU00+000c002U00+000g006Tzzm"
	Numbers.="|<3>**100$22.07w03kC0s0C2008E00l0014004ED0FVa13wM401UE0A11zUA601Uk0A200M800kz010TU4030E041Dkk5Va0Q3k3U00+001c004k01l00A703U7zs2"
	Numbers.="|<4>**100$23.3yDw46EA84U8E90EUG0X0Y1418282E4E4U9UN0G0W0Y1A182M2kAUB0F0O0y0g001E002U005000/000Hzy0U041008200E400U8010E020U063007wU"
	Numbers.="|<5>**100$22.3zzwM00F0014004E00l00241zsEA030U0A200UDs20Us800kU01W00281UAkD0FzY100E4010HwA1MNU70w0s002U00O001A00AM03Us0s0zy0U"
	Numbers.="|<6>**100$23.03z00w3k300kM00UU01W001A002E1kBU6kG0MrY1UwM2zkk70t0M0O0U0I000s081k1s1U6M308k60l0A1W0M1A1k3k2k004U00NU01V006300M3U3U1zw1"
	Numbers.="|<7>**100$20.Tzzo005001E00Q007001zy0k1U80E60A1020k1U80E60A1020k1U80k60A1060k1080k6081060k1080k20A1U20E0kA06200zU0U"
	Numbers.="|<8>**100$23.01w00wDU701UM01VU012003A002E3k4U4U90N0G0W0Y1g381k4M00MM01kk00X001g1s1E6M2U8E70FUC0W0M1g0s1k3k004U00NU00X003300Q3U3U1zw1"
	Numbers.="|<9>**100$23.07w01kC0C070k0330024006E004U20/0T0I0W0s140k681UAk30D070A0+000K021Y0A2C0k47zU8030FwA1aAk2MD0AU00F001W006400MA01UC0C07mamm     uu  mmamm     uu          uu          uu          uu          uu     tm     uu          uu          uu          uu          uu     tmamm     uu          uu          uu          uu          uu     tm     uu          uu          uu          uu          uu     tmamm     uu          uu          uu          uu          uu     tm     uu          uu          uu          uu          uu     tamm     uu          uu          uu          uu          uu     tm     uu          uu          uu          uu          uu     t        uu          uu          uu          uu     tm     uu          uu          uu          uu          uu     tmamm     uu          uu          uu          uu          uu     tm     uu          uu          uu          uu          uu     tmamm     uu          uu          uu          uu          uu     tm     uu          uu          uu          uu          uu     tzk1"
	Numbers.="|<0>**100$25.03z00D0s0A070Q00U800M8004A00140M0a0S0G0NU90ME7U881k440k220M310A10U60UE70E82U841E660c120I0X0O0P09U7U4E006A00660031U030M07070C00zw0E"
	Numbers.="|<:>**100$10.7kla3E50I1EBUXC7U000DlVg2U+0c2UP37sU"
	
	FindText().PicLib(Numbers, 1)
	ok:=FindText(X, Y, 725, 901, 981, 972, 0.3, 0.3, FindText().PicN("0123456789:/"))
	if (ocr := FindText().OCR(ok, 5, 5, 5)) {
		;ToolTip, % ocr.text, 35, 250
	}

	FindText().PicLib("|<0>*142$21.zs7zs0Dy00zU03s00C001k3U40y0UDk41y00Tk03y00Tk03y00Tk03y00Tk03y10TU83w1UD0Q003U00y007k01z00Ty0Dw", 1)
	FindText().PicLib("|<1>*139$12.y7w1k1U00001U1m1y1y1y1w1w1w1w1w1w1w1w1w1w3w3w3w3w3w3z3U", 1)
	FindText().PicLib("|<2>*142$19.zUDz01y00S007003000UD0EDU87k47s33s3zs1zs1zs0zs0zs0zs0zs0zk0zk0zk0zs0zw002001000U00M00Q", 1)
	FindText().PicLib("|<3>*141$18.zUTw03s01k01k00k00kT0wT0zz0zz0zy1y03w07s03s01zs0zy0zy0zy0ny01w000100100300700Tk1zU", 1)
	FindText().PicLib("|<4>*139$20.wTVz1s7kC1w3UC0s3US0s7UC1s70S1k7UQ3s70y1UD0M3k6001U00E004001000Q007zw1zz0TzkDzw3zz0zzkDzz3U", 1)
	FindText().PicLib("|<7>*142$16.zzw0000000000000zs7z0Tw3zUDy1zk7z0zs3z0Tw1zUDy0zk7z0Ts3zUDw0zk7z0Tw3zsDzU", 1)
	FindText().PicLib("|</>*142$11.zVz3y7sDkTUy3w7sDUT1y3w7kTUz1w7sDkT1y3w7sTUz1z7y", 1)

	ok:=FindText(X, Y, 2053, 530, 2369, 623, 0.15, 0.15, FindText().PicN("012347/"))
	if (ocr := FindText().OCR(ok, 3, 3)) {
		if (ocr.text == "10/7") {
			Send {Escape}
			Sleep, 700

			Return
		}
	}

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
	Text.="|<kormany>*138$53.000007k0000000Tk0000001nU000700370000z006C0001r00Cs0003D1zzU0007Tzzz00007zzzz00007zzzz00007zzbz0000Dzznz0000wzzxz0003zzztz0007zsTvy000TzUyTy001zzXszw003zjzkzs007y87kjs00TsDrlDzk1zVzbaTznzz1zjwzXzzzrzTtT3tzzjyzmzznzzTtzZzz"
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
