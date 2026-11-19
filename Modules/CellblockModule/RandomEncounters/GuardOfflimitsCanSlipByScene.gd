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
		saynn("Осторожно пробираясь через это место, вы замечаете одного из охранников. Вам очень повезло, так как {npc.him} застигнут в удачный момент: {npc.his} стоит к вам спиной, так что можно попытаться проскользнуть мимо незаметно.")
		
		if(sawBefore):
			saynn("Отсюда трудно разобрать, но тебе кажется, что ты уже видел {npc.him} раньше.")
		
			if(npcVariation == "subby"):
				saynn("Ты помнишь, как {npc.him} был"+RNG.pick(["довольно застенчивая", "из нервных типов", "shy", "немного застенчивая", "на тихом фронте"])+".")
			if(npcVariation == "mean"):
				saynn("Ты помнишь, как {npc.him} был"+RNG.pick(["одна из тех стерв", "довольно вредная", "один из тех самых отморозков", "mean", "не того типа"])+".")
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
				saynn("Охранник "+RNG.pick(["ловит твой силуэт {npc.his} взглядом", "слышит твои шаги"])+" и оборачивается, его электрошокер {npc.his} уже высекает искры.")
				
				saynn(RNG.pick([
					"[say=npc]Хм, опять ты. Ты из этих мазохистских сучек?[/say]",
					"[say=npc]Опять ты. Нарушение правил карается переломами костей.[/say]",
					"[say=npc]Смело. И невероятно тупо. Я думал, ты усвоил урок, зэк.[/say]",
					"[say=npc]Ты же знаешь, что я просто так тебя не пропущу.[/say]",
					]))
			else:
				saynn("Охранник "+RNG.pick(["ловит твой силуэт {npc.his} взглядом", "слышит твои шаги"])+" и оборачивается, его электрошокер {npc.his} уже высекает искры. {npc.He} быстро осматривает тебя.")
				
				saynn(RNG.pick([
					"[say=npc]И кто тут у нас? Очередная больная шлюха?[/say]",
					"[say=npc]Ты нарушаешь границы, зэк. Но, полагаю, тебе нравится трахаться с опасностью? Мне тоже.[/say]",
					"[say=npc]Смело. И невероятно тупо.[/say]",
					"[say=npc]Мне никогда не надоедают новые лица. Они так быстро меняются после пары хороших взбучек.[/say]",
					]))
			
			saynn("Похоже, с этим типом остается только драться.")
			
			addButton("Драться", "Начать бой", "startfight")
		elif(npcVariation == "subby"):
			if(sawBefore):
				saynn("Охранник "+RNG.pick(["gasps", "eeks", "пошатывается назад", "jumps"])+" когда {npc.he} замечает тебя. И тогда {npc.he} краснеет.")
				
				saynn("[say=npc]"+RNG.pick([
					"Чего-то хотела?.. Ладно, не буду тебе мешать.",
					"О, привет. Да я так, патрулирую тут...",
					"Эй, заключенная. Как жизнь?",
					"Оу. Тебя вроде как не должно здесь быть. Или должна?..",
					"Может, займемся чем-нибудь?..",
				])+"[/say]")
			else:
				saynn("Охранник "+RNG.pick(["gasps", "eeks", "пошатывается назад", "jumps"])+" когда {npc.he} замечает тебя. Электрошокер чуть не выскальзывает из рук {npc.his}.")
			
				saynn("[say=npc]"+RNG.pick([
					"О! Еще одна заключенная. И что ты со мной сделаешь?..",
					"Тебе здесь не место... Что же нам делать?",
					"А! О, привет...",
					"Не припоминаю тебя... Ты из новеньких?.."
				])+"[/say]")
			
			saynn("Похоже, этот охранник не собирается проламывать тебе череп.")
			
			addWonButton()
		else:
			if(sawBefore):
				saynn("Охранник "+RNG.pick(["вскидывает {npc.his} бровь, глядя на тебя", "разворачивается к тебе лицом", "бросает на тебя строгий взгляд"])+" когда {npc.he} заприметила тебя. Охранник включает {npc.his} электрошокер и внимательно следит за тобой.")
				
				saynn("[say=npc]"+RNG.pick([
					"А, теперь вспомнил. Тебе здесь не положено находиться, зэк.",
					"Эй, ты! Что, жаждешь добавки наказаний?",
					"Тебя здесь быть не должно. Теперь мне придется тебя проучить.",
					"Сдашься добровольно? Так будет не так больно."
				])+"[/say]")
			else:
				saynn("Охранник "+RNG.pick(["вскидывает {npc.his} бровь, глядя на тебя", "разворачивается к тебе лицом", "бросает на тебя строгий взгляд"])+" когда {npc.he} заприметила тебя. Охранник включает {npc.his} электрошокер и внимательно разглядывает незнакомое лицо.")
				
				saynn("[say=npc]"+RNG.pick([
					"Что-то не припоминаю тебя. Но тебе здесь не место, зэк.",
					"Эй! Хочешь наказать себя?",
					"Тебя здесь быть не должно. Теперь мне придется тебя проучить.",
					"Эй! Руки вверх. И без лишних движений."
				])+"[/say]")
			
			saynn("Похоже, теперь просто так развернуться и уйти не получится.")
			
			addButton("Драться", "Начать бой", "startfight")
			addButton("Сдаться", "Позволить им делать с тобой всё, что захотят", "surrender")
	
	if(state == "surrender"):
		saynn("Вместо того чтобы драться, ты просто поднимаешь руки вверх и сдаешься.")
		
		saynn("[say=npc]"+RNG.pick([
			"Хороший выбор. А теперь повеселимся.",
			"Правильный выбор. Готова повеселиться?",
			"Послушная зэчка. А теперь — твоё наказание.",
			"Вот это я люблю. Но за вторжение я тебя всё равно накажу.",
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
			"Ой!",
			"А-а!",
			"А?",
			"Кто...",
			"Что..",
		])+"[/say]")
		
		saynn("К твоему удивлению, {npc.he} почти не сопротивляется. Тебе удается найти наручники и быстро защелкнуть их на {npc.his} руках, заставив их завести их за спину.")
		
		if(sawBefore):
			saynn("[say=npc]"+RNG.pick([
				"А, это ты. Мог бы просто спросить..",
				"О, привет.. а ты с изюминкой.",
				"О, привет..",
			])+"[/say]")
		else:
			saynn("[say=npc]"+RNG.pick([
				"Э-э.. Привет, новенький.",
				"Что-то ты быстро. Хотя, я даже не против.",
				"А ты кто такой?",
				"Ох, извращения...",
			])+"[/say]")
		
		saynn("{npc.He} сильно краснеет; можно просто оставить {npc.him} в таком виде, а можно немного развлечься.")
		
		addButtonWithChecks("Секс!", "Пора их оттрахать", "startsexasdom", [], [ButtonChecks.CanStartSex])
		addButton("Уйти", "Просто уходи, пока тебя не заметили.", "endthescene")
		
	if(state == "cuff_fail"):
		playAnimation(StageScene.Duo, "stand", {npc=npcID})

		saynn("Ты подкрадываешься к охраннику со спины и внезапно хватаешь {npc.him} за шею, пока вторая рука шарит по {npc.his} снаряжению.")
		
		saynn("[say=npc]"+RNG.pick([
			"Какого хера?!",
			"Эй!",
			"Что?!",
			"Уф!",
			"А?!",
		])+"[/say]")
		
		saynn("Но {npc.he} успевает быстро убрать твою руку, прежде чем ткнуть {npc.his} локтем тебе в грудь и развернуться.")
		
		saynn("[say=npc]"+RNG.pick([
			"Ну и хамство.",
			"Большая ошибка.",
			"На меня это не подействует, зэк.",
			"Похоже, тебе пора преподать урок.",
		])+"[/say]")
	
		saynn("Ой. Похоже, теперь придется драться.")
		
		addButton("Драться", "Начать бой", "startfight")
	
	if(state == "cuff_success"):
		playAnimation(StageScene.Duo, "stand", {npc=npcID})
		
		saynn("Ты подкрадываешься к охраннику со спины и внезапно хватаешь {npc.him} за шею, пока вторая рука шарит по {npc.his} снаряжению.")
		
		saynn("[say=npc]"+RNG.pick([
			"Какого хера?!",
			"Эй!",
			"Что?!",
			"Уф!",
			"А?!",
		])+"[/say]")
		
		saynn("{npc.He} пытается сопротивляться, но один меткий тычок {npc.his} в бок успокаивает {npc.him}. Тебе удается найти наручники, которые быстро защелкиваются на руках {npc.his}, заставляя их оказаться за спиной.")
		
		if(sawBefore):
			saynn("[say=npc]"+RNG.pick([
				"Серьезно? Опять ты? Твою мать.",
				"Ох, блядь. Какой у тебя план, зэк?",
				"Сними наручники прямо сейчас, иначе пожалеешь.",
			])+"[/say]")
		else:
			saynn("[say=npc]"+RNG.pick([
				"Ты ещё кто за хуйня? Сними наручники.",
				"Ох, блядь. Какой у тебя план, зэк?",
				"Сними наручники прямо сейчас, иначе пожалеешь.",
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
			"[say=npc]Какой план?[/say]",
			"[say=npc]Не бросай меня так, заключенный.[/say]",
			"[say=npc]И что теперь? Хоть поцелуешь меня?[/say]",
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
				addMessage("Тебе удается залезть в пояс охранника.")
			else:
				addMessage("Тебе удается залезть в пояс охранника, но ничего полезного ты не находишь.")
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
