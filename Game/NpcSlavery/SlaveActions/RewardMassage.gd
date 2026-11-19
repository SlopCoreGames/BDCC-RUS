extends SlaveActionBase

func _init():
	id = "RewardMassage"
	actionType = Reward
	#extraSlaves = {}
	#sceneID = ""
	slaveResistChanceMult = 1.0
	slaveOnlyActiveResist = true
	
	buttonPriority = 70
	rewardHint = 3

func getVisibleName():
	return "Массаж"

func getVisibleDesc():
	return "Сделайте рабу массаж спины в качестве награды"

func doActionSimple(_slaveID, _extraSlavesIDs = {}):
	var character:DynamicCharacter = GlobalRegistry.getCharacter(_slaveID)
	var npcSlavery:NpcSlave = character.getNpcSlavery()
	
	var text = "Вы приказываете {npc.name} лечь, а затем делаете {npc.him} нежный массаж спины — отличная награда за {npc.his} старания.\n\n"
	
	if(npcSlavery.getDespair() > 0.8):
		text += "{npc.HeShe} остается пассивной, не проявляя никакого интереса к массажу. Впрочем, как и ко всему остальному.."
	elif(npcSlavery.getSpoiling() > 0.7):
		text += "Пока ты делаешь массаж, {npc.heShe} указывает на недостатки и требует корректировок, ожидая идеального исполнения."
	elif(npcSlavery.isResistingSuperActively() && !character.hasBoundArms()):
		text += "{npc.HeShe} напрягается под твоими руками. В конце концов ты слышишь отчетливый вздох раздражения, а затем {npc.him} резко отстраняется."
	elif(npcSlavery.isResistingSuperActively()):
		text += "{npc.HeShe} напрягается под твоими прикосновениями. В конце концов, ты слышишь отчетливый вздох раздражения, а затем {npc.him} пытается отстраниться. Однако путы удерживают {npc.him} на месте."
	elif(npcSlavery.isActivelyResisting()):
		text += "Пусть поначалу {npc.his} и сопротивляется, но под твоими руками её напряженная поза постепенно смягчается. {npc.HeShe} не протестует, но едва уловимое напряжение всё еще ощущается."
	elif(npcSlavery.rewardBalance <= 0):
		text += "Несмотря на замешательство, {npc.heShe} выражает благодарность за массаж, мягко улыбаясь."
	elif(npcSlavery.getObedience() > 0.5 || npcSlavery.getLove() > 0.5 || npcSlavery.getBrokenSpirit() > 0.5):
		text += "Прикрыв {npc.his} глаза, {npc.heShe} подается навстречу твоим рукам, наслаждаясь нежностью массажа. Тихий вздох срывается с {npc.him}, выражая благодарность за этот момент заботы."
	else:
		text += "{npc.HeShe} остается равнодушной к массажу, не сопротивляясь и не приветствуя прикосновения."
	
	npcSlavery.handleReward(3)
	npcSlavery.addTired(-0.8)
	return {
		text = text,
	}

func getAnimationInfo(_slaveID, _extraSlavesIDs = {}):
	return [StageScene.Massage, "back", {pc="pc", npc=_slaveID, npcBodyState={naked=true}}]

func getTimePass(_slaveID, _extraSlavesIDs = {}):
	return 60*25
