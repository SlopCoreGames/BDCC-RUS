extends "res://Util/SexActivityCreator/Actions/BaseAction.gd"

var who = "domInfo"
var howMuch = "0.1"
var sexOrForeplay = "Sex"

func _init():
	id = "AddArousalSex"

func getName():
	return "Добавить возбуждение"

func getVisibleText():
	return generateCode()

func getArgs():
	return {
		"who": {
			"type": "dropdown",
			"value": who,
			"text": "Кто",
			"values": [
				["domInfo", "Доминант"],
				["subInfo", "Сабмиссив"],
			],
		},
		"howMuch": {
			"type": "string",
			"value": howMuch,
			"text": "Сколько?",
		},
		"sexOrForeplay": {
			"type": "dropdown",
			"value": sexOrForeplay,
			"text": "Секс или прелюдия",
			"values": [
				["Sex", "Секс"],
				["Foreplay", "Прелюдия"],
			],
		},
	}

func applyArgs(_data):
	who = _data["who"]
	howMuch = _data["howMuch"]
	sexOrForeplay = _data["sexOrForeplay"]

func generateCode():
	var text = ""+who+".addArousal"+sexOrForeplay+"("+howMuch+")"
	# subInfo.addArousalSex(0.2)
	return text

func saveData():
	return {
		who = who,
		howMuch = howMuch,
		sexOrForeplay = sexOrForeplay,
	}

func loadData(_data):
	if(_data.has("who")):
		who = _data["who"]
	if(_data.has("howMuch")):
		howMuch = _data["howMuch"]
	if(_data.has("sexOrForeplay")):
		sexOrForeplay = _data["sexOrForeplay"]
