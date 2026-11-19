extends "res://Scenes/SceneBase.gd"

var npcID = ""
var sawBefore = false
var npcVariation = ""
var foundIllegalItems = false

func _init():
	sceneID = "GuardCaughtOfflimitsScene"

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
				"[say=npc]Заблудился, зэк?[/say]",
				"[say=npc]Впервые тебя вижу. Есть объяснения?[/say]",
			]

			# (mean or dommy)
			if(npcVariation == "mean"):
				possibleLines = [
					"[say=npc]Ну и какое у тебя оправдание? Хотя похер. Теперь у тебя проблемы.[/say]",
					"[say=npc]Кто-то сегодня решил рискнуть, а? Хочешь объясниться, пока я тебе череп не проломил?[/say]",
					"[say=npc]Вижу бродячего зэка. Лицо твое не припомню, но проблем у тебя теперь выше крыши.[/say]",
					"[say=npc]Заключенные вечно ничему не учатся. Что ж, значит, будет еще больше отбросов, которых можно побить.[/say]",
					"[say=npc]Ну и? Что тут у нас? Сучка забыла, где её конура?[/say]",
				]

			# (kind)
			if(npcVariation == "kind"):
				possibleLines = [
					"[say=npc]О, привет. Ты че тут забыла?[/say]",
					"[say=npc]О, привет. Кажется, раньше тебя здесь не видел.[/say]",
					"[say=npc]Тебе здесь не место, заключенный. Не глупи~.[/say]",
					"[say=npc]Ого, привет! Кажется, тебе здесь не положено находиться.[/say]",
				]

			# (subby)
			if(npcVariation == "subby"):
				possibleLines = [
					"[say=npc]Охх.. Приветик, заключенный..[/say]",
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
				"[say=npc]Опять заблудился, заключенный?[/say]",
				"[say=npc]О, я тебя помню. Хочешь объясниться?[/say]",
			]

			# (mean or dommy)
			if(npcVariation == "mean"):
				possibleLines = [
					"[say=npc]Ну и какое оправдание на этот раз? Хотя погоди, мне плевать.[/say]",
					"[say=npc]Кто-то снова решил рискнуть, а? Хочешь объясниться? Или мне тебя немного проучить?[/say]",
					"[say=npc]Я тебя помню, зэк. Но у тебя серьезные неприятности.[/say]",
					"[say=npc]Ты никак не научишься, да? Что ж, значит, у меня будет еще больше отбросов, которых можно побить.[/say]",
					"[say=npc]Ну и? Что тут у нас? Очередная сучка опять забыла свое место?[/say]",
				]

			# (kind)
			if(npcVariation == "kind"):
				possibleLines = [
					"[say=npc]О, привет! О, я тебя знаю! Как поживаешь?[/say]",
					"[say=npc]О, привет. Кажется, я тебя уже видел(а).[/say]",
					"[say=npc]Тебе здесь не место, заключенный. Не глупи~.[/say]",
					"[say=npc]Ого, привет! Кажется, тебе здесь не положено находиться.[/say]"
				]

			# (subby)
			if(npcVariation == "subby"):
				possibleLines = [
					"[say=npc]Охх.. Приветик, заключенный..[/say]",
					"[say=npc]О... Хм... Кажется, мы знакомы?..[/say]",
					"[say=npc]Не уверена, но мне кажется, тебе здесь не место..[/say]",
					"[say=npc]Мне кажется, тебе здесь не место... Верно?.. Хотя... точно помню, что видел(а) тебя.[/say]",
				]
				
			saynn(RNG.pick(possibleLines))
			# (end)

		saynn("Ты оборачиваешься и видишь одного из охранников, судя по {npc.his} броне.")

		saynn("{npc.He} хватает {npc.his} электрошокер и небрежно приближается к тебе, а {npc.his} глаза вовсю тебя изучают.")

		# (default lines)
		var possibleLines = [
			"[say=npc]Будешь подчиняться и пойдешь на обыск?[/say]",
			"[say=npc]Что ж, придется тебя прощупать.[/say]",
			"[say=npc]На всякий случай обыщу тебя.[/say]",
			"[say=npc]Развернись, чтобы я мог тебя обыскать.[/say]",
			"[say=npc]Мне нужно тебя обыскать.[/say]",
		]

		if(npcVariation == "mean"):
		# (mean or dommy)
			possibleLines = [
				"[say=npc]Не дергайся, сучка. Сейчас буду тебя прощупывать.[/say]",
				"[say=npc]Не смей шелохнуться, пока я тебя ищу, иначе я тебя сломаю.[/say]",
				"[say=npc]Не двигайся, шлюха. Надо тебя обыскать.[/say]",
				"[say=npc]Будешь покорно подставишься под обыск или любишь, когда тебя заставляют силой?[/say]",
			]

		# (kind)
		if(npcVariation == "kind"):
			possibleLines = [
				"[say=npc]Знаю, это немного грубо, но по правилам я должен тебя обыскать. Так что, готова?[/say]",
				"[say=npc]Прости, что немного грубо, но мне придется тебя обыскать. Идет?[/say]",
				"[say=npc]Я не могу тебя отпустить, пока не проведу обыск — просто тюремный устав.[/say]",
				"[say=npc]У тебя, скорее всего, ничего нет, но мне всё равно нужно тебя обыскать. Ты не против?[/say]",
			]

		# (subby)
		if(npcVariation == "subby"):
			possibleLines = [
				"[say=npc]Эм.. Может, позволишь мне тебя обыскать? На случай, если у тебя есть что-то.. запрещенное.[/say]",
				"[say=npc]Можешь.. повернуться ко мне.. Мне нужно тебя обыскать..[/say]",
				"[say=npc]Похоже, мне придется обыскать тебя прямо сейчас..[/say]",
			]
		saynn(RNG.pick(possibleLines))
		# (Options are Submit, Attack, Offer body)

		addButton("Искать", "Позволить им обыскать твои вещи", "submit")
		addButton("Атаковать", "Ну, они сами напросились", "attack")
		addButton("Предложить свое тело", "Может, стоит попытаться соблазнить их?", "offer_body")

	if(state == "submit"):
		playAnimation(StageScene.SexStanding, "tease", {
			pc=npcID,npc="pc",
			bodyState={},
			npcBodyState={},
		})
		
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
		playAnimation(StageScene.SexStanding, "tease", {
			pc=npcID,npc="pc",
			bodyState={},
			npcBodyState={},
		})
		
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
			saynn("[say=npc]Нападать на охранника было не самой умной идеей, а?[/say]")

		# (if mean)
		else:
			saynn("[say=npc]Так я и думала, сучка.[/say]")

		saynn("{npc.He} обыскивает твои вещи и конфискует всё незаконное.")

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

		# (Options are sex or leave them be, Inventory, Struggle)

		# (Need everything to be free to fuck)

		addWonButton()

	if(state == "offer_body"):
		saynn("Ты очень хочешь избежать драки, но и обыскиваться тебе не в радость. Поэтому вместо того, чтобы подчиниться, ты одариваешь охранника ласковой улыбкой и принимаешь сексуальную позу, демонстрируя свои {pc.masc} изгибы.")

		saynn("[say=pc]Как насчет того, чтобы я предложила тебе кое-что получше? Например, саму себя.[/say]")

		# (if mean)
		if(npcVariation == "mean"):
			saynn("{npc.He} оценивающе осматривает тебя и тянется, чтобы схватить за руку.")

			saynn("[say=npc]Да неужели? Попробуй только сопротивляться — пожалеешь.[/say]")
			
			addButton("Получи по полной", "Дать им жару", "startsexsubby")

		# (if subby)
		elif(npcVariation == "subby"):
			saynn("{npc.He} краснеет, украдкой поглядывая на тебя. Застенчивый охранник опускает {npc.his} голову.")

			saynn("[say=npc]В смысле... можешь взять меня, если хочешь..[/say]")

			saynn("Хм, кажется, этот охранник довольно покорный.")
			addWonButton()
		else:
			# (if default)

			saynn("{npc.He} разглядывает тебя и делает шаг навстречу.")

			saynn("[say=npc]Хм. Может быть. А теперь не сопротивляйся.[/say]")

			addButton("Получи по полной", "Дать им жару", "startsexsubby")

		# (Options are sex or sex (dom) if hands untied)


	if(state == "after_sex" || state == "after_sex_won"):
		saynn("Когда веселое время заканчивается, охранник просто оставляет тебя в покое.")

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
			
			GM.pc.getInventory().removeItemsList(GM.pc.getInventory().getItemsWithTag(ItemTag.Illegal))
			GM.pc.getInventory().removeEquippedItemsList(GM.pc.getInventory().getEquippedItemsWithTag(ItemTag.Illegal))

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
