#Requires AutoHotkey v2
#Include %A_ScriptDir%\Lib\guidegui.ahk
#Include %A_ScriptDir%\Lib\webhooksgui.ahk
#Include %A_ScriptDir%\Lib\config.ahk
#Include %A_ScriptDir%\Lib\mainsettingsui.ahk
#Include %A_ScriptDir%\Lib\keybinds.ahk
#Include %A_ScriptDir%\Lib\updates.ahk
GemsEarned := 0
ShibuyaFood := 0
TraitRerolls := 0
StatChips := 0
SuperStatChips := 0
GreenEssence := 0
ColoredEssence := 0
CurrentChallenge := "None"
MinimizeImage := "Lib\Images\minimize.png"
CloseImage := "Lib/Images/close.png"
TaxiImage := "Lib\Images\faxi pfp.png"
DiscordImage := "Lib\Images\Discord-Logo.png"
GithubImage := "Lib\Images\Github-logo2.png"
global currentVersion
lastlog := ""
MainGUI := Gui("-Caption +Border +AlwaysOnTop", "Macro GUI")
MainGUI.BackColor := "0c000a"
MainGUI.SetFont("s9 bold", "Segoe UI")

CloseAppButton := MainGUI.Add("Picture", "x940 y8 w60 h34 +BackgroundTrans cffffff", DiscordImage)
CloseAppButton.OnEvent("Click", (*) => OpenDiscord())

CloseAppButton := MainGUI.Add("Picture", "x810 y4 w60 h40  +BackgroundTrans cffffff", GithubImage)
CloseAppButton.OnEvent("Click", (*) => OpenGithub())


MinimizeButton := MainGUI.Add("Picture", "x1000 y22 w37 h9 +BackgroundTrans cffffff", MinimizeImage)
MinimizeButton.OnEvent("Click", (*) => MinimizeGUI())

CloseAppButton := MainGUI.Add("Picture", "x1052 y10 w30 h32 +BackgroundTrans cffffff", CloseImage)
CloseAppButton.OnEvent("Click", (*) => ExitApp())

GuideBttn := MainGui.Add("Button", "x830 y632 w105 cffffff +BackgroundTrans +Center", "How to use?")
GuideBttn.OnEvent("Click", (*) => OpenGuide())

#Requires AutoHotkey v2.0
#MaxThreadsPerHotkey 2


; Create the initial GUI
MainSettings := Gui("+AlwaysOnTop")
MainSettings.SetFont("s8 bold", "Segoe UI")

AutoUpdate := MainGUI.Add("Checkbox", "x500 y640 w110 cffb8c6 Checked", "Auto update") ;360,110
AutoUpdate.OnEvent("Click", (*) => ChangedAutoUpdate())

ChangedAutoUpdate() {
    global autoUpdateEnabled := AutoUpdate.Value
}

; Set GUI properties
MainSettings.BackColor := "0c000a"
MainSettings.MarginX := 20
MainSettings.MarginY := 20
MainSettings.OnEvent("Close", (*) => MainSettings.Hide())
MainSettings.Title := "Main Settings UI"

MainSettings.Add("Text", "x10 y20 w340 h130 +Center cffffff", "Settings")

; Add Launch Button
Webhookbttn := MainSettings.Add("Button", "x110 y45 w150", "Webhook Settings")
Webhookbttn.OnEvent("Click", (*) => OpenWebhooks())

SendChatBttn := MainSettings.Add("Button", "x110 y95 w150", "Send Chat")
SendChatBttn.OnEvent("Click", (*) => OpenSendChat())

SendChatBttn := MainSettings.Add("Button", "x110 y140 w150", "Keybinds")
SendChatBttn.OnEvent("Click", (*) => OpenKeybinds())

MainGUI.Add("Text", "x735 y640 cffb8c6 w30 Choose1 +Center", "Stage:")

StageDropdown := MainGUI.Add("DropDownList", "x777 y635 cffb8c6 w30 Choose1 +Center", ["1", "2", "3","4"])
StageDropdown.OnEvent("Change", (*) => SaveStageSetting(StageDropdown.Text))

ActionDropdown := MainGUI.Add("DropDownList", "x630 y635 cffb8c6 w85 Choose1 +Center",  [ "Play here","Find Match"]) 
ActionDropdown.OnEvent("Change", (*) => SavePlaySetting())

; Show the main settings GUI
; Show the initial GUI
OpenSettings() {
    MainSettings.Show("AutoSize Center")
}

WebhookBtn := MainGui.Add("Button", "x965 y632 w105 cffffff +BackgroundTrans +Center", "Settings")
WebhookBtn.OnEvent('Click', (*) => OpenSettings())

MainGUI.Add("Picture", "x863 y-20 w90 h90 +BackgroundTrans cffffff", TaxiImage)

MainGUI.AddProgress("c0x7e4141 x8 y27 h602 w800", 100) ; box behind roblox, credits to yuh for this idea
WinSetTransColor("0x7e4141 255", MainGUI)

MainGUI.Add("GroupBox", "x830 y60 w238 h250 cfffd90 ", "Unit Setup")
enabled1 := MainGUI.Add("Checkbox", "x840 y80 cffffff", "Slot 1")
enabled2 := MainGUI.Add("Checkbox", "x840 y110 cffffff", "Slot 2")
enabled3 := MainGUI.Add("Checkbox", "x840 y140 cffffff", "Slot 3")
enabled4 := MainGUI.Add("Checkbox", "x840 y170 cffffff", "Slot 4")
enabled5 := MainGUI.Add("Checkbox", "x840 y200 cffffff", "Slot 5")
enabled6 := MainGUI.Add("Checkbox", "x840 y230 cffffff", "Slot 6")

placement1 := MainGUI.Add("DropDownList", "x1020 y80  w40 cffffff Choose3", [1, 2, 3, 4, 5])
placement2 := MainGUI.Add("DropDownList", "x1020 y110 w40 cffffff Choose3", [1, 2, 3, 4, 5])
placement3 := MainGUI.Add("DropDownList", "x1020 y140 w40 cffffff Choose3", [1, 2, 3, 4, 5])
placement4 := MainGUI.Add("DropDownList", "x1020 y170 w40 cffffff Choose3", [1, 2, 3, 4, 5])
placement5 := MainGUI.Add("DropDownList", "x1020 y200 w40 cffffff Choose3", [1, 2, 3, 4, 5])
placement6 := MainGUI.Add("DropDownList", "x1020 y230 w40 cffffff Choose3", [1, 2, 3, 4, 5])

MainGUI.Add("Text", "x940 y80 h60 cffffff +BackgroundTrans", "Placements: ")
MainGUI.Add("Text", "x940 y110 h60 cffffff +BackgroundTrans", "Placements: ")
MainGUI.Add("Text", "x940 y140 h60 cffffff +BackgroundTrans", "Placements: ")
MainGUI.Add("Text", "x940 y170 h60 cffffff +BackgroundTrans", "Placements: ")
MainGUI.Add("Text", "x940 y200 h60 cffffff +BackgroundTrans", "Placements: ")
MainGUI.Add("Text", "x940 y230 h60 cffffff +BackgroundTrans", "Placements: ")

SaveConfigBttn := MainGUI.Add("Button", "x840 y270 w95 h30 cffffff +Center", "Load config")
SaveConfigBttn.OnEvent("Click", (*) => LoadConfig())

SaveConfigBttn := MainGUI.Add("Button", "x960 y270 w95 h30 cffffff +Center", "Save config")
SaveConfigBttn.OnEvent("Click", (*) => SaveConfig())

MainGUI.Add("GroupBox", "x830 y320 w238 h210 cfffd90 ", "Activity Log ")
ActivityLog := MainGUI.Add("Text", "x830 y340 w238 h300 r11 cffffff +BackgroundTrans +Center", "Macro Launched")

MainGUI.Add("GroupBox", "x830 y540 w238 h80 cfffd90 ", "Keybinds")
KeyBinds := MainGUI.Add("Text", "x830 y560 w238 h300 r7 cffffff +BackgroundTrans +Center", "F1 - Fix Roblox Position `n F2 - Start Macro `n F3 - Stop Macro")

MainGUI.SetFont("s16 bold", "Segoe UI")

MainGUI.Add("Text", "x12 y632 w300 cffb8c6 +BackgroundTrans", "Dodos Strange-town raid: " currentVersion)


MainGUI.Show("x27 y15 w1100 h665") 

AddToLog(text) {
    global lastlog
    ActivityLog.Value := text "`n" ActivityLog.Value
}

MinimizeGUI() {
    WinMinimize("Macro GUI")
}

OpenDiscord() {
    Run("https://discord.gg/UB9AaPzqdq")
}

OpenGithub() {
Run("https://github.com/Dodoyung24/Magic-hill")
}

SendChatGUI := Gui("+AlwaysOnTop")

SendChatGUI.SetFont("s8 bold", "Segoe UI")
SendChatGUI.Add("Text", "x10 y8 w280 cWhite", "Would you like the macro to send a message once it loads in a game? (it only sends it once per game and this is optional)")

SendChatGUI.Add("Text", "x10 y56 cWhite", "Message to send")
ChatToSend := SendChatGUI.Add("Edit", "x10 y70 w280", "")

ChatStatusBox := SendChatGUI.Add("Checkbox", "x10 y109 cWhite", "Enabled")

SendChatGUI.BackColor := "0c000a"
SendChatGUI.MarginX := 20
SendChatGUI.MarginY := 20

SendChatGUI.OnEvent("Close", (*) => SendChatGUI.Hide())
SendChatGUI.Title := "Send Chat"


OpenSendChat() {
    SendChatGUI.Show("w300 h150")
}

LoadConfigFromFile("C:\global.txt")
LoadWebhookSettings(true)
LoadHotkeys()