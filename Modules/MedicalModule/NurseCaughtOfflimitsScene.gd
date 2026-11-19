extends "res://Scenes/SceneBase.gd"

var npcID = ""
var sawBefore = false
var npcVariation = ""
var foundIllegalItems = false

func _init():
	sceneID = "NurseCaughtOfflimitsScene"

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
		# (new guard)
		if(!sawBefore):
			if(RNG.chance(50)):
				saynn("Пока ты осторожно пробираешься там, где тебе находиться не положено, внезапный голос заставляет тебя вздрогнуть.")

			# (or)
			else:
				saynn("Ты осторожно крадешься по зоне, закрытой для заключенных. Но, похоже, осторожности не хватило — чей-то громкий голос заставляет тебя обернуться.")

			# (default lines)
			var possibleLines = [
				"[say=npc]Эй, тебе здесь не место.[/say]",
				"[say=npc]Заблудился, пациент?[/say]",
				"[say=npc]Впервые тебя вижу. Есть объяснения?[/say]",
			]

			# (mean or dommy)
			if(npcVariation == "mean"):
				possibleLines = [
					"[say=npc]Ну и какое у тебя оправдание? Хотя похер. Теперь у тебя проблемы.[/say]",
					"[say=npc]Кто-то сегодня решил рискнуть, а? Хочешь объясниться, пока я тебе череп не проломил?[/say]",
					"[say=npc]Вижу бродячего пациента. Твое лицо мне не знакомо, но у тебя большие неприятности.[/say]",
					"[say=npc]Пациенты никогда не учатся, верно? Что ж, значит, будет еще больше отморозков, которых я смогу побить.[/say]",
					"[say=npc]Ну и? Что тут у нас? Сучка забыла, где её конура?[/say]",
				]

			# (kind)
			if(npcVariation == "kind"):
				possibleLines = [
					"[say=npc]О, привет. Ты че тут забыла?[/say]",
					"[say=npc]О, привет. Кажется, раньше тебя здесь не видел.[/say]",
					"[say=npc]Тебе нельзя здесь находиться, пациент. Не глупи~.[/say]",
					"[say=npc]Ого, привет! Кажется, тебе здесь не положено находиться.[/say]",
				]

			# (subby)
			if(npcVariation == "subby"):
				possibleLines = [
					"[say=npc]Охх.. Привет, пациент..[/say]",
					"[say=npc]Oh. Hmm.. Hello?..[/say]",
					"[say=npc]Не уверена, но мне кажется, тебе здесь не место..[/say]",
					"[say=npc]Мне кажется, тебе не стоит здесь быть.. Верно?..[/say]",
				]
				
			saynn(RNG.pick(possibleLines))
		# (old guard)
		else:
			if(RNG.chance(50)):
				saynn("Пока ты осторожно пробираешься там, где тебе находиться не положено, внезапный голос заставляет тебя вздрогнуть. Голос, который ты узнаешь.")

			# (or)
			else:
				saynn("Ты осторожно крадешься по зоне, закрытой для заключенных. Но, похоже, осторожности не хватило — чей-то громкий голос заставляет тебя обернуться. Знакомый голос.")

			# (default lines)
			var possibleLines = [
				"[say=npc]Эй, ты. Мы ведь уже встречались? Так почему ты снова здесь?[/say]",
				"[say=npc]Снова заблудился, пациент?[/say]",
				"[say=npc]О, я тебя помню. Хочешь объясниться?[/say]",
			]

			# (mean or dommy)
			if(npcVariation == "mean"):
				possibleLines = [
					"[say=npc]Ну и какое оправдание на этот раз? Хотя погоди, мне плевать.[/say]",
					"[say=npc]Кто-то снова решил рискнуть, а? Хочешь объясниться? Или мне тебя немного проучить?[/say]",
					"[say=npc]Я помню тебя, пациент. Но у тебя большие неприятности.[/say]",
					"[say=npc]Ты никак не научишься, да? Что ж, значит, у меня будет еще больше отбросов, которых можно побить.[/say]",
					"[say=npc]Ну и? Что тут у нас? Очередная сучка опять забыла свое место?[/say]",
				]

			# (kind)
			if(npcVariation == "kind"):
				possibleLines = [
					"[say=npc]О, привет! О, я тебя знаю! Как поживаешь?[/say]",
					"[say=npc]О, привет. Кажется, я тебя уже видел(а).[/say]",
					"[say=npc]Тебе нельзя здесь находиться, пациент. Не глупи~.[/say]",
					"[say=npc]Ого, привет! Кажется, тебе здесь не положено находиться.[/say]"
				]

			# (subby)
			if(npcVariation == "subby"):
				possibleLines = [
					"[say=npc]Охх.. Привет, пациент..[/say]",
					"[say=npc]О... Хм... Кажется, мы знакомы?..[/say]",
					"[say=npc]Не уверена, но мне кажется, тебе здесь не место..[/say]",
					"[say=npc]Мне кажется, тебе здесь не место... Верно?.. Хотя... точно помню, что видел(а) тебя.[/say]",
				]
				
			saynn(RNG.pick(possibleLines))
			# (end)

		saynn("Ты оборачиваешься и видишь одну из медсестер, судя по {npc.his} униформе.")

		saynn("{npc.He} хватает {npc.his} электрошокер и небрежно приближается к тебе, а {npc.his} глаза вовсю тебя изучают.")

		# (default lines)
#		var possibleLines = [
#			"[say=npc]Gonna submit to the search?[/say]",
#			"[say=npc]Well, I will have to frisk you.[/say]",
#			"[say=npc]I’m gonna search you just in case.[/say]",
#			"[say=npc]Turn around for me so I can pat you down.[/say]",
#			"[say=npc]I need to pat you down.[/say]",
#		]
#
#		if(npcVariation == "mean"):
#		# (mean or dommy)
#			possibleLines = [
#				"[say=npc]Don’t move, bitch. I’m gonna frisk you.[/say]",
#				"[say=npc]Don’t move a muscle while I search you or I will break you.[/say]",
#				"[say=npc]Don’t move, slut. Got to frisk you.[/say]",
#				"[say=npc]Gonna submit to the search or do you like to be forced?[/say]",
#			]
#
#		# (kind)
#		if(npcVariation == "kind"):
#			possibleLines = [
#				"[say=npc]I know it’s a bit rude but the rules say I need to frisk you. So can you?[/say]",
#				"[say=npc]Sorry for being a bit mean but I will have to search you. Okay?[/say]",
#				"[say=npc]I can’t let you go unless I pat you down, just a prison policy.[/say]",
#				"[say=npc]You probably don’t have anything but I kinda have to search you. Is that okay with you?[/say]",
#			]
#
#		# (subby)
#		if(npcVariation == "subby"):
#			possibleLines = [
#				"[say=npc]Um.. Would you let me search you maybe? For anything.. bad.[/say]",
#				"[say=npc]Can you.. turn around for me.. I need to search you..[/say]",
#				"[say=npc]I might need to search you now..[/say]",
#			]
#		saynn(RNG.pick(possibleLines))
		# (Options are Submit, Attack, Offer body)

#		addButton("Подчиниться", "Позволить им обыскать твои вещи", "submit")
		addButton("Атаковать", "Ну, они сами напросились", "attack")
		addButton("Предложить свое тело", "Может, стоит попытаться соблазнить их?", "offer_body")

	if(state == "submit"):
		# (if subby or cowardly there is a change for her to not do anything)

		# (if mean/dommy she might try to fuck you anyways)

		saynn("Ты поворачиваешься и прислоняешься к ближайшей стене, позволяя {npc.him} делать то, что {npc.he} хочет. {npc.Name} заходит тебе за спину и кладет {npc.his} руки на твое тело, выискивая что-нибудь запрещенное.")

		# (if found something)
		if(foundIllegalItems):
			saynn("[say=npc]О, это я заберу себе. Тебе это не положено. И штраф ты тоже получишь![/say]")

		# (else)
		else:
			saynn("[say=npc]Ничего запрещенного у тебя нет. Хорошо. Но за нарушение границ ты всё равно получишь штраф.[/say]")

		saynn("{npc.Name} нажимает на кнопки на {npc.his} планшете, списывая с тебя немного кредитов. И после этого {npc.he} оставляет тебя в покое.")

		saynn("[say=npc]Не нарывай больше на неприятности.[/say]")

		addButton("Уйти", "Пора идти", "endthescene")

	if(state == "submit_mean"):
		saynn("Ты разворачиваешься и прислоняешься к ближайшей стене, позволяя {npc.him} делать всё, что {npc.he} вздумается. {npc.Name} заходит тебе за спину и кладет {npc.his} руки на твое тело, обыскивая в поисках чего-нибудь запрещенного. Ты чувствуешь, что {npc.his} действует довольно... бесцеремонно. {npc.He} практически лапает тебя!")

		# (if found something)
		if(foundIllegalItems):
			saynn("[say=npc]Смотри, что я нашел. Сучка, да у тебя тут контрабанда. Похоже, тебе пора преподать урок.[/say]")

		# (else)
		else:
			saynn("[say=npc]У тебя нихера нет. Но мне всё равно нужно проучить такую шлюху, как ты.[/say]")

		saynn("О, {npc.he} лапает тебя еще сильнее. Тебе нужно что-то предпринять.")

		# (attack or submit)
		addButton("Атаковать", "Заметить это", "attack")
		addButton("Подчиниться", "Позволить им делать с тобой всё, что угодно", "startsexsubby")

	if(state == "submit_subby"):
		saynn("Ты разворачиваешься и прислоняешься к ближайшей стене, позволяя {npc.him} делать всё, что {npc.he} вздумается. Но вместо обыска охранник начинает часто моргать и краснеть.")

		saynn("[say=npc]Э-э.. Вообще-то.. всё нормально.. можешь идти..[/say]")

		saynn("{npc.Name} заикается, а потом просто быстро убегает. Это было даже мило.")

		addButton("Уйти", "Пора идти", "endthescene")

	if(state == "attack"):
		# (if subby, can just auto-win)

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
			saynn("{npc.He} была к такому совершенно не готова. Медсестра ахает и падает перед тобой.")

			saynn(RNG.pick([
				"[say=npc]Ой!.. Не делай мне больно! Можешь идти.[/say]",
				"[say=npc]Ладно, ладно, ты победил... Делай что хочешь...[/say]",
				"[say=npc]Эй!.. Ой.. ты победил. И что ты теперь будешь делать?..[/say]",
			]))

			addWonButton()
			# (default)
		else:
			saynn("{npc.He} отшатывается, но быстро берет себя в руки. Медсестра явно не в восторге от тебя.")

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
			saynn("[say=npc]Нападать на меня было не самой умной идеей, верно?[/say]")

		# (if mean)
		else:
			saynn("[say=npc]Так я и думала, сучка.[/say]")

		#saynn("{npc.He} обыскивает твои вещи и конфискует всё незаконное.")
		saynn("{npc.He} опускается на колени рядом с тобой.")

		saynn("[say=npc]А теперь пришло время немного развлечься с тобой.[/say]")

		saynn("Раз уж ты больше не можешь сопротивляться, твой единственный выход — сдаться.")

		# (sex)
		addButton("Получи по полной", "Ну, ты проиграл(а)", "startsexsubby")


	if(state == "if_won"):
		saynn("Ты прижимаешь побежденную медсестру к полу. {npc.He} особо не сопротивляется.")

		saynn(RNG.pick([
			"[say=npc]Какой план?[/say]",
			"[say=npc]Не бросай меня так, пациент.[/say]",
			"[say=npc]И что теперь? Хоть поцелуешь меня?[/say]",
		]))

		# (Options are sex or leave them be, Inventory, Struggle)

		# (Need everything to be free to fuck)

		addWonButton()

	if(state == "offer_body"):
		saynn("Тебе очень хочется избежать драки. Ты одариваешь медсестру ласковой улыбкой, принимая сексуальную позу и демонстрируя свои {pc.masc} изгибы.")

		saynn("[say=pc]Как насчет того, чтобы я предложила тебе кое-что? Например, саму себя.[/say]")

		# (if mean)
		if(npcVariation == "mean"):
			saynn("{npc.He} оценивающе осматривает тебя и тянется, чтобы схватить за руку.")

			saynn("[say=npc]Да неужели? Попробуй только сопротивляться — пожалеешь.[/say]")
			
			addButton("Получи по полной", "Дать им жару", "startsexsubby")

		# (if subby)
		elif(npcVariation == "subby"):
			saynn("{npc.He} краснеет, украдкой поглядывая на тебя. Застенчивая медсестра опускает {npc.his} голову.")

			saynn("[say=npc]В смысле... можешь взять меня, если хочешь..[/say]")

			saynn("Хм, кажется, эта медсестра довольно субмиссивная.")
			addWonButton()
		else:
			# (if default)

			saynn("{npc.He} разглядывает тебя и делает шаг навстречу.")

			saynn("[say=npc]Хм. Может быть. А теперь не сопротивляйся.[/say]")

			addButton("Получи по полной", "Дать им жару", "startsexsubby")

		# (Options are sex or sex (dom) if hands untied)


	if(state == "after_sex" || state == "after_sex_won"):
		saynn("Когда веселье заканчивается, медсестра просто оставляет тебя в покое.")

		# (scene ends)
		addButton("Уйти", "Пора идти", "endthescene")
		
	if(state == "after_sex"):
		GM.ES.triggerRun(Trigger.AfterSexWithDynamicNPCThatWon, [npcID])
		
	if(state == "after_sex_won"):
		GM.ES.triggerRun(Trigger.AfterSexWithDefeatedDynamicNPC, [npcID])

	if(state == "catchEscapedPC"):
		saynn("Медсестра прижимает тебя к полу.")

		saynn("[say=npc]О, я знаю, кто ты такая. Думала, сможешь сбежать, тестовая сучка?[/say]")

		saynn("{npc.He} натягивает на тебя смирительную рубашку! Ты пытаешься сопротивляться, но уже слишком поздно.")

		saynn("[say=npc]Не так быстро, ты идешь со мной.[/say]")

		saynn("{npc.He} сажает тебя на поводок и ведет к Элизе. Доктор, похоже, не в восторге от тебя.")

		addButton("О нет", "Побег провалился", "oh_no")

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
	
	if(_action == "submit"):
		if(npcVariation == "subby" && RNG.chance(100)):
			setState("submit_subby")
			return
		
		if(npcVariation == "mean"):
			setState("submit_mean")
		else:
			setState("submit")
		GM.pc.addCredits(-5)
		addMessage("У тебя отобрали 5 кредитов")
		
		if(GM.pc.hasIllegalItems()):
			foundIllegalItems = true
			GM.pc.getInventory().removeItemsList(GM.pc.getInventory().getItemsWithTag(ItemTag.Illegal))
			GM.pc.getInventory().removeEquippedItemsList(GM.pc.getInventory().getEquippedItemsWithTag(ItemTag.Illegal))
		
		return

	if(_action == "oh_no"):
		runScene("ElizaCaughtEscapedPC")
		endScene()
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
			if(GM.ES.triggerReact(Trigger.WonCaughtOffLimitsFight, [npcID, CharacterType.Nurse])):
				endScene()
				return
		else:
			if(GM.ES.triggerReact(Trigger.LostCaughtOffLimitsFight, [npcID, CharacterType.Nurse])):
				endScene()
				return
			#setState("if_lost")
			addExperienceToPlayer(5)
			
			if(getModuleFlag("MedicalModule", "Mental_PlayerEscaped", false)):
				setState("catchEscapedPC")
				GM.pc.getInventory().forceEquipStoreOtherUnlessRestraint(GlobalRegistry.createItem("LatexStraitjacket"))
			else:
				setState("if_lost")
			
			#GM.pc.getInventory().removeItemsList(GM.pc.getInventory().getItemsWithTag(ItemTag.Illegal))
			#GM.pc.getInventory().removeEquippedItemsList(GM.pc.getInventory().getEquippedItemsWithTag(ItemTag.Illegal))

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
