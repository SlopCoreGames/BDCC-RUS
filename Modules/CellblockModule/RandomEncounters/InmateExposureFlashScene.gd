extends "res://Scenes/SceneBase.gd"

var npcID = ""
var sawBefore = false
var npcVariation = ""
var attackSuccessful = false

func _init():
	sceneID = "InmateExposureFlashScene"

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
		# (if naked)
		if(GM.pc.isFullyNaked()):
			saynn(RNG.pick([
				"You can’t help but to feel like someone is watching you. You look around a spot one of the inmates checking you out. {npc.His} stare makes you tactically cover your privates a bit.",
				"You’re completely naked so obviously eyes are gonna be attracted to you. One set in particular is quite curious in your {pc.masc} curves.",
			]))

		# (if not naked)
		else:
			saynn(RNG.pick([
				"You can’t help but to feel like someone is watching you. You look around a spot one of the inmates checking you out. {npc.His} stare makes your heart beat a bit harder.",
				"You’re quite exposed so eyes are gonna be attracted to you. One set in particular is quite curious in your {pc.masc} curves.",
			]))

		var ehibit = GM.pc.getSkillLevel(Skill.Exhibitionism)

		if(ehibit < 2):
			saynn("Может, стоит воспользоваться случаем и испытать себя..")
		elif(ehibit < 4):
			saynn("В голову приходит непристойная мысль. Может, устроить {npc.him} небольшое шоу?")
		elif(ehibit < 6):
			saynn("Ты чувствуешь себя очень уверенно в своем теле. В голове то и дело всплывают пошлые мысли.")
		else:
			saynn("Тебе не терпится раздеться еще сильнее. Все эти удивленные и смущенные взгляды приносят тебе невероятное удовольствие.")

		addButton("Избежать", "Тебе не хочется раздеваться больше", "avoid")
		
		addButtonWithChecks("Сиськи", "Показать грудь", "tits", [], [[ButtonChecks.SkillCheck, Skill.Exhibitionism, 1], ButtonChecks.NotArmsRestrained, ButtonChecks.NotHandsBlocked])
		if(ehibit >= 1):
			addButtonWithChecks("В задницу", "Показать задницу", "ass", [], [[ButtonChecks.SkillCheck, Skill.Exhibitionism, 3], ButtonChecks.NotArmsRestrained, ButtonChecks.NotHandsBlocked])
		if(ehibit >= 3):
			addButtonWithChecks("В киску", "Показать киску", "pussy", [], [ButtonChecks.HasReachableVagina, [ButtonChecks.SkillCheck, Skill.Exhibitionism, 5], ButtonChecks.NotArmsRestrained, ButtonChecks.NotHandsBlocked])
			addButtonWithChecks("Член", "Покажи свой член", "cock", [], [ButtonChecks.HasPenis, [ButtonChecks.SkillCheck, Skill.Exhibitionism, 5], ButtonChecks.NotArmsRestrained, ButtonChecks.NotHandsBlocked])
		if(ehibit >= 5):
			addButtonWithChecks("Выставь себя напоказ", "Не скрывай ничего", "show_yourself_off", [], [[ButtonChecks.SkillCheck, Skill.Exhibitionism, 7], ButtonChecks.NotArmsRestrained, ButtonChecks.NotHandsBlocked])
		addButton("Атаковать", "Чего они хотят?", "attack")
		
	if(state == "avoid"):
		saynn("Вы прикрываете лицо и стараетесь как можно быстрее свалить отсюда, стараясь не попадаться на глаза.")

		saynn("К счастью, заключенный, кажется, не собирается за вами гнаться.")

		# (scene ends)
		addButton("Уйти", "Пора идти", "endthescene")
		
	if(state == "failed_to_get_away"):
		saynn("Но прежде чем вы успеваете уйти, заключенный хватает вас за воротник и пытается лапать ваше тело!")
		
		saynn(RNG.pick([
			"[say=npc]Where are you going, slut? Your job is to serve inmates like me.[/say]",
			"[say=npc]Hold it right there, whore. I’m not letting you go unless we fuck right here.[/say]",
			"[say=npc]Think I will just let you go, little fucktoy? Think again.[/say]",
			"[say=npc]Think I will let you go after what I saw? I’m gonna fuck you.[/say]",
		]))

		addButton("Атаковать", "Чего они хотят?", "attack")
		addButton("Подчиниться", "Пусть делают, что хотят", "startsexsubby")

	if(state == "attack"):
		saynn("Ты резко разворачиваешься и втыкаешь локоть в {npc.his} грудь.")

		# (if success)
		if(attackSuccessful):
			saynn("Это выбивает из {npc.him} весь дух. Заключенный падает на {npc.his} колени, жадно хватая ртом воздух.")
			
			saynn(RNG.pick([
				"[say=npc]You.. fucker..[/say]",
				"[say=npc]What a bitch..[/say]",
				"[say=npc]Ugh.. you whore..[/say]",
				
			]))

			saynn("Похоже, сейчас самое время сваливать.")
			
			addWonButton()
		# (addwonbuttons)

		# (if fail)
		else:
			saynn("От этого {npc.him} начинает кашлять, но {npc.he} всё еще стоит на ногах. И {npc.he} всё еще в ярости.")

			saynn(RNG.pick([
				"[say=npc]Ugh.. Prepare to be my bitch.[/say]",
				"[say=npc]You little bitch. You will learn your place soon.[/say]",
				
			]))

			# (fight)
			addButton("Драться", "Начать бой", "startfight")

		# (if won, if lose are the same)

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

	if(state == "tits"):
		# (Requires level 1)

		# (if flat tits)
		if(!GM.pc.hasBigBreasts()):
			saynn("Ты обнажаешь и выставляешь напоказ свою {pc.breasts}, дразня и лаская соски, которые твердеют от прикосновений. Твоя грудь не очень большая, но иногда размер не имеет значения.")

		# (if big tits)
		else:
			saynn("Ты обнажаешь и выставляешь напоказ свою {pc.breasts}, сжимая и лаская их. Ты игриво прикрываешь только соски — как же это похотливо. Зачем прятать такие классные буфера, если ими можно смущать других?")

		saynn("Заключенный приподнимает {npc.his} бровь. Подобные непристойности заставляют тебя чувствовать себя увереннее и гордиться своим телом.")

		addButton("Уйти", "Это было пошло", "leavecheck")

	if(state == "ass"):
		# (Requires level 3)

		saynn("Ты демонстрируешь свою {pc.thick} задницу и слегка виляешь ею, оглядываясь назад. Ты шлепаешь себя по ягодицам, заставляя их подпрыгивать. (или) Ты разводишь булки, демонстрируя свою {pc.analStretch} звездочку.")

		saynn("Ты видишь широко раскрытые глаза заключенного. Подобные непристойности заставляют тебя чувствовать себя увереннее и гордиться своим телом.")

		addButton("Уйти", "Это было пошло", "leavecheck")

	if(state == "pussy"):
		# (Requires level 5)

		saynn("Ты на секунду демонстрируешь свою {pc.pussyStretch} киску и высовываешь язык. Но даже этого мгновения хватило, чтобы ты почувствовала прилив похоти.")

		saynn("Возможно, заключенный подловил именно тот нужный момент. Но тебя не смущает обнажение кожи — в конце концов, это всего лишь твоя киска.")

		addButton("Уйти", "Это было пошло", "leavecheck")

	if(state == "cock"):
		# (requires level 5)
		if(GM.pc.isWearingChastityCage()):
			saynn("Ты быстро демонстрируешь свой член в клетке и одариваешь любого наблюдателя дерзкой ухмылкой. Азарт от столь смелого саморазоблачения приносит удовольствие.")
		else:
			saynn("Ты быстро демонстрируешь свою {pc.penis} и одариваешь любого наблюдателя дерзкой ухмылкой. Азарт от столь смелого саморазоблачения приносит удовольствие.")

		saynn("Тебе даже удается удерживать зрительный контакт с заключенным. Подобные развратные штучки придают тебе уверенности и заставляют гордиться своим телом.")

		addButton("Уйти", "Это было пошло", "leavecheck")

	if(state == "show_yourself_off"):
		# (requires level 7)

		saynn("Нет ничего лучше, чем выставлять свое тело напоказ и наблюдать за реакцией окружающих. Ты смотришь прямо на заключенного, лаская себя.")

		# (if has flat tits)
		if(!GM.pc.hasBigBreasts()):
			saynn("Ты начинаешь с того, что демонстрируешь свои {pc.breasts} и дразнишь соски, пока они не станут твердыми и возбужденными. В конце концов, кому нужны огромные сиськи? От них слишком много отвлекаешься.")

		# (if has big tits)
		else:
			saynn("Ты начинаешь с того, что демонстрируешь свои {pc.breasts} и сжимаешь их ладонями. Твои соски быстро твердеют и упираются в ладони, пока ты их трешь. У тебя отличная грудь, которую стоит показать.")

		# (if has pussy)
		if(GM.pc.hasReachableVagina()):
			saynn("Затем одна твоя рука скользит вниз, к киске. Ты продолжаешь ощупывать грудь, одновременно раздвигая половые губы и демонстрируя чувствительную плоть. Как развратно.")

		# (if has cock)
		if(GM.pc.isWearingChastityCage()):
			saynn("На твоем лице играет широкая ухмылка, пока ты демонстрируешь свои запертые {pc.penis}. Пальцы обхватывают твою девственную клетку и слегка поглаживают её. Ты не получаешь от этого удовольствия, но ощущения всё равно приятные.")
		elif(GM.pc.hasReachablePenis()):
			saynn("На твоем лице играет широкая ухмылка, пока ты демонстрируешь свои {pc.penis}. Пальцы обхватывают твой член и слегка поглаживают его.")

		saynn("Ты поворачиваешься спиной и ведешь руками вниз по своим {pc.thick} бедрам, прежде чем звонко шлепнуть по ним. Затем ты раздвигаешь ягодицы, демонстрируя свое {pc.analStretch} анальное отверстие!")

		saynn("Так волнительно — ты выставляешь себя на показ ради одного-единственного заключенного. А затем быстро убегаешь.")

		# (scene ends)
		if(npcVariation in ["kind", "subby"]):
			addButton("Продолжить", "Как развратно", "endthescene")
		else:
			addButton("Продолжить", "Как развратно", "failed_to_get_away")

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
	
	
	if(_action == "openinventory"):
		runScene("InventoryScene")
		return
	
	if(_action == "strugglemenu"):
		runScene("StrugglingScene")
		return
	
	if(_action == "leavecheck"):
		if(npcVariation == "mean" || (npcVariation == "" && RNG.chance(50))):
			setState("failed_to_get_away")
		else:
			endScene()
		return
	
	if(_action == "attack"):
		if(RNG.chance(50)):
			attackSuccessful = true
		else:
			attackSuccessful = false

	if(_action == "tits"):
		GM.pc.addSkillExperience(Skill.Exhibitionism, 10)
	if(_action == "ass"):
		GM.pc.addSkillExperience(Skill.Exhibitionism, 20)
	if(_action in ["pussy", "cock"]):
		GM.pc.addSkillExperience(Skill.Exhibitionism, 30)
	if(_action in ["show_yourself_off"]):
		GM.pc.addSkillExperience(Skill.Exhibitionism, 50)

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
		else:
			setState("if_lost")
			addExperienceToPlayer(5)

func saveData():
	var data = .saveData()
	
	data["npcID"] = npcID
	data["sawBefore"] = sawBefore
	data["npcVariation"] = npcVariation
	data["attackSuccessful"] = attackSuccessful
	
	return data
	
func loadData(data):
	.loadData(data)
	
	npcID = SAVE.loadVar(data, "npcID", "")
	sawBefore = SAVE.loadVar(data, "sawBefore", false)
	npcVariation = SAVE.loadVar(data, "npcVariation", "")
	attackSuccessful = SAVE.loadVar(data, "attackSuccessful", false)
