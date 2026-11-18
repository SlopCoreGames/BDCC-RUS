extends SceneBase

func _init():
	sceneID = "DomM3LostNpcFight"

func _run():
	if(state == ""):
		playAnimation(StageScene.GivingBirth, "idle")
		aimCameraAndSetLocName("medical_paddedcell_player")
		saynn("Ты проиграла бой!")

		saynn("Вскоре приходят несколько медсестер и скручивают тебя.")

		saynn("Затем тебя бросают в мягкую камеру, где какое-то время можно ни о чем не беспокоиться. Что бы они тебе ни вкололи, от этого на душе становится удивительно приятно и спокойно.")

		saynn("Тебе не удалось украсть лабораторное оборудование для Ферри. Похоже, придется пробовать снова.")

		saynn("Миссия провалена!")

		addButton("Продолжить", "Прервать миссию", "stopthemission")
		addButton("Перезапустить", "Попробовать еще раз", "trymissionagain")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "stopthemission"):
		processTime(60*60*3)
		endScene()
		GM.pc.setLocation(GM.pc.getCellLocation())
		GM.main.MS.failCurrentMission()

	if(_action == "trymissionagain"):
		endScene()
		GM.main.MS.restartCurrentMission()
		return

	setState(_action)
