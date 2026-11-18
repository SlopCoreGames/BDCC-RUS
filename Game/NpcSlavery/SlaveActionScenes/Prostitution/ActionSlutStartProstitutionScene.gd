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
	sceneID = "ActionSlutStartProstitutionScene"

func _run():
	if(state == ""):
		addCharacter(npcID)
		playAnimation(StageScene.Duo, "stand", {npc=npcID})
		
		var npcSlave:NpcSlave = npc.getNpcSlavery()
		if(npcSlave.getWorkEfficiency() <= 0.25):
			saynn("{npc.name} слишком устала, чтобы сегодня проститутировать. Дайте {npc.him} отдохнуть.")
			
			addButton("Продолжить", "Ну и ладно", "endthescene")
			return
		
		saynn("Выпустить {npc.name} в тюрьму, чтобы {npc.he} могла трахать {npc.himself} на панели?")
		saynn("{npc.He} вернется к вам через некоторое время и принесет выручку от {npc.his}. Сколько заработает {npc.he}, зависит от уровня шлюховатости {npc.his}. Чем он выше, тем больше заработает {npc.he} и тем дольше {npc.he} сможет работать без перерыва.")
		

		addButton("Проституция!", "Заставить свою шлюху поработать", "start_whore")
		addButton("Отмена", "Вы передумали", "endthescene")
	
	if(state == "start_whore"):
		saynn("Вы приказываете своей шлюхе выйти в свет и заработать вам кредитов!")
		
		addButton("Продолжить", "Смотреть, что будет дальше", "do_start_whore")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return
		
	if(_action == "do_start_whore"):
		var npcSlave:NpcSlave = npc.getNpcSlavery()
		npcSlave.startActivity("Prostitution")
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
