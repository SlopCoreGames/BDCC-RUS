extends SceneBase

func _init():
	sceneID = "ChemistryLabShowerScene"

func _reactInit():
	GM.main.SCI.doPCShower()
	processTime(10*60)

func _run():
	if(state == ""):
		playAnimation(StageScene.Showering, "body", {pc="pc", bodyState={naked=true}})
		saynn("Вы раздеваетесь и заходите в умный душ. Чистая вода начинает омывать ваше тело.")

		saynn("Вода здесь куда приятнее, чем в блоке камер.")

		saynn("Любая грязь, что была на вас, собирается и фильтруется.")

		addButton("Хватит", "Хватит мыться", "endthescene")
		if (GM.main.SCI.hasUpgrade("shower2")):
			addButton("Спринцевание", "Собрать жидкости изнутри ваших дырочек тоже", "collect_inside")
		else:
			addDisabledButton("Спринцевание", "У вас не установлен необходимый апгрейд")
	if(state == "collect_inside"):
		playAnimation(StageScene.Showering, "rub", {pc="pc", bodyState={naked=true, hard=true}})
		saynn("Вы используете специальный душ-спринцовку, который позволяет промывать и ваши дырочки тоже!")

		saynn("Все похотливые жидкости, что были внутри вас, были собраны и обработаны.")

		addButton("Хватит", "Хватит мыться", "endthescene")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "collect_inside"):
		GM.main.SCI.doPCShowerInside()
		processTime(10*60)

	setState(_action)
