﻿#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.

; # = Windows Key
; + = Shift
; ^ = Control
; ! = Alt

; win + t ... Set phone timer
#t::
    ;     run C:\Users\Merritt\Nextcloud\Scripts\Windows\set_phone_timer.ps1
    run C:\Users\Merritt\Dev\set_phone_timer\build\windows\runner\Release\set_phone_timer.exe
return

; Ctrl + Alt + T ... Launch Windows Terminal
^!t::
    run wt
return

; win + PgDown ... Minimize active window
#PgDn::WinMinimize, A

; win + PgUp ... Maximize / unmaximize active window
toggle := 0
return
#PgUp::
    toggle := !toggle
    if (toggle = 1)
        WinMaximize, A
    else
        WinRestore, A
return

; Move virtual desktop to the left
#WheelUp::Send ^#{Left}{LWin up}

; Move virtual desktop to the right
#WheelDown::Send ^#{Right}{LWin up}

; --------------------- Move window to virtual desktop --------------------- 
; https://superuser.com/a/1538134/560254

; Ctrl + Win + Mouse wheel up ... Move active window to previous virtual desktop
^#WheelUp::
    WinGetTitle, Title, A
    WinSet, ExStyle, ^0x80, %Title%
    Send {LWin down}{Ctrl down}{Left}{Ctrl up}{LWin up}
    sleep, 50
    WinSet, ExStyle, ^0x80, %Title%
    WinActivate, %Title%
Return

; Ctrl + Win + Mouse wheel up ... Move active window to next virtual desktop
^#WheelDown::
    WinGetTitle, Title, A
    WinSet, ExStyle, ^0x80, %Title%
    Send {LWin down}{Ctrl down}{Right}{Ctrl up}{LWin up}
    sleep, 50
    WinSet, ExStyle, ^0x80, %Title%
    WinActivate, %Title%
Return