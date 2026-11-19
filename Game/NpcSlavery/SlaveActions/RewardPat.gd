extends SlaveActionBase

func _init():
	id = "RewardPat"
	actionType = Reward
	#extraSlaves = {}
	#sceneID = ""
	slaveResistChanceMult = 0.0
	
	buttonPriority = 80
	rewardHint = 2

func getVisibleName():
	return "Поглаживания по голове"

func getVisibleDesc():
	return "Погладь свою рабыню по голове"

func doActionSimple(_slaveID, _extraSlavesIDs = {}):
	var character:DynamicCharacter = GlobalRegistry.getCharacter(_slaveID)
	var npcSlavery:NpcSlave = character.getNpcSlavery()
	
	var text = "Вы ласково гладите {npc.name} по голове, поощряя {npc.his} старания.\n\n"
	
	var deservesPunishment = false
	
	if(npcSlavery.getDespair() > 0.8):
		text += "{npc.HeShe} позволяет гладить себя, но при этом взгляд остается отрешенным. В глазах {npc.his} таится едва уловимая грусть."
	elif(npcSlavery.getSpoiling() > 0.7):
		text += "{npc.HeShe} подставляет голову под поглаживания, а затем и вовсе начинает выпрашивать их, а вокруг {npc.him} разливается самодовольная аура избалованности."
	elif(npcSlavery.isResistingSuperActively() && !character.hasBoundArms()):
		if(RNG.chance(15 + npcSlavery.personalityScore({PersonalityStat.Mean:1.0})*20.0)):
			text += "{npc.HeShe} отмахивается от твоей руки после одного единственного похлопывания, и её глаза пылают вызовом. Ого! Это заслуживает небольшого наказания!"
			deservesPunishment = true
		else:
			text += "{npc.HeShe} терпит похлопывания, но глаза {npc.his} пылают вызовом."
	elif(npcSlavery.isResistingSuperActively()):
		text += "{npc.HeShe} уворачивается от твоих поглаживаний, словно от огня, а {npc.his} сверкает глазами, полными непокорности."
	elif(npcSlavery.isActivelyResisting()):
		if(RNG.chance(15 + npcSlavery.personalityScore({PersonalityStat.Mean:1.0})*20.0)):
			text += "{npc.HeShe} ворчит и продолжает утыкать {npc.his} головой в сторону от твоей руки. Довольно грубо. Это заслуживает небольшого наказания!"
			deservesPunishment = true
		else:
			text += "{npc.HeShe} терпит похлопывания, но глаза {npc.his} пылают вызовом."
		
	elif(npcSlavery.rewardBalance <= 0):
		text += "{npc.HeShe} моргает, и на лице {npc.his} отражается недоумение. Похоже, поглаживания по голове застали {npc.him} врасплох."
	elif(npcSlavery.getObedience() > 0.5 || npcSlavery.getLove() > 0.5 || npcSlavery.getBrokenSpirit() > 0.5):
		text += "{npc.HeShe} подается навстречу твоему прикосновению, довольно зажмурив глаза. С {npc.his} губ срывается тихий вздох, приветствующий нежность этого жеста."
	else:
		text += "{npc.HeShe} слегка напрягается, но не отстраняется."
	
	npcSlavery.handleReward(2)
	if(deservesPunishment):
		text += "\n\nВаша рабыня заслужила {npc.himself} наказание... сразу после того, как получила награду."
		npcSlavery.deservesPunishment(1)
	return {
		text = text,
	}

func getAnimationInfo(_slaveID, _extraSlavesIDs = {}):
	return [StageScene.Grope, "pat", {npc="pc", pc=_slaveID}]
