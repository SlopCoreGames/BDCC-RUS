extends SceneBase

var charID:String = ""
var blockedItemIDs:Array

func _init():
	sceneID = "FeedSomethingScene"

func _initScene(_args = []):
	charID = _args[0] if _args.size() > 0 else "rahi"
	blockedItemIDs = _args[1] if _args.size() > 1 else []

func _run():
	if(state == ""):
		addCharacter(charID)
		var theChar:BaseCharacter = getCharacter(charID)
		if(!theChar):
			addButton("Закрыть", "Что-то пошло не так", "endthescene")
			return
		
		saynn("{npc.name} достаточно доверяет тебе, чтобы позволить скормить {npc.him} что-нибудь!")
		addButton("Назад", "На этом ты сделал достаточно", "endthescene")
		
		var _hasSomething:bool = false
		for theItemA in GM.pc.inventory.items:
			var theItem:ItemBase = theItemA
			
			if(!theItem.canFeedToNPC(theChar)):
				continue
			_hasSomething = true
			addButton(theItem.getStackName(), theItem.getVisisbleDescription(), "use_item", [theItem])
		
		if(!_hasSomething):
			saynn("Сейчас у тебя нет ничего, чем можно было бы накормить {npc.him}. Сходи раздобудь немного наркоты!")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return
	
	if(_action == "use_item"):
		var theChar:BaseCharacter = getCharacter(charID)
		var theItem:ItemBase = _args[0]
		var theResult:Dictionary = theItem.doFeedToNpc(theChar)
		
		addMessage("Вы использовали '"+str(theItem.getVisibleName())+"' on "+theChar.getName()+"!")
		
		if(!theResult.get("noConsume", false)):
			theItem.removeXOrDestroy(1)
		return

	setState(_action)

func resolveCustomCharacterName(_charID):
	if(_charID == "npc" && charID != ""):
		return charID
	
	return .resolveCustomCharacterName(_charID)

func saveData():
	var data = .saveData()
	
	data["charID"] = charID
	data["blockedItemIDs"] = blockedItemIDs

	return data
	
func loadData(data):
	.loadData(data)
	
	charID = SAVE.loadVar(data, "charID", "rahi")
	blockedItemIDs = SAVE.loadVar(data, "blockedItemIDs", [])
