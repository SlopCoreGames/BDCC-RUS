extends "res://Scenes/SceneBase.gd"

var npcID = ""
var npc:DynamicCharacter

var howMuchEarned:int = 0

func _initScene(_args = []):
	npcID = _args[0]
	npc = GlobalRegistry.getCharacter(npcID)

func resolveCustomCharacterName(_charID):
	if(_charID == "npc"):
		return npcID

func _reactInit():
	var npcSlave:NpcSlave = npc.getNpcSlavery()
	if(npcSlave == null || npcSlave.getActivityID() != "Prostitution"):
		setState("something_wrong")
		return
	var prostitution = npcSlave.getActivity()
	howMuchEarned = prostitution.getEarnedCredits()
	GM.pc.addCredits(howMuchEarned)
	npcSlave.addTired(5)
	if(howMuchEarned <= 1):
		npcSlave.deservesPunishment(3)
	elif(howMuchEarned <= 4):
		npcSlave.deservesPunishment(1)
	elif(howMuchEarned <= 10):
		npcSlave.deservesReward(1)
	elif(howMuchEarned <= 20):
		npcSlave.deservesReward(2)
	else:
		npcSlave.deservesReward(3)

func _init():
	sceneID = "SlutProstitutionReceiveCredits"

func _run():
	if(state == ""):
		addCharacter(npcID)
		playAnimation(StageScene.Duo, "stand", {npc=npcID})
		
		var npcSlave:NpcSlave = npc.getNpcSlavery()
		var prostitution = npcSlave.getActivity()
		
		saynn("{npc.name} находит тебя, выглядящую совершенно измотанной после того, как ты трахалась с {npc.himself} в течение "+str(prostitution.workHoursRemember)+" часов!")
		
		if(howMuchEarned <= 0):
			saynn("{npc.He} подходит к тебе и дает тебе... ничего... каким-то образом {npc.he} ничего не заработала.")
		else:
			saynn("{npc.He} подходит к тебе и дает тебе "+str(howMuchEarned)+" credit"+("s" if howMuchEarned != 1 else "")+"!")
		
		if(howMuchEarned <= 4):
			if(npcSlave.getObedience() < 0.3 && npcSlave.getLove() < 0.3 && npcSlave.getBrokenSpirit() < 0.3):
				saynn("[say=npc]"+RNG.pick([
					"Слушай... Да пошел ты, ясно? Не то чтобы я сама этого хотела.",
					"Ненавижу это дерьмо. Я не шлюха, ясно тебе?",
					"Я старалась изо всех сил, так что иди нахуй.",
					"С удовольствием бы посмотрела, как ты раздвигаешь ноги перед каждым еблом!",
				])+"[/say]")
			else:
				saynn("[say=npc]"+RNG.pick([
					"Прости, я честно старалась...",
					"Может, быть шлюхой — это не моё.",
					"Может, я просто хреновая шлюха.",
					"Прости, я правда старалась.",
				])+"[/say]")
		else:
			if(npcSlave.getObedience() < 0.3 && npcSlave.getLove() < 0.3 && npcSlave.getBrokenSpirit() < 0.3):
				saynn("[say=npc]"+RNG.pick([
					"Да пошел ты, ты даже не представляешь, чего мне это стоило.",
					"Ты даже вообразить не можешь, через что мне пришлось пройти, чтобы заработать это.",
					"Хочется, чтобы ты зарабатывала больше. Спорим, ты не сможешь?",
				])+"[/say]")
			else:
				saynn("[say=npc]"+RNG.pick([
					"Вот, держи, {npc.pcOwner}.",
					"Надеюсь, этого хватит, {npc.pcOwner}.",
					"Вот то, что я заработала, {npc.pcOwner}.",
				])+"[/say]")
		
		if(howMuchEarned == 0):
			saynn("Ноль кредитов? Серьезно? Это жалко, и ты заслуживаешь хорошего наказания!")
		elif(howMuchEarned == 1):
			saynn("Всего один кредит? Серьезно? Это жалко, и ты заслуживаешь хорошего наказания!")
		elif(howMuchEarned <= 4):
			saynn("Всего лишь "+str(howMuchEarned)+" кредитов? Это немного, заслуживает легкого наказания.")
		elif(howMuchEarned <= 10):
			saynn("Не так уж много... но все же что-то есть, заслуживает небольшой награды.")
		elif(howMuchEarned <= 20):
			saynn("Очень справедливая сумма, {npc.he} заслуживает обычной награды.")
		else:
			saynn("Ого, это прилично. {npc.He} заслуживает щедрой награды!")
		
		if(npcSlave.getObedience() < 0.3 && npcSlave.getLove() < 0.3 && npcSlave.getBrokenSpirit() < 0.3):
			saynn("[say=npc]Думаю, я вернусь в твою камеру.[/say]")
		else:
			saynn("[say=npc]"+RNG.pick([
				"Я чертовски устала, пойду обратно в камеру.",
				"Пойду, надену на себя ошейник...",
			])+"[/say]")
		
		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
	
	if(state == "something_wrong"):
		saynn("Что-то пошло не так, она оказалась вовсе не шлюхой!")
		addButton("Продолжить", "Ну и ладно", "endthescene")
		return

func _react(_action: String, _args):
	if(_action == "endthescene"):
		var npcSlave:NpcSlave = npc.getNpcSlavery()
		npcSlave.stopActivity()
		endScene()
		return

	setState(_action)


func saveData():
	var data = .saveData()
	
	data["npcID"] = npcID
	data["howMuchEarned"] = howMuchEarned

	return data
	
func loadData(data):
	.loadData(data)
	
	npcID = SAVE.loadVar(data, "npcID", "")
	howMuchEarned = SAVE.loadVar(data, "howMuchEarned", 0)
	npc = GlobalRegistry.getCharacter(npcID)
