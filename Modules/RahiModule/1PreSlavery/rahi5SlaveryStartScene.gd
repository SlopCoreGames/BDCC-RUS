extends SceneBase

func _init():
	sceneID = "rahi5SlaveryStartScene"

func _run():
	if(state == ""):
		addCharacter("rahi")
		playAnimation(StageScene.Duo, "stand", {npc="rahi"})
		saynn("Вы входите в камеру Рахи. Она мало чем отличается от остальных — заключенным не особо разрешают иметь личные вещи. Стоит что-то выставить напоказ, как это тут же крадут. Так что... просто камера.")

		saynn("Рахи стоит у своей кровати и смотрит на вас.")

		saynn("[say=rahi]Значит... ты собираешься... помочь ей?[/say]")

		saynn("[say=pc]Обязательно, киска. Я сделаю всё, что в моих силах.[/say]")

		saynn("Она слегка склоняет голову.")

		saynn("[say=rahi]Она доверяет тебе... Пожалуйста, поступай так, как считаешь нужным... даже если она будет не согласна...[/say]")

		saynn("Сильные слова. От такой слабой на вид кошечки. Она полностью отдается вам на волю.")

		saynn("[say=pc]Даже если ты будешь сопротивляться?[/say]")

		saynn("[say=rahi]Да...[/say]")

		saynn("Ну вот. Пора. Пришло время отдать ей приказ и посмотреть, что из этого выйдет.")

		addButton("Продолжить", "Смотреть, что будет дальше", "pick_task_scene")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return

	if(_action == "pick_task_scene"):
		endScene()
		runScene("rahiSlaveryPickTaskScene")
		return

	setState(_action)
