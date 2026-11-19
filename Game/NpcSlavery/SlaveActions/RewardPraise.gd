extends SlaveActionBase

func _init():
	id = "RewardPraise"
	actionType = Reward
	#extraSlaves = {}
	#sceneID = ""
	slaveResistChanceMult = 0.0
	
	buttonPriority = 90
	rewardHint = 1

func getVisibleName():
	return "Похвала"

func getVisibleDesc():
	return "Скажи своему рабу, что он справляется весьма недурно."

func doActionSimple(_slaveID, _extraSlavesIDs = {}):
	var character:DynamicCharacter = GlobalRegistry.getCharacter(_slaveID)
	var npcSlavery:NpcSlave = character.getNpcSlavery()
	
	var text = "Вы мягко хвалите своего раба, отмечая его {npc.his} послушание и хорошее поведение.\n\n"
	
	text += RNG.pick([
		"[say=pc]Молодец.[/say]",
		"[say=pc]Так держать.[/say]",
		"[say=pc]Мне уже нравится то, что я вижу.[/say]",
		"[say=pc]Хорошая работа.[/say]",
		"[say=pc]Ты молодец. Так держать.[/say]",
		"[say=pc]Ты молодец.[/say]",
		"[say=pc]Неплохо.[/say]",
	])
	
	text += "\n\n"
	
	var deservesPunishment = false
	
	if(npcSlavery.getDespair() > 0.8):
		text += "{npc.HeShe} continues with {npc.his} current activity of staring at a blank wall, as if your words had little impact."
	elif(npcSlavery.getSpoiling() > 0.7):
		text += "{npc.HeShe} ухмыляется, наслаждаясь чрезмерной похвалой."
	elif(npcSlavery.isResistingSuperActively()):
		if(RNG.chance(10 + npcSlavery.personalityScore({PersonalityStat.Mean:1.0})*10.0)):
			text += "На лице {npc.his} промелькнуло беспокойство, прежде чем {npc.heShe} закатил(а) {npc.his} глаза."
			text += "\n\n[say=npc]"+RNG.pick(["Да пошел ты.", "Пошёл ты нахуй.", "Плевать."])+"[/say]"
				
			if(character.isGagged()):
				text += "\n\n[say=pc]Что это было?[/say]"
				
				text += "\n\n{npc.He} молчит, отказываясь повторять сказанное. Похоже, кляп спас твою рабыню от наказания."
			else:
				text += "\n\nОго. Ты вроде как пытаешься похвалить своего раба, но при этом {npc.he} {npc.isAre} ведешь себя чертовски грубо."
				
				deservesPunishment = true
		else:
			text += "На лице {npc.his} промелькнуло беспокойство, прежде чем {npc.heShe} закатил(а) {npc.his} глаза."
	elif(npcSlavery.isActivelyResisting()):
		text += "{npc.HeShe} коротко кивает, казалось бы, ничуть не тронутая вашей похвалой."
	elif(npcSlavery.rewardBalance <= 0):
		text += "{npc.HeShe} нерешительно улыбается, явно сбитая с толку, но принимающая неожиданную похвалу."
	elif(npcSlavery.getObedience() > 0.5 || npcSlavery.getLove() > 0.5 || npcSlavery.getBrokenSpirit() > 0.5):
		text += "{npc.HeShe} тепло улыбается, наслаждаясь признанием. Твоя похвала, кажется, находит глубокий отклик в душе {npc.him}."
	else:
		text += "{npc.HeShe} медленно и нерешительно кивает, принимая твою похвалу с легким оттенком сдержанности."
	
	npcSlavery.handleReward(1)
	if(deservesPunishment):
		text += "\n\nВаша рабыня заслужила {npc.himself} наказание... сразу после того, как получила награду."
		npcSlavery.deservesPunishment(1)
	return {
		text = text,
	}
