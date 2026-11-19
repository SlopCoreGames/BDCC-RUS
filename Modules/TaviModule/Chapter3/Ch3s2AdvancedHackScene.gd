extends "res://Scenes/SceneBase.gd"

func _init():
	sceneID = "Ch3s2AdvancedHackScene"

func _run():

	if(state == ""):
		saynn("Ты осматриваешь массивный сейф. У него даже нет привычных ручек или дисков — просто тяжелый металлический ящик с дверцей, у которой нет даже ручки. Но ты замечаешь провода, соединяющие его с одной из консолей. Очевидно, что просто перерезать их ничего не даст, так что, если хочешь заглянуть внутрь, придется взломать консоль.")

		saynn("У тебя есть предчувствие, что в этом сейфе нет ничего сверхважного, но это может стать отличной тренировкой для твоих навыков взлома. Впрочем, эта консоль, скорее всего, окажется куда сложнее.")

		saynn("Хочешь попробовать взломать эту консоль?")

		addButton("Да", "Попробовать взломать", "screen")
		addButton("Неа", "Хватит взлома", "endthescene")


	if(state == "after_completed"):
		setFlag("TaviModule.ch3CompletedDoorHack", true)
		
		saynn("Успех! Из сейфа доносятся механические звуки: внутренние шестерни начинают вращаться, медленно отворяя дверцу и являя тебе содержимое...")

		# (scene ends)
		addButton("Смотреть", "Посмотреть, что внутри", "endthescene")
		#addButton("Осмотреть", "Посмотреть, что внутри", "look_at")

func _react(_action: String, _args):
	if(_action == "screen"):
		runScene("ComputerSimScene", ["TaviEngineeringSafeComputer"], "computerhack")
		setState("after_completed")
		return

	if(_action == "endthescene"):
		endScene()
		return

	setState(_action)

func _react_scene_end(_tag, _result):
	if(_tag == "computerhack"):
		if(_result is Array):
			if(_result[0] == true):
				processTime(10*60)
				addMessage("Ты получил 50 кредитов! Но есть и кое-что ещё...")
				addItemToSavedItems(GlobalRegistry.createItem("HorsecockDildo"))
				GM.pc.addCredits(50)
				addExperienceToPlayer(100)
				setState("after_completed")
				setFlag("TaviModule.ch3CompletedSafeHack", true)
				return
		endScene()
