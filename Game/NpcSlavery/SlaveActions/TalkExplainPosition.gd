extends SlaveActionBase

func _init():
	id = "TalkExplainPosition"
	actionType = Talk
	#extraSlaves = {}
	#sceneID = ""
	slaveResistChanceMult = 0.0
	buttonPriority = 80

func getVisibleName():
	return "Объяснить свое положение"

func getVisibleDesc():
	return "Сказать им, что теперь они рабы"

func doActionSimple(_slaveID, _extraSlavesIDs = {}):
	var npcSlavery = getSlave(_slaveID)
	
	var theTexts = []
	theTexts.append("Вы объясняете положение {npc.name} {npc.his}. Вы говорите {npc.him}, что {npc.he} {npc.isAre} теперь принадлежит вам, и {npc.he} ничего не может с этим поделать.")
	
	if(npcSlavery.getTalkedTimesToday() >= 2):
		theTexts.append("Это не особо подействовало на {npc.him}. {npc.He} и так слышал(а) это сегодня слишком много раз.")
	else:
		var awareness = npcSlavery.getAwareness()
		if(awareness > 0.7):
			theTexts.append("{npc.He} уже не раз это слышал(а), так что нового вы {npc.him} не скажете.")
		elif(awareness > (0.25+npcSlavery.personalityScore({PersonalityStat.Subby: 0.1}))):
			npcSlavery.addTired(0.2)
			theTexts.append("{npc.He} и так это знает, так что нового вы {npc.him} не скажете.")
		else:
			if(npcSlavery.getWorkEfficiency() <= 0.4):
				npcSlavery.addTired(0.2)
				theTexts.append("{npc.He} слишком устал(а), чтобы полностью вникнуть в ваши слова.")
			elif(npcSlavery.isActivelyResisting()):
				npcSlavery.addTired(0.2)
				npcSlavery.addAwareness(0.04)
				theTexts.append("{npc.He} совсем не нравится то, что слышит {npc.he}. И все же, вы чувствуете, что вас услышали.")
			else:
				npcSlavery.addTired(0.2)
				npcSlavery.addAwareness(0.05)
				theTexts.append("{npc.He} молча слушает вас. Похоже, {npc.he} начинает лучше понимать положение {npc.his}.")
		
	npcSlavery.didTalkWithToday()
	return {
		text = Util.join(theTexts, "\n\n"),
	}
