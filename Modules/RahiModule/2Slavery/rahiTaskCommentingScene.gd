extends SceneBase

var success = false

func _init():
	sceneID = "rahiTaskCommentingScene"

func _reactInit():
	success = getFlag("RahiModule.rahiTaskSuceeded", false)

func _run():
	if(state == ""):
		addCharacter("rahi")
		saynn("Рахи стоит неподвижно, словно чего-то ждет. Пока любопытство не заставляет её саму задать тебе вопрос.")

		saynn("[say=rahi]"+RNG.pick([
			"So.. how did she do today?..",
			"So.. how was her performance today, {rahiMaster}?..",
			"What do you think about her task, {rahiMaster}?..",
		])+"[/say]")

		addButton(RNG.pick(["Great", "Good", "Good job", "Amazing"]), "Сказать, что сегодня она выступила великолепно", "say_great")
		addButton(RNG.pick(["Could be better", "Meh", "Okay-ish", "Needs improvement"]), "Рахи могла бы постараться получше", "say_meh")
		addButton(RNG.pick(["Bad", "Pathetic", "Awful", "Terrible"]), "Рахи выступила ужасно", "say_bad")
	if(state == "say_great"):
		saynn("[say=pc]Сегодня ты была великолепна, киска. Так держать![/say]")

		if (success):
			saynn("Киска довольно улыбается и мурлычет.")

			saynn("[say=rahi]Ура![/say]")

		else:
			saynn("Киска слегка наклоняет голову, выглядя удивленной.")

			saynn("[say=rahi]О?.. Она ведь старалась изо всех сил, правда?..[/say]")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
	if(state == "say_meh"):
		saynn("[say=pc]Не буду врать, ты могла бы и получше.[/say]")

		if (success):
			saynn("Китти наклоняет голову. Видно, как её щеки слегка раздуваются.")

			saynn("[say=rahi]Но.. Но.. Прости, {rahiMaster}.. Ты прав..[/say]")

		else:
			saynn("Китти наклоняет голову.")

			saynn("[say=rahi]Прости, {rahiMaster}.. В следующий раз она постарается лучше..[/say]")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")
	if(state == "say_bad"):
		saynn("[say=pc]Это было просто ужасно, китти. Любая другая рабыня справилась бы лучше.[/say]")

		if (success):
			saynn("Китти сильно наклоняет голову; очевидно, она чего-то не понимает.")

			saynn("[say=rahi]Но.. Но.. {rahiMaster}.. Это несправедливо..[/say]")

		else:
			saynn("Китти наклоняет голову, её ушки поникают, а хвост трется между бедер.")

			saynn("[say=rahi]Прости, {rahiMaster}.. Твоя рабыня очень раскаивается в своей неудаче..[/say]")

		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "say_great"):
		if(success):
			increaseFlag("RahiModule.rahiAffection", 2)
			increaseFlag("RahiModule.rahiObedience", 0)
		else:
			increaseFlag("RahiModule.rahiAffection", 3)
			increaseFlag("RahiModule.rahiObedience", -3)

	if(_action == "say_meh"):
		if(success):
			increaseFlag("RahiModule.rahiAffection", -2)
			increaseFlag("RahiModule.rahiObedience", -2)
		else:
			increaseFlag("RahiModule.rahiAffection", -1)
			increaseFlag("RahiModule.rahiObedience", 3)

	if(_action == "say_bad"):
		if(success):
			increaseFlag("RahiModule.rahiAffection", -2)
			increaseFlag("RahiModule.rahiObedience", -4)
		else:
			increaseFlag("RahiModule.rahiAffection", 0)
			increaseFlag("RahiModule.rahiObedience", 2)

	setState(_action)

func saveData():
	var data = .saveData()

	data["success"] = success

	return data

func loadData(data):
	.loadData(data)

	success = SAVE.loadVar(data, "success", false)
