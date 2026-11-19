extends "res://Scenes/SceneBase.gd"

var npcID = ""
var sawBefore = false
var npcVariation = ""

func _init():
	sceneID = "EngineerCaughtOfflimitsScene"

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
		saynn("Пока ты бродишь по темным, тускло освещенным коридорам инженерного блока, из-за угла доносится звук тяжелых шагов. Внезапно перед тобой появляется один из инженеров. {npc.He} замечает тебя!")
		
		# (new engineer)
		if(!sawBefore):

			# (default lines)
			var possibleLines = [
				"[say=npc]Hey! You're not authorized to be in here.[/say]",
				"[say=npc]You think you can just waltz in here and go unnoticed? Think again.[/say]",
				"[say=npc]You're making a big mistake by trying to sneak in here.[/say]",
				"[say=npc]I'll show you what happens to those who defy the rules.[/say]",
				"[say=npc]Hey! I'm not going to let you sabotage our equipment.[/say]",
				"[say=npc]You think you can just waltz in here and mess with my machinery? Think again.[/say]",
				"[say=npc]What do we have here? A new inmate trying to sneak into the engineering block? You're going to regret that decision.[/say]",
			]

			# (mean or dommy)
			if(npcVariation == "mean"):
				possibleLines = [
					"[say=npc]Who the hell are you and what are you doing here?[/say]",
					"[say=npc]You better have a good explanation for why you're here or you're in for a world of pain.[/say]",
					"[say=npc]You picked the wrong engineer to mess with, bitch.[/say]",
					"[say=npc]Hey, bitch! I have zero tolerance for intruders, especially in my sacred engineering block.[/say]",
					"[say=npc]I’m giving you exactly one second to explain yourself, whore. Time’s up![/say]",
				]

			# (kind)
			if(npcVariation == "kind"):
				possibleLines = [
					"[say=npc]Oh, hello there! I'm sorry, but you're not supposed to be in this area. I'll have to report this to the guards.[/say]",
					"[say=npc]Oh, hi. I'm sorry, but you'll have to face the consequences of your actions. But I'll make sure you're treated fairly.[/say]",
					"[say=npc]Oh, who are you? I don't wanna hurt you, I'm here to help keep this facility running. But I can't let you break the rules.[/say]",
					"[say=npc]Hey! I'll have to ask you to come with me. I promise I won't hurt you as long as you obey.[/say]",
				]

			# (subby)
			if(npcVariation == "subby"):
				possibleLines = [
					"[say=npc]Oh. Who are you? You wanted me?..[/say]",
					"[say=npc]Oh, a curious one? What are you looking for? It’s not me, is it?..[/say]",
					"[say=npc]This is not the place for inmates. What are you gonna do to me?..[/say]",
				]
				
			saynn(RNG.pick(possibleLines))
		# (saw before)
		else:
			# (default lines)
			var possibleLines = [
				"[say=npc]You should have run while you had the chance.[/say]",
				"[say=npc]You again. You're going to pay for your audacity.[/say]",
				"[say=npc]I'll make an example out of you for anyone else thinking of trespassing.[/say]",
				"[say=npc]I warned you, now you'll have to deal with me.[/say]",
			]

			# (mean or dommy)
			if(npcVariation == "mean"):
				possibleLines = [
					"[say=npc]I remember you, fucker! Time to throw your ass out.[/say]",
					"[say=npc]You can’t escape from me this time, you sleezy fuck.[/say]",
					"[say=npc]Did I not tell you to get fuck out of my engineering, bitch?[/say]",
					"[say=npc]The fuck are you still doing here, bitch?[/say]",
				]

			# (kind)
			if(npcVariation == "kind"):
				possibleLines = [
					"[say=npc]Hello again, I saw you wandering around here earlier. This is a restricted area, you know.[/say]",
					"[say=npc]You again.. I'll have to report this to the guards. I'll put in a good word for you if you obey.[/say]",
					"[say=npc]Oh, I remember you. I think you should stop trying to break into the engineering block, there is nothing interesting here..[/say]",
					"[say=npc]Oh, hey there. You can’t be here, I already told you.[/say]"
				]

			# (subby)
			if(npcVariation == "subby"):
				possibleLines = [
					"[say=npc]You came back for more?..[/say]",
					"[say=npc]I don’t know what you are looking for but there is no one around but me..[/say]",
					"[say=npc]Oh, you found me again. What are you gonna do?..[/say]",
				]
				
			saynn(RNG.pick(possibleLines))
			# (end)

		if(npcVariation in ["kind", "subby"]):
			saynn("Похоже, {npc.he} не настроен на драку.")
			
			addButton("Запугивание", "Вежливо попросить пропустить тебя", "intimidate")
			addButton("Атаковать", "Ну, они сами напросились", "attack")
			addButton("Предложить свое тело", "Может, стоит попытаться соблазнить их?", "offer_body")
		else:
			saynn("Похоже, {npc.he} просто так тебя не отпустит.")

			addButton("Атаковать", "Ну, они сами напросились", "attack")
			addButton("Предложить свое тело", "Может, стоит попытаться соблазнить их?", "offer_body")
		
	if(state == "intimidate_success"):
		saynn(RNG.pick([
			"[say=pc]Думаю, тебе будет лучше, если ты меня отпустишь. Понимаешь, о чем я?[/say]",
			"[say=pc]Если не собираешься меня отпускать, я не стану сдерживаться.[/say]",
			"[say=pc]Попытка остановить меня плохо кончится для тебя. А?[/say]",
		]))
		
		saynn("Инженер слышит твои слова и опускает {npc.his} голову.")
		
		saynn(RNG.pick([
			"[say=npc]Ладно, ладно, я тебя услышал(а). Только не бей..[/say]",
			"[say=npc]Тогда я не буду тебя задерживать, иди..[/say]",
			"[say=npc]Ладно, только ничего не сломай..[/say]",
			]))
		
		saynn("Похоже, уговорить {pc.him} немного развлечься не составит труда.")
		
		addWonButton()
	
	if(state == "intimidate_fail"):
		saynn(RNG.pick([
			"[say=pc]Думаю, тебе будет лучше, если ты меня отпустишь. Понимаешь, о чем я?[/say]",
			"[say=pc]Если не собираешься меня отпускать, я не стану сдерживаться.[/say]",
			"[say=pc]Попытка остановить меня плохо кончится для тебя. А?[/say]",
		]))
		
		saynn("Инженер слышит твои слова и принимает боевую стойку.")
	
		saynn(RNG.pick([
			"[say=npc]Я не могу тебя отпустить, прости.[/say]",
			"[say=npc]Если придется драться — я буду драться.[/say]",
			"[say=npc]Я не боюсь! Я должен защитить оборудование![/say]",
		]))
		
		saynn("Похоже, назревает драка.")
		
		addButton("Драться", "Начать бой", "startfight")
		
	if(state == "attack"):
		# (if subby, can just auto-win)
		playAnimation(StageScene.Duo, "stand", {npc=npcID})

		saynn("Ты наносишь удар по {npc.name}!")

		# (if mean)
		if(npcVariation == "mean"):
			saynn("Но {npc.he} готов(а): он(а) отталкивает тебя и издает яростный рык.")

			saynn(RNG.pick([
				"[say=npc]О, ты, блять, об этом еще пожалеешь.[/say]",
				"[say=npc]Значит, придется применить силу.[/say]",
				"[say=npc]Плохой выбор. Готовься к последствиям, сучка.[/say]",
			]))

		# (options is fight)
			addButton("Драться", "Начать бой", "startfight")
		# (if subby/coward happened)
		elif(npcVariation == "subby"):
			saynn("{npc.He} совершенно к этому не был(а) готов(а). Охранник ахает и падает перед тобой замертво.")

			saynn(RNG.pick([
				"[say=npc]Ой!.. Не делай мне больно! Можешь идти.[/say]",
				"[say=npc]Ладно, ладно, ты победил... Делай что хочешь...[/say]",
				"[say=npc]Эй!.. Ой.. ты победил. И что ты теперь будешь делать?..[/say]",
			]))

			addWonButton()
			# (default)
		else:
			saynn("{npc.He} пошатывается, но быстро восстанавливает равновесие. Охранник явно не в восторге от тебя.")

			saynn(RNG.pick([
				"[say=npc]Ну, я могу преподать тебе пару уроков.[/say]",
				"[say=npc]Посмотрим, хватит ли этого урока для тебя.[/say]",
				"[say=npc]Сопротивление только ухудшит твое положение.[/say]",
			]))

			addButton("Драться", "Начать бой", "startfight")



	if(state == "if_lost"):
		saynn("Ты валишься с ног, не в силах продолжать бой.")

		# (default)
		if(npcVariation != "mean"):
			saynn(RNG.pick([
				"[say=npc]Хм. Думаю, сначала нам стоит немного развлечься.[/say]",
				"[say=npc]Мы сейчас повеселимся, прежде чем я вышвырну тебя из инженерного блока.[/say]",
				"[say=npc]Я вышвырну тебя из инженерного блока. Но сначала...[/say]",
			]))

		# (if mean)
		else:
			saynn(RNG.pick([
				"[say=npc]Ты реально думала, что сможешь победить? Ну и шлюха.[/say]",
				"[say=npc]Тупая сучка. То, что тебя сейчас оттрахают — это меньшая из твоих проблем.[/say]",
			]))

		saynn("Раз уж ты больше не можешь сопротивляться, твой единственный выход — сдаться.")

		# (sex)
		addButton("Получи по полной", "Ну, ты проиграл(а)", "startsexsubby")


	if(state == "if_won"):
		saynn("Ты прижимаешь поверженного инженера к полу. {npc.He}, кажется, особо и не сопротивляется.")

		saynn(RNG.pick([
			"[say=npc]Ну и что теперь?[/say]",
			"[say=npc]Ладно, ты победила. Будь по-твоему.[/say]",
			"[say=npc]Уже собираешься меня оттрахать?[/say]",
		]))

		# (Options are sex or leave them be, Inventory, Struggle)

		# (Need everything to be free to fuck)

		addWonButton()

	if(state == "offer_body"):
		saynn("Ты очень хочешь избежать драки, но и быть вышвырнутым(ой) из инженерного блока тоже не гоже. Поэтому вместо того, чтобы сдаться, ты одариваешь инженера ласковой улыбкой и принимаешь сексуальную позу, демонстрируя свои {pc.masc} изгибы.")

		saynn("[say=pc]Как насчет того, чтобы я предложила тебе кое-что получше? Например, саму себя.[/say]")

		# (if mean)
		if(npcVariation == "mean"):
			saynn("{npc.He} оценивающе осматривает тебя и тянется, чтобы схватить за руку.")

			saynn("[say=npc]Да неужели? Попробуй только сопротивляться — пожалеешь.[/say]")
			
			addButton("Получи по полной", "Дать им жару", "startsexsubby")

		# (if subby)
		elif(npcVariation == "subby"):
			saynn("{npc.He} краснеет, украдкой поглядывая на тебя. Застенчивый инженер опускает {npc.his} голову.")

			saynn("[say=npc]В смысле... можешь взять меня, если хочешь..[/say]")

			saynn("Хм, похоже, этот инженер — та еще подчиняшка.")
			addWonButton()
		else:
			# (if default)

			saynn("{npc.He} разглядывает тебя и делает шаг навстречу.")

			saynn("[say=npc]Хм. Может быть. Я бы не отказалась от хорошего траха.[/say]")

			addButton("Получи по полной", "Дать им жару", "startsexsubby")

		# (Options are sex or sex (dom) if hands untied)


	if(state == "after_sex"):
		saynn("Ты используешь это время, чтобы ускользнуть, пока инженер не вывела тебя из инженерного блока.")

		# (scene ends)
		addButton("Уйти", "Пора идти", "endthescene")

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
	
	if(_action == "intimidate"):
		if(npcVariation == "kind" && RNG.chance(50)):
			setState("intimidate_fail")
			return
		setState("intimidate_success")
		return

	setState(_action)


func _react_scene_end(_tag, _result):
	if(_tag in ["subbysex", "domsex"]):
		setState("after_sex")
	
	if(_tag == "guardfight"):
		processTime(20 * 60)
		var battlestate = _result[0]
		#var wonHow = _result[1]
		
		if(battlestate == "win"):
			setState("if_won")
			addExperienceToPlayer(30)
			if(GM.ES.triggerReact(Trigger.WonCaughtOffLimitsFight, [npcID, CharacterType.Engineer])):
				endScene()
				return
		else:
			if(GM.ES.triggerReact(Trigger.LostCaughtOffLimitsFight, [npcID, CharacterType.Engineer])):
				endScene()
				return
			setState("if_lost")
			addExperienceToPlayer(5)
			
func saveData():
	var data = .saveData()
	
	data["npcID"] = npcID
	data["sawBefore"] = sawBefore
	data["npcVariation"] = npcVariation
	
	return data
	
func loadData(data):
	.loadData(data)
	
	npcID = SAVE.loadVar(data, "npcID", "")
	sawBefore = SAVE.loadVar(data, "sawBefore", false)
	npcVariation = SAVE.loadVar(data, "npcVariation", "")
