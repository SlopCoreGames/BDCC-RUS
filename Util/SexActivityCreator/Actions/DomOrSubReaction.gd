extends "res://Util/SexActivityCreator/Actions/BaseAction.gd"

var who = "dom"
var reactionType = "Teasing"
var chance = ""

func _init():
	id = "domOrSubReaction"

func getName():
	return "Реакция Доминанта или Сабмиссива"

func getVisibleText():
	return generateCode()

func getArgs():
	return {
		"who": {
			"type": "dropdown",
			"value": who,
			"text": "Кто",
			"values": [
				["dom", "Доминант"],
				["sub", "Сабмиссив"],
			],
		},
		"reactionType": {
			"type": "dropdown",
			"value": reactionType,
			"text": "Тип реакции",
			"values": SexReaction.getAllStrings(),
		},
		"chance": {
			"type": "string",
			"value": chance,
			"text": "Chance (empty = 100%)",
		},
	}

func applyArgs(_data):
	who = _data["who"]
	reactionType = _data["reactionType"]
	chance = _data["chance"]

func generateCode():
	var stuff = {
		"dom": ["domSay", "domReaction"],
		"sub": ["subSay", "subReaction"],
	}
	
	if(chance == ""):
		return stuff[who][0]+" = "+stuff[who][1]+"(SexReaction."+reactionType+")"
	else:
		return stuff[who][0]+" = "+stuff[who][1]+"(SexReaction."+reactionType+", "+chance+")"
	

func saveData():
	return {
		who = who,
		reactionType = reactionType,
		chance = chance,
	}

func loadData(_data):
	if(_data.has("who")):
		who = _data["who"]
	if(_data.has("reactionType")):
		reactionType = _data["reactionType"]
	if(_data.has("chance")):
		chance = _data["chance"]

func shouldAddDomSubReactions():
	return true
