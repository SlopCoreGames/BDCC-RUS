extends "res://Scenes/SceneBase.gd"

func _init():
	sceneID = "TaviQuest2Start"


func _run():
	if(state == ""):
		addCharacter("tavi")
		
	if(state == ""):
		saynn("Ты привлекаешь внимание Тави, опускаясь на колени и тыкая её в ногу.")

		saynn("[say=pc]Ну, чего тебе, мисс?[/say]")

		saynn("[say=tavi]Мы можем заняться разведкой.[/say]")

		saynn("[say=pc]Разведкой?[/say]")

		saynn("[say=tavi]Ага. Ты видела капитана? Ну и мудак же он.[/say]")

		saynn("Ты киваешь.")

		saynn("[say=tavi]Добраться до его кабинета, найти консоль связи и позвонить моим друзьям.[/say]")

		saynn("[say=pc]У тебя есть друзья?[/say]")

		saynn("В ответ повисает тишина. Спустя пару секунд Тави тихонько посмеивается.")

		saynn("[say=tavi]Жду тебя завтра у контрольно-пропускного пункта. Будь готова, милашка.[/say]")

		# (new quest added)
		addButton("Уйти", "Она всё равно получила то, что заслужила.", "endthescene")


func _react(_action: String, _args):
	if(_action == "endthescene"):
		processTime(60*3)
		
		setModuleFlag("TaviModule", "Tavi_Quest2Started", true)
		setModuleFlag("TaviModule", "Tavi_Quest2Day", GM.main.getDays())
		endScene()
		return


	setState(_action)

