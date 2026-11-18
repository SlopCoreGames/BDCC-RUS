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
	sceneID = "ActionSlaverySubManageHelper"

func _run():
	if(state == ""):
		addCharacter(npcID)
		playAnimation(StageScene.Duo, "stand", {npc=npcID})
		
		saynn("Ваша подчиненная достаточно обучена, чтобы вы могли позволить ей {npc.him} ходить по тюрьме. Вы можете приказать {npc.him} автоматически мыть других ваших рабов, покрытых спермой, или приводить беременных рабынь в родильный зал.")
		
		var npcSlave:NpcSlave = npc.getNpcSlavery()
		var willWash = false
		var willHelpBirth = false
		if(npcSlave.isDoingActivity() && npcSlave.getActivityID() == "SubHelper"):
			var subHelper = npcSlave.getActivity()
			willWash = subHelper.willWashSlaves
			willHelpBirth = subHelper.willHelpGiveBirth
		
		if(!willWash):
			saynn("В данный момент ваша рабыня [b]не будет[/b] автоматически мыть других ваших рабов, когда те покрыты спермой.")
		else:
			saynn("В данный момент ваша рабыня [b]будет[/b] автоматически мыть других ваших рабов.")
			
		if(!willHelpBirth):
			saynn("Также {npc.he} будет [b]не[/b] автоматически приводить ваших беременных рабынь в родильный зал для родов.")
		else:
			saynn("Также {npc.he} [b]будет[/b] автоматически приводить ваших беременных рабынь в родильный зал для родов.")
		
		addButton("Переключить мытье", "Заставить/остановить мытье рабов вашей рабыней", "toggle_wash")
		addButton("Переключить роды", "Заставить/остановить приведение беременных рабынь в родильный зал", "toggle_birth")
		
		addButton("Закрыть", "Хватит манипуляций", "endthescene")


func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return
		
	if(_action == "toggle_wash"):
		var npcSlave:NpcSlave = npc.getNpcSlavery()
		if(npcSlave.isDoingActivity() && npcSlave.getActivityID() == "SubHelper"):
			var subHelper = npcSlave.getActivity()
			subHelper.willWashSlaves = !subHelper.willWashSlaves
			
			if(!subHelper.hasAnythingToggledOn()):
				npcSlave.stopActivity()
		else:
			var subHelper = npcSlave.startActivity("SubHelper")
			if(subHelper != null):
				subHelper.willWashSlaves = true
		return
		
	if(_action == "toggle_birth"):
		var npcSlave:NpcSlave = npc.getNpcSlavery()
		if(npcSlave.isDoingActivity() && npcSlave.getActivityID() == "SubHelper"):
			var subHelper = npcSlave.getActivity()
			subHelper.willHelpGiveBirth = !subHelper.willHelpGiveBirth
			
			if(!subHelper.hasAnythingToggledOn()):
				npcSlave.stopActivity()
		else:
			var subHelper = npcSlave.startActivity("SubHelper")
			if(subHelper != null):
				subHelper.willHelpGiveBirth = true
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
