extends "res://Scenes/SceneBase.gd"

var npcID = ""
var npc:DynamicCharacter

func _initScene(_args = []):
	npcID = _args[0]
	npc = GlobalRegistry.getCharacter(npcID)

func resolveCustomCharacterName(_charID):
	if(_charID == "npc"):
		return npcID

func _init():
	sceneID = "PunishSlaveryLeaveInStocks"

func _run():
	if(state == ""):
		addCharacter(npcID)
		playAnimation(StageScene.StocksSexOral, "tease", {npc="pc", pc=npcID})
		
		if(GM.pc.getLocation() == "main_punishment_spot"):
			saynn("Вы решаете запереть своего раба в колодки.")
			
			saynn("В конце концов, почему бы другим не повеселиться с {npc.him}?")
		else:
			aimCameraAndSetLocName("main_punishment_spot")
			GM.pc.setLocation("main_punishment_spot")
			
			saynn("После того как {npc.name} получит свое {npc.his} наказание, вы решаете оставить {npc.him} торчать там.")
			
			saynn("В конце концов, почему бы другим не повеселиться с {npc.him}?")
			
		addButton("Продолжить", "Смотреть, что будет дальше", "leave_slave_in_stocks")


func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return
		
	if(_action == "leave_slave_in_stocks"):
		var npcSlavery:NpcSlave = npc.getNpcSlavery()
		if(npcSlavery == null):
			endScene()
			return
		npcSlavery.startActivity("StuckInStocks")
		
		endScene()
		return
		
	setState(_action)


func saveData():
	var data = .saveData()
	
	data["npcID"] = npcID

	return data
	
func loadData(data):
	.loadData(data)
	
	npcID = SAVE.loadVar(data, "npcID", "")
	npc = GlobalRegistry.getCharacter(npcID)
