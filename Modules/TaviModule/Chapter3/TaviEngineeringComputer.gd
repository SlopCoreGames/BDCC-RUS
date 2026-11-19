extends NetworkedComputerBase

func _init():
	id = "TaviEngineeringComputer"
	
	# create local server & files
	var locals = NetworkedComputerServer.new("",["connect"])
	addFileToServer(locals,newCompFile("readme.txt","Полезное дерьмо:\n1[cuss]27.0.69[/cuss] - Сервер с порнухой, знаю, вы всё равно рано или поздно его найдёте, дегенераты\n127.0.10 - дверь передатчика блюспейса, не трогай, если тебе не велели\n\nИ не ебите мне мозг вопросами о том, как к ним подключиться, читайте мануалы, блять. Или введите 'help connect', если вы до этого ни разу с терминалом не работали.","",true,1))
	addFileToServer(locals,newCompFile("forum.html","...**[corrupt]повреждённые данные[/corrupt]**...\n\n<message>Какого хуя мы юзаем такое устаревшее железо?</message>\n<message>Работает — не трогай. Это кусок говна, но ты же не собираешься запускать на нём Doom, эта машина поддерживает telnet, и этого нам за глаза.</message>\n<message>Что ещё за telnet?</message>\n<message>То, чем мы пользовались ещё до открытия блюспейса. Просто прочитай уже этот ебаный readme.</message>\n\n...**[corrupt]ещё больше повреждённых данных[/corrupt]**...","",false,2))
	
	# door server
	var doors = NetworkedComputerServer.new("127.0.10",["mode","disconnect","help"],"Статус двери: ЗАБЛОКИРОВАНА\nПоследнее обслуживание: [cuss]9999999[/cuss] дн. назад",false)
	
	# horny server
	var hornys = NetworkedComputerServer.new("127.0.69",["disconnect"],"Добро пожаловать в секретное логово horny bread. У нас действует строгий запрет на штаны. Пожалуйста, наслаждайтесь!\nЧтобы увидеть список доступных команд сервера, введите 'help'",true)
	addFileToServer(hornys,newCompFile("porn.png",Util.readFile("res://Images/asciiporn/taviquest/porn.txt"),"res://Fonts/smallconsolefont.tres",true,1))
	addFileToServer(hornys,newCompFile("sex.png",Util.readFile("res://Images/asciiporn/taviquest/sex.txt"),"res://Fonts/smallconsolefont.tres",true,2))
	addFileToServer(hornys,newCompFile("mouwse.png",Util.readFile("res://Images/asciiporn/taviquest/mouwse.txt"),"res://Fonts/smallconsolefont.tres",true,3))
	addFileToServer(hornys,newCompFile("railme.png",Util.readFile("res://Images/asciiporn/taviquest/railme.txt"),"res://Fonts/smallconsolefont.tres",true,4))
	# set servers
	servers = {
		"":locals,
		"127.0.10":doors,
		"127.0.69":hornys,
		}
	
	# set local cmds
	localCmds["mode"] = "Изменяет режим работы двери.\n'mode 0' — обычный режим\n'mode 9' — режим обслуживания"

func localCmd_mode(_args:Array=[]): # prefix necessary when setting custom cmds for react func
	if(_args.size() == 1):
		var modeStr = _args[0]
		if(modeStr == "0"):
			return "Дверь уже работает в этом режиме"
		elif(modeStr == "9"):
			markFinished()
			return "Переключение двери в режим обслуживания! Внимание: теперь её сможет открыть кто угодно. По завершении верните режим на 0."
		return "Ошибка: неподдерживаемый режим. Введите 'help mode' для подробностей"
	
	return "Команда 'mode' ожидает 1 аргумент. Введите 'help mode' для подробностей"

var tutorialData = [
	["*", "Эта мини-игра имитирует простую консоль. Если вы когда-нибудь пользовались cmd или bash, вы будете чувствовать себя как дома. В противном случае просто следуйте этой инструкции.", "введите что угодно"],
	["help", "Для начала получи список команд.", "Выбери 'help', а затем нажми 'Send'"],
	["help ls", "Вы выучили новые команды. Используйте команду 'help', чтобы разобраться с командой 'ls'", "Выберите 'help', затем выберите 'ls' и нажмите 'Отправить'"],
	["ls", "Теперь попробуйте выполнить эту команду", "Выберите 'ls' и нажмите 'Отправить'"],
	["help cat", "Теперь попробуйте понять, как использовать команду 'cat'", "Выберите 'help', затем выберите 'cat' и нажмите 'Отправить'"],
	["cat 1", "Используйте команду 'cat', чтобы вывести содержимое первого файла", "Выберите 'cat', переключитесь на цифровую панель, выберите '1', а затем нажмите 'Send'"],
	["connect 127.0.10", "Попробуйте подключиться к двери, ведущей к передатчику блюспейса", "Выберите 'connect', переключитесь на цифровую панель и введите '127.0.10'. Затем нажмите 'Send'"],
	["help", "Вы подключились к новому серверу. Выясните, какие команды он поддерживает", "Введите 'help' и нажмите 'Send'"],
	["режим справки", "Разберитесь, как использовать команду 'mode'", "Выберите 'help', затем выберите 'mode' и нажмите 'Send'"],
	["mode 9", "Переведите дверь в режим обслуживания", "Выберите «mode», затем переключитесь на цифровой блок, выберите 9 и нажмите Send"],
]
var currentTutorialStep:int = 0
var shouldSpoilHint:bool = false

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
	
	data["currentTutorialStep"] = currentTutorialStep
	data["shouldSpoilHint"] = shouldSpoilHint
	
	return data
	
func loadData(data):
	.loadData(data)
	
	currentTutorialStep = SAVE.loadVar(data, "currentTutorialStep", 0)
	shouldSpoilHint = SAVE.loadVar(data, "shouldSpoilHint", false)
