extends Reference
class_name DatapackQuest

var id:String = "error"
var name:String = "Новый квест"
var isMain:bool = false
var priority:float = 0.0

var code = preload("res://Game/Datapacks/UI/CrotchCode/SlotCalls.gd").new()

func getEditorName():
	return "id="+id+" name="+name

func getName():
	return name

func getEditVars():
	return {
		"name": {
			name = "Имя",
			type = "string",
			value = name,
		},
		"isMain": {
			name = "Основной квест",
			type = "checkbox",
			value = isMain,
		},
		"priority": {
			name = "Приоритет в списке задач",
			type = "number",
			value = priority,
		},
	}

func applyEditVar(varid, value):
	if(varid == "name"):
		name = value
	if(varid == "isMain"):
		isMain = value
	if(varid == "priority"):
		priority = value
	
	return false

func saveData():
	return {
		"name": name,
		"code": code.saveData(),
		"isMain": isMain,
		"priority": priority,
	}

func loadData(data):
	name = loadVar(data, "name", "No name")
	isMain = loadVar(data, "isMain", false)
	priority = loadVar(data, "priority", 0.0)
	code.loadData(loadVar(data, "code", {}))

func loadVar(_data, thekey, defaultValue = null):
	if(_data.has(thekey)):
		return _data[thekey]
	return defaultValue

func getCode():
	return code
