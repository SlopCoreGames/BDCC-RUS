extends "res://Scenes/SceneBase.gd"

var computer:ComputerBase
var computerID = "error"
var currentCommand = []
var inputMode = "buttons" # buttons, numpad or keyboard
var shouldPlayFancyAnimation = false
var shouldPlayFancyAnimationForText = false

func _initScene(_args = []):
	if(_args.size() > 0):
		if(_args[0] is String):
			computerID = _args[0]
		else:
			computer = _args[0]
			computerID = computer.id
	
	if(computer == null):
		computer = GlobalRegistry.createComputer(computerID)

func _init():
	sceneID = "ComputerSimScene"

func _run():
	if(state == ""):
		if(computer.getLastCommand() != ""):
			saynn("> "+computer.getLastCommand())
		if(shouldPlayFancyAnimationForText):
			saynn("[console speed=40]"+computer.getOutput()+"[/console]")
			shouldPlayFancyAnimationForText = false
		else:
			saynn(computer.getOutput())
		
		var tutorialText = computer.getTutorial()
		if(tutorialText != null && tutorialText != ""):
			saynn("[i]"+tutorialText+"[/i]")
		
		if(inputMode == "keyboard"):
			say(">")
			var textBox:LineEdit = addTextbox("textcommand")
			var _ok = textBox.connect("text_entered", self, "onTextBoxEnterPressed")
			addButtonAt(0, "SEND", "Отправить команду", "sendkeyboard")
			addButtonAt(14, "COMMANDS", "Перейти к командам", "buttons")
		
		elif(inputMode == "buttons"):
			saynn("> "+ getCurrentCommandString())
			#for key in TextTransitionSettings.transitions:
			#	TextTransitionSettings.transitions[key].fade_in()
			
			if(currentCommand.size() > 0):
				addButtonAt(0, "SEND", "Отправить команду", "send")
				addButtonAt(9, "CLEAR", "Очистить команду", "clearcommand")
			else:
				addDisabledButtonAt(0, "SEND", "Нечего отправлять")
				addDisabledButtonAt(9, "CLEAR", "Нечего очищать")
			addButtonAt(13, "NUMPAD", "Перейти к цифровой панели", "numpad")
			addButtonAt(14, "KEYBOARD", "Перейти к клавиатуре для ручного ввода команды", "keyboard")
			
			var words = computer.getCommands()
			if(words.size() == 0):
				addButton("Печатать абракадабру", "Печатать что-нибудь", "inputfull", ["asdasdf"])
			for command in words:
				addButton(command, "Печатать это", "add", [command])
			
		elif(inputMode == "numpad"):
			saynn("> "+getCurrentCommandString())
			
			addButtonAt(1, "7", "Печатать это", "addnumpad", ["7"])
			addButtonAt(2, "8", "Печатать это", "addnumpad", ["8"])
			addButtonAt(3, "9", "Печатать это", "addnumpad", ["9"])
			addButtonAt(6, "4", "Печатать это", "addnumpad", ["4"])
			addButtonAt(7, "5", "Печатать это", "addnumpad", ["5"])
			addButtonAt(8, "6", "Печатать это", "addnumpad", ["6"])
			addButtonAt(11, "1", "Печатать это", "addnumpad", ["1"])
			addButtonAt(12, "2", "Печатать это", "addnumpad", ["2"])
			addButtonAt(13, "3", "Печатать это", "addnumpad", ["3"])
			addButtonAt(10, "0", "Печатать это", "addnumpad", ["0"])
			addButtonAt(5, ".", "Печатать это", "addnumpad", ["."])
			
			if(currentCommand.size() > 0):
				addButtonAt(0, "SEND", "Отправить команду", "send")
				addButtonAt(9, "CLEAR", "Очистить команду", "clearcommand")
			else:
				addDisabledButtonAt(0, "SEND", "Нечего отправлять")
				addDisabledButtonAt(9, "CLEAR", "Нечего очищать")
			addButtonAt(14, "COMMANDS", "Перейти к командам", "buttons")
			

		#addButton("Уйти", "Работа выполнена!", "endthescene")

	elif(state == "finished"):
		if(computer.getLastCommand() != ""):
			saynn("> "+computer.getLastCommand())
		if(shouldPlayFancyAnimationForText):
			saynn("[console]"+computer.getOutput()+"[/console]")
			shouldPlayFancyAnimationForText = false
		else:
			saynn(computer.getOutput())
		
		addButton("Продолжить", "Завершить взаимодействие", "endthescene")

func getCurrentCommandString():
	var result = []
	for _i in range(currentCommand.size()):
		if(_i == (currentCommand.size() - 1) && currentCommand[_i][1] == "word" && shouldPlayFancyAnimation):
			result.append("[console]"+currentCommand[_i][0]+"[/console]")
			shouldPlayFancyAnimation = false
		else:
			result.append(currentCommand[_i][0])
	
	return Util.join(result, " ")

func onTextBoxEnterPressed(_new_text:String):
	GM.main.pickOption("sendkeyboard", [])

func _react(_action: String, _args):
	if(_action == "send"):
		computer.inputCommand(getCurrentCommandString())
		currentCommand.clear()
		if(inputMode == "numpad"):
			inputMode = "buttons"
		if(computer.hasEndedOrFailed()):
			state = "finished"
		shouldPlayFancyAnimationForText = true
		return
	
	if(_action == "sendkeyboard"):
		computer.inputCommand(getTextboxData("textcommand"))
		currentCommand.clear()
		if(computer.hasEndedOrFailed()):
			state = "finished"
		shouldPlayFancyAnimationForText = true
		return
	
	if(_action == "clearcommand"):
		currentCommand.clear()
		return
	
	if(_action == "inputfull"):
		computer.inputCommand(_args[0])
		currentCommand.clear()
		if(computer.hasEndedOrFailed()):
			state = "finished"
		shouldPlayFancyAnimationForText = true
		return
	
	if(_action == "numpad"):
		inputMode = "numpad"
		return
	
	if(_action == "buttons"):
		inputMode = "buttons"
		return
		
	if(_action == "keyboard"):
		inputMode = "keyboard"
		return
		
	if(_action == "addnumpad"):
		if(currentCommand.size() == 0):
			currentCommand.append([str(_args[0]), "num"])
		else:
			if(currentCommand.back()[1] == "num"):
				currentCommand.back()[0] = currentCommand.back()[0] + str(_args[0])
			else:
				currentCommand.append([str(_args[0]), "num"])
		return
	
	if(_action == "add"):
		currentCommand.append([_args[0], "word"])
		shouldPlayFancyAnimation = true
		return
	
	if(_action == "endthescene"):
		if(computer.hasEnded()):
			endScene([true, computer.getEndedArgs()])
			return
		if(computer.hasEndedFailed()):
			endScene([false, computer.getEndedArgs()])
			return
		endScene([false, []])
		return
	
	setState(_action)

func saveData():
	var data = .saveData()
	
	data["computerID"] = computerID
	data["computerData"] = computer.saveData()
	data["currentCommand"] = currentCommand
	data["inputMode"] = inputMode
	
	return data
	
func loadData(data):
	.loadData(data)
	
	computerID = SAVE.loadVar(data, "computerID", "error")
	computer = GlobalRegistry.createComputer(computerID)
	computer.loadData(SAVE.loadVar(data, "computerData", {}))
	currentCommand = SAVE.loadVar(data, "currentCommand", [])
	inputMode = SAVE.loadVar(data, "inputMode", "buttons")

func getDebugActions():
	return [
		{
			"id": "instantWin",
			"name": "Пропустить взлом компьютера",
			"args": [
			],
		},
	]

func doDebugAction(_id, _args = {}):
	if(_id == "instantWin"):
		computer.markFinished()
		state = "finished"
		GM.main.reRun()
