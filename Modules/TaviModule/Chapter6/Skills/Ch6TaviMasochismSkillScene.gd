extends SceneBase

var isCorrupt = false
var isPure = false
var isNormal = false
var isVirgin = false
var painSkill = 0

func _init():
	sceneID = "Ch6TaviMasochismSkillScene"

func _run():
	if(state == ""):
		addCharacter("tavi")
		playAnimation(StageScene.Duo, "stand", {npc="tavi"})
		saynn("Ты говоришь Тави, что хочешь научить её лучше терпеть боль, потому что... это необходимо ей, чтобы дольше сражаться в бою.")

		saynn("Тави кивает и внимательно вас слушает.")

		isCorrupt = getModule("TaviModule").isCorrupt()
		isPure = getModule("TaviModule").isPure()
		isNormal = (!isCorrupt && !isPure)
		isVirgin = getModule("TaviModule").isVirgin()
		painSkill = getModule("TaviModule").getSkillScore("taviSkillMasochism")
		addButton("Вводный урок", "Познакомить Тави с мазохизмом", "intro_lesson")
		if (painSkill > 0):
			addButton("Мини-игра", "Попытаться довести Тави до определённого уровня боли", "start_minigame")
		else:
			addDisabledButton("Мини-игра", "Сначала нужно познакомить Тави с мазохизмом")
		addButton("Отмена", "Вы передумали", "cancel_lesson")
	if(state == "intro_lesson"):
		saynn("Ты решаешь, что пора начать учить Тави быть мазохисткой. Ты стоишь посреди её тускло освещённой камеры и зовёшь её к себе.")

		saynn("[say=pc]Как у тебя с болевым порогом, Тави?[/say]")

		saynn("Уши Тави слегка дёргаются, когда она занимает место перед тобой.")

		saynn("[say=tavi]"+str(taviSpeak("Боль? Я предпочитаю удовольствие...", "Если ты начнешь меня душить, мне станет плевать на боль~.", "Я использую боль себе во благо. Но сама стараюсь её избегать, само собой."))+"[/say]")

		saynn("Хм. Интересный ответ. Но он не особо отвечает на твой вопрос. Лучше просто проверить Тави на деле.")

		saynn("[say=pc]Стой смирно, Тави.[/say]")

		saynn("Ты начинаешь медленно обходить её, ведя пальцами по плечу Тави, чтобы успокоить её. Но в то же время ты высматриваешь подходящий момент, чтобы отвесить ей шлепок.")

		addButton("Шлепнуть Тави", "Слегка шлепнуть её по заднице", "intro_spank")
	if(state == "intro_spank"):
		playAnimation(StageScene.Duo, "stand", {npc="tavi", npcAction="hurt"})
		saynn("Ты не спешишь, просто кружа вокруг кошечки. И хотя твои прикосновения её немного успокаивают, напряжение только растет...")

		saynn("Наконец, ты наносишь первый удар — шлепок по круглой заднице Тави. Он был настолько мягким, что она почти не вздрогнула.")

		saynn("[say=tavi]Ох... Это было так, пустяки![/say]")

		saynn("Но это была лишь разминка. Настоящий шлепок следует секундой позже: ты так сильно хлопаешь её по заднице, что она начинает колыхаться. Звук удара разносится в воздухе, а внезапная жгучая боль заставляет Тави прервать вдох, и её глаза на мгновение расширяются.")

		saynn("[say=tavi]Ай!.. Ай.. ай..[/say]")

		saynn("Она тут же теряет самообладание и начинает тереть свою ушибленную задницу, которая теперь едва заметно светится зеленым... что выглядит даже довольно мило.")

		saynn("[say=pc]Убери руки, Тави.[/say]")

		saynn("Она фыркает и качает головой.")

		saynn("[say=pc]Это было только начало.[/say]")

		saynn("Тави фыркает еще громче и трет задницу, пока боль не начинает утихать.")

		saynn("[say=tavi]Думаю, на этом хватит... пока что...[/say]")

		addButton("Остановиться", "Хватит шлепков", "intro_stop")
		addButton("Легкие шлепки", "Дать пару легких шлепков", "intro_light")
		addButton("Шлепать ощутимо", "Дать еще один крепкий шлепок", "intro_firm")
	if(state == "intro_stop"):
		saynn("Ты соглашаешься и решаешь пока остановиться.")

		saynn("Почему-то кажется, что Тави это не особо помогло... Иногда нужно немного выталкивать себя из зоны комфорта...")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
	if(state == "intro_firm"):
		playAnimation(StageScene.Duo, "stand", {npc="tavi", npcAction="defeat"})
		saynn("Ну, если она не хочет подставлять тебе свою задницу... это её проблемы.")

		saynn("Ты заносишь руку и с силой опускаешь её на её задницу, отвешивая шлепок и одновременно хлопая по лапкам, которыми она её прикрывает.")

		saynn("Тави болезненно вскрикивает и внезапно оседает, её ноги дрожат.")

		saynn("[say=tavi]Аргх!.. Агх.. гх-х..[/say]")

		saynn("Это было... явно чересчур. Хм. Тави шипит на тебя. Не совсем та реакция, которую ожидаешь от мазохистки.")

		saynn("Похоже, нужно найти правильный баланс... ту самую идеальную точку, которая усиливает ощущения, а не притупляет их...")

		saynn("Ты вздыхаешь и помогаешь Тави.")

		saynn("[say=pc]Мой косяк.[/say]")

		saynn("[say=tavi]Все в порядке... Я понимаю, что ты пытаешься сделать... Просто это было... слишком...[/say]")

		saynn("Справедливо. Лучше попробовать позже.")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
	if(state == "intro_light"):
		playAnimation(StageScene.Spanking, "spank", {npc="tavi"})
		saynn("Ты раздумываешь об этом еще немного. Очевидно, чтобы научиться получать удовольствие от боли... эта боль должна быть приятной. Это ведь не соревнование...")

		saynn("[say=pc]Ладно. Мой косяк, Тави. Обещаю, что буду нежным. Но мне нужно, чтобы ты мне доверилась.[/say]")

		saynn("Кошка слегка наклоняет голову, и выражение её мордочки становится более спокойным.")

		saynn("[say=tavi]М-м... Я... я верю тебе.[/say]")

		saynn("Она убирает лапы от задницы и позволяет тебе поставить её на четвереньки.")

		saynn("[say=pc]Спасибо.[/say]")

		saynn("Кошка заметно напрягается, когда ты заносишь руку. Но когда твоя ладонь с мягким, милым шлепком опускается на её задницу, Тави выдыхает.")

		saynn("Ты не останавливаешься на этом, нанося еще несколько таких же мягких шлепков по одетой заднице Тави.")

		saynn("[say=tavi]Можешь... чуть сильнее... если хочешь...[/say]")

		saynn("И вот, опираясь на её реакцию, ты подбираешь силу ударов, шлепая свою питомицу так, чтобы у неё сводило пальцы на лапах, но при этом ей оставалось комфортно.")

		saynn("[say=pc]Хорошая девочка.[/say]")

		saynn("Тави мурлычет. Похоже, на этом стоит закончить первый урок.")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
func taviSpeak(normalSpeak, corruptSpeak, pureSpeak):
	if(isCorrupt):
		return corruptSpeak
	if(isPure):
		return pureSpeak
	return normalSpeak


func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "intro_lesson"):
		processTime(2*60)

	if(_action == "start_minigame"):
		runScene("TaviMasochismScene")
		endScene()
		return

	if(_action == "cancel_lesson"):
		increaseFlag("TaviModule.Ch6Tiredness", -1)
		endScene()
		return

	if(_action == "intro_spank"):
		processTime(2*60)

	if(_action == "intro_light"):
		getModule("TaviModule").advanceSkill("taviSkillMasochism")

	setState(_action)

func saveData():
	var data = .saveData()

	data["isCorrupt"] = isCorrupt
	data["isPure"] = isPure
	data["isNormal"] = isNormal
	data["isVirgin"] = isVirgin
	data["painSkill"] = painSkill

	return data

func loadData(data):
	.loadData(data)

	isCorrupt = SAVE.loadVar(data, "isCorrupt", false)
	isPure = SAVE.loadVar(data, "isPure", false)
	isNormal = SAVE.loadVar(data, "isNormal", false)
	isVirgin = SAVE.loadVar(data, "isVirgin", false)
	painSkill = SAVE.loadVar(data, "painSkill", 0)
