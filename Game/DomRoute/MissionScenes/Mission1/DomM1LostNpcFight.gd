extends SceneBase

func _init():
	sceneID = "DomM1LostNpcFight"

func _run():
	if(state == ""):
		playAnimation(StageScene.GivingBirth, "idle")
		aimCameraAndSetLocName("solitary_cell")
		saynn("Ты проиграла бой!")

		saynn("Охранник зовет подмогу, и они вместе скручивают тебя.")

		saynn("Вскоре тебя бросают в карцер, чтобы ты могла поразмыслить над своим поведением.")

		saynn("До принтеров ты так и не добралась... похоже, придется начинать всё сначала.")

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
