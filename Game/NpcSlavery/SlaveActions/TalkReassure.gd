extends SlaveActionBase

func _init():
	id = "TalkReassure"
	actionType = Talk
	#extraSlaves = {}
	#sceneID = ""
	slaveResistChanceMult = 0.0
	buttonPriority = 40

func getVisibleName():
	return "Успокоить"

func getVisibleDesc():
	return "Утешить и успокоить свою рабыню"

func doActionSimple(_slaveID, _extraSlavesIDs = {}):
	var npcSlavery = getSlave(_slaveID)
	
	var theTexts = []
	theTexts.append("Вы подбираете слова утешения для {npc.name}, заверяя {npc.him}, что всё будет хорошо. Ваша цель — развеять её страхи и подарить чувство комфорта.")
	
	if(npcSlavery.isMindBroken()):
		theTexts.append("{npc.He} просто тупо пялится на вас...")
	elif(npcSlavery.getTalkedTimesToday() >= 2):
		theTexts.append("Это не особо подействовало на {npc.him}. {npc.He} и так слышал(а) это сегодня слишком много раз.")
	elif(npcSlavery.getWorkEfficiency() <= 0.11):
		theTexts.append("{npc.He} {npc.isAre} слишком измотана, чтобы до конца понять ваши слова; {npc.he} уже едва держится на {npc.his} ногах.")
	else:
		var awareness = npcSlavery.getAwareness()
		var despair = npcSlavery.getDespair()
		var love = npcSlavery.getLove()
		var obedience = npcSlavery.getObedience()
		var spoiling = npcSlavery.getSpoiling()
		var brokenspirit = npcSlavery.getBrokenSpirit()
		var wasAfraid = false
		
		if(npcSlavery.getFear() > 40):
			wasAfraid = true
			npcSlavery.addFear(-50)
			npcSlavery.addSpoiling(-0.05)
			npcSlavery.addDespair(-0.07)
			npcSlavery.addObedience(0.1)
			npcSlavery.addBrokenSpirit(-0.05)
			npcSlavery.addTrust(0.05)
		else:
			npcSlavery.addFear(-30)
			npcSlavery.addSpoiling(0.05)
			npcSlavery.addDespair(-0.07)
			npcSlavery.addObedience(-0.02)
			npcSlavery.addBrokenSpirit(-0.02)
			npcSlavery.addTrust(0.01)
			npcSlavery.addLove(0.04)
		
		if(despair > 0.8):
			theTexts.append("[say=npc]"+RNG.pick([
				"Ладно...",
				"Mhm.. okay..",
				"..sorry..",
				"..mhm..",
				"..right..",
				"Угу...",
			])+"[/say]")
		elif(spoiling > 0.5):
			if(wasAfraid):
				theTexts.append("[say=npc]"+RNG.pick([
					"Ну и напугал же ты меня! Рада, что ты снова меня балуешь~.",
					"О? Так ты перестанешь дурачиться и будешь гладить меня дальше?",
					"В следующий раз не оставляй меня в таком страхе, ты хоть представляешь, через что мне пришлось пройти?!",
					"Я рада, что ты передумал. А теперь гладь меня!",
				])+"[/say]")
			else:
				theTexts.append("[say=npc]"+RNG.pick([
					"Оу, спасибо. Это так мило.",
					"Ты всегда знаешь, как заставить меня почувствовать себя лучше!",
					"Мне так повезло, что ты у меня есть.",
					"Ты вечно меня балуешь, хе-хе.",
				])+"[/say]")
		elif(obedience > 0.9 || brokenspirit > 0.9):
			theTexts.append("[say=npc]"+RNG.pick([
				"Я буду очень стараться...",
				"Твои слова много значат для меня. Я буду стараться еще сильнее.",
				"Я ценю твою поддержку. Я тебя не подведу...",
			])+"[/say]")
		elif(obedience < 0.3 && brokenspirit < 0.3 && love < 0.3):
			if(wasAfraid):
				if(npcSlavery.personalityScore({PersonalityStat.Mean:1.0}) > 0.2):
					theTexts.append("[say=npc]"+RNG.pick([
						"Серьезно? После всего, что ты сделал? Я тебе не верю.",
						"Ага, спасибо большое, рожа ублюдская.",
						"Угу, так и говори дальше.",
						"С чего бы мне тебе верить?",
					])+"[/say]")
				elif(awareness > 0.7):
					theTexts.append("[say=npc]"+RNG.pick([
						"Спасибо, твои слова помогли мне успокоиться.",
						"О?.. Понятно, спасибо за добрые слова...",
						"Мне нужно было это услышать, спасибо..."
					])+"[/say]")
				else:
					theTexts.append("[say=npc]"+RNG.pick([
						"Приятная перемена. Я ценю это.",
						"Мне было страшно. Спасибо за понимание.",
						"Пожалуй, мне стоит успокоиться.",
					])+"[/say]")
			else:
				if(npcSlavery.personalityScore({PersonalityStat.Mean:1.0}) > 0.2):
					theTexts.append("[say=npc]"+RNG.pick([
						"Почему бы тебе просто не отпустить меня вместо того, чтобы разводить эти нежности?",
						"Спасибо. Может, теперь я смогу уйти?",
						"Твои слова приятны, но я тебе не рабыня, отпусти меня.",
					])+"[/say]")
				elif(awareness > 0.7):
					theTexts.append("[say=npc]"+RNG.pick([
						"Спасибо...",
						"Я буду стараться лучше... Всё равно мне отсюда скоро не выбраться...",
					])+"[/say]")
				else:
					theTexts.append("[say=npc]"+RNG.pick([
						"Спасибо, что подбодрила.",
						"Для меня это много значит.",
						"Спасибо за понимание.",
					])+"[/say]")
			
		elif(despair > 0.4):
			if(wasAfraid):
				theTexts.append("[say=npc]"+RNG.pick([
					"Мне это было очень нужно услышать. Спасибо...",
					"Твои слова помогают, спасибо...",
					"Трудно сохранять позитивный настрой...",
					"Ты ведь не причинишь мне боли?..",
				])+"[/say]")
			else:
				theTexts.append("[say=npc]"+RNG.pick([
					"Спасибо...",
					"Твои слова помогают, спасибо...",
					"Я постараюсь не унывать...",
					"Но ты ведь отлупишь меня, если я облажаюсь, да?..",
				])+"[/say]")
		else:
			if(wasAfraid):
				theTexts.append("[say=npc]"+RNG.pick([
					"Спасибо за добрые слова.",
					"Я постараюсь успокоиться.",
				])+"[/say]")
			else:
				theTexts.append("[say=npc]"+RNG.pick([
					"Спасибо за добрые слова... наверное.",
					"Я тебя слышу, спасибо.",
				])+"[/say]")
		
		if(wasAfraid):
			theTexts.append("Твои слова успокоили {npc.him} и подействовали благотворно.")
		else:
			theTexts.append("Твои слова произвели впечатление на {npc.him}.")
		
		var enemyLustInterests = npcSlavery.getChar().getLustInterests()
		if(enemyLustInterests.learnRandomInterest()):
			theTexts.append("Во время этого разговора ты также узнал(а) об одном из предпочтений {npc.his}.")
			
	npcSlavery.didTalkWithToday()
	return {
		text = Util.join(theTexts, "\n\n"),
	}
