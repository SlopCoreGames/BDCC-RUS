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
				"[say=npc]Wanna have some fun? I’m offering. I’m well worth the price.[/say]",
				"[say=npc]Name is {npc.name}. Wanna fuck? Show me some creds~.[/say]",
				"[say=npc]Looking for company, new face? I can provide. For a price~.[/say]",
			]))
		else:
			saynn(RNG.pick([
				"[say=npc]Wanna have.. oh hi, familiar face. Looking to have some fun?[/say]",
				"[say=npc]Hey there. Wanna fuck? Show me some creds and I will give you a good time.[/say]",
				"[say=npc]Looking for company, sweetie? I can provide. For a price~.[/say]",
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
				"[say=npc]You fucker. The only free thing you're gonna get is some broken bones.[/say]",
				"[say=npc]Oh fuck off, I’m not scared. I will break you in half.[/say]",
			]))
		# (if subby)
		elif(npcVariation == "subby"):
			saynn(RNG.pick([
				"[say=npc]Hey! No, that’s not how it works..[/say]",
				"[say=npc]You’re not getting me for free..[/say]",
			]))
		# (if normal or kind)
		else:
			saynn(RNG.pick([
				"[say=npc]Oh yeah? Well, try and get me.[/say]",
				"[say=npc]Good luck getting anything for free in this world.[/say]",
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
				"[say=npc]I can be a total sub bitch for you for just "+str(amountRequested)+" credits~.[/say]",
				"[say=npc]"+str(amountRequested)+" credits and I will be yours to do whatever you want with me~.[/say]",
				"[say=npc]Give me "+str(amountRequested)+" credits and I will be your slut~.[/say]",
			]))
			addButtonWithChecks("Согласиться", "Начать секс в роли доминанта", "paytodom", [], [[ButtonChecks.HasCredits, amountRequested]])
			addButton("Атаковать", "Вы не хотите платить", "attack")
			addButton("Уйти", "Вам не нужны её услуги", "leave")
			addButton("Попросить её доминировать", "Может, она и доминантка", "ask_to_dom")

		# (if npc is switch)
		elif(subbyStat >= -0.2):
			saynn(RNG.pick([
				"[say=npc]I’m a switch, give me "+str(amountRequested)+" credits and you can fuck me or allow me to fuck your precious body~.[/say]",
				"[say=npc]"+str(amountRequested)+" credits and you will be able to choose who fucks who~.[/say]",
				"[say=npc]"+str(amountRequested)+" credits for a fuck. I can top or bottom, your choice~.[/say]",
			]))
			
			addButtonWithChecks("Доминировать над ней", "Начать секс в роли доминанта", "paytodom", [], [[ButtonChecks.HasCredits, amountRequested]])
			addButtonWithChecks("Подчиниться ей", "Начать секс в роли сабмиссива", "paytosub", [], [[ButtonChecks.HasCredits, amountRequested]])
			addButton("Атаковать", "Вы не хотите платить", "attack")
			addButton("Уйти", "Вам не нужны её услуги", "leave")
		# (if npcs is dom)
		else:
			saynn(RNG.pick([
				"[say=npc]I can dom your ass for "+str(amountRequested)+" credits, not a credit less.[/say]",
				"[say=npc]I can fuck you for "+str(amountRequested)+" credits, cutie.[/say]",
				"[say=npc]"+str(amountRequested)+" credits. I’m a dom so I decide how we will fuck, understand?[/say]",
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
			"[say=npc]You know what? I changed my mind. I don’t feel like fucking.[/say]",
			"[say=npc]Thank you very much. Now get lost, bitch, I changed my mind.[/say]",
			"[say=npc]You know what? I decided that I won’t fuck with you. Thanks for the creds though.[/say]",
		]))

		saynn("{npc.He} явно пытается тебя развести!")

		# (Options are Attack, Just leave)

		addButton("Атаковать", "Нельзя позволять им вот так просто воровать твои кредиты!", "attack1")
		addButton("Просто уйти", "Дать им жару", "just_leave")

	if(state == "attack1"):
		saynn("Разъяренный несправедливостью ситуации, вы толкаете заключенного и встаете в боевую стойку. {npc.He} пошатывается, а затем рычит на вас.")

		saynn(RNG.pick([
			"[say=npc]Should have just left, fucker.[/say]",
			"[say=npc]Big mistake, bitch.[/say]",
			"[say=npc]Try me, fucker.[/say]",
		]))

		saynn("Похоже, назревает драка.")

		# (fight button. Winning recovers credits)
		addButton("Драться", "Начать бой", "startfight")

	if(state == "just_leave"):
		saynn("Вы склоняете голову, позволяя {npc.him} оставить кредиты себе.")
		
		saynn(RNG.pick([
			"[say=npc]Good paypig, you would have wasted all your credits on sluts anyways.[/say]",
			"[say=npc]What a good payslut~.[/say]",
		]))

		# (scene ends)
		addButton("Продолжить", "Пф!", "endthescene")

		addButton("Попросить её доминировать", "Спросить, могут ли они доминировать", "ask_to_dom")

	if(state == "ask_to_dom"):
		saynn("Вы спрашиваете заключенного, может ли {npc.he} быть доминантом и трахнуть вас.")

		saynn(RNG.pick([
			"[say=npc]Uhh.. I can try? You would have to pay way more though, at least "+str(amountRequested)+" credits.[/say]",
			"[say=npc]You understand that I’m a sub, right?.. Bu-u-ut.. "+str(amountRequested)+" credits and we can try something..[/say]",
			"[say=npc]I.. I’m not.. hm.. I will do it for "+str(amountRequested)+" credits, how about that.[/say]",
		]))

		# (Options are Agree, Leave, Attack)
		addButtonWithChecks("Согласиться", "Начать секс в роли сабмиссива", "paytosub", [], [[ButtonChecks.HasCredits, amountRequested]])
		addButton("Атаковать", "Вы не хотите платить", "attack")
		addButton("Уйти", "Вам не нужны её услуги", "leave")

	if(state == "ask_to_sub"):
		saynn("Вы спрашиваете заключенного, может ли {npc.he} быть сабом, чтобы вы могли трахнуть {npc.him}.")

		saynn(RNG.pick([
			"[say=npc]Are you serious? Me? Sub to you? I won’t do it.. Unless you have at least "+str(amountRequested)+" credits.[/say]",
			"[say=npc]Bitch, I’m a dominant, I will never sub. But I can pretend for "+str(amountRequested)+" credits, how about that.[/say]",
			"[say=npc]Ugh. Fine, I can let you fuck me. But the price is higher. "+str(amountRequested)+" credits.[/say]",
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
			"What a slut.",
			"Ugh.. Bitch.",
			"Go fuck yourself.",
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
				addMessage("You recovered the stolen credits")
		else:
			setState("if_lost")
			addExperienceToPlayer(5)
			
			if(triedToScam):
				addMessage("You lost the stolen credits..")

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
