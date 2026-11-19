extends ComputerBase
class_name NetworkedComputerBase

var connectedTo = "" # ip, empty is local computer

var servers : Dictionary = {} # key is ip, value is server class instance

const defaultCmds : Array = ["help","ls","cat","login"] # these are always available unless otherwise specified and built into all computers

var localCmds : Dictionary = {} # key is string for command, value is description for help; these are for each separate server/script/whatever

class NetworkedComputerServer:
	var ip : String = "0.0.0.0" # empty string is always local computer
	var enterText : String = "это сообщение отображается при подключении!"
	var supportedCmds : Array = [] # only these are enabled per server, includes defaultCmds by default
	var adminCommands : Array = [] # cmds here are available only if logged in
	
	var username : String = "admin"
	var adminPassword : String = "uwuwowo" # can be empty str to disable admin stuff
	var loggedin : bool = false
	
	var files : Array = [] # uses CompFiles, sorted
	var privateFiles : Array = [] # same, require login
	var data : Dictionary = {} # for per-server variables, such as transferring credits in the safe script
	var disconnectData : Dictionary = {} # upon disconnection, keys that are found here as well as in the data dictionary will be set to their values in here (eg. log out on disconnect)
	
	var nextAvailableId : int = 0 # unique per server now, makes more sense & easier to deal with
	
	func _init(i:String,cmds:Array=[],txt="server",defs:bool=true,d:Dictionary={},dd:Dictionary={},un:String="admin",pw:String="",adcmds:Array=[]):
		self.ip = i
		if defs: # default cmds are included here
			cmds.append_array(defaultCmds)
		self.supportedCmds = cmds
		self.enterText = txt
		self.data = d
		self.disconnectData = dd
		self.username = un
		self.adminPassword = pw
		self.adminCommands = adcmds
	
	func saveData() -> Dictionary:
		return {
			"nextAvailableId":nextAvailableId,
			"data":data,
			"loggedin":loggedin,
			
		}
	
	func loadData(d:Dictionary) -> void:
		data = d.get("data",{})
		nextAvailableId = d.get("nextAvailableId",0)
		loggedin = d.get("loggedin",false)
	
	
	
	func hasFileWithId(id:int=nextAvailableId,private:bool=false) -> bool:
		return ComputerFileSorting.findFileIdxWithIdStrict(self,id,private) != -1
		
	
	func addFile(f:ComputerFile) -> void:
		var insertIdx = ComputerFileSorting.findFileIdxWithObjStrict(self,f)
		if insertIdx != -1: # no duplicates
			return
		files.insert(insertIdx,f)
	
	func addPrivateFile(f:ComputerFile) -> void:
		var insertIdx = ComputerFileSorting.findFileIdxWithObjStrict(self,f,true)
		if insertIdx==-1: # no duplicates
			return
		privateFiles.insert(insertIdx,f)
	
	func getFileFromName(n:String="") -> ComputerFile:
		if loggedin:
			for f in privateFiles:
				if f.name==n:
					return f
		for f in files:
			if f.name==n:
				return f
		return null
		
	func getFileFromId(i:int=0) -> ComputerFile:
		if loggedin:
			for f in privateFiles:
				if f.id==i:
					return f
		for f in files:
			if f.id==i:
				return f
		
		return null

class ComputerFile:
	var name : String = "file.exe"
	var catData : String = "" # prints when catted
	var canDownload : bool = true # it'd be nice to be able to download most files, esp. pngs
	var id = -1 # set automatically if -1, otherwise you can set it manually
	var catFont : String = "" # path of font file, can be empty
	
	var method : String = "" # method to call if file is .exe (requires localCmd_ prefix for method, added automatically; eg. to call open, method="open" and calls localCmd_open())

class ComputerFileSorting:
	static func sortComputerFileObjects(a:ComputerFile, b:ComputerFile):
		return a.id < b.id
	
	static func sortComputerFileIds(a, b): # sucks, but it should work. can compare both computerFiles as args or ids
		if a is ComputerFile:
			a = a.id
		if b is ComputerFile:
			b = b.id
		return a < b
	
	static func findFileIdxWithId(server:NetworkedComputerServer,id:int,private:bool=false) -> int: # returns current idx or insertion idx
		var array = server.privateFiles if private else server.files
		var idx = array.bsearch_custom(id,ComputerFileSorting,"sortComputerFileIds")
		return idx
	
	static func findFileIdxWithIdStrict(server:NetworkedComputerServer,id:int,private:bool=false) -> int: # returns current idx or -1 if file doesn't exist
		var array = server.privateFiles if private else server.files
		var idx = findFileIdxWithId(server,id)
		if array.size()<=idx: # outta bounds
			return -1
		if array[idx].id!=id: # would return insertion idx
			return -1
		return idx
	
	
	static func findFileIdxWithObj(server:NetworkedComputerServer,obj:ComputerFile,private:bool=false) -> int: # returns current idx or insertion idx
		var array = server.privateFiles if private else server.files
		var idx = array.bsearch_custom(obj,ComputerFileSorting,"sortComputerFileObjects")
		return idx
	
	static func findFileIdxWithObjStrict(server:NetworkedComputerServer,obj:ComputerFile,private:bool=false) -> int: # returns current idx or -1 if file doesn't exist
		var array = server.privateFiles if private else server.files
		var idx = findFileIdxWithObj(server,obj)
		if array.size()<=idx: # outta bounds
			return -1
		if array[idx]!=obj: # would return insertion idx
			return -1
		return idx




# returns compfile. note that this doesn't assign an id if specified id is -1!
func newCompFile(n:String,cat:String="это файл!",f:String="",down:bool=true,i=-1,meth:String="") -> ComputerFile:
	var nf = ComputerFile.new()
	nf.name = n
	nf.catData = cat
	nf.canDownload = down
	nf.id = i
	nf.catFont = f
	nf.method = meth
	return nf



# add a file to server as a public/private file, setting a new id if i==-1. keeps file array sorted, which is necessary
func addFileToServer(server:NetworkedComputerServer,file:ComputerFile,private:bool=false) -> void:
	if !server: # just in case
		Log.printerr("tried to add file with name %s (id %s) to a non-existent server!" % [file.name,file.id])
		return
	
	if file.id==-1: # assign new
		while ComputerFileSorting.findFileIdxWithIdStrict(server,server.nextAvailableId,private)!=-1: # in case we stumble upon file with id it shouldn't have, such as in cases of custom ids
			server.nextAvailableId += 1
		
		file.id = server.nextAvailableId
	
	var newIdx = ComputerFileSorting.findFileIdxWithObj(server,file,private)
	(server.privateFiles if private else server.files).insert(newIdx,file)

func getServer(ip:String="") -> NetworkedComputerServer:
	return servers.get(ip,null)

func login(_args):
	if _args.size()!=1:
		return "команда 'login' ожидает 1 аргумент"
	var currentServer = getServer(connectedTo)
	if !currentServer:
		return "текущий сервер отсутствует"
	if currentServer.loggedin:
		return "Вы уже вошли в систему"
	if !currentServer.adminPassword:
		return "Этот сервер не поддерживает авторизацию"
	if currentServer.adminPassword==_args[0]:
		currentServer.loggedin=true
		return "Вы успешно вошли как admin. Добро пожаловать, "+currentServer.username
	
	return "Ошибка, неверный пароль"

func ls(_args:Array=[]):
	var currentServer = getServer(connectedTo)
	if !currentServer:
		return "ERROR: no connected server"
	if(_args.size() == 0):
		var fs = currentServer.files.duplicate()
		if currentServer.loggedin:
			fs.append_array(currentServer.privateFiles)
		var txt = "Найденные файлы:" + ("\n(none)" if fs.size()==0 else "")
		for file in fs:
			txt += "\n"+str(file.id)+" - "+file.name
		return txt
	return "Команда 'ls' ожидает 0 аргументов"

func cat(_args:Array=[]):
	if _args.size()!=1:
		learnCommand("tunya")
		return "Команда 'cat' ожидает 1 аргумент"
	if _args[0] in ["tuna", "tunya"]:
		return "cat говорит тебе «туня» :3"
	var currentServer : NetworkedComputerServer = getServer(connectedTo)
	if !currentServer:
		return "ERROR: no connected server"
	if !str(_args[0]).is_valid_integer(): # invalid arg
		return "Ошибка. Неверный индекс"
	var file = currentServer.getFileFromId(int(_args[0]))
	if !file:
		return "Ошибка. Файл с таким индексом не найден"
	
	return file.name+"\n\n"+  ("[font={f}]".format([file.catFont],"{f}") if(file.catFont) else "")  +  (file.catData if file.catData else "данные файла отсутствуют!")  +  ("[/font]" if(file.catFont) else "")

func help(_args:Array=[]):
	var descs : Dictionary = {
		"ls":"Эта команда выводит содержимое вашего жёсткого диска",
		"help":"Эта команда выводит список всех остальных команд, а также может помочь с определённой командой, если ввести 'help <КОМАНДА>'",
		"cat":"Эта команда выводит содержимое файла в консоль.\nСинтаксис: 'cat <ИНДЕКС_ФАЙЛА>', где индекс файла — это [b]число[/b], которое можно получить с помощью команды ls",
		"connect":"Эта команда позволяет подключиться к удаленному серверу по его IP-адресу.\nСинтаксис: 'connect <IP>'. Пример IP-адреса: 127.0.1",
		"tunya":"Ты что творишь? Отдай туню коту!",
		"disconnect":"Разрывает соединение",
		"login":"Позволяет войти под учетной записью администратора. Синтаксис: login <пароль>",
	} # descriptions for each cmd
	
	var currentServer = getServer(connectedTo)
	if !currentServer:
		return "ERROR: can't get connected server with ip "+connectedTo
	if _args.size()==1: # for one command
		var result = "Команда '"+str(_args[0])+"' не найдена. Чтобы увидеть все доступные команды, введите 'help'"
		if _args[0] in currentServer.adminCommands && !currentServer.loggedin: # admin cmd access attempt
			return "Недостаточно прав для выполнения команды '"+str(_args[0])+"'"
		if descs.has(_args[0]):
			learnCommand(_args[0]) # in case user somehow guesses the command's existence
			result = descs.get(_args[0])
		elif localCmds.has(_args[0]):
			learnCommand(_args[0])
			result = localCmds.get(_args[0])
		return result
	
	elif _args.size()==0: # general help
		var alcmds = currentServer.supportedCmds.duplicate()
		for cmd in currentServer.supportedCmds:
			learnCommand(cmd) # learn 'em all
		if currentServer.loggedin:
			alcmds.append_array(currentServer.adminCommands)
			for cmd in currentServer.adminCommands:
				learnCommand(cmd)
		return "Доступные команды: "+", ".join(alcmds)+".\nЧтобы узнать больше о команде, введите 'help <КОМАНДА>'"
	
	# too many args
	return "Команда 'help' принимает не более одного аргумента."

func connectComputer(_args:Array=[]):
	if _args.size()!=1:
		return "'connect' expects 1 argument"
	var res = "Подключение к "+_args[0]+"..."
	var newServer = getServer(_args[0])
	if newServer:
		res += " Подключено!\n"+newServer.enterText
		connectedTo = _args[0]
	else:
		res += " Ошибка подключения!"
	return res

func disconnectComputer(_args:Array=[]):
	if _args.size()!=0:
		return "Команда 'disconnect' ожидает 0 аргументов"
	if !connectedTo: # not connected anyway
		return "Соединение отсутствует"
	
	var currentServer : NetworkedComputerServer = getServer(connectedTo)
	if currentServer:
		currentServer.loggedin = false
		for key in currentServer.disconnectData.keys():
			currentServer.data[key] = currentServer.disconnectData[key] # set affected data to disconnect data
	
	connectedTo = ""
	
	return "Disconnecting... Success"

func reactToCommand(_command:String, _args:Array, _commandStringRaw:String):
	var currentServer : NetworkedComputerServer = getServer(connectedTo)
	if !currentServer:
		return "ERROR: no connected server"
	
	if(_command in currentServer.supportedCmds or (currentServer.loggedin && _command in currentServer.adminCommands)):
		match _command:
			"disconnect":
				return disconnectComputer(_args)
			"help":
				return help(_args)
			"cat":
				return cat(_args)
			"ls":
				return ls(_args)
			"connect":
				return connectComputer(_args)
			"login":
				return login(_args)
	
	if has_method("localCmd_"+_command): # this is for local cmds
		print(_command)
		return call("localCmd_"+_command,_args)
	
	var cmdfile = currentServer.getFileFromName(_command)
	if cmdfile:
		if cmdfile.method:
			return call("localCmd_"+cmdfile.method,_args)
		else:
			return "В этом файле повреждены бинарные данные!"
	
	# nothing works, command must not exist
	learnCommand("help")
	return "Ошибка: неизвестная команда. Используйте 'help', чтобы увидеть список всех доступных команд"

func getServersData() -> Dictionary:
	var sd:Dictionary = {} # servers data, ip:{...data...}, ...
	for serverID in servers:
		var server:NetworkedComputerServer = servers[serverID]
		if(!server):
			continue
		
		sd[server.ip] = server.saveData()
	return sd

func saveData():
	var data = .saveData()
	
	data["serversData"] = getServersData()
	data["connectedTo"]=connectedTo

	return data
	
func loadData(_data):
	.loadData(_data)
	
	connectedTo = SAVE.loadVar(_data, "connectedTo", "")
	var sd:Dictionary = SAVE.loadVar(_data, "serversData", {})
	for ip in sd:
		if(!servers.has(ip)):
			continue
		servers[ip].loadData(sd[ip])
	
	
