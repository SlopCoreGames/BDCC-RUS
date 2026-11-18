extends "res://Scenes/SceneBase.gd"

var npcID = ""
var sawBefore = false
var npcVariation = ""
var foundIllegalItems = false

func _init():
	sceneID = "GuardOfflimitsCanSlipByScene"

func _initScene(_args = []):
	npcID = _args[0]
	var npc = GlobalRegistry.getCharacter(npcID)
	
	if(npc.getFlag(CharacterFlag.Introduced)):
		sawBefore = true
	#else:
		#npc.setFlag(CharacterFlag.Introduced, true)
	
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
		playAnimation(StageScene.Duo, "stand", {npc=npcID, flipNPC=true, npcAction="stand", further=true})

	if(state == ""):
		saynn("While carefully stepping through the area you spot one of the guards. You caught {npc.him} at a very good moment because {npc.his} back is turned away so you can try to just sneak past.")
		
		if(sawBefore):
			saynn("Отсюда трудно разобрать, но тебе кажется, что ты уже видел {npc.him} раньше.")
		
			if(npcVariation == "subby"):
				saynn("Ты помнишь, как {npc.him} был"+RNG.pick(["quite shy", "of the nervous type", "shy", "on the shy side", "on the quiet side"])+".")
			if(npcVariation == "mean"):
				saynn("Ты помнишь, как {npc.him} был"+RNG.pick(["one of the mean ones", "quite mean", "one of the rough ones", "mean", "not of the kind type"])+".")
		else:
			saynn("Вы не помните, чтобы встречали {npc.him} раньше.")
			
		saynn("Ты стараешься не шуметь, обдумывая свои варианты.")
		
		addButton("Противостояние", "Привлечь их внимание", "confront")
		addButton("Проскользнуть мимо", "Шанс успеха:"+str(Util.roundF(getSlipByChance(), 1))+"%. Постарайся их избежать", "sneak_past")

	if(state in ["confront", "spotted", "spottedstealing"]):
		playAnimation(StageScene.Duo, "stand", {npc=npcID})

		if(state == "confront"):
			saynn("Ты решаешь не прятаться в тенях, а открыто противостоять охраннику. Ты делаешь шаг к {npc.him} и привлекаешь {npc.his} внимание.")
		elif(state == "spotted"):
			saynn("Ты пытаешься проскользнуть мимо охранника незаметно, но терпишь неудачу!")
		elif(state == "spottedstealing"):
			saynn("Ты пытаешься обнести охранника, но у тебя ничего не выходит!")

		if(npcVariation == "mean"):
			if(sawBefore):
				saynn("Охранник "+RNG.pick(["catches your silhouette with {npc.his} gaze", "hears your steps"])+" и оборачивается, его электрошокер {npc.his} уже высекает искры.")
				
				saynn(RNG.pick([
					"[say=npc]Huh, you again. Are you one of those masochistic bitches?[/say]",
					"[say=npc]It's you again. Breaking of rules is punished with breaking of bones.[/say]",
					"[say=npc]Brave. And incredibly stupid. I thought you learned your lesson, inmate.[/say]",
					"[say=npc]You know I'm not just gonna let you through.[/say]",
					]))
			else:
				saynn("Охранник "+RNG.pick(["catches your silhouette with {npc.his} gaze", "hears your steps"])+" и оборачивается, его электрошокер {npc.his} уже высекает искры. {npc.He} быстро осматривает тебя.")
				
				saynn(RNG.pick([
					"[say=npc]Who do we have here? More painsluts?[/say]",
					"[say=npc]You're trespassing, inmate. But I guess you like fucking around? Me too.[/say]",
					"[say=npc]Brave. And incredibly stupid.[/say]",
					"[say=npc]I'm never tired of fresh faces. They change so fast after a few beatings.[/say]",
					]))
			
			saynn("Похоже, с этим типом остается только драться.")
			
			addButton("Драться", "Начать бой", "startfight")
		elif(npcVariation == "subby"):
			if(sawBefore):
				saynn("Охранник "+RNG.pick(["gasps", "eeks", "staggers back", "jumps"])+" когда {npc.he} замечает тебя. И тогда {npc.he} краснеет.")
				
				saynn("[say=npc]"+RNG.pick([
					"You wanted something?.. I'm not gonna stop you.",
					"Oh, hi. I'm just patrolling here..",
					"Hey there, inmate. How are you doing?",
					"Oh. You're not supposed to be here. I think? Maybe you are..",
					"Do you wanna do something with me?..",
				])+"[/say]")
			else:
				saynn("Охранник "+RNG.pick(["gasps", "eeks", "staggers back", "jumps"])+" когда {npc.he} замечает тебя. Электрошокер чуть не выскальзывает из рук {npc.his}.")
			
				saynn("[say=npc]"+RNG.pick([
					"Oh! Another inmate. What are you gonna do with me?..",
					"You're not supposed to be here.. What should we do?",
					"Ah! Hey there..",
					"Don't remember you.. Are you one of the new ones?.."
				])+"[/say]")
			
			saynn("Похоже, этот охранник не собирается проламывать тебе череп.")
			
			addWonButton()
		else:
			if(sawBefore):
				saynn("Охранник "+RNG.pick(["raises {npc.his} brow at you", "turns around to face you", "gives you a strict look"])+" когда {npc.he} заприметила тебя. Охранник включает {npc.his} электрошокер и внимательно следит за тобой.")
				
				saynn("[say=npc]"+RNG.pick([
					"I remember you. You're not allowed to be here, inmate.",
					"Hey, you! Craving for more punishments?",
					"You're not supposed to be here. Now I will have to punish you.",
					"Gonna surrender? Not as painful for you that way."
				])+"[/say]")
			else:
				saynn("Охранник "+RNG.pick(["raises {npc.his} brow at you", "turns around to face you", "gives you a strict look"])+" когда {npc.he} заприметила тебя. Охранник включает {npc.his} электрошокер и внимательно разглядывает незнакомое лицо.")
				
				saynn("[say=npc]"+RNG.pick([
					"Don't recall you. But you're not allowed to be here, inmate.",
					"Hey! Looking for a punishment?",
					"You're not supposed to be here. Now I will have to punish you.",
					"Hey! Hands up. No funny movements."
				])+"[/say]")
			
			saynn("Похоже, теперь просто так развернуться и уйти не получится.")
			
			addButton("Драться", "Начать бой", "startfight")
			addButton("Сдаться", "Позволить им делать с тобой всё, что захотят", "surrender")
	
	if(state == "surrender"):
		saynn("Вместо того чтобы драться, ты просто поднимаешь руки вверх и сдаешься.")
		
		saynn("[say=npc]"+RNG.pick([
			"Good choice. Now we're gonna have some fun.",
			"That was the correct choice. Ready to have some fun?",
			"Good inmate. Now for your punishment.",
			"That's what I wanna see. I will still punish you for trespassing.",
		])+"[/say]")
		
		saynn("Ты полностью во власти {npc.his}.")
		
		addButton("Подчиниться", "Позволить им делать с тобой всё, что захотят", "startsexsubby")
			
	if(state == "after_sex" || state == "after_sex_won"):
		saynn("Когда веселое время заканчивается, охранник просто оставляет тебя в покое.")

		# (scene ends)
		addButton("Уйти", "Пора идти", "endthescene")
		
	if(state == "after_sex"):
		GM.ES.triggerRun(Trigger.AfterSexWithDynamicNPCThatWon, [npcID])
		
	if(state == "after_sex_won"):
		GM.ES.triggerRun(Trigger.AfterSexWithDefeatedDynamicNPC, [npcID])

	if(state == "sneak_past"):
		saynn("Тебе удалось проскользнуть мимо охранника так, что {npc.him} ничего не заметила!")
		
		addButton("Уйти", "Пора идти", "endthescene")

	if(state == "sneak_past_canSteal"):
		saynn("Тебе удалось проскользнуть мимо охранника!")
		
		saynn("Но прямо перед выходом твой взгляд падает на полезные припасы, которые можно стащить с {npc.his} пояса.")

		saynn("Впрочем, это может быть рискованно.")

		addButtonWithChecks("Украсть", "Шанс: 50%. Попытаться что-нибудь стащить у охранника", "trysteal", [], [ButtonChecks.NotArmsRestrained, ButtonChecks.NotHandsBlocked])
		addButton("Просто уйти", "Пора идти", "endthescene")
	
	if(state == "sneak_past_canAttack"):
		saynn("Тебе удалось проскользнуть мимо охранника!")
		
		saynn("Но охранник всё ещё стоит на очень удобном месте. Ты думаешь, что сможешь схватить {npc.him} и сковать его/её с помощью {npc.his} собственных наручников.")

		saynn("Впрочем, это довольно рискованно.")

		addButtonWithChecks("Атаковать", "Шанс: 70%. Попытаться обездвижить их", "trycuff", [], [ButtonChecks.NotArmsRestrained, ButtonChecks.NotHandsBlocked])
		addButton("Просто уйти", "Пора идти", "endthescene")
	
	if(state == "cuff_subby"):
		playAnimation(StageScene.Duo, "stand", {npc=npcID})
		
		saynn("Ты подкрадываешься к охраннику со спины и внезапно хватаешь {npc.him} за шею, пока вторая рука шарит по {npc.his} снаряжению.")
		
		saynn("[say=npc]"+RNG.pick([
			"Eek!",
			"AH!",
			"Huh?",
			"Who..",
			"Wha..",
		])+"[/say]")
		
		saynn("К твоему удивлению, {npc.he} почти не сопротивляется. Тебе удается найти наручники и быстро защелкнуть их на {npc.his} руках, заставив их завести их за спину.")
		
		if(sawBefore):
			saynn("[say=npc]"+RNG.pick([
				"Oh, it's you. You could have just asked..",
				"Oh, hi.. kinky.",
				"Oh, hey there..",
			])+"[/say]")
		else:
			saynn("[say=npc]"+RNG.pick([
				"Uh.. Hi there, new face.",
				"That's a bit fast, isn't it? I almost don't mind though.",
				"Who are you now?",
				"Kinky..",
			])+"[/say]")
		
		saynn("{npc.He} сильно краснеет; можно просто оставить {npc.him} в таком виде, а можно немного развлечься.")
		
		addButtonWithChecks("Секс!", "Пора их оттрахать", "startsexasdom", [], [ButtonChecks.CanStartSex])
		addButton("Уйти", "Просто уходи, пока тебя не заметили.", "endthescene")
		
	if(state == "cuff_fail"):
		playAnimation(StageScene.Duo, "stand", {npc=npcID})

		saynn("Ты подкрадываешься к охраннику со спины и внезапно хватаешь {npc.him} за шею, пока вторая рука шарит по {npc.his} снаряжению.")
		
		saynn("[say=npc]"+RNG.pick([
			"The fuck?!",
			"Hey!",
			"What?!",
			"Ugh!",
			"Huh!?",
		])+"[/say]")
		
		saynn("Но {npc.he} успевает быстро убрать твою руку, прежде чем ткнуть {npc.his} локтем тебе в грудь и развернуться.")
		
		saynn("[say=npc]"+RNG.pick([
			"Now that was rude.",
			"Big mistake.",
			"That won't work on me, inmate.",
			"Seems like you need to be taught a lesson.",
		])+"[/say]")
	
		saynn("Ой. Похоже, теперь придется драться.")
		
		addButton("Драться", "Начать бой", "startfight")
	
	if(state == "cuff_success"):
		playAnimation(StageScene.Duo, "stand", {npc=npcID})
		
		saynn("Ты подкрадываешься к охраннику со спины и внезапно хватаешь {npc.him} за шею, пока вторая рука шарит по {npc.his} снаряжению.")
		
		saynn("[say=npc]"+RNG.pick([
			"The fuck?!",
			"Hey!",
			"What?!",
			"Ugh!",
			"Huh!?",
		])+"[/say]")
		
		saynn("{npc.He} пытается сопротивляться, но один меткий тычок {npc.his} в бок успокаивает {npc.him}. Тебе удается найти наручники, которые быстро защелкиваются на руках {npc.his}, заставляя их оказаться за спиной.")
		
		if(sawBefore):
			saynn("[say=npc]"+RNG.pick([
				"Really? It's you? Fuck me.",
				"Oh fuck. What's your plan, inmate?",
				"Uncuff me right now or you will regret it.",
			])+"[/say]")
		else:
			saynn("[say=npc]"+RNG.pick([
				"Who the fuck are you? Uncuff me.",
				"Oh fuck. What's your plan, inmate?",
				"Uncuff me right now or you will regret it.",
			])+"[/say]")
		
		saynn("{npc.He} всё еще сильно сопротивляется. Можно просто оставить {npc.him} как есть, а можно немного развлечься.")
		
		addButtonWithChecks("Секс!", "Пора их оттрахать", "startsexasdom", [], [ButtonChecks.CanStartSex])
		addButton("Уйти", "Просто уходи, пока тебя не заметили.", "endthescene")
	
	if(state == "if_lost"):
		saynn("Ты валишься с ног, не в силах продолжать бой.")

		# (default)
		if(npcVariation != "mean"):
			saynn("[say=npc]Нападать на охранника было не самой умной идеей, а?[/say]")

		# (if mean)
		else:
			saynn("[say=npc]Так я и думала, сучка.[/say]")

		saynn("{npc.He} приседает рядом и смотрит на тебя.")

		saynn("[say=npc]А теперь пришло время немного развлечься с тобой.[/say]")

		saynn("Раз уж ты больше не можешь сопротивляться, твой единственный выход — сдаться.")

		# (sex)
		addButton("Получи по полной", "Ну, ты проиграл(а)", "startsexsubby")


	if(state == "if_won"):
		saynn("Ты прижимаешь поверженного охранника к полу. {npc.He} вроде как не особо сопротивляется.")

		saynn(RNG.pick([
			"[say=npc]What’s your plan?[/say]",
			"[say=npc]Don’t leave me like this, inmate.[/say]",
			"[say=npc]What now? Gonna kiss me at least?[/say]",
		]))

		addWonButton()
		
func addWonButton(sextext = "Sex!", sexdesc = "Time to fuck them!"):
	addButton("Уйти", "Просто уходи, пока тебя не заметили.", "endthescene")
	addButtonWithChecks(sextext, sexdesc, "startsexasdom", [], [ButtonChecks.CanStartSex])
	addButton("Подчиниться", "Позволить им делать с тобой всё, что захотят", "startsexsubby")
	addButton("Инвентарь", "Посмотреть инвентарь", "openinventory")
	if(GM.pc.getInventory().hasRemovableRestraints()):
		addButton("Сопротивление", "Вырваться из оков", "strugglemenu")
	GM.ES.triggerRun(Trigger.DefeatedDynamicNPC, [npcID])

func _react(_action: String, _args):
	if(_action in ["confront", "startfight"]):
		getCharacter(npcID).setFlag(CharacterFlag.Introduced, true)

	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "trysteal"):
		if(RNG.chance(50)):
			setState("spottedstealing")
			getCharacter(npcID).setFlag(CharacterFlag.Introduced, true)
		else:
			var lootTableClass = preload("res://Inventory/LootTable/GuardLoot.gd")
			var lootTable = lootTableClass.new()
			
			var loot = lootTable.generateAndCreateItems()
			
			if(loot.has("items") && loot["items"].size() > 0):
				runScene("LootingScene", [loot])
				addMessage("You manage to get into the guard's belt")
			else:
				addMessage("You manage to get into the guard's belt but didn't find anything useful")
			endScene()
		return

	if(_action == "sneak_past"):
		if(!RNG.chance(getSlipByChance())):
			setState("spotted")
		else:
			getCharacter(npcID).setFlag(CharacterFlag.Introduced, true)
			if(RNG.chance(33)):
				setState("sneak_past")
			elif(RNG.chance(33)):
				setState("sneak_past_canSteal")
			else:
				setState("sneak_past_canAttack")
		return

	if(_action == "trycuff"):
		getCharacter(npcID).setFlag(CharacterFlag.Introduced, true)
		if(npcVariation == "subby"):
			setState("cuff_subby")
			getCharacter(npcID).getInventory().equipItem(GlobalRegistry.createItem("inmatewristcuffs"))
			return
		
		if(RNG.chance(70)):
			setState("cuff_success")
			getCharacter(npcID).getInventory().equipItem(GlobalRegistry.createItem("inmatewristcuffs"))
			return

		setState("cuff_fail")
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
			if(GM.ES.triggerReact(Trigger.WonCaughtOffLimitsFight, [npcID, CharacterType.Guard])):
				endScene()
				return
		else:
			if(GM.ES.triggerReact(Trigger.LostCaughtOffLimitsFight, [npcID, CharacterType.Guard])):
				endScene()
				return
			setState("if_lost")
			addExperienceToPlayer(5)
			
func getSlipByChance():
	var baseChance = 60.0
	
	if(GM.pc.hasBoundLegs()):
		baseChance *= 0.6
	
	if(GM.pc.isBlindfolded()):
		baseChance *= 0.6

	if(GM.pc.hasBoundArms()):
		baseChance *= 0.8
	
	return max(5.0, baseChance)

func saveData():
	var data = .saveData()
	
	data["npcID"] = npcID
	data["sawBefore"] = sawBefore
	data["npcVariation"] = npcVariation
	data["foundIllegalItems"] = foundIllegalItems
	
	return data
	
func loadData(data):
	.loadData(data)
	
	npcID = SAVE.loadVar(data, "npcID", "")
	sawBefore = SAVE.loadVar(data, "sawBefore", false)
	npcVariation = SAVE.loadVar(data, "npcVariation", "")
	foundIllegalItems = SAVE.loadVar(data, "foundIllegalItems", false)
