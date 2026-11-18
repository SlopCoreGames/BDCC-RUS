extends SkinBase
class_name DatapackSkin

var name:String = "Новый скин"
var skinImage:DatapackImage = DatapackImage.new()
var skinTypeWeights:Dictionary = {}

func getEditorName():
	return "id="+id+" name="+name

func getName():
	return name

func getPatternTexture():
	return skinImage.getTexture()

func getFittingSkinTypes():
	return skinTypeWeights

func getEditVars():
	return {
		"name": {
			name = "Имя",
			type = "string",
			value = name,
		},
		"skinImage": {
			name = "Кожа",
			type = "image",
			value = skinImage.getImage(),
		},
		"skinTypeWeights": {
			name = "Веса типа кожи (0 = никогда, 1.0 = нормально, >1.0 = чаще)",
			type = "skinTypeWeights",
			value = skinTypeWeights,
		},
	}

func applyEditVar(varid, value):
	if(varid == "name"):
		name = value
	if(varid == "skinImage"):
		skinImage.setImage(value)
		return true
	if(varid == "skinTypeWeights"):
		skinTypeWeights = value
	
	return false

func saveData():
	return {
		"name": name,
		"skinImage": skinImage.saveData(),
		"skinTypeWeights": skinTypeWeights,
	}

func loadData(data):
	name = loadVar(data, "name", "No name")
	skinImage.loadData(loadVar(data, "skinImage", PoolByteArray()))
	skinTypeWeights = loadVar(data, "skinTypeWeights", {})

func loadVar(_data, thekey, defaultValue = null):
	if(_data.has(thekey)):
		return _data[thekey]
	return defaultValue
