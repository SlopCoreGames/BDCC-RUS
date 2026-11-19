extends NetworkedComputerBase

func _init():
	id = "TaviEngineeringSafeComputer"
	
	# create local server & files
	var locals = NetworkedComputerServer.new("",["connect","quit"])
	addFileToServer(locals,newCompFile("safe.txt","В сейфе лежит несколько кредитных чипов, которые мы конфисковали у заключенных. Каким-то образом они нашли способ их дублировать, что вызвало кучу проблем. Надеюсь, больше их нигде не валяется.\n\nIP сейфа: 127.0.24\nТы должен знать пароль администратора. Если забыл — придется его взломать.\nУдачи!","",true,1))
	addFileToServer(locals,newCompFile("forum.html","...**[corrupt]поврежденные данные[/corrupt]**...\n\n<message>Эй, ребят. Что делать, если я забыл пароль от одного из серверов и теперь не могу залогиниться?</message>\n<message>лол, нуб</message>\n<message>У меня была такая же проблема. Но в один прекрасный день я просто вспомнил пароль</message>\n<message>Слышал, есть прога, которая может подобрать пароль брутфорсом, глянь сервер 127.0.55</message>\n<message>Спасибо за ответы, ребят, очень помогли. И я не собираюсь качать всякое мутное дерьмо.</message>\n<message>О, кстати, последние две цифры IP — [corrupt]53[/corrupt], а не 55.</message>\n\n...**[corrupt]еще больше поврежденных данных[/corrupt]**...","",true,2))
	
	# create safe server
	var safes = NetworkedComputerServer.new("127.0.24",["login","open","disconnect","help"],"Safe server status: Operational.\nDoor status: Closed",false,{},{},"Bob","5327")
	
	
	# create public server & files
	var publics = NetworkedComputerServer.new("127.0.53",["login","wget","disconnect"],"Logged in as guest. Welcome to our public server, feel free to share anything you want.\nAlso, feel free to donate, we only have 10 credits out of a 100 that we need for hosting",true,{"credits":10},{},"xxxDark-Masterxxx","42069",["withdraw"])
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
	localCmds["open"]="Opens the safe"
	localCmds["withdraw"]="Transfers credits to your console where you can withdraw them."
	localCmds["wget"]="Download a file from the server. Syntax 'wget <FILE INDEX>' where file index is a [b]number[/b] that can be obtained by using the ls command"

func localCmd_wget(_args):
	if(_args.size() != 1):
		return "'wget' command expects 0 arguments"
	if !str(_args[0]).is_valid_integer():
		return "Invalid index"
	if connectedTo=="": # can't download our own files
		return "Can't download from local server"
	var currentServer : NetworkedComputerServer = getServer(connectedTo)
	if !currentServer:
		return "no current server"
	
	var file : ComputerFile = currentServer.getFileFromId(int(_args[0]))
	if !file:
		return "File not found in current scope"+(". Try logging in as admin" if(!currentServer.loggedin) else "")
	var blacklist = ["html","png"] # blacklisted extensions
	
	if _args[0].get_extension() in blacklist:
		return "Error, unable to download "+file.get_extension()+" files"
	
	if getServer("").getFileFromName(file.name):
		return "You already have this file"
	var nf = newCompFile(file.name,file.catData,file.catFont,file.canDownload,-1,file.method)
	addFileToServer(getServer(""),nf)
	if file.method: # for executables
		learnCommand(file.method)
	return "Downloading "+file.name+"... Success!"

func localCmd_open(_args):
	if _args.size()!=0:
		return "'open' command expects 0 arguments"
	
	var currentServer = getServer(connectedTo)
	if !currentServer:
		return "no current server"
	if currentServer.loggedin:
		markFinished()
		return "Opening the safe..."
	return "Error, Access denied!"

func localCmd_quit(_args):
	markFinishedFail()
	return "Shutting down.."

func localCmd_brute(_args):
	if(_args.size() == 1):
		var iptohack = _args[0]
		if(iptohack == "127.0.24"):
			return "Connecting... success..\nAttempting to bruteforce the password..\nError, this server has a protection against simple bruteforcing.\n\nSmart bruteforcing required\nBuy our brand new brutev2.exe to be able to hack any server!\nPrice: only 99999 credits\nSend to our dumcoin account [cuss]5329751923[/cuss]\n\nUnable to bruteforce the password.\nShutting down.."
		if(iptohack == "127.0.53"):
			return "Connecting... success..\nAttempting to bruteforce the password..\nSuccess!!! Password is '42069'.\nShutting down.."
		return "Error, Unable to connect to this ip"
	
	return "Syntax: brute.exe <IP>"

func localCmd_brutev2(_args):
	if(_args.size() == 1):
		var iptohack = _args[0]
		if(iptohack == "127.0.24"):
			return "Connecting... success..\nAttempting to bruteforce the password..\nSuccess!!! Password is '5327'.\nShutting down.."
		if(iptohack == "127.0.53"):
			return "Connecting... success..\nAttempting to bruteforce the password..\nSuccess!!! Password is '42069'.\nShutting down.."
		
		return "Error, Unable to connect to this ip"
	return "Syntax: brutev2.exe <IP>"

func localCmd_withdraw(_args):
	if _args.size()!=0:
		return "'withdraw' expects 0 arguments"
	var currentServer = getServer(connectedTo)
	if !currentServer:
		return "no current server"
	
	if !currentServer.loggedin:
		return "Insufficient access"
	
	var creds = currentServer.data.get("credits",0)
	if creds==0:
		return "The account is empty, ask people to donate more often or we will go out of bussiness and be forced to close :("
	else:
		currentServer.data["credits"]=0
		GM.pc.addCredits(creds)
		return "Transferring "+str(creds)+" credits to your account.. success!"
