#SingleInstance
#Requires Autohotkey v2.0+

Data := [false, 0, "Anticastinador V1.0","","","","",""]

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

InfoText := MainGui.Add("Text", "w315 h30 x10 y50 cLime BackgroundBlack", "('_')/ Hola! Contaré cuanto tiempo utilices las ventanas que definas en el menú.")
InfoText.SetFont("s8", "Lucida Console")

StartButton := MainGui.Add("Button", "w50 h30 x155 y10", "Iniciar")
StartButton.OnEvent("Click", StartButtonClick)
StartButtonClick(Info, Href) {
	Data[1] := not Data[1]
	if Data[1] == true {
		TimerText.Opt("BackgroundYellow")
		MainGui.BackColor := "Olive"
		StartButton.text := "Parar"
		InfoText.text := "(°.°), Iniciando..."
		SetTimer(TimerRun, 1000)
	} else {
		TimerText.Opt("BackgroundAqua")
		MainGui.BackColor := "Teal"
		StartButton.text := "Iniciar"
		InfoText.text := "('_'), Temporizador detenido."
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
	InfoText.text := "(*_*), Temporizador reiniciado."
}

MenuButton := MainGui.Add("Button", "w50 h30 x275 y10", "Menú")
MenuButton.OnEvent("Click", MenuButtonClick)
MenuButtonClick(Info, Href) {
	MenuGui.Show("w270 h315 Center")
}

MenuGui := Gui.Call("-Resize -MinimizeBox +AlwaysOnTop +Border", Data[3], Data)

SlotIButton := MenuGui.Add("Button", "w250 h30 v4", "[Vacío]")
SlotIIButton := MenuGui.Add("Button", "w250 h30 v5", "[Vacío]")
SlotIIIButton := MenuGui.Add("Button", "w250 h30 v6", "[Vacío]")
SlotIVButton := MenuGui.Add("Button", "w250 h30 v7", "[Vacío]")
SlotVButton := MenuGui.Add("Button", "w250 h30 v8", "[Vacío]")

SlotIButton.OnEvent("Click", SlotButtonClick)
SlotIIButton.OnEvent("Click", SlotButtonClick)
SlotIIIButton.OnEvent("Click", SlotButtonClick)
SlotIVButton.OnEvent("Click", SlotButtonClick)
SlotVButton.OnEvent("Click", SlotButtonClick)

SlotButtonClick(Button, Href) {
	if Button.text == "[Vacío]" {
		Button.text := "[Awaiting input...]"
		loop {
			Sleep(1)
		} until !WinActive(Data[3])
		if Button.text != "[Vacío]" and WinExist("A") {
			Button.text := WinGetTitle("A")
			Data[Button.name] := Button.text
		} else {
			Button.text := "[Vacío]"
			Data[Button.name] := ""
		}
	} else {
		Button.text := "[Vacío]"
		Data[Button.name] := ""
	}
}

MenuInfoI := MenuGui.Add("Text", "w250 Center", "Para añadir ventanas, selecciona un botón y luego abre la ventana correspondiente. Ten en cuenta que las ventanas se detectan por nombre.")
MenuInfoII := MenuGui.Add("Text", "w250 Center cGray", "El Anticastinador esta inspirado en una herramienta creada por Neil Cicierega en 2013. Como el link de descarga está roto y la versión es muy antigua, decidí rediseñarla para que sepas cuanto tiempo realmente estás trabajando. ¡Que te vaya bien!")

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
		InfoText.text := "(^_^)/ Eso es! Sigue trabajando."
	} else {
		TimerText.Opt("BackgroundRed")
		MainGui.BackColor := "Maroon"
		InfoText.text := "(¬_¬)_ Regresa a lo que elegiste hacer."
	}
}