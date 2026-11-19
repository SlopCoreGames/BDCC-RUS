extends ComputerBase

var connectedTo = ""
var plugSpeed = 0
var lastCageCmd = "disconnect"

func _init():
	id = "DatapadHackComputer"
	introText = "ProbY v1.21 локальная сетевая RMI утилита\nИнформация стремится к свободе!"

func reactToCommand(_command:String, _args:Array, _commandStringRaw:String):
	if(_command == "skiptut"):
		currentTutorialStep = 9999
		return "Обучение пропущено."
	if(connectedTo == ""):
		return reactToCommandLocalhost(_command, _args, _commandStringRaw)
	elif(connectedTo == "deloxekarat_default"):
		return reactToCommandCage(_command, _args, _commandStringRaw)
	elif(connectedTo == "viplug_m_default"):
		return reactToCommandPlug(_command, _args, _commandStringRaw)
	
func reactToCommandLocalhost(_command: String, _args:Array, _commandStringRaw:String):
	if(_command == "connect"):
		if(_args.size() == 1):
			var device = _args[0]
			if(device in ["grd_radio_3511", "1"]):
				return "Подключение к grd_radio_3511...\nУчетные данные не найдены. Соединение прервано.\n[Nice try, but no. - Alex]"
			if(device in ["grd_radio_1447", "2"]):
				return "Подключение к grd_radio_1447...\nУчетные данные не найдены. Соединение прервано.\n[Nice try, but no. - Alex]"
			elif(device in ["deloxekarat_default", "3"]):
				connectedTo = "deloxekarat_default"
				return "Подключение к deloxekarat_default...\nПодключено с использованием заводского логина и пароля производителя/устройства."
			elif(device in ["viplug_m_default", "4"]):
				connectedTo = "viplug_m_default"
				return "Подключение к viplug_m_default...\nПодключено с использованием заводского логина и пароля производителя/устройства."
			else:
				return "Подключение к "+device+"...\nУстройство не найдено."
		else:
			return "Эта команда ожидает 1 аргумент"
	
	if(_command == "probe"):
		if(_args.size() == 0):
			return "Scanning...\nDone. Found 4 devices.\n1 - grd_radio_3511\n2 - grd_radio_1447\n3 - deloxekarat_default\n4 - viplug_m_default"
		else:
			return "Команде требуется 0 аргументов"
			
	if(_command == "exit"):
		markFinishedFail()
		return "До связи! Пусть ваш коннект будет стабильным!"
		
	if(_command == "help"):
		if(_args.size() == 1):
			var tolearn = _args[0]
			if(tolearn == "help"):
				return "Эта команда выводит список всех остальных команд, а также может предоставить справку по конкретной команде при вводе 'help <КОМАНДА>'."
			elif(tolearn == "probe"):
				return "Эта команда сканирует доступные локальные BT-устройства."
			elif(tolearn == "exit"):
				return "Эта команда завершает работу программы."
			elif(tolearn == "connect"):
				return "Эта команда позволяет подключиться к удаленному беспроводному устройству по его BT-идентификатору.\nСинтаксис: 'connect <BT>'"
			else:
				return "Команда '"+str(tolearn)+"'. Чтобы увидеть все доступные команды, введите 'help'."
			
		elif(_args.size() == 0):
			learnCommand("help")
			learnCommand("probe")
			learnCommand("connect")
			learnCommand("exit")
			return "Доступные команды: \nconnect\nprobe\nexit\nhelp\nЧтобы узнать больше о команде, введите 'help <КОМАНДА>'"
		else:
			learnCommand("help")
			return "'help' expects 0 or 1 arguments"
			
	learnCommand("help")
	return "Ошибка: неизвестная команда. Используйте 'help', чтобы увидеть список всех доступных команд"
	
const memPosMap = {
			"unlock": "[color=#88FF88][6,8][/color] (считано 5 байт)",
			"disconnect": "[color=#88FF88][4,16][/color] (считано 10 байт)",
			"monitor": "[color=#88FF88][8,0][/color] (считано 170 байт)",
			"help": "[color=#FF8888][17,4][/color] (считано 78 байт)",
			"strscan": "[color=#FF8888][external memory][/color] (считано ? байт)",
		}
		
const strMap = {
			"1": [" [color=#88FF88][0,8][/color] ", "DeLoxe S3-Karat v1.0.7"],
			"2": [" [color=#88FF88][1,8][/color] ", "ОШИБКА ПАМЯТИ (SEGFAULT) по адресу: %s"],
			"3": [" [color=#88FF88][2,0][/color] ", "Vion"],
			"4": [" [color=#88FF88][2,24][/color]", "locked"],
			"5": [" [color=#88FF88][3,0][/color] ", "unlocked"],
			"6": [" [color=#88FF88][3,12][/color]", "Operating"],
			"7": [" [color=#88FF88][3,24][/color]", "Inactive"],
			"8": [" [color=#88FF88][4,16][/color]", "Disconnecting..."],
			"9": [" [color=#88FF88][5,4][/color] ", "Готов."],
			"10": ["[color=#88FF88][6,0][/color] ", "default"],
			"11": ["[color=#88FF88][6,8][/color] ", "block"],
			"12": ["[color=#88FF88][6,20][/color]", "override"],
			"13": ["[color=#88FF88][7,0][/color] ", "Code "],
			"14": ["[color=#88FF88][7,8][/color] ", "valid."],
			"15": ["[color=#88FF88][7,16][/color]", "invalid."]
		}

const NI = "[color=#FFFF00]|[/color]"
const CR = "[color=#FFAAAA]¬[/color]"
const HI = "[color=#AAAAFF]"
const NO = "[color=#FFFFFF]"

func reactToCommandCage(_command: String, _args:Array, _commandStringRaw:String):
	if(_command == "disconnect"):
		lastCageCmd = _command
		connectedTo = ""
		return "Отключение...\nСоединение разорвано удаленным хостом."
	elif(_command == "monitor"):
		if(_args.size() == 0):
			var lastMem = memPosMap[lastCageCmd]
			var lastCmdStored = lastCageCmd
			lastCageCmd = _command
			return \
				"Status: locked\n"+\
				"Дней в замкнутом состоянии: "+str(GM.main.getDays() + 47)+"\n"+\
				"Сила электромагнитного замка: "+str(stepify(rand_range(3200, 3600),0.1))+" N\n"+\
				"Заряд батареи: "+str(stepify(rand_range(1400, 1500),0.1))+" mAh\n"+\
				"Bioreactor: Operating\n"+\
				"Последний доступ к памяти в: "+lastMem+" by '[color=#EE88FF]"+lastCmdStored+"[/color]'\n"+\
				"Memory dump (first page): \n[b][font=res://Fonts/smallconsolefont.tres]"+\
				"[color=#AAFFAA]   0        8        16       24      [/color]\n"+\
				"[color=#AAFFAA] 0 [/color]BEEFBEA7 DeLoxe S 3-Karat  v1.0.7"+NI+"_\n"+\
				"[color=#AAFFAA] 1 [/color]00010017 ОШИБКА ПАМЯТИ (SEGFAULT) по адресу: %s"+NI+" Eo2ZiE93\n"+\
				"[color=#AAFFAA] 2 [/color]Vion"+NI+"___ b1Un374k J0sTIBXF locked"+NI+"_\n"+\
				"[color=#AAFFAA] 3 [/color]unlocked "+NI+"___Oper ating "+NI+"_ Inactive\n"+\
				"[color=#AAFFAA] 4 [/color]"+NI+"___sAxz 38VsDvXT "+(HI if lastCmdStored == "disconnect" else NO)+"Отключение... [/color]\n"+\
				"[color=#AAFFAA] 5 [/color]"+NI+"___Read y."+NI+"_DwyM UNz6v4ML B1jowhGw\n"+\
				"[color=#AAFFAA] 6 [/color]default"+NI+" "+(HI if lastCmdStored == "unlock" else NO)+"block[/color]"+NI+"__ ____over ride"+NI+"hl|\n"+\
				"[color=#AAFFAA] 7 [/color]Code "+NI+"__ валидно."+NI+"_ невалидно. "+NI+"___6521\n"+\
				"[color=#AAFFAA] 8 [/color]"+(HI if lastCmdStored == "monitor" else NO)+"Status:  %s"+CR+"Дней заблокировано: %d"+CR+"Elect\n"+\
				"Сила [color=#AAFFAA]9[/color]электромагнитного замка: %fN"+CR+"Batt\n"+\
				"[color=#AAFFAA]10 [/color]erycharg e: %f mA h"+CR+"Биореактор: %s"+CR+"\n"+\
				"Последний доступ к памяти [color=#AAFFAA]11[/color]: [ %d,%d] ([/color]\n[/font][/b]"
		else:
			return "Команде требуется 0 аргументов"
	elif(_command == "unlock"):
		lastCageCmd = _command
		if(_args.size() == 1):
			var unlockcode = _args[0]
			if(unlockcode in ["block"]):
				markFinished()
				return "Код верный. Разблокировка..."
			else:
				return "Код неверный."
		else:
			return "Эта команда ожидает 1 аргумент"
	elif(_command == "help"):
		lastCageCmd = _command
		if(_args.size() == 1):
			var tolearn = _args[0]
			if(tolearn == "help"):
				return "Эта команда выводит список всех остальных команд, а также может предоставить справку по конкретной команде при вводе 'help <КОМАНДА>'."
			elif(tolearn == "disconnect"):
				return "Эта команда отключает вас от удаленного хоста."
			elif(tolearn == "monitor"):
				return "Эта команда выводит диагностику оборудования."
			elif(tolearn == "unlock"):
				return "Эта команда разблокирует электромагнитный замок.\nСинтаксис: 'unlock <код разблокировки>'"
			elif(tolearn == "strscan"):
				return "Эта команда сканирует память локального устройства на наличие строк. Без параметров она просто выводит список найденных строк. Если указать ID строки в качестве параметра, она будет добавлена в список запомненных команд.\nСинтаксис: 'strscan <ID строки>'"
			else:
				return "Команда '"+str(tolearn)+"'. Чтобы увидеть все доступные команды, введите 'help'."
			
		elif(_args.size() == 0):
			learnCommand("help")
			learnCommand("monitor")
			learnCommand("unlock")
			learnCommand("disconnect")
			learnCommand("strscan")
			return "Доступные команды: \ndisconnect\nmonitor\nunlock\nhelp\nstrscan\nЧтобы узнать больше, введите 'help <КОМАНДА>'\n\n"+\
				"[Amateur firmware. The password's stored in plaintext, directly in memory. Don't waste time trying every option, remember that the unlock function has to access the password to check if it's been given a valid one.\n\nI've also added the strscan utility, in case the keyboard freezes up again. Don't bother with it otherwise.\n - Alex]"
		else:
			learnCommand("help")
			return "'help' expects 0 or 1 arguments"
	elif(_command == "strscan"):
		lastCageCmd = _command
		if(_args.size() == 1):
			var id = _args[0]
			if(id in strMap.keys()):
				learnCommand(strMap[id][1])
				return "String '" + strMap[id][1] + "' добавлено к кнопкам команд."
			else:
				return "Неверный параметр."
		elif(_args.size() == 0):
			var outstr = "Эта пробная версия strscan ограничена первыми 15 результатами.\n"+\
					"Run strscan again with the id of the string you'd like to add to your command buttons as the first parameter.\n\n[font=res://Fonts/smallconsolefont.tres]"+\
					"[color=#AAFFFF]Строка местоположения ID[/color]\n"
			for key in strMap:
				outstr += key + " " + strMap[key][0] + ":  '" + strMap[key][1] + "'\n"
			outstr += "[/font]"
			return outstr
		else:
			return "Эта команда ожидает 1 или 0 аргументов"
						
	learnCommand("help")
	return "Ошибка: неизвестная команда. Используйте 'help', чтобы увидеть список всех доступных команд"
	
func reactToCommandPlug(_command: String, _args:Array, _commandStringRaw:String):
	if(_command == "get_speed"):
		return "Выполнение...\nВозвращаемое значение: "+str(plugSpeed)
	elif(_command == "set_speed"):
		var value = 0
		if(_args.size() >= 1):
			value = int(_args[0])
		value = clamp(value, 0, 100)
		plugSpeed = value
		if(value >= 25):
			return "Выполнение...\nКод возврата 00041: Успех, обнаружено учащение сердцебиения"
		else:
			return "Выполнение...\nКод возврата 00000: Успех"
	elif(_command == "disconnect"):
		connectedTo = ""
		return "Отключение...\nСоединение разорвано удаленным хостом."
	elif(_command == "help"):
		if(_args.size() == 1):
			var tolearn = _args[0]
			if(tolearn == "help"):
				return "Эта команда выводит список всех остальных команд, а также может предоставить справку по конкретной команде при вводе 'help <КОМАНДА>'."
			elif(tolearn == "disconnect"):
				return "Эта команда отключает вас от удаленного хоста."
			elif(tolearn == "get_speed"):
				return "Возвращает текущую настройку скорости вибрационного мотора."
			elif(tolearn == "set_speed"):
				return "Устанавливает текущую скорость вибрации мотора. \nСинтаксис: 'set_speed <значение [0 - 100]>'"
			else:
				return "Команда '"+str(tolearn)+"'. Чтобы увидеть все доступные команды, введите 'help'."
			
		elif(_args.size() == 0):
			learnCommand("help")
			learnCommand("get_speed")
			learnCommand("set_speed")
			learnCommand("disconnect")
			return "Доступные команды: \ndisconnect\nget_speed\nset_speed\nhelp\nЧтобы узнать больше о команде, введите 'help <КОМАНДА>'"
		else:
			learnCommand("help")
			return "'help' expects 0 or 1 arguments"
						
	learnCommand("help")
	return "Ошибка: неизвестная команда. Используйте 'help', чтобы увидеть список всех доступных команд"

var tutorialData = [
	["*", "Разберись, как работает этот девайс, или используй 'skiptut', чтобы пропустить обучение.", "Введите что угодно"],
	["help", "Для начала получи список команд.", "Выбери 'help', а затем нажми 'Send'"],
	["help probe", "Ты выучил новые команды. Используй 'help', чтобы разобраться с командой 'probe'", "Выбери 'help', затем 'probe' и нажми 'Send'"],
	["probe", "А теперь попробуй выполнить эту команду.", "Выберите 'probe' и нажмите Send"],
	["help connect", "Теперь попробуйте разобраться, как использовать команду connect.", "Выберите 'help', затем выберите 'connect' и нажмите Send"],
	["connect 4", "Устройство viplug_m_default будет использоваться в качестве примера для этого обучения. Подключитесь к нему.", "Выберите 'connect', затем переключитесь на цифровой блок и выберите '4', прежде чем нажать Send"],
	["help", "Вы подключились к устройству. Разберитесь, на что оно способно.", "Выберите 'help' и нажмите Send"],
	["help get_speed", "Разберитесь, что делает команда get_speed.", "Выберите 'help', затем выберите 'get_speed' и нажмите 'Send'"],
	["get_speed", "Выполните команду 'get_speed'.", "Выберите 'get_speed' и нажмите 'Send'"],
	["disconnect", "Больше здесь делать нечего. Когда закончите эксперименты, отключитесь от этого устройства.", "Выберите 'disconnect' и нажмите 'Send'"],
	["*", "Обучение завершено. Удачи! Помните, что вы можете использовать команду 'probe', чтобы найти нужное устройство.", "Снова используйте команду 'probe', чтобы найти нужное устройство."],
]
var currentTutorialStep = 0
var shouldSpoilHint = false

func getTutorial():
	if(currentTutorialStep >= tutorialData.size()):
		return
	
	var currentTutStep = tutorialData[currentTutorialStep]
	
	var currentText = currentTutStep[1]
	#var currentExpectedCommand = currentTutStep[0]
	if(shouldSpoilHint && currentTutStep.size() > 2):
		currentText += " ("+currentTutStep[2]+")"

	return currentText

func progressTutorial():
	if(currentTutorialStep >= tutorialData.size()):
		return
	var currentTutStep = tutorialData[currentTutorialStep]
	var currentExpectedCommand = currentTutStep[0]
	
	if(lastCommand != ""):
		if(lastCommand == currentExpectedCommand || currentExpectedCommand == "*"):
			currentTutorialStep += 1
			shouldSpoilHint = false
		else:
			shouldSpoilHint = true

func saveData():
	var data = .saveData()
	
	data["connectedTo"] = connectedTo
	data["plugSpeed"] = plugSpeed
	data["lastCageCmd"] = lastCageCmd
	data["currentTutorialStep"] = currentTutorialStep
	data["shouldSpoilHint"] = currentTutorialStep
	
	return data
	
func loadData(data):
	.loadData(data)
	
	connectedTo = SAVE.loadVar(data, "connectedTo", "")
	plugSpeed = SAVE.loadVar(data, "plugSpeed", 0)
	lastCageCmd = SAVE.loadVar(data, "lastCageCmd", "disconnect")
	currentTutorialStep = SAVE.loadVar(data, "currentTutorialStep", 0)
	shouldSpoilHint = SAVE.loadVar(data, "shouldSpoilHint", false)
