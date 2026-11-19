extends ComputerBase

var connectedTo = ""

func _init():
	id = "TaviEngineeringComputer"

func reactToCommand(_command:String, _args:Array, _commandStringRaw:String):
	if(connectedTo == "127.0.10"):
		if(_command == "help"):
			if(_args.size() == 1):
				var tolearn = _args[0]
				
				if(tolearn == "disconnect"):
					return "Разрывает соединение"
				elif(tolearn == "mode"):
					return "Изменяет режим работы двери.\n'mode 0' — обычный режим\n'mode 9' — режим обслуживания"
				return "Для этой команды справка не найдена"
			learnCommand("disconnect")
			learnCommand("mode")
			return "Доступные команды:\ndisconnect\nmode"
		
		if(_command == "disconnect"):
			if(_args.size() == 0):
				connectedTo = ""
				return "Disconnecting... Success"
			else:
				return "Команда 'disconnect' ожидает 0 аргументов"
		
		if(_command == "mode"):
			if(_args.size() == 1):
				var modeStr = _args[0]
				if(modeStr == "0"):
					return "Дверь уже работает в этом режиме"
				elif(modeStr == "9"):
					markFinished()
					return "Переключение двери в режим обслуживания! Внимание: теперь её сможет открыть кто угодно. По завершении верните режим на 0."
				return "Ошибка: неподдерживаемый режим. Введите 'help mode' для подробностей"
			else:
				return "Команда 'mode' ожидает 1 аргумент. Введите 'help mode' для подробностей"
		return "Ошибка: неизвестная команда. Используйте 'help', чтобы увидеть список всех доступных команд"
	
	if(connectedTo == "127.0.69"):
		if(_command == "help"):
			if(_args.size() == 0):
				learnCommand("disconnect")
				learnCommand("ls")
				learnCommand("cat")
				return "Доступные команды:\ndisconnect\nls\ncat"
			else:
				return "Команда 'help' ожидает 0 аргументов. Владелец сервера слишком ленив, чтобы писать описания к каждой команде."
		
		if(_command == "disconnect"):
			if(_args.size() == 0):
				connectedTo = ""
				return "Disconnecting... Success"
			else:
				return "Команда 'disconnect' ожидает 0 аргументов"
		
		if(_command == "ls"):
			if(_args.size() == 0):
				return "Найденные файлы:\n1 - porn.png\n2 - sex.png\n3 - mouwse.png\n4 - railme.png"
			else:
				return "Команда 'ls' ожидает 0 аргументов"
			
		if(_command == "cat"):
			if(_args.size() == 1):
				var fileToShow = _args[0]
				if(fileToShow in ["1", "porn.png"]):
					return "porn.png\n\n[font=res://Fonts/smallconsolefont.tres]"+Util.readFile("res://Images/asciiporn/taviquest/porn.txt")+"[/font]"
				if(fileToShow in ["2", "sex.png"]):
					return "sex.png\n\n[font=res://Fonts/smallconsolefont.tres]"+Util.readFile("res://Images/asciiporn/taviquest/sex.txt")+"[/font]"
				if(fileToShow in ["3", "mouwse.png"]):
					return "mouwse.png\n\n[font=res://Fonts/smallconsolefont.tres]"+Util.readFile("res://Images/asciiporn/taviquest/mouwse.txt")+"[/font]"
				if(fileToShow in ["4", "railme.png"]):
					return "railme.png\n\n[font=res://Fonts/smallconsolefont.tres]"+Util.readFile("res://Images/asciiporn/taviquest/railme.txt")+"[/font]"
				return "Файл с таким индексом не найден!"
			else:
				return "Команда 'cat' ожидает 1 аргумент"
		
		return "Ошибка: неизвестная команда. Используйте 'help', чтобы увидеть список всех доступных команд"
	
	
	
	if(connectedTo == ""):
		if(_command == "connect"):
			if(_args.size() == 1):
				var server = _args[0]
				if(server in ["127.0.69", "127.0.10"]):
					connectedTo = server
					if(server == "127.0.69"):
						return "Подключение к "+server+"... Подключено!\nДобро пожаловать в секретное логово horny bread. У нас строгий дресс-код: БЕЗ ШТАНОВ. Повеселитесь!\nЧтобы увидеть список доступных команд, введите 'help'"
					if(server == "127.0.10"):
						return "Подключение к "+server+"... Подключено!\nСтатус двери: ЗАБЛОКИРОВАНА\nПоследнее обслуживание: [cuss]9999999[/cuss] дн. назад"
				else:
					return "Подключение к "+server+"... Соединение разорвано!"
			else:
				return "'connect' expects 1 argument"
		
		if(_command == "ls"):
			if(_args.size() == 0):
				return "Found 2 files:\n1 - readme.txt\n2 - forum.html"
			else:
				return "Команде требуется 0 аргументов"
		if(_command == "cat"):
			if(_args.size() == 1):
				var fileIndex = _args[0]
				if(fileIndex in ["1", "readme.txt"]):
					return "Полезное дерьмо:\n1[cuss]27.0.69[/cuss] - Сервер с порнухой, знаю, вы всё равно рано или поздно его найдёте, дегенераты\n127.0.10 - дверь передатчика блюспейса, не трогай, если тебе не велели\n\nИ не ебите мне мозг вопросами о том, как к ним подключиться, читайте мануалы, блять. Или введите 'help connect', если вы до этого ни разу с терминалом не работали."
				elif(fileIndex in ["2", "forum.html"]):
					return "...**[corrupt]повреждённые данные[/corrupt]**...\n\n<message>Какого хуя мы юзаем такое устаревшее железо?</message>\n<message>Работает — не трогай. Это кусок говна, но ты же не собираешься запускать на нём Doom, эта машина поддерживает telnet, и этого нам за глаза.</message>\n<message>Что ещё за telnet?</message>\n<message>То, чем мы пользовались ещё до открытия блюспейса. Просто прочитай уже этот ебаный readme.</message>\n\n...**[corrupt]ещё больше повреждённых данных[/corrupt]**..."
				elif(fileIndex in ["tuna", "tunya"]):
					return "cat говорит тебе «туня» :3"
				else:
					return "Ошибка. Файл с таким индексом не найден"
			else:
				learnCommand("tunya")
				return "'cat' ожидает 1 аргумент (или tunya)"
		
		if(_command == "help"):
			if(_args.size() == 1):
				var tolearn = _args[0]
				if(tolearn == "help"):
					return "Эта команда выводит список всех остальных команд, а также может помочь с определённой командой, если ввести 'help <КОМАНДА>'"
				elif(tolearn == "ls"):
					return "Эта команда выводит содержимое вашего жёсткого диска"
				elif(tolearn == "cat"):
					return "Эта команда выводит содержимое файла в консоль.\nСинтаксис: 'cat <ИНДЕКС_ФАЙЛА>', где индекс файла — это [b]число[/b], которое можно получить с помощью команды ls"
				elif(tolearn == "connect"):
					return "Эта команда позволяет подключиться к удаленному серверу по его IP-адресу.\nСинтаксис: 'connect <IP>'. Пример IP-адреса: 127.0.1"
				elif(tolearn == "tunya"):
					return "Ты что творишь? Отдай туню коту!"
				else:
					return "Команда '"+str(tolearn)+"' не найдена. Чтобы увидеть все доступные команды, введите 'help'"
				
			elif(_args.size() == 0):
				learnCommand("help")
				learnCommand("ls")
				learnCommand("cat")
				learnCommand("connect")
				return "Доступные команды: ls, cat, connect, help.\nЧтобы узнать больше о команде, введите 'help <КОМАНДА>'"
			else:
				learnCommand("help")
				return "'help' expects 0 or 1 arguments"
			
		learnCommand("help")
		return "Ошибка: неизвестная команда. Используйте 'help', чтобы увидеть список всех доступных команд"

var tutorialData = [
	["*", "This minigame simulates a simple console. If you ever used cmd or bash, you will feel right at home. Otherwise, just follow this tutorial.", "type anything"],
	["help", "Start by getting the list of commands.", "Select 'help' and then press Send"],
	["help ls", "You learned new commands. Use the help command to figure out the 'ls' command", "Select 'help', then select 'ls' and then press Send"],
	["ls", "Now try to execute this command", "Select 'ls' and press Send"],
	["help cat", "Now try to figure out how to use the cat command", "Select 'help', then select 'cat' and press Send"],
	["cat 1", "Use the cat command to output the contents of the first file", "Select 'cat', then switch to the numpad and select '1' before pressing Send"],
	["connect 127.0.10", "Try to connect to the door that leads to the bluespace transmitter", "Select 'connect', then switch to the numpad and use it to type '127.0.10'. Then press Send"],
	["help", "You connected to a new server. Figure out what commands it supports", "Type 'help' and press Send"],
	["help mode", "Figure out how to use the mode command", "Select 'help', then select 'mode' and press Send"],
	["mode 9", "Switch the door to the maintenance mode", "Select 'mode', then switch to the numpad and select 9 before pressing Send"],
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
	data["currentTutorialStep"] = currentTutorialStep
	data["shouldSpoilHint"] = shouldSpoilHint
	
	return data
	
func loadData(data):
	.loadData(data)
	
	connectedTo = SAVE.loadVar(data, "connectedTo", "")
	currentTutorialStep = SAVE.loadVar(data, "currentTutorialStep", 0)
	shouldSpoilHint = SAVE.loadVar(data, "shouldSpoilHint", false)
