extends "res://Scenes/SceneBase.gd"

var npcID = ""
var sawBefore = false
var npcVariation = ""
var bribeSuccess = false
var subOffered = ""

func _init():
	sceneID = "InmateExposureForcedSexScene"

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
		# (default)
		if(!(npcVariation in ["mean", "kind", "subby"])):
			saynn(RNG.pick([
				"Ты куда-то шла, как вдруг почувствовала, что чья-то рука потянулась к твоей {pc.thick} {pick('ass', 'butt')} и начала бесстыдно ощупывать её! Обернувшись, ты видишь одного из заключенных, который вовсю пялится на твои изгибы.",
				"Чья-то ладонь отвешивает шлепок по твоей {pc.thick} {pick('ass', 'butt')}. Ты оборачиваешься и видишь одного из заключенных с наглой ухмылкой на {npc.his} лице.",
				"Один из заключенных преграждает тебе путь! {npc.He} потирает {npc.his} подбородок, оценивающе разглядывая тебя. Ты пытаешься обойти {npc.him}, но {npc.he} снова встает у тебя на пути.",
				"Один из заключенных вклинивается прямо перед тобой. {npc.He} явно не собирается давать тебе пройти, а {npc.his} голодные глаза уже вовсю {pick('fucking', 'molesting', 'teasing')} тебя.",
			]))

			# (if never met)
			if(!sawBefore):
				saynn("[say=npc]"+RNG.pick([
					"Эй, детка. Мне нужно с кем-нибудь трахнуться, и ты выглядишь чертовски подходящей для этого.",
					"Свежая кровь? Мне нужен кусочек этой жопы.",
					"Думаешь, можно вот так просто разгуливать здесь, новая сучка? Я тебя оттрахаю.",
					"Куда это ты собралась, сучка? Думаешь, я тебя отпущу? Ты практически сама умоляешь, чтобы тебя трахнули.",
					"Прибыли новенькие секс-игрушки? Я не отпущу тебя без хорошего траха.",
				])+"[/say]")

			# (if met before)
			else:
				saynn("[say=npc]"+RNG.pick([
					"Опять ты. Мне нужно с кем-нибудь трахнуться, и ты выглядишь чертовски подходящей для этого.",
					"Мне нужен кусочек этой жопы.",
					"Думаешь, можно вот так просто разгуливать, сучка? Я тебя оттрахаю.",
					"Куда это ты собралась, сучка? Думаешь, я тебя отпущу? Ты практически сама умоляешь, чтобы тебя трахнули.",
					"Я тебя просто так не отпущу, пока не трахну.",
				])+"[/say]")
				
			addButton("Даться траху", "Позволить им делать с тобой всё, что захотят", "startsexsubby")
			addButton("Атаковать", "Показать им, что это была хреновая идея", "attack")
			addButtonWithChecks("Предложить 5 кредитов", "Может, тогда они отъебутся", "offer_5_credits", [], [[ButtonChecks.HasCredits, 5]])
			
		# (kind version)
		if(npcVariation == "kind"):
			if(RNG.chance(50)):
				saynn("Один из заключенных привлекает ваше внимание. Вы смотрите на {npc.him} и понимаете, что {npc.he} не кажется особо угрожающим.")
			else:
				saynn("Заключенный указывает на вас, привлекая внимание. Вы останавливаетесь и наблюдаете, как {npc.him} шагает к вам, а {npc.his} жадными глазами обводит ваши {pc.masc} изгибы.")

			# (if never met)
			if(!sawBefore):
				saynn("[say=npc]"+RNG.pick([
					"Привет, красавица. Что-то меня развезло, а ты выглядишь такой шлюхой. Хочешь трахнуться?",
					"Похоже, ты не против случайного секса. Хочешь трахнуться?",
					"Привет, маленькая шлюшка. Хочешь трахнуться?",
				])+"[/say]")
			
		# (if met before)
			else:
				saynn("[say=npc]"+RNG.pick([
					"Я тебя помню. Я уже в возбуждении, а ты всё такая же шлюха. Хочешь трахнуться?",
					"Похоже, ты не против случайного секса. Хочешь трахнуться?",
					"Хочешь трахнуться?",
				])+"[/say]")
			
			addButton("Согласиться", "Позволить им делать с тобой всё, что захотят", "startsexsubby")
			addButton("Отказаться", "Вам бы не хотелось, чтобы вас трахнули", "decline")
			addButton("Атаковать", "Показать им, что это была хреновая идея", "attack")

		# (mean version)
		if(npcVariation == "mean"):
			saynn(RNG.pick([
				"Один из заключенных хватает тебя за плечо и пытается прижать к полу!",
				"Один из заключенных преграждает вам путь, а затем сбивает с ног!",
				"Заключенный внезапно толкает вас, пытаясь вывернуть руку и прижать к полу.",
			]))

			# (if never saw or saw)
			saynn("[say=npc]"+RNG.pick([
				"Не дергайся, сучка. А то будет только хуже.",
				"Не сопротивляйся, шлюха. Я же знаю, что ты сама этого хочешь.",
				"Ори сколько влезет, шлюха. Всем плевать.",
				"Посмотри на себя. Ты же сама умоляешь, чтобы тебя использовали.",
				"Заткнись и дай мне тебя оттрахать.",
			])+"[/say]")

			saynn("{npc.He} пытается вас оттрахать!")
			
			addButton("Даться траху", "Позволить им делать с тобой всё, что захотят", "startsexsubby")
			addButton("Атаковать", "Показать им, что это была хреновая идея", "attack")
			addButtonWithChecks("Предложить 5 кредитов", "Может, тогда они отъебутся", "offer_5_credits", [], [[ButtonChecks.HasCredits, 5]])

		# (subby version)
		if(npcVariation == "subby"):
			saynn(RNG.pick([
				"Один из заключенных привлекает ваше внимание. {npc.He} подходит к вам, держа {npc.his} за руки за {npc.him} и глядя в пол.",
				"Заключенный подходит к вам и соблазнительно виляет перед вами {npc.his} задом.",
				"Кто-то привлекает ваше внимание. Вы оборачиваетесь и видите {npc.him} — заключенную с видом покорной сабмиссивной сучки.",
			]))

			# (if never saw)
			if(!sawBefore):
				saynn("[say=npc]"+RNG.pick([
					"О, привет.. Выглядишь похотливо. Может, повеселимся?..",
					"Привееет.. Я так возбуждена.. Хочешь трахнуться?",
					"Раньше тебя не видела.. Хочешь секса?",
				])+"[/say]")

			# (if saw before)
			else:
				saynn("[say=npc]"+RNG.pick([
					"О, я тебя помню. Может, повеселимся?..",
					"Опять меня штырит.. Хочешь трахнуться?",
					"Хей.. Хочешь секса?",
				])+"[/say]")

			#addButton("Подчиниться", "Позволить им делать с тобой всё, что захотят", "startsexsubby")
			addButtonWithChecks("Секс!", "Пора их оттрахать!", "startsexasdom", [], [ButtonChecks.CanStartSex])
			addButton("Подчиниться", "Позволить им делать с тобой всё, что захотят", "startsexsubby")
			addButton("Инвентарь", "Посмотреть инвентарь", "openinventory")
			if(GM.pc.getInventory().hasRemovableRestraints()):
				addButton("Сопротивление", "Вырваться из оков", "strugglemenu")
			addButton("Отказаться", "Вам бы не хотелось, чтобы вас трахнули", "decline")
			# (OPTIONS ARE)

			# (if normal = Be fucked, Attack, Offer credits)

			# (if mean = Same but offer credits has a chance to fail)

			# (if kind = Agree, Decline)

			# (if subby = Submit to, Fuck them, Decline. Decline might end up with them offering something?)


	if(state == "attack"):
		# (if normal)
		if(npcVariation != "mean"):
			saynn("Вы наносите удар {npc.him} и отталкиваете его! Заключенный в ответ рычит и готовится к драке.")

			saynn("[say=npc]"+RNG.pick([
				"Ладно, можем поиграть грубо.",
				"Если придется, я возьму тебя силой.",
				"Конечно, я тебя немного отыграю, прежде чем мы трахнемся.",
				"Плохая идея, сучка.",
			])+"[/say]")

		# (if mean)
		else:
			saynn("Вы собрав все силы, отталкиваете {npc.him} от себя. Заключенный рычит и поднимается, готовый к драке.")

			saynn("[say=npc]"+RNG.pick([
				"Огромная ошибка, сучка.",
				"Для тебя это плохо кончится, сучка.",
				"Тебе стоило просто дать мне трахнуть тебя.",
				"Ну и шлюха. Сама виновата, что тебя сейчас оттрахают до беспамятства.",
				"Надеюсь, тебе нравится боль, сучка. Хотя нет, надеюсь, что нет.",
			])+"[/say]")

		addButton("Драться", "Начать бой", "startfight")


	if(state == "if_lost"):
		saynn("Ты валишься с ног, не в силах продолжать бой.")

		# (default)
		if(npcVariation != "mean"):
			saynn("[say=npc]Ты что, думал, всё будет иначе?[/say]")

		# (if mean)
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

		# (Options are sex or leave them be, Inventory, Struggle)

		# (Need everything to be free to fuck)

		addWonButton()

	if(state == "offer_5_credits"):
		# (if success)
		if(bribeSuccess):
			saynn("Вы достаете чип номиналом 5 кредитов и предлагаете его заключенному.")

			saynn("[say=npc]"+RNG.pick([
				"Хм, считай, что тебе повезло.",
				"И так сойдет. Еще увидимся.",
				"Ладно. Найду себе шлюху и посговорчивее.",
			])+"[/say]")

			saynn("{npc.He} выхватывает его и оставляет вас в покое.")

			addButton("Уйти", "Пора идти", "endthescene")
		# (if mean and fails)
		else:
			saynn("Вы фыркаете и немного сопротивляетесь, прежде чем наконец показать заключенному чип с кредитами.")

			saynn("Но {npc.he} отбивает вашу руку и вместо этого заводит её вам за спину.")

			saynn("[say=npc]"+RNG.pick([
				"Думаешь, сможешь меня подкупить? Сучка, тебя всё равно оттрахают.",
				"Прибереги это для врача, сучка. Он тебе понадобится, когда я с тобой закончу.",
			])+"[/say]")

			# (options are get fucked and attack)
			addButton("Даться траху", "Позволить им делать с тобой всё, что захотят", "startsexsubby")
			addButton("Атаковать", "Показать им, что это была хреновая идея", "attack")

	if(state == "decline"):
		if(subOffered == ""):
			saynn("Вы вежливо отказываетесь. Заключенный пожимает плечами.")

			saynn("[say=npc]"+RNG.pick([
				"Ладно, не буду тебя принуждать.",
				"Ну, тогда береги себя.",
				"Тут будь осторожнее.",
			])+"[/say]")

		# (scene ends)
			addButton("Уйти", "Пора идти", "endthescene")

		# (if subby and chance)
		else:
			saynn("Вы вежливо отказываетесь. Заключенный громко вздыхает и шарит по {npc.his} карманам, прежде чем протянуть вам "+subOffered+".")

			saynn("[say=npc]"+RNG.pick([
				"Ну пожалуйста?..",
				"Может, это заставит тебя передумать?..",
				"Я так возбуждена...",
			])+"[/say]")

			# (Options are the same but starting sex will give you a pill or credits)

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
	
	if(_action in ["startsexsubby", "startsexasdom"]):
		if(subOffered == "some pill"):
			var item:ItemBase = GlobalRegistry.createItem(RNG.pick([
				"AnaphrodisiacPill",
				"BirthControlPill",
				"BreederPill",
				"HeatPill",
			]))
			GM.pc.getInventory().addItem(item)
			addMessage("Вы получили "+item.getAStackName())
		if(subOffered == "some credits"):
			var credAmount = RNG.randi_range(2, 5)
			GM.pc.addCredits(credAmount)
			addMessage("Вы получили "+str(credAmount)+" credits")
	
	if(_action == "openinventory"):
		runScene("InventoryScene")
		return
	
	if(_action == "strugglemenu"):
		runScene("StrugglingScene")
		return
	
	if(_action == "offer_5_credits"):
		if(npcVariation == "mean"):
			if(RNG.chance(50)):
				GM.pc.addCredits(-5)
				bribeSuccess = true
			else:
				bribeSuccess = false
		else:
			GM.pc.addCredits(-5)
			bribeSuccess = true

	if(_action == "decline"):
		if(npcVariation == "subby"):
			if(RNG.chance(50)):
				subOffered = RNG.pick(["какая-нибудь таблетка", "какие-нибудь кредиты"])

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
	data["bribeSuccess"] = bribeSuccess
	data["subOffered"] = subOffered
	
	return data
	
func loadData(data):
	.loadData(data)
	
	npcID = SAVE.loadVar(data, "npcID", "")
	sawBefore = SAVE.loadVar(data, "sawBefore", false)
	npcVariation = SAVE.loadVar(data, "npcVariation", "")
	bribeSuccess = SAVE.loadVar(data, "bribeSuccess", false)
	subOffered = SAVE.loadVar(data, "subOffered", "")
