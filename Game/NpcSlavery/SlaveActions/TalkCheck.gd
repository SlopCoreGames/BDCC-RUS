extends SlaveActionBase

func _init():
	id = "TalkCheck"
	actionType = Talk
	#extraSlaves = {}
	#sceneID = ""
	slaveResistChanceMult = 0.0

func getVisibleName():
	return "Проверить рабыню"

func getVisibleDesc():
	return "Спросить, что они чувствуют"

func doActionSimple(_slaveID, _extraSlavesIDs = {}):
	var npcSlavery = getSlave(_slaveID)
	
	var theTexts = []
	theTexts.append("Ты спрашиваешь {npc.name}, о чем {npc.his} думает.")
	
	var slaveWords = []
	if(npcSlavery.isMindBroken()):
		slaveWords.append(RNG.pick([
			"...",
			"... ..",
			"... .. h..",
			"... nothing..",
			]))
	elif(npcSlavery.isResistingSuperActively()):
		if(npcSlavery.personalityScore({PersonalityStat.Mean: 1.0}) > 0.3):
			slaveWords.append(RNG.pick([
				"Да пошел ты, ни хера я тебе не скажу! А ну отпусти меня!",
				]))
			
			if(npcSlavery.getUnhappinessEscapeChance() > 0.0):
				slaveWords.append(RNG.pick([
					"Я сваливаю из этой дыры, как только представится случай!",
					]))
		else:
			slaveWords.append(RNG.pick([
				"Я не хочу здесь находиться. Не трогай меня. Отпусти меня...",
				]))
				
			if(npcSlavery.getUnhappinessEscapeChance() > 0.0):
				slaveWords.append(RNG.pick([
					"Я не в восторге от того, что я здесь. Я сбегу, как только смогу...",
					]))
	else:
		var obedience = npcSlavery.getObedience()
		var brokenSpirit = npcSlavery.getBrokenSpirit()
		var love = npcSlavery.getLove()
		
		var awareness = npcSlavery.getAwareness()
		var trust = npcSlavery.getTrust()
		var despair = npcSlavery.getDespair()
		
		var spoiling = npcSlavery.getSpoiling()
		var fear = npcSlavery.getFear()
		
		var neediness = npcSlavery.getNeediness() # Value from 0.0 to 100.0
		
		if(!npcSlavery.isActivelyResisting()):
			if(awareness >= 0.8):
				slaveWords.append(RNG.pick([
					"Ты мой {npc.pcOwner}. А я всего лишь раб... Твой раб.",
					]))
			elif(awareness >= 0.6):
				slaveWords.append(RNG.pick([
					"Я понимаю... Похоже, теперь я раб... В тюрьме, полной других рабов...",
					]))
			elif(awareness >= 0.4):
				slaveWords.append(RNG.pick([
					"Наверное, мне нужно относиться к тебе как к моему {npc.pcOwner}? Только вот я толком не знаю, как именно...",
					]))
			elif(awareness >= 0.2):
				slaveWords.append(RNG.pick([
					"Я более-менее осознаю свое положение... Но все еще надеюсь, что ты просто отпустишь меня.",
					]))
		
		if(obedience < 0.2 && brokenSpirit < 0.2 && love < 0.2):
			slaveWords.append(RNG.pick([
				"Зачем ты похитил меня и запер в своей камере?",
				]))
		else:
			if(obedience >= brokenSpirit && obedience >= love):
				# Obedience
				if(obedience <= 0.4):
					slaveWords.append(RNG.pick([
						"Пожалуй, мне стоит больше тебя слушаться.",
						]))
				elif(obedience <= 0.6):
					slaveWords.append(RNG.pick([
						"Я стараюсь тебе подчиняться. Надеюсь, у меня получается...",
						]))
				elif(obedience <= 0.8):
					slaveWords.append(RNG.pick([
						"Если хочешь, чтобы я что-то сделала, только скажи, {npc.pcOwner}.",
						]))
				else:
					slaveWords.append(RNG.pick([
						"Повиноваться тебе — мое предназначение...",
						]))
			elif(brokenSpirit >= love):
				# Broken spirit
				if(brokenSpirit <= 0.4):
					slaveWords.append(RNG.pick([
						"Я крепкая орешка. Тебе не так-то просто меня сломить.",
						]))
				elif(brokenSpirit <= 0.6):
					slaveWords.append(RNG.pick([
						"Ты творишь со мной всякие жестокости...",
						]))
				elif(brokenSpirit <= 0.8):
					slaveWords.append(RNG.pick([
						"Если я подчинюсь тебе, ты перестанешь меня пытать?..",
						]))
				else:
					slaveWords.append(RNG.pick([
						"Я готова сказать и сделать всё, что угодно, {npc.pcOwner}...",
						]))
			else:
				# Love
				if(love <= 0.4):
					slaveWords.append(RNG.pick([
						"А ты мне вроде как нравишься...",
						]))
				elif(love <= 0.8):
					slaveWords.append(RNG.pick([
						"Мне кажется... я влюбляюсь в своего похитителя...",
						]))
				else:
					slaveWords.append(RNG.pick([
						"Я так сильно тебя люблю... Я больше не могу без тебя жить, {npc.pcOwner}.",
						]))
		
		if(trust > 0.01 && trust <= 0.1):
			slaveWords.append(RNG.pick([
				"Я тебе не верю... Ни капли.",
				]))
		elif(trust <= 0.3):
			slaveWords.append(RNG.pick([
				"Я не доверяю тебе. Как я вообще могу...",
				]))
		elif(trust <= 0.5):
			slaveWords.append(RNG.pick([
				"Ты довольно справедливо ко мне относишься...",
				]))
		elif(trust <= 0.7):
			slaveWords.append(RNG.pick([
				"До сих пор ты обходился со мной справедливо.",
				]))
		else:
			slaveWords.append(RNG.pick([
				"Не знаю почему, но ты был очень справедлив ко мне.",
				]))
		
		if(despair <= 0.1):
			pass
		elif(despair <= 0.2):
			slaveWords.append(RNG.pick([
				"Ты довольно суров со мной...",
				]))
		elif(despair <= 0.4):
			slaveWords.append(RNG.pick([
				"Зачем ты так со мной...",
				]))
		elif(despair <= 0.6):
			slaveWords.append(RNG.pick([
				"Я чувствую себя ужасно... Этого ты и хотел? Ты хочешь сломить меня, верно?",
				]))
		elif(despair <= 0.8):
			slaveWords.append(RNG.pick([
				"Ненавижу эти цепи. Ненавижу то, что ты со мной делаешь. Ненавижу эту жизнь... Когда же всё это закончится...",
				]))
		else:
			slaveWords.append(RNG.pick([
				"Ненавижу себя... Кажется, мне пора уже всё это закончить...",
				]))
		
		if(despair <= 0.4):
			if(spoiling >= 0.7):
				slaveWords.append(RNG.pick([
					"Ты такой щедрый, продолжай в том же духе~",
					]))
			elif(spoiling >= 0.3):
				slaveWords.append(RNG.pick([
					"Мне нравится, когда ты меня награждаешь. Можешь делать это почаще?",
					]))
		
		if(fear <= 0.2):
			slaveWords.append(RNG.pick([
				"Я тебя не боюсь.",
				]))
		elif(fear <= 0.4):
			slaveWords.append(RNG.pick([
				"Я не боюсь... ну, не очень.",
				]))
		elif(fear <= 0.6):
			slaveWords.append(RNG.pick([
				"Ты так быстро меня наказываешь. Уф...",
				]))
		else:
			slaveWords.append(RNG.pick([
				"Я сделаю всё, что угодно. Только не причиняй мне боли...",
				]))
				
		if(npcSlavery.getUnhappinessEscapeChance() > 5.0):
			slaveWords.append(RNG.pick([
				"Я не рада быть здесь. Особенно после всего, что ты со мной сделал.",
				]))
				
		if(neediness >= 70.0):
			slaveWords.append(RNG.pick([
				"Я сделаю всё, что угодно, только дай мне кончить, по-о-ожалуйста!.. Кажется, я сейчас просто сойду с ума...",
				]))
		elif(neediness >= 50.0):
			slaveWords.append(RNG.pick([
				"Я так, блядь, возбуждена, ты даже представить себе не можешь. Просто дай мне кончить уже! Хватит меня мучить!",
				]))
		elif(neediness >= 25.0):
			slaveWords.append(RNG.pick([
				"Я уже и не помню, когда кончала в последний раз... Так хочется кончить... Ну пожалуйста?",
				]))
		elif(neediness >= 10.0):
			slaveWords.append(RNG.pick([
				"Так хочется кончить...",
				]))
		elif(neediness >= 2.0):
			slaveWords.append(RNG.pick([
				"Я чувствую легкое возбуждение.",
				]))

	var isFirst = true
	var processedWords = []
	for slaveWord in slaveWords:
		if(!isFirst):
			processedWords.append(RNG.pick([
				"{npc.He} немного задумывается и добавляет...",
				"{npc.He} на мгновение замолкает, а затем добавляет...",
				"{npc.He} затем добавляет...",
				"{npc.He} затем объясняет...",
				"{npc.He} немного задумывается...",
			]))
		processedWords.append("[say=npc]"+slaveWord+"[/say]")
		
		isFirst = false
	theTexts.append_array(processedWords)

	return {
		text = Util.join(theTexts, "\n\n"),
	}


func getExtraActions(_slaveID, _extraSlavesIDs = {}):
	return [
		{
			name = "Освободить рабыню",
			desc = "Освободить рабыню и позволить ей покинуть камеру",
			sceneID = "ActionSlaveryFreeSlaveScene",
			args = [],
			buttonChecks = [],
		}
	]
