#SingleInstance
#Requires Autohotkey v2.0+

Data := [false, 0, "Anticastinator V1.0","","","","",""]

MainGui := Gui.Call("-Resize -MinimizeBox +AlwaysOnTop +Border", Data[3], Data)
MainGui.Show("w335 h90 Center")
MainGui.SetFont("", "Verdana")
MainGui.BackColor := "Teal"
MainGui.OnEvent("Close", GuiClosed)
GuiClosed(Info){
	ExitApp(0)
}

TimerText := MainGui.Add("Text", "w135 h30 x10 y10 Center BackgroundAqua", "0:00:00")
TimerText.SetFont("s18 w700", "Verdana")

InfoText := MainGui.Add("Text", "w315 h30 x10 y50 cLime BackgroundBlack", "('_')/ Hello! I will count how much time you use the windows you define in the menu.")
InfoText.SetFont("s8", "Lucida Console")

StartButton := MainGui.Add("Button", "w50 h30 x155 y10", "Start")
StartButton.OnEvent("Click", StartButtonClick)
StartButtonClick(Info, Href) {
	Data[1] := not Data[1]
	if Data[1] == true {
		TimerText.Opt("BackgroundYellow")
		MainGui.BackColor := "Olive"
		StartButton.text := "Pause"
		InfoText.text := "(°.°), Starting..."
		SetTimer(TimerRun, 1000)
	} else {
		TimerText.Opt("BackgroundAqua")
		MainGui.BackColor := "Teal"
		StartButton.text := "Start"
		InfoText.text := "('_'), Timer paused."
	}
}

ResetButton := MainGui.Add("Button", "w50 h30 x215 y10", "Reset")
ResetButton.OnEvent("Click", ResetButtonClick)
ResetButtonClick(Info, Href) {
	Data[1] := false
	Data[2] := 0
	TimerText.Text := "0:00:00"
	TimerText.Opt("BackgroundAqua")
	MainGui.BackColor := "Teal"
	StartButton.text := "Iniciar"
	InfoText.text := "(*_*), Timer reset."
}

MenuButton := MainGui.Add("Button", "w50 h30 x275 y10", "Menu")
MenuButton.OnEvent("Click", MenuButtonClick)
MenuButtonClick(Info, Href) {
	MenuGui.Show("w270 h315 Center")
}

MenuGui := Gui.Call("-Resize -MinimizeBox +AlwaysOnTop +Border", Data[3], Data)

SlotIButton := MenuGui.Add("Button", "w250 h30 v4", "[Empty]")
SlotIIButton := MenuGui.Add("Button", "w250 h30 v5", "[Empty]")
SlotIIIButton := MenuGui.Add("Button", "w250 h30 v6", "[Empty]")
SlotIVButton := MenuGui.Add("Button", "w250 h30 v7", "[Empty]")
SlotVButton := MenuGui.Add("Button", "w250 h30 v8", "[Empty]")

SlotIButton.OnEvent("Click", SlotButtonClick)
SlotIIButton.OnEvent("Click", SlotButtonClick)
SlotIIIButton.OnEvent("Click", SlotButtonClick)
SlotIVButton.OnEvent("Click", SlotButtonClick)
SlotVButton.OnEvent("Click", SlotButtonClick)

SlotButtonClick(Button, Href) {
	if Button.text == "[Empty]" {
		Button.text := "[Awaiting input...]"
		loop {
			Sleep(1)
		} until !WinActive(Data[3])
		if Button.text != "[Empty]" and WinExist("A") {
			Button.text := WinGetTitle("A")
			Data[Button.name] := Button.text
		} else {
			Button.text := "[Empty]"
			Data[Button.name] := ""
		}
	} else {
		Button.text := "[Empty]"
		Data[Button.name] := ""
	}
}

MenuInfoI := MenuGui.Add("Text", "w250 Center", "To add windows, select a button and then open the corresponding window. Keep in mind they are detected by name.")
MenuInfoII := MenuGui.Add("Text", "w250 Center cGray", "The Anticastinator is inspired in a tool created by Neil Cicierega in 2013. Because the download link is broken and the version is really old, I decided to redesign it so you could see how much time you truly spend working. ¡Good luck!")

TimerRun() {
	if Data[1] == false {
		Exit
	}
	if (WinActive(Data[4]) or WinActive(Data[5]) or WinActive(Data[6]) or WinActive(Data[7]) or WinActive(Data[8])) and (A_TimeIdle < 10000) {
		TimerText.Opt("BackgroundLime")
		MainGui.BackColor := "Green"
		Data[2]++
		DigitI := Floor(Data[2]/3600)
		DigitII := Mod(Floor(Data[2]/600),6)
		DigitIII := Mod(Floor(Data[2]/60), 10)
		DigitIV := Mod(Floor(Data[2]/10),6)
		DigitV := Mod(Data[2], 10)
		TimerText.Text := DigitI ":" DigitII DigitIII ":" DigitIV DigitV
		InfoText.text := "(^_^)/ Yeah! Keep working."
	} else {
		TimerText.Opt("BackgroundRed")
		MainGui.BackColor := "Maroon"
		InfoText.text := "(¬_¬)_ Go back to what you have chosen to do."
	}
}