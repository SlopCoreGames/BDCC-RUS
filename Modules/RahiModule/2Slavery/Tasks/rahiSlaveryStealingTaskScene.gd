extends SceneBase

var chanceEasy = 0.0
var chanceMedium = 0.0
var chanceHard = 0.0
var success = false

func _init():
	sceneID = "rahiSlaveryStealingTaskScene"

func _reactInit():
	var rahiModule = getModule("RahiModule")
	chanceEasy = rahiModule.getSkillSuccessChance("rahiSkillLabor", 60, 95)
	chanceMedium = rahiModule.getSkillSuccessChance("rahiSkillLabor", 10, 75)
	chanceHard = rahiModule.getSkillSuccessChance("rahiSkillLabor", 2, 55)

func _run():
	if(state == ""):
		addCharacter("rahi")
		saynn("Выберите уровень сложности задачи по воровству для Рахи.")

		saynn("Легкий: "+str(Util.roundF(chanceEasy, 1))+"% шанс. Рахи попытается стащить яблоко из теплиц.")

		saynn("Средний: "+str(Util.roundF(chanceMedium, 1))+"% шанс. Рахи попытается украсть что-нибудь из медблока.")

		saynn("Тяжелый: "+str(Util.roundF(chanceHard, 1))+"% шанс. Рахи попытается обнести заключенных на кредиты.")

		addButton("Назад", "Выбрать другое задание", "endthescene")
		addButton("Легкий", "Рахи попытается стащить яблоко из теплиц", "easy_steal")
		addButton("Средний", "Рахи попытается украсть что-нибудь из медблока", "medium_steal")
		addButton("Сложный", "Рахи попытается обнести заключенных на кредиты", "hard_steal")
	if(state == "easy_steal"):
		saynn("Вы приказываете Рахи отправиться в теплицы и украсть для вас яблоко.")

		saynn("Она кивает и выходит из камеры, чтобы выполнить задание.")

		addButton("Продолжить", "Смотреть, что будет дальше", "easy_outcome")
	if(state == "easy_outcome"):
		if (success):
			saynn("Спустя некоторое время Рахи возвращается и приносит вам запретный плод!")

			saynn("[say=rahi]Вот, держи, {rahiMaster}.. Её никто не заметил![/say]")

			saynn("Ты берешь яблоко и протираешь его о её мех, чтобы очистить.")

			saynn("[say=pc]Молодец.[/say]")

		else:
			playAnimation(StageScene.Duo, "stand", {npc="rahi"})
			saynn("Спустя некоторое время Рахи возвращается. Но вместо яблока она тащит на себе целый список средств для связывания.")

			saynn("[say=rahi]Её спалили.. много раз.. Прости, {rahiMaster}, у неё не вышло..[/say]")

			saynn("Что ж, Рахи провалила задание. Ты гадаешь, стоит ли вообще начинать её развязывать.")

		addButton("Продолжить", "Смотреть, что будет дальше", "stop_task")
	if(state == "medium_steal"):
		saynn("Ты приказываешь Рахи прокрасться в хранилище медблока и что-нибудь оттуда стащить.")

		saynn("Она кивает и выходит из камеры, чтобы выполнить задание.")

		addButton("Продолжить", "Смотреть, что будет дальше", "medium_outcome")
	if(state == "medium_outcome"):
		if (success):
			saynn("Спустя некоторое время Рахи возвращается и приносит тебе украденную вещь!")

			saynn("[say=rahi]Вот, держи, {rahiMaster}.. Ни одна медсестра её не заметила![/say]")

			saynn("Ты забираешь принесенное ею и киваешь ей.")

			saynn("[say=pc]Молодец.[/say]")

		else:
			saynn("Спустя некоторое время Рахи возвращается. Но вместо полезной вещи она входит в комнату в смирительной рубашке, и выглядит она.. весьма похотливо.")

			saynn("[say=rahi]Её заметили.. Ей.. что-то вкололи.. Прости, {rahiMaster}, она не справилась..[/say]")

			saynn("Что ж, Рахи провалила задание. Ты задумываешься, стоит ли вообще пытаться её освободить.")

		addButton("Продолжить", "Смотреть, что будет дальше", "stop_task")
	if(state == "hard_steal"):
		saynn("Ты приказываешь Рахи украсть немного кредитов у заключенных.")

		saynn("Она кивает и выходит из камеры, чтобы выполнить задание.")

		addButton("Продолжить", "Смотреть, что будет дальше", "hard_outcome")
	if(state == "hard_outcome"):
		if (success):
			saynn("Спустя некоторое время Рахи возвращается и приносит тебе чип с кредитами!")

			saynn("[say=rahi]Вот, {rahiMaster}.. Они не узнают, что это была она![/say]")

			saynn("Ты хватаешь чип и вставляешь его в свой ошейник, переводя кредиты на свой счет заключенного.")

			saynn("[say=pc]Молодец.[/say]")

		else:
			saynn("Рахи возвращается, но вместо кредитов она выглядит избитой и помятой. Кажется, кто-то написал унизительные вещи прямо на её меху.")

			saynn("[say=rahi]Её поймали на краже.. Она не смогла сбежать..[/say]")

			saynn("Что ж, Рахи провалила задание.")

		addButton("Продолжить", "Смотреть, что будет дальше", "stop_task")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "easy_steal"):
		if(RNG.chance(chanceEasy)):
			success = true
			getModule("RahiModule").advanceSkill("rahiSkillLabor", 10)

	if(_action == "medium_steal"):
		if(RNG.chance(chanceMedium)):
			success = true
			getModule("RahiModule").advanceSkill("rahiSkillLabor")

	if(_action == "hard_steal"):
		if(RNG.chance(chanceHard)):
			success = true
			getModule("RahiModule").advanceSkill("rahiSkillLabor")

	if(_action == "easy_outcome"):
		processTime(30*60)
		if(!success):
			var rahi = getCharacter("rahi")
			rahi.getInventory().equipItem(GlobalRegistry.createItem("blindfold"))
			rahi.getInventory().equipItem(GlobalRegistry.createItem("inmatewristcuffs"))
			rahi.getInventory().equipItem(GlobalRegistry.createItem("inmateanklecuffs"))
			rahi.getInventory().equipItem(GlobalRegistry.createItem("ropeharness"))
			rahi.getInventory().equipItem(GlobalRegistry.createItem("ballgag"))
			rahi.getInventory().equipItem(GlobalRegistry.createItem("bondagemittens"))
		else:
			GM.pc.getInventory().addItem(GlobalRegistry.createItem("appleitem"))
			addMessage("You receive an apple")

	if(_action == "stop_task"):
		getCharacter("rahi").resetEquipment()
		endScene([success])
		return

	if(_action == "medium_outcome"):
		processTime(30*60)
		if(!success):
			var rahi = getCharacter("rahi")
			rahi.forceIntoHeat()
			rahi.getInventory().forceEquipRemoveOther(GlobalRegistry.createItem("LatexStraitjacket"))
		else:
			var possibleItems = [
			["painkillers", "painkillers"],
			["a single pregnancy test", "PregnancyTest"],
			["an energy drink", "EnergyDrink"],
			["a heat pill", "HeatPill"],
			["a tube of lube", "lube"],
			["a single condom", "QualityCondom"],
			["a restraint key", "restraintkey"],
			["a birth control pill", "BirthControlPill"],
			["an anaphrodisiac pill", "AnaphrodisiacPill"],
			["a breeder pill", "BreederPill"],
			]
			var randomItem = RNG.pick(possibleItems)
			GM.pc.getInventory().addItem(GlobalRegistry.createItem(randomItem[1]))
			addMessage("You receive "+str(randomItem[0]))

	if(_action == "hard_outcome"):
		processTime(30*60)
		if(!success):
			var rahi = getCharacter("rahi")
			for _i in range(5):
				var zone = BodyWritingsZone.getRandomZone()
				rahi.addBodywriting(zone, BodyWritings.getRandomWritingIDForZone(zone))
		else:
			var creditAmount = RNG.randi_range(2, 5)
			addMessage("You receive "+str(creditAmount)+" credits!")
			GM.pc.addCredits(creditAmount)

	setState(_action)

func saveData():
	var data = .saveData()

	data["chanceEasy"] = chanceEasy
	data["chanceMedium"] = chanceMedium
	data["chanceHard"] = chanceHard
	data["success"] = success

	return data

func loadData(data):
	.loadData(data)

	chanceEasy = SAVE.loadVar(data, "chanceEasy", 0.0)
	chanceMedium = SAVE.loadVar(data, "chanceMedium", 0.0)
	chanceHard = SAVE.loadVar(data, "chanceHard", 0.0)
	success = SAVE.loadVar(data, "success", false)
