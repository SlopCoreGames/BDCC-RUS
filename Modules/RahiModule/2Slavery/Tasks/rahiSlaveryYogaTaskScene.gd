extends SceneBase

var chanceEasy = 0.0
var chanceMedium = 0.0
var chanceHard = 0.0
var success = false

func _init():
	sceneID = "rahiSlaveryYogaTaskScene"

func _reactInit():
	var rahiModule = getModule("RahiModule")
	chanceEasy = rahiModule.getSkillSuccessChance("rahiSkillExhibit", 50, 95)
	chanceMedium = rahiModule.getSkillSuccessChance("rahiSkillExhibit", 30, 75)
	chanceHard = rahiModule.getSkillSuccessChance("rahiSkillExhibit", 2, 55)

func _run():
	if(state == ""):
		addCharacter("rahi")
		saynn("Выберите уровень сложности йоги для Рахи.")

		saynn("Легкий: "+str(Util.roundF(chanceEasy, 1))+"% шанс. Рахи делает простые асаны")

		saynn("Средний: "+str(Util.roundF(chanceMedium, 1))+"% шанс. Рахи занимается йогой обнаженной")

		saynn("Тяжелый: "+str(Util.roundF(chanceHard, 1))+"% шанс. Рахи занимается йогой обнаженной и с игрушками")

		addButton("Назад", "Выбрать другое задание", "endthescene")
		addButton("Легкий", "Рахи делает простые асаны", "easy_task")
		addButton("Средний", "Рахи занимается йогой обнаженной", "medium_task")
		addButton("Сложный", "Рахи занимается йогой обнаженной и с игрушками", "hard_task")
	if(state == "easy_task"):
		playAnimation(StageScene.Solo, "struggle", {pc="rahi"})
		saynn("Вы просите Рахи сделать несколько упражнений йоги для расслабления. Она соглашается попробовать.")

		saynn("Рахи начинает свою йогу с простых растяжек: она высоко тянется вверх, а затем наклоняется, чтобы коснуться пальцев ног. Она старается сосредоточиться на дыхании.")

		addButton("Продолжить", "Смотреть, что будет дальше", "easy_outcome")
	if(state == "easy_outcome"):
		playAnimation(StageScene.Yoga, "catcow", {pc="rahi"})
		saynn("После простых растяжек Рахи встает на четвереньки и начинает делать упражнение «кошка-корова», выгибая спину, как кошка, а затем округляя её, как корова. Довольно мило и очень подходит такой кошечке, как Рахи.")

		if (success):
			saynn("Спустя некоторое время Рахи завершает всю последовательность упражнений, чувствуя себя более расслабленной и уверенной.")

			saynn("Рахи справилась!")

		else:
			saynn("К несчастью, Рахи замечает твой пристальный взгляд и начинает краснеть. От смущения кошечка ставит лапку не туда и валится с ног.")

			saynn("Рахи провалила задание.")

			saynn("[say=rahi]{rahiFP('I', 'She')} даже с простейшими не справилась... жаль...[/say]")

		addButton("Продолжить", "Смотреть, что будет дальше", "stop_task")
	if(state == "medium_task"):
		playAnimation(StageScene.Solo, "struggle", {pc="rahi", bodyState={naked=true}})
		saynn("Ты предлагаешь Рахи сделать несколько поз йоги для расслабления. Она соглашается попробовать. Подвох в том, что делать это она должна полностью обнаженной.")

		saynn("Кошечка снимает одежду и протягивает её тебе.")

		saynn("Рахи начинает йогу с простых растяжек: она тянется высоко вверх, а затем наклоняется, чтобы коснуться пальцев ног. Пока она это делает, ты ходишь вокруг неё, разглядывая её тело во всех этих соблазнительных позах. Она старается не думать о том, что ты пялишься на её интимные места, и вместо этого концентрируется на дыхании.")

		addButton("Продолжить", "Смотреть, что будет дальше", "medium_outcome")
	if(state == "medium_outcome"):
		playAnimation(StageScene.Yoga, "camel", {pc="rahi", bodyState={naked=true}})
		saynn("После простых растяжек Рахи опускается перед тобой на колени. Она следит за тем, чтобы голени плотно прилегали к полу, пока она отклоняется назад, максимально прогибая позвоночник и опираясь лапками на лодыжки для поддержки.")

		saynn("[say=rahi]Поза верблюда...[/say]")

		saynn("В этой позе Рахи полностью открыта тебе... Её {rahi.breasts}, пушистый животик, узкая щелочка киски — всё как на ладони.")

		if (success):
			saynn("Она знает, что ты пялишься на неё, но изо всех сил старается не давать этим мыслям сбивать её с толку. Рахи успешно выполняет всю программу нагишом.")

			saynn("Рахи справилась!")

		else:
			saynn("Внезапно она осознаёт, насколько похотливо это, должно быть, выглядит с твоей точки зрения, и сильно смущается. Рахи пытается прикрыться хвостом, но теряет равновесие, сбивается с позы и падает.")

			saynn("[say=rahi]Тяжело, когда на тебя так пялятся...[/say]")

			saynn("Рахи провалила задание.")

		addButton("Продолжить", "Смотреть, что будет дальше", "stop_task")
	if(state == "hard_task"):
		playAnimation(StageScene.Solo, "struggle", {pc="rahi", bodyState={naked=true}})
		saynn("Ты веляешь Рахи сделать несколько поз йоги для расслабления. Но есть один нюанс: кошечка должна делать это голой и с жужжащими игрушками на себе. Она неохотно соглашается попробовать.")

		saynn("Она протягивает тебе свою одежду и встаёт посреди камеры. Ты берешь несколько розовых вибраторов-пулек, вставляешь два в щелочку киски Рахи, а последний приклеиваешь пластырем к её клитору. Рахи уже вся краснеет.")

		saynn("Рахи начинает свою обычную йогу: простая растяжка, потягивания вверх, затем наклоны к носкам. Пока она это делает, ты включаешь все игрушки на самый минимум, отчего кошечка внезапно издает стон удовольствия. Игрушки вибрируют на её чувствительных точках, из-за чего сосредоточиться становится невероятно трудно. Но Рахи изо всех сил старается следить за своими движениями и дыханием.")

		addButton("Продолжить", "Смотреть, что будет дальше", "hard_outcome")
	if(state == "hard_outcome"):
		playAnimation(StageScene.Hogtied, "idle", {pc="rahi", bodyState={naked=true}})
		saynn("После разминочной растяжки Рахи медленно ложится на живот и тянется лапами назад, чтобы ухватиться за щиколотки. Затем она пытается оторвать грудь и ноги от пола, выгибая тело дугой.")

		saynn("Самое сложное здесь — удерживать эту позу долгое время. Ты усложняешь ей задачу, меняя настройки игрушек, отчего они начинают вибрировать громче, вжимаясь в киску Рахи. Она прикусывает губу и тихо стонет; пока она изо всех сил старается держать позу, из её щелочки на пол капает сок.")

		if (success):
			saynn("Она борется с невероятным удовольствием. Её киска слегка подергивается и выделяет всё больше смазки, но Рахи остается неподвижной, позволяя игрушкам вибрировать внутри неё. Она дышит очень глубоко, а её взгляд полон похоти.")

			saynn("В конце концов, Рахи удается продержаться в таком положении несколько минут и не кончить! Рахи справилась!")

		else:
			saynn("К сожалению, удовольствие оказалось слишком сильным для бедной кошечки. Она стонет и тяжело дышит, пока внезапная мощная оргазма не накрывает её с головой. Рахи извивается и теряет равновесие, её дрожащие ноги бессильно опускаются на пол. Её перестимулированная киска заливает всё вокруг девичьим соком, оставляя после себя настоящий беспорядок на бедрах.")

			saynn("Застенчивая кошечка смотрит на тебя своими виноватыми глазками.")

			saynn("[say=rahi]Для {rahiFP('me', 'her')} это было слишком. Прости..[/say]")

			saynn("Рахи провалила задание.")

		addButton("Продолжить", "Смотреть, что будет дальше", "stop_task")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "easy_task"):
		if(RNG.chance(chanceEasy)):
			success = true
		getModule("RahiModule").advanceSkill("rahiSkillExhibit", 5)

	if(_action == "medium_task"):
		if(RNG.chance(chanceMedium)):
			success = true
			getModule("RahiModule").advanceSkill("rahiSkillExhibit", 10)
		#getCharacter("rahi").getInventory().equipItem(GlobalRegistry.createItem("blindfold"))

	if(_action == "hard_task"):
		if(RNG.chance(chanceHard)):
			success = true
			getModule("RahiModule").advanceSkill("rahiSkillExhibit")

	if(_action == "easy_outcome"):
		processTime(5*60)

	if(_action == "stop_task"):
		getCharacter("rahi").resetEquipment()
		endScene([success])
		return

	if(_action == "medium_outcome"):
		processTime(5*60)

	if(_action == "hard_outcome"):
		processTime(5*60)

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
