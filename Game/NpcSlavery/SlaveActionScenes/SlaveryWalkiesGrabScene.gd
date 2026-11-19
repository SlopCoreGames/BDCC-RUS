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
	sceneID = "SlaveryWalkiesGrabScene"

func _run():
	if(state == ""):
		addCharacter(npcID)
		var npcSlave:NpcSlave = npc.getNpcSlavery()
		
		saynn("Что ты планируешь делать с {npc.name}?")
		
		addButton("Бродить туда-сюда", "Взять рабыню на поводок и погулять с ней по станции", "do_wander")
		if(npcSlave.getSlaveSkill(SlaveType.Pet) >= 3):
			if(npcSlave.getWorkEfficiency() <= 0.25):
				addDisabledButton("Прогулка", "Твой питомец слишком устал для прогулки, дай ему отдохнуть")
			else:
				addButton("Прогулка", "Вывести своего питомца на прогулку по станции", "do_petwander")
		else:
			addDisabledButton("Прогулка", "У твоей рабыни недостаточно высокий навык питомца. Требуется ранг не ниже D-")
		#addDisabledButton("Сутенёрство", "У твоего раба недостаточно высокий навык шлюхи")
		addButton("Отмена", "Проехали", "endthescene")
		
	if(state == "do_wander"):
		GM.pc.setLocation("hall_mainentrance")
		aimCameraAndSetLocName("hall_mainentrance")
		playAnimation(StageScene.Duo, "stand", {npc=npcID, npcBodyState={leashedBy="pc"}})
		
		saynn("Ты надеваешь поводок на своего раба и выводишь {npc.him} в главный зал.")
		
		addButton("Продолжить", "Смотреть, что будет дальше", "start_wander", [""])
	
	if(state == "do_petwander"):
		GM.pc.setLocation("hall_mainentrance")
		aimCameraAndSetLocName("hall_mainentrance")
		#playAnimation(StageScene.PuppyDuo, "walk", {npc=npcID, npcAction="walk", flipNPC=true, npcBodyState={naked=true, leashedBy="pc"}})
		playAnimation(StageScene.PuppyDuo, "stand", {npc=npcID, flipNPC=true, npcBodyState={naked=true, leashedBy="pc"}})

		saynn("Вы "+("раздевайся и " if !npc.isFullyNaked() else "")+"надень на своего питомца собачьи ограничители, прежде чем выводить {npc.him} в главный зал на прогулку.")
		
		var npcSlave:NpcSlave = npc.getNpcSlavery()
		var puppySkill = npcSlave.getSlaveSkill(SlaveType.Pet)
		if(puppySkill < 15):
			var howMuchNeeded = 2 + int(sqrt(puppySkill+1)*1.5)
			
			saynn("Твой питомец получает очки щенка каждый раз, когда ты удовлетворяешь потребность {npc.his}. Наберите как минимум "+str(howMuchNeeded)+" очков щенка, чтобы повысить навык питомца {npc.his}.")
		
		addButton("Продолжить", "Смотреть, что будет дальше", "start_wander", ["walkies"])

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return
		
	if(_action == "start_wander"):
		runScene("SlaveryWalkiesScene", [npcID, _args[0]])
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
