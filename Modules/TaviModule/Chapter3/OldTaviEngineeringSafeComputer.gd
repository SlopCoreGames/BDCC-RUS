extends ComputerBase

var connectedTo = ""
var loggedAsAdmin = false
var downloadedBrute = false
var downloadedBruteV2 = false
var transferredCredits = false

func _init():
	id = "TaviEngineeringSafeComputer"

func reactToCommand(_command:String, _args:Array, _commandStringRaw:String):
	if(connectedTo == "127.0.24"):
		if(_command == "help"):
			if(_args.size() == 1):
				var tolearn = _args[0]
				
				if(tolearn == "disconnect"):
					return "Разрывает соединение"
				elif(tolearn == "login"):
					return "Позволяет войти под учетной записью администратора. Синтаксис: login <пароль>"
				elif(tolearn == "open"):
					return "Открыть сейф"
				return "Для этой команды справка не найдена"
			learnCommand("disconnect")
			learnCommand("login")
			learnCommand("open")
			return "Доступные команды:\ndisconnect\nlogin\nopen"
		
		if(_command == "disconnect"):
			if(_args.size() == 0):
				connectedTo = ""
				loggedAsAdmin = false
				return "Disconnecting... Success"
			else:
				return "Команда 'disconnect' ожидает 0 аргументов"
		
		if(_command == "open"):
			if(loggedAsAdmin):
				markFinished()
				return "Открытие сейфа..."
			else:
				return "Ошибка, доступ запрещен!"
		
		if(_command == "login"):
			if(loggedAsAdmin):
				return "Вы уже вошли в систему"
			
			if(_args.size() == 1):
				var modeStr = _args[0]
				if(modeStr == "5327"):
					loggedAsAdmin = true
					return "Вы успешно вошли как админ. Добро пожаловать, Боб"
				return "Ошибка, неверный пароль"
			else:
				return "Команда 'login' ожидает 1 аргумент. Введите 'help login' для подробностей"
		return "Ошибка, сервер не поддерживает эту команду. Используйте 'help', чтобы увидеть список всех команд"
	
	if(connectedTo == "127.0.53"):
		if(_command == "help"):
			if(_args.size() == 1):
				var tolearn = _args[0]
				
				if(tolearn == "disconnect"):
					return "Разрывает соединение"
				elif(tolearn == "login"):
					return "Позволяет войти под учетной записью администратора. Синтаксис: login <пароль>"
				elif(tolearn == "ls"):
					return "Эта команда выводит содержимое вашего жёсткого диска"
				elif(tolearn == "cat"):
					return "Эта команда выводит содержимое файла в консоль.\nСинтаксис: 'cat <ИНДЕКС_ФАЙЛА>', где индекс файла — это [b]число[/b], которое можно получить с помощью команды ls"
				elif(tolearn == "wget"):
					return "Скачать файл с сервера. Синтаксис: 'wget <ИНДЕКС ФАЙЛА>', где индекс файла — это [b]число[/b], которое можно получить с помощью команды ls"
				elif(tolearn == "withdraw" && loggedAsAdmin):
					return "Переводит кредиты на ваш консольный счет, откуда их можно снять."
				return "Для этой команды справка не найдена"
			learnCommand("disconnect")
			learnCommand("login")
			learnCommand("ls")
			learnCommand("cat")
			learnCommand("wget")
			if(loggedAsAdmin):
				learnCommand("withdraw")
				return "Доступные команды:\ndisconnect\nlogin\nls\ncat\nwget\nwithdraw"
			return "Доступные команды:\ndisconnect\nlogin\nls\ncat\nwget"
		
		if(_command == "withdraw" && loggedAsAdmin):
			if(transferredCredits):
				return "Счет пуст. Просите людей жертвовать чаще, иначе мы разоримся и будем вынуждены закрыться :("
			else:
				transferredCredits = true
				GM.pc.addCredits(10)
				return "Перевод 10 кредитов на ваш счет... успешно!"
		
		if(_command == "disconnect"):
			if(_args.size() == 0):
				connectedTo = ""
				loggedAsAdmin = false
				return "Disconnecting... Success"
			else:
				return "Команда 'disconnect' ожидает 0 аргументов"
		
		if(_command == "login"):
			if(loggedAsAdmin):
				return "Вы уже вошли в систему"
			
			if(_args.size() == 1):
				var modeStr = _args[0]
				if(modeStr == "42069"):
					loggedAsAdmin = true
					return "Вы успешно вошли под учетной записью admin. Добро пожаловать, xxxDark-Masterxxx"
				return "Ошибка, неверный пароль"
		
		if(_command == "wget"):
			if(_args.size() == 1):
				var programtodownload = _args[0]
				if(programtodownload in ["2", "forum.html"]):
					return "Ошибка: не удалось скачать html-файл"
				if(loggedAsAdmin && (programtodownload in ["69", "babe.png", "123", "petplay.png"])):
					return "Ошибка: не удалось скачать png-файл"
				if(programtodownload in ["1", "brute.exe"]):
					if(downloadedBrute):
						return "Этот файл у вас уже есть"
					else:
						downloadedBrute = true
						learnCommand("brute.exe")
						return "Загрузка brute.exe... Успешно!"
				if(programtodownload in ["420", "brutev2.exe"]):
					if(!loggedAsAdmin):
						return "ДОСТУП ЗАПРЕЩЕН"
					
					if(downloadedBruteV2):
						return "Этот файл у вас уже есть"
					else:
						downloadedBruteV2 = true
						learnCommand("brutev2.exe")
						return "Загрузка brutev2.exe... Успешно!"
				return "ФАЙЛ НЕ НАЙДЕН"
			else:
				return "Команде требуется 0 аргументов"
		
		if(_command == "ls"):
			if(_args.size() == 0):
				if(loggedAsAdmin):
					return "Found 5 files:\n1 - brute.exe\n2 - forum.html\n69 - babe.png\n123 - petplay.png\n420 - brutev2.exe"
				return "Found 2 files:\n1 - brute.exe\n2 - forum.html"
			else:
				return "Команде требуется 0 аргументов"
	
	
		if(_command == "cat"):
			if(_args.size() == 1):
				var fileIndex = _args[0]
				if(fileIndex in ["1", "brute.exe"]):
					return "Ошибка: невозможно отобразить бинарный файл"
				elif(fileIndex in ["2", "forum.html"]):
					learnCommand("wget")
					return "<message>Пацаны, как пользоваться программой brute.exe?</message>\n<message>Все супер просто. [cuss]Скачай её с сервера[/cuss] через wget [cuss]а затем запусти вот так[/cuss] 'brute.exe SERVER_IP'. [cuss]Она попытается подобрать пароль методом брутфорса[/cuss].</message>"
				elif(loggedAsAdmin && (fileIndex in ["69", "babe.png"])):
					return "babe.png\n\n[font=res://Fonts/smallconsolefont.tres]"+Util.readFile("res://Images/asciiporn/taviquest/babe.txt")+"[/font]"
				elif(loggedAsAdmin && (fileIndex in ["123", "petplay.png"])):
					return "petplay.png\n\n[font=res://Fonts/smallconsolefont.tres]"+Util.readFile("res://Images/asciiporn/taviquest/petplay.txt")+"[/font]"
				else:
					return "Ошибка. Файл с таким индексом не найден"
			else:
				learnCommand("tunya")
				return "'cat' expects 1 argument"
				
		return "Ошибка: сервер не поддерживает эту команду"
	
	if(connectedTo == ""):
		if(_command == "connect"):
			if(_args.size() == 1):
				var server = _args[0]
				if(server in ["127.0.24", "127.0.53"]):
					connectedTo = server
					if(server == "127.0.24"):
						return "Подключение к "+server+"... Подключено!\nСтатус сейфового сервера: Работает.\nСтатус двери: Закрыта"
					if(server == "127.0.53"):
						return "Подключение к "+server+"... Подключено!\nВошли как гость. Добро пожаловать на наш публичный сервер, делитесь чем угодно.\nА еще не стесняйтесь донатить: у нас всего 10 кредитов из 100, необходимых для хостинга"
				else:
					return "Подключение к "+server+"... Соединение разорвано!"
			else:
				return "'connect' expects 1 argument"
		
		if(_command == "brute.exe" && downloadedBrute):
			if(_args.size() == 1):
				var iptohack = _args[0]
				if(iptohack == "127.0.24"):
					return "Подключение... успешно..\nПопытка брутфорса пароля..\nОшибка: на этом сервере стоит защита от простого перебора.\n\nТребуется умный брутфорс\nКупи нашу новенькую brutev2.exe, чтобы взламывать любой сервер!\nЦена: всего 99999 кредитов\nОтправляй на наш dumcoin-аккаунт [cuss]5329751923[/cuss]\n\nНе удалось подобрать пароль методом брутфорса.\nЗавершение работы.."
				if(iptohack == "127.0.53"):
					return "Подключение... успешно..\nПопытка брутфорса пароля..\nУспех!!! Пароль: '42069'.\nЗавершение работы.."
				
				return "Ошибка: не удалось подключиться к этому IP"
			else:
				return "Синтаксис: brute.exe ip"
		
		if(_command == "brutev2.exe" && downloadedBruteV2):
			if(_args.size() == 1):
				var iptohack = _args[0]
				if(iptohack == "127.0.24"):
					return "Подключение... успешно..\nПопытка брутфорса пароля..\nУспех!!! Пароль: '5327'.\nЗавершение работы.."
				if(iptohack == "127.0.53"):
					return "Подключение... успешно..\nПопытка брутфорса пароля..\nУспех!!! Пароль: '42069'.\nЗавершение работы.."
				
				return "Ошибка: не удалось подключиться к этому IP"
			else:
				return "Синтаксис: brutev2.exe ip"
		
		if(_command == "ls"):
			if(_args.size() == 0):
				return "Found 2 files:\n1 - safe.txt\n2 - forum.html"
			else:
				return "Команде требуется 0 аргументов"
		if(_command == "cat"):
			if(_args.size() == 1):
				var fileIndex = _args[0]
				if(fileIndex in ["1", "safe.txt"]):
					return "В сейфе лежит несколько кредитных чипов, которые мы конфисковали у заключенных. Каким-то образом они нашли способ их дублировать, что вызвало кучу проблем. Надеюсь, больше их нигде не валяется.\n\nIP сейфа: 127.0.24\nТы должен знать пароль администратора. Если забыл — придется его взломать.\nУдачи!"
				elif(fileIndex in ["2", "forum.html"]):
					return "...**[corrupt]поврежденные данные[/corrupt]**...\n\n<message>Эй, ребят. Что делать, если я забыл пароль от одного из серверов и теперь не могу залогиниться?</message>\n<message>лол, нуб</message>\n<message>У меня была такая же проблема. Но в один прекрасный день я просто вспомнил пароль</message>\n<message>Слышал, есть прога, которая может подобрать пароль брутфорсом, глянь сервер 127.0.55</message>\n<message>Спасибо за ответы, ребят, очень помогли. И я не собираюсь качать всякое мутное дерьмо.</message>\n<message>О, кстати, последние две цифры IP — [corrupt]53[/corrupt], а не 55.</message>\n\n...**[corrupt]еще больше поврежденных данных[/corrupt]**..."
				elif(fileIndex in ["tuna", "tunya"]):
					return "cat говорит тебе «туня» :3"
				else:
					return "Ошибка. Файл с таким индексом не найден"
			else:
				learnCommand("tunya")
				return "'cat' ожидает 1 аргумент (или tunya)"
		if(_command == "quit"):
			markFinishedFail()
			return "Завершение работы..."
		
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
				elif(tolearn == "quit"):
					return "Выключить консоль"
				else:
					return "Команда '"+str(tolearn)+"' не найдена. Чтобы увидеть все доступные команды, введите 'help'"
				
			elif(_args.size() == 0):
				learnCommand("help")
				learnCommand("ls")
				learnCommand("cat")
				learnCommand("connect")
				learnCommand("quit")
				return "Доступные команды: ls, cat, connect, help, quit.\nЧтобы узнать больше о команде, введите 'help <КОМАНДА>'"
			else:
				learnCommand("help")
				return "'help' expects 0 or 1 arguments"
			
		learnCommand("help")
		return "Ошибка: неизвестная команда. Используйте 'help', чтобы увидеть список всех доступных команд"

func saveData():
	var data = .saveData()
	
	data["connectedTo"] = connectedTo
	data["loggedAsAdmin"] = loggedAsAdmin
	data["downloadedBrute"] = downloadedBrute
	data["downloadedBruteV2"] = downloadedBruteV2
	data["transferredCredits"] = transferredCredits
	
	return data
	
func loadData(data):
	.loadData(data)
	
	connectedTo = SAVE.loadVar(data, "connectedTo", "")
	loggedAsAdmin = SAVE.loadVar(data, "loggedAsAdmin", false)
	downloadedBrute = SAVE.loadVar(data, "downloadedBrute", false)
	downloadedBruteV2 = SAVE.loadVar(data, "downloadedBruteV2", false)
	transferredCredits = SAVE.loadVar(data, "transferredCredits", false)
