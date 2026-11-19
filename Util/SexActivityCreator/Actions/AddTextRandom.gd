extends "res://Util/SexActivityCreator/Actions/BaseAction.gd"

var storedTexts = ""

func _init():
	id = "addTextRandom"

func getName():
	return "Добавить случайный текст"

func getVisibleText():
	return "Выбрать случайный текст: " + storedTexts

func getArgs():
	return {
		"storedTexts": {
			"type": "bigstring",
			"value": storedTexts,
			"text": "Тексты",
		},
	}

func applyArgs(_data):
	storedTexts = _data["storedTexts"]

func generateCode():
	var theStoredTexts = storedTexts.split("\n", false)
	
	if(theStoredTexts.size() == 0):
		return ""
	if(theStoredTexts.size() == 1):
		return "text += \""+theStoredTexts[0]+"\""
	var text = "text += RNG.pick([\n\t"+Util.joinWithBorders(processStringArray(theStoredTexts), ",\n\t", "\"")+"\n])"
	return text

func saveData():
	return {
		storedTexts = storedTexts,
	}

func loadData(_data):
	if(_data.has("storedTexts")):
		storedTexts = str(_data["storedTexts"])
