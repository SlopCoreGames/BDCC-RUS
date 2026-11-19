extends SlaveActionBase

func _init():
	id = "TalkIntimidate"
	actionType = Talk
	#extraSlaves = {}
	#sceneID = ""
	slaveResistChanceMult = 0.0
	buttonPriority = 50

func getVisibleName():
	return "Запугивание"

func getVisibleDesc():
	return "Угрожать своей рабыне, чтобы она лучше слушалась"

func doActionSimple(_slaveID, _extraSlavesIDs = {}):
	var npcSlavery = getSlave(_slaveID)
	
	var theTexts = []
	theTexts.append("Угрожающим тоном вы даете понять {npc.name}, что сопротивление бесполезно. {npc.HeShe} {npc.isAre} теперь полностью под вашим контролем, и любое неповиновение будет караться.")
	
	if(npcSlavery.isMindBroken()):
		theTexts.append("{npc.He} просто тупо пялится на вас...")
	elif(npcSlavery.getTalkedTimesToday() >= 2):
		theTexts.append("Это не особо подействовало на {npc.him}. {npc.He} и так слышал(а) это сегодня слишком много раз.")
	elif(npcSlavery.getWorkEfficiency() <= 0.11):
		theTexts.append("{npc.He} {npc.isAre} слишком измотана, чтобы до конца понять ваши слова; {npc.he} уже едва держится на {npc.his} ногах.")
	elif(npcSlavery.getFear() >= 80):
		theTexts.append("{npc.He} {npc.isAre} уже слишком напугана, чтобы ваши слова могли на что-то повлиять.")
	
		npcSlavery.addTired(0.3)
	else:
		var awareness = npcSlavery.getAwareness()
		var despair = npcSlavery.getDespair()
		var love = npcSlavery.getLove()
		var obedience = npcSlavery.getObedience()
		var spoiling = npcSlavery.getSpoiling()
		var brokenspirit = npcSlavery.getBrokenSpirit()
		
		npcSlavery.addFear(30)
		
		npcSlavery.addSpoiling(-0.1)
		npcSlavery.addDespair(0.07)
		npcSlavery.addTired(0.3)
		npcSlavery.addObedience(0.05)
		npcSlavery.addTrust(-0.1)
		npcSlavery.addBrokenSpirit(0.01)
		
		if(despair > 0.8):
			theTexts.append("[say=npc]"+RNG.pick([
				"Ладно...",
				"Можешь просто делать всё, что тебе вздумается...",
				"Так почему бы тебе просто не сделать это?.. Завязывай уже с этим...",
				"Mhm.. okay..",
				"..sorry..",
				"..mhm..",
				"..right..",
			])+"[/say]")
		elif(spoiling > 0.5):
			theTexts.append("[say=npc]"+RNG.pick([
				"Серьезно? Но у нас же всё так хорошо шло, почему ты вдруг стал таким злым...",
				"Ну почему ты такой злой...",
				"Какой злой..",
				"Ну слишком злой!..",
				"Okay, okay, whatever, relax..",
				"Ого, не знала, что правила такие строгие..",
			])+"[/say]")
		elif(obedience > 0.9 || brokenspirit > 0.9):
			theTexts.append("[say=npc]"+RNG.pick([
				"Я буду беспрекословно подчиняться. Пожалуйста, пощади меня..",
				"Я сделаю всё, что захочешь, только прошу.. Прости меня.",
				"Просто скажи, что мне делать, и я сделаю, прости..",
			])+"[/say]")
		elif(obedience < 0.3 && brokenspirit < 0.3 && love < 0.3):
			if(npcSlavery.personalityScore({PersonalityStat.Mean:1.0}) > 0.2 && npcSlavery.getFear() < 0.4):
				theTexts.append("[say=npc]"+RNG.pick([
					"Да пошёл ты, ясно? Я не боюсь.",
					"Ну давай, ублюдок, я тебя в порошок сотру.",
					"Угрозы меня не сломят, делай что хочешь, сука.",
					"Меня не сломить, я выдержу всё, что ты на меня вывалишь.",
					"Докажи свои слова делом, ублюдок.",
					"Ты не сможешь держать меня здесь вечно.",
				])+"[/say]")
			elif(awareness > 0.7):
				theTexts.append("[say=npc]"+RNG.pick([
					"Мне очень жаль, я буду стараться лучше. Пожалуйста...",
					"Я знаю, что застряну здесь надолго... Я буду стараться, умоляю...",
				])+"[/say]")
			else:
				theTexts.append("[say=npc]"+RNG.pick([
					"Просто отпусти меня.",
					"Почему бы тебе просто не отпустить меня?",
					"Прости, меня вообще здесь быть не должно...",
				])+"[/say]")
			
		elif(despair > 0.4):
			theTexts.append("[say=npc]"+RNG.pick([
				"Извини, ладно? Я и так на взводе...",
				"Я буду стараться лучше, только не бей меня...",
				"Я же стараюсь изо всех сил...",
				"Только не причиняй мне боли...",
			])+"[/say]")
		else:
			theTexts.append("[say=npc]"+RNG.pick([
				"Ладно, ладно, я тебя слышу.",
				"Не нужно насилия, я тебя понял.",
			])+"[/say]")
		
		theTexts.append("Твои слова произвели впечатление на {npc.him}.")
		
		var enemyLustInterests = npcSlavery.getChar().getLustInterests()
		if(enemyLustInterests.learnRandomInterest()):
			theTexts.append("Во время этого разговора ты также узнал(а) об одном из предпочтений {npc.his}.")
		
	npcSlavery.didTalkWithToday()
	return {
		text = Util.join(theTexts, "\n\n"),
	}
