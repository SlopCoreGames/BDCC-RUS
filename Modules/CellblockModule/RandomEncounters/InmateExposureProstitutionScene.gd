extends "res://Scenes/SceneBase.gd"

var npcID = ""
var sawBefore = false
var npcVariation = ""
var triedToScam = false
var amountStole:int = 0
var amountRequested:int = 0

func _init():
	sceneID = "InmateExposureProstitutionScene"

func _initScene(_args = []):
	npcID = _args[0]
	var npc = GlobalRegistry.getCharacter(npcID)
	
	if(npc.getFlag(CharacterFlag.Introduced)):
		sawBefore = true
	else:
		npc.setFlag(CharacterFlag.Introduced, true)
	
	var personality:Personality = npc.getPersonality()
	if(personality.getStat(PersonalityStat.Mean) > 0.3 || personality.getStat(PersonalityStat.Subby) < -0.6):
		npcVariation = "mean"
	if(personality.getStat(PersonalityStat.Mean) < -0.3):
		npcVariation = "kind"
	if(personality.getStat(PersonalityStat.Subby) > 0.6 || personality.getStat(PersonalityStat.Coward) > 0.8):
		npcVariation = "subby"
	
func resolveCustomCharacterName(_charID):
	if(_charID == "npc"):
		return npcID

func _run():
	if(state == ""):
		addCharacter(npcID)
		playAnimation(StageScene.Duo, "stand", {npc=npcID})

	if(state == ""):
		saynn("Вы куда-то шли, как вдруг ваш взгляд зацепился за одну из заключенных, которая соблазнительно позирует каждому проходящему мимо. {npc.He} ловит ваш взгляд и жестом приглашает подойти поближе.")

		# (if didn’t saw)
		if(!sawBefore):
			saynn(RNG.pick([
				"[say=npc]Хочешь развлечься? Я предлагаю. Моя цена того стоит.[/say]",
				"[say=npc]Меня зовут {npc.name}. Хочешь трахнуться? Покажи кредиты~.[/say]",
				"[say=npc]Ищешь компанию, новенький? Я могу устроить. За определенную цену~.[/say]",
			]))
		else:
			saynn(RNG.pick([
				"[say=npc]Хочешь... о, привет, знакомое лицо. Хочешь немного повеселиться?[/say]",
				"[say=npc]Эй. Хочешь трахнуться? Покажи кредиты, и я устрою тебе отличный вечер.[/say]",
				"[say=npc]Ищешь компанию, сладенький? Я могу помочь. За умеренную плату~.[/say]",
			]))

		saynn("Хм, похоже, {npc.he} — проститутка. Или просто пытается подзаработать кредитов.")

		# (Options are Leave, How much and Attack?)

		addButton("Сколько?", "Спросить у проститутки, сколько стоят её услуги", "how_much")
		addButton("Атаковать", "Вы не хотите платить", "attack")
		addButton("Уйти", "Вам не нужны её услуги", "leave")

	if(state == "leave"):
		saynn("Вы говорите {npc.him}, что не заинтересованы, и просто уходите.")

		# (scene ends)
		addButton("Продолжить", "Пора идти", "endthescene")

	if(state == "attack"):
		saynn("Вы принимаете внушительную позу и говорите угрожающим голосом.")

		saynn("[say=pc]Зачем мне платить, если можно получить всё бесплатно?[/say]")

		saynn("{npc.name} ахает и делает шаг назад.")

		# (if mean)
		if(npcVariation == "mean"):
			saynn(RNG.pick([
				"[say=npc]Ах ты ублюдок. Единственное бесплатное, что ты получишь — это парочку сломанных костей.[/say]",
				"[say=npc]Да отвали ты, я не боюсь. Я тебя пополам переломаю.[/say]",
			]))
		# (if subby)
		elif(npcVariation == "subby"):
			saynn(RNG.pick([
				"[say=npc]Эй! Нет, это работает не так...[/say]",
				"[say=npc]Бесплатно ты меня не получишь...[/say]",
			]))
		# (if normal or kind)
		else:
			saynn(RNG.pick([
				"[say=npc]Да неужели? Ну так попробуй поймай![/say]",
				"[say=npc]Удачи тебе в попытках получить хоть что-то бесплатно в этом мире.[/say]",
			]))

		saynn("Похоже, назревает драка.")

		# (fight button)
		addButton("Драться", "Начать бой", "startfight")

	if(state == "how_much"):
		saynn("Вы спрашиваете заключенную, сколько стоят {npc.his} услуги. {npc.He} отвечает вам милой улыбкой.")

		var npc = GlobalRegistry.getCharacter(npcID)
		var personality:Personality = npc.getPersonality()
		var subbyStat = personality.getStat(PersonalityStat.Subby)
		# (if npc is subby)
		if(subbyStat > 0.2):
			saynn(RNG.pick([
				"[say=npc]Я могу быть твоей самой покорной сучкой, лишь бы... "+str(amountRequested)+" credits~.[/say]",
				"[say=npc]"+str(amountRequested)+" ...кредитов, и я буду в твоем полном распоряжении, делай со мной всё, что пожелаешь~.[/say]",
				"[say=npc]Дай мне "+str(amountRequested)+" ...кредитов, и я стану твоей шлюхой~.[/say]",
			]))
			addButtonWithChecks("Согласиться", "Начать секс в роли доминанта", "paytodom", [], [[ButtonChecks.HasCredits, amountRequested]])
			addButton("Атаковать", "Вы не хотите платить", "attack")
			addButton("Уйти", "Вам не нужны её услуги", "leave")
			addButton("Попросить её доминировать", "Может, она и доминантка", "ask_to_dom")

		# (if npc is switch)
		elif(subbyStat >= -0.2):
			saynn(RNG.pick([
				"[say=npc]Я универсал, дай мне "+str(amountRequested)+" кредитов, и сможешь трахать меня или позволить мне трахать твое драгоценное тело~.[/say]",
				"[say=npc]"+str(amountRequested)+" кредитов, и ты сможешь выбирать, кто кого трахает~.[/say]",
				"[say=npc]"+str(amountRequested)+" бабки за трах. Могу быть и сверху, и снизу, как захочешь~.[/say]",
			]))
			
			addButtonWithChecks("Доминировать над ней", "Начать секс в роли доминанта", "paytodom", [], [[ButtonChecks.HasCredits, amountRequested]])
			addButtonWithChecks("Подчиниться ей", "Начать секс в роли сабмиссива", "paytosub", [], [[ButtonChecks.HasCredits, amountRequested]])
			addButton("Атаковать", "Вы не хотите платить", "attack")
			addButton("Уйти", "Вам не нужны её услуги", "leave")
		# (if npcs is dom)
		else:
			saynn(RNG.pick([
				"[say=npc]Я могу доминировать над твоей задницей за "+str(amountRequested)+" кредитов, ни кредитом меньше.[/say]",
				"[say=npc]Я могу трахнуть тебя за "+str(amountRequested)+" кредитов, милашка.[/say]",
				"[say=npc]"+str(amountRequested)+" кредитов. Я тут домина, так что я решаю, как мы будем трахаться, усек?[/say]",
			]))
			addButtonWithChecks("Согласиться", "Начать секс в роли сабмиссива", "paytosub", [], [[ButtonChecks.HasCredits, amountRequested]])
			addButton("Атаковать", "Вы не хотите платить", "attack")
			addButton("Уйти", "Вам не нужны её услуги", "leave")
			addButton("Попросить её подчиниться", "Может, они могут быть сабами?", "ask_to_sub")

		# (subs get options Agree, Leave, Attack, Ask to dom)
		# (switches get options Sub to them, Dom them, Leave, Attack)
		# (doms get options Agree, Leave, Attack, Ask to sub)
		# (Agree deducts the credits and starts sex)

	if(state == "agree_mean_sometimes"):
		saynn("Вы соглашаетесь и даете {npc.him} чип с кредитами. {npc.He} смотрит на вас с хитрой ухмылкой и убирает чип.")

		saynn(RNG.pick([
			"[say=npc]Знаешь что? Я передумала. Что-то не тянет меня на секс.[/say]",
			"[say=npc]Огромное спасибо. А теперь свали в туман, сучка, я передумала.[/say]",
			"[say=npc]Знаешь что? Я решила, что не буду с тобой трахаться. Но за кредиты спасибо.[/say]",
		]))

		saynn("{npc.He} явно пытается тебя развести!")

		# (Options are Attack, Just leave)

		addButton("Атаковать", "Нельзя позволять им вот так просто воровать твои кредиты!", "attack1")
		addButton("Просто уйти", "Дать им жару", "just_leave")

	if(state == "attack1"):
		saynn("Разъяренный несправедливостью ситуации, вы толкаете заключенного и встаете в боевую стойку. {npc.He} пошатывается, а затем рычит на вас.")

		saynn(RNG.pick([
			"[say=npc]Надо было просто сразу уйти, ублюдок.[/say]",
			"[say=npc]Большая ошибка, сучка.[/say]",
			"[say=npc]Попробуй, ублюдок.[/say]",
		]))

		saynn("Похоже, назревает драка.")

		# (fight button. Winning recovers credits)
		addButton("Драться", "Начать бой", "startfight")

	if(state == "just_leave"):
		saynn("Вы склоняете голову, позволяя {npc.him} оставить кредиты себе.")
		
		saynn(RNG.pick([
			"[say=npc]Хороший кошелек, ты бы всё равно спустил все свои кредиты на шлюх.[/say]",
			"[say=npc]Какая послушная шлюшка~.[/say]",
		]))

		# (scene ends)
		addButton("Продолжить", "Пф!", "endthescene")

		addButton("Попросить её доминировать", "Спросить, могут ли они доминировать", "ask_to_dom")

	if(state == "ask_to_dom"):
		saynn("Вы спрашиваете заключенного, может ли {npc.he} быть доминантом и трахнуть вас.")

		saynn(RNG.pick([
			"[say=npc]Э-э.. Ну, можно попробовать? Но тогда тебе придется платить гораздо больше, как минимум "+str(amountRequested)+" credits.[/say]",
			"[say=npc]Ты же понимаешь, что я саб, да?.. Но-о-о... "+str(amountRequested)+" кредитов, и мы можем что-нибудь попробовать..[/say]",
			"[say=npc]Я.. я не.. хм.. Я сделаю это за "+str(amountRequested)+" кредитов, как тебе такое?[/say]",
		]))

		# (Options are Agree, Leave, Attack)
		addButtonWithChecks("Согласиться", "Начать секс в роли сабмиссива", "paytosub", [], [[ButtonChecks.HasCredits, amountRequested]])
		addButton("Атаковать", "Вы не хотите платить", "attack")
		addButton("Уйти", "Вам не нужны её услуги", "leave")

	if(state == "ask_to_sub"):
		saynn("Вы спрашиваете заключенного, может ли {npc.he} быть сабом, чтобы вы могли трахнуть {npc.him}.")

		saynn(RNG.pick([
			"[say=npc]Ты серьезно? Я? Саб для тебя? Ну не стану.. Если только у тебя нет хотя бы "+str(amountRequested)+" credits.[/say]",
			"[say=npc]Сучка, я доминантка, я никогда не буду сабмиссивной. Но могу притвориться ради "+str(amountRequested)+" кредитов, как тебе такое?[/say]",
			"[say=npc]Фух... Ладно, так и быть, давай трахнешь меня. Но цена будет выше. "+str(amountRequested)+" credits.[/say]",
		]))

		# (Options are Agree, Leave, Attack)
		addButtonWithChecks("Согласиться", "Начать секс в роли доминанта", "paytodom", [], [[ButtonChecks.HasCredits, amountRequested]])
		addButton("Атаковать", "Вы не хотите платить", "attack")
		addButton("Уйти", "Вам не нужны её услуги", "leave")

	if(state == "if_lost"):
		saynn("Ты валишься с ног, не в силах продолжать бой.")

		if(npcVariation != "mean"):
			saynn("[say=npc]Ты что, думал, всё будет иначе?[/say]")

		else:
			saynn("[say=npc]Знай своё место, сучка.[/say]")

		saynn("Поскольку {npc.him} больше не может по-настоящему сопротивляться, у тебя остается только один выбор — подчиниться.")

		addButton("Получи по полной", "Ну, ты проиграл(а)", "startsexsubby")

	if(state == "if_won"):
		saynn("Ты прижимаешь побежденного заключенного к полу. {npc.He} особо не сопротивляется.")

		saynn("[say=npc]"+RNG.pick([
			"Ну и шлюшка.",
			"Уф.. Сучка.",
			"Иди нахуй.",
		])+"[/say]")

		addWonButton()

	if(state == "after_sex" || state == "after_sex_won"):
		saynn("Когда веселье заканчивается, зэк просто оставляет тебя в покое.")

		# (scene ends)
		addButton("Уйти", "Пора идти", "endthescene")
		
	if(state == "after_sex"):
		GM.ES.triggerRun(Trigger.AfterSexWithDynamicNPCThatWon, [npcID])
		
	if(state == "after_sex_won"):
		GM.ES.triggerRun(Trigger.AfterSexWithDefeatedDynamicNPC, [npcID])

func addWonButton():
	addButton("Уйти", "Просто уходи, пока тебя не заметили.", "endthescene")
	addButtonWithChecks("Секс!", "Пора их оттрахать!", "startsexasdom", [], [ButtonChecks.CanStartSex])
	addButton("Подчиниться", "Позволить им делать с тобой всё, что захотят", "startsexsubby")
	addButton("Инвентарь", "Посмотреть инвентарь", "openinventory")
	if(GM.pc.getInventory().hasRemovableRestraints()):
		addButton("Сопротивление", "Вырваться из оков", "strugglemenu")
	GM.ES.triggerRun(Trigger.DefeatedDynamicNPC, [npcID])

func _react(_action: String, _args):
	if(_action == "how_much"):
		amountRequested = 5

		var npc = GlobalRegistry.getCharacter(npcID)
		var personality:Personality = npc.getPersonality()
		var cowardStat = personality.getStat(PersonalityStat.Coward)
		var naiveStat = personality.getStat(PersonalityStat.Naive)
		
		amountRequested += int(round(-3 * cowardStat))
		amountRequested += int(round(-3 * naiveStat))
		amountRequested = Util.maxi(2, amountRequested)

	if(_action in ["ask_to_dom", "ask_to_sub"]):
		amountRequested *= RNG.randi_range(2, 4)

	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "startfight"):
		runScene("FightScene", [npcID], "guardfight")
	
	if(_action == "startsexsubby"):
		getCharacter(npcID).prepareForSexAsDom()
		GlobalRegistry.getCharacter(npcID).addPain(-50)
		runScene("GenericSexScene", [npcID, "pc"], "subbysex")
	
	if(_action == "startsexasdom"):
		runScene("GenericSexScene", ["pc", npcID], "domsex")
	
	if(_action in ["paytosub", "paytodom"]):
		var npc = GlobalRegistry.getCharacter(npcID)
		var personality:Personality = npc.getPersonality()
		var meanStat = personality.getStat(PersonalityStat.Mean)
		var bratStat = personality.getStat(PersonalityStat.Brat)
		
		var chanceToScam = max(0.0, meanStat * 50.0) + max(0.0, bratStat * 50.0)
		if(RNG.chance(chanceToScam)):
			GM.pc.addCredits(-amountRequested)
			amountStole = amountRequested
			triedToScam = true
			setState("agree_mean_sometimes")
			return
	
	if(_action == "paytosub"):
		GM.pc.addCredits(-amountRequested)
		
		getCharacter(npcID).prepareForSexAsDom()
		GlobalRegistry.getCharacter(npcID).addPain(-50)
		runScene("GenericSexScene", [npcID, "pc"], "subbysex")
		return
	
	if(_action == "paytodom"):
		GM.pc.addCredits(-amountRequested)
		
		runScene("GenericSexScene", ["pc", npcID], "domsex")
		return
	
	if(_action == "openinventory"):
		runScene("InventoryScene")
		return
	
	if(_action == "strugglemenu"):
		runScene("StrugglingScene")
		return
	

	setState(_action)

func _react_scene_end(_tag, _result):
	if(_tag in ["subbysex"]):
		setState("after_sex")
	if(_tag in ["domsex"]):
		setState("after_sex_won")
	
	if(_tag == "guardfight"):
		processTime(20 * 60)
		var battlestate = _result[0]
		#var wonHow = _result[1]
		
		if(battlestate == "win"):
			setState("if_won")
			addExperienceToPlayer(30)
			
			if(triedToScam):
				GM.pc.addCredits(amountStole)
				addMessage("Вы вернули украденные кредиты")
		else:
			setState("if_lost")
			addExperienceToPlayer(5)
			
			if(triedToScam):
				addMessage("Вы потеряли украденные кредиты..")

func saveData():
	var data = .saveData()
	
	data["npcID"] = npcID
	data["sawBefore"] = sawBefore
	data["npcVariation"] = npcVariation
	data["triedToScam"] = triedToScam
	data["amountStole"] = amountStole
	data["amountRequested"] = amountRequested
	
	return data
	
func loadData(data):
	.loadData(data)
	
	npcID = SAVE.loadVar(data, "npcID", "")
	sawBefore = SAVE.loadVar(data, "sawBefore", false)
	npcVariation = SAVE.loadVar(data, "npcVariation", "")
	triedToScam = SAVE.loadVar(data, "triedToScam", false)
	amountStole = SAVE.loadVar(data, "amountStole", 0)
	amountRequested = SAVE.loadVar(data, "amountRequested", 0)
