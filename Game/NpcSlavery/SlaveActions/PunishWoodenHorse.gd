extends SlaveActionBase

func _init():
	id = "PunishWoodenHorse"
	actionType = Punishment
	#extraSlaves = {}
	#sceneID = "MeScene"
	#endsTalkScene = true
	slaveResistChanceMult = 1.0
	slaveOnlyActiveResist = true
	
	buttonPriority = 60
	rewardHint = -4

func getVisibleName():
	return "Деревянная лошадь"

func getVisibleDesc():
	return "Истязать свою рабыню на деревянной лошади"

func checkCanDo(_slaveID, _extraSlavesIDs = {}):
	if(!getFlag("NpcSlaveryModule.hasWoodenHorse", false)):
		return [false, "Сначала тебе нужно установить деревянную лошадь в своей камере"]
	
	return [true]

func doActionSimple(_slaveID, _extraSlavesIDs = {}):
	var character:DynamicCharacter = GlobalRegistry.getCharacter(_slaveID)
	var npcSlavery:NpcSlave = character.getNpcSlavery()
	
	var text = "В порыве жестокости вы швыряете {npc.name} на деревянную лошадь, заставляя {npc.him} оседлать её острый металлический край, который мгновенно впивается в {npc.his} пах, вызывая мучительный дискомфорт!\n\n"
	
	if(npcSlavery.isActivelyResisting()):
		text += "{npc.HeShe} отчаянно пытается вырваться из пут, но крепкие путы удерживают {npc.him} на месте, заставляя {npc.him} терпеть наказание."
	else:
		text += "Несмотря на дискомфорт, {npc.heShe} покорно принимает позу и просто терпит наказание столько, сколько хватает сил {npc.he}."

	if(character.hasReachableVagina()):
		text += " Спустя примерно час чистой пытки твоя рабыня стонет от боли, а {npc.his} {pussy} выглядит невероятно избитой!"
	elif(character.hasPenis()):
		text += " Спустя примерно час чистой пытки твоя рабыня стонет от боли, а яички и член {npc.his} выглядят невероятно избитыми!"
	else:
		text += " Спустя примерно час чистой пытки твоя рабыня стонет от боли, а промежность {npc.his} выглядит невероятно избитой!"
		
	npcSlavery.handlePunishment(4)
	npcSlavery.addTired(1)
	return {
		text = text,
	}

func getAnimationInfo(_slaveID, _extraSlavesIDs = {}):
	return [StageScene.WoodenHorseSolo, "struggle", {pc=_slaveID, bodyState={naked=true,hard=true}}]

func getTimePass(_slaveID, _extraSlavesIDs = {}):
	return 60*50
