extends SceneBase

var ownerID:String = ""

func _initScene(_args = []):
	ownerID = _args[0]

func _reactInit():
	addCharacter(ownerID)

func _init():
	sceneID = "NpcOwnerSleepTogetherScene"

func _run():
	if(state == ""):
		playAnimation(StageScene.Sleeping, "sleep", {pc=ownerID, npc="pc", bodyState={naked=true}, npcBodyState={naked=true}})
		saynn("{npc.name} приказывает тебе переспать с {npc.him}.")
		saynn("И ты повинуешься, проводя ночь на груди своего хозяина..")
		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")

func resolveCustomCharacterName(_charID):
	if(_charID == "npc"):
		return ownerID
	return null

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	setState(_action)

func saveData():
	var data = .saveData()
	
	data["ownerID"] = ownerID
	
	return data
	
func loadData(data):
	.loadData(data)
	
	ownerID = SAVE.loadVar(data, "ownerID", "")
