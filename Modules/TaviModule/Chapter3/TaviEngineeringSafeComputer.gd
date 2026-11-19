extends NetworkedComputerBase

func _init():
	id = "TaviEngineeringSafeComputer"
	
	# create local server & files
	var locals = NetworkedComputerServer.new("",["connect","quit"])
	addFileToServer(locals,newCompFile("safe.txt","В сейфе лежит несколько кредитных чипов, которые мы конфисковали у заключенных. Каким-то образом они нашли способ их дублировать, что вызвало кучу проблем. Надеюсь, больше их нигде не валяется.\n\nIP сейфа: 127.0.24\nТы должен знать пароль администратора. Если забыл — придется его взломать.\nУдачи!","",true,1))
	addFileToServer(locals,newCompFile("forum.html","...**[corrupt]поврежденные данные[/corrupt]**...\n\n<message>Эй, ребят. Что делать, если я забыл пароль от одного из серверов и теперь не могу залогиниться?</message>\n<message>лол, нуб</message>\n<message>У меня была такая же проблема. Но в один прекрасный день я просто вспомнил пароль</message>\n<message>Слышал, есть прога, которая может подобрать пароль брутфорсом, глянь сервер 127.0.55</message>\n<message>Спасибо за ответы, ребят, очень помогли. И я не собираюсь качать всякое мутное дерьмо.</message>\n<message>О, кстати, последние две цифры IP — [corrupt]53[/corrupt], а не 55.</message>\n\n...**[corrupt]еще больше поврежденных данных[/corrupt]**...","",true,2))
	
	# create safe server
	var safes = NetworkedComputerServer.new("127.0.24",["login","open","disconnect","help"],"Статус защищенного сервера: Работает.\nСтатус двери: Закрыта",false,{},{},"Bob","5327")
	
	
	# create public server & files
	var publics = NetworkedComputerServer.new("127.0.53",["login","wget","disconnect"],"Вошли как гость. Добро пожаловать на наш публичный сервер, делитесь чем угодно.\nА еще не стесняйтесь делать донаты: у нас всего 10 кредитов из 100, необходимых для хостинга",true,{"credits":10},{},"xxxDark-Masterxxx","42069",["withdraw"])
	addFileToServer(publics,newCompFile("brute.exe","Ошибка: невозможно отобразить бинарный файл","font",true,1,"brute"))
	addFileToServer(publics,newCompFile("forum.html","<message>Пацаны, как пользоваться программой brute.exe?</message>\n<message>Все супер просто. [cuss]Скачай её с сервера[/cuss] через wget [cuss]а затем запусти вот так[/cuss] 'brute.exe SERVER_IP'. [cuss]Она попытается подобрать пароль методом брутфорса[/cuss].</message>","font",true,2))
	addFileToServer(publics,newCompFile("babe.png",Util.readFile("res://Images/asciiporn/taviquest/babe.txt"),"res://Fonts/smallconsolefont.tres",true,69),true)
	addFileToServer(publics,newCompFile("petplay.png",Util.readFile("res://Images/asciiporn/taviquest/petplay.txt"),"res://Fonts/smallconsolefont.tres",true,123),true)
	addFileToServer(publics,newCompFile("brutev2.exe","Ошибка: невозможно отобразить бинарный файл","font",true,420,"brutev2"),true)
	
	# add servers
	servers = {
		"":locals,
		"127.0.53":publics,
		"127.0.24":safes,
	}
	
	# set cmds
	localCmds["open"]="Открыть сейф"
	localCmds["withdraw"]="Переводит кредиты на ваш консольный счет, откуда их можно снять."
	localCmds["wget"]="Скачать файл с сервера. Синтаксис: 'wget <ИНДЕКС ФАЙЛА>', где индекс файла — это [b]число[/b], которое можно получить с помощью команды ls"

func localCmd_wget(_args):
	if(_args.size() != 1):
		return "Команда 'wget' ожидает 0 аргументов"
	if !str(_args[0]).is_valid_integer():
		return "Неверный индекс"
	if connectedTo=="": # can't download our own files
		return "Невозможно скачать с локального сервера"
	var currentServer : NetworkedComputerServer = getServer(connectedTo)
	if !currentServer:
		return "текущий сервер отсутствует"
	
	var file : ComputerFile = currentServer.getFileFromId(int(_args[0]))
	if !file:
		return "Файл не найден в текущей области видимости"+(". Попробуйте войти под учетной записью админа" if(!currentServer.loggedin) else "")
	var blacklist = ["html","png"] # blacklisted extensions
	
	if _args[0].get_extension() in blacklist:
		return "Ошибка, не удалось скачать "+file.get_extension()+" files"
	
	if getServer("").getFileFromName(file.name):
		return "Этот файл у вас уже есть"
	var nf = newCompFile(file.name,file.catData,file.catFont,file.canDownload,-1,file.method)
	addFileToServer(getServer(""),nf)
	if file.method: # for executables
		learnCommand(file.method)
	return "Downloading "+file.name+"... Успешно!"

func localCmd_open(_args):
	if _args.size()!=0:
		return "команда 'open' ожидает 0 аргументов"
	
	var currentServer = getServer(connectedTo)
	if !currentServer:
		return "текущий сервер отсутствует"
	if currentServer.loggedin:
		markFinished()
		return "Открытие сейфа..."
	return "Ошибка, доступ запрещен!"

func localCmd_quit(_args):
	markFinishedFail()
	return "Завершение работы..."

func localCmd_brute(_args):
	if(_args.size() == 1):
		var iptohack = _args[0]
		if(iptohack == "127.0.24"):
			return "Подключение... успешно..\nПопытка брутфорса пароля..\nОшибка: на этом сервере стоит защита от простого перебора.\n\nТребуется умный брутфорс\nКупи нашу новенькую brutev2.exe, чтобы взламывать любой сервер!\nЦена: всего 99999 кредитов\nОтправляй на наш dumcoin-аккаунт [cuss]5329751923[/cuss]\n\nНе удалось подобрать пароль методом брутфорса.\nЗавершение работы.."
		if(iptohack == "127.0.53"):
			return "Подключение... успешно..\nПопытка брутфорса пароля..\nУспех!!! Пароль: '42069'.\nЗавершение работы.."
		return "Ошибка: не удалось подключиться к этому IP"
	
	return "Syntax: brute.exe <IP>"

func localCmd_brutev2(_args):
	if(_args.size() == 1):
		var iptohack = _args[0]
		if(iptohack == "127.0.24"):
			return "Подключение... успешно..\nПопытка брутфорса пароля..\nУспех!!! Пароль: '5327'.\nЗавершение работы.."
		if(iptohack == "127.0.53"):
			return "Подключение... успешно..\nПопытка брутфорса пароля..\nУспех!!! Пароль: '42069'.\nЗавершение работы.."
		
		return "Ошибка: не удалось подключиться к этому IP"
	return "Syntax: brutev2.exe <IP>"

func localCmd_withdraw(_args):
	if _args.size()!=0:
		return "'withdraw' expects 0 arguments"
	var currentServer = getServer(connectedTo)
	if !currentServer:
		return "текущий сервер отсутствует"
	
	if !currentServer.loggedin:
		return "Недостаточно прав доступа"
	
	var creds = currentServer.data.get("credits",0)
	if creds==0:
		return "Счет пуст. Просите людей жертвовать чаще, иначе мы разоримся и будем вынуждены закрыться :("
	else:
		currentServer.data["credits"]=0
		GM.pc.addCredits(creds)
		return "Transferring "+str(creds)+" кредиты зачислены на ваш счет... успех!"
