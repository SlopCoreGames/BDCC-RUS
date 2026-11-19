extends "res://Scenes/SceneBase.gd"

func _init():
	sceneID = "Ch3s2ControlRoomScene"

func _run():

	if(state == ""):
		saynn("Эта комната забита консолями и мигающими огоньками. Ты быстро пробегаешь глазами по надписям в поисках той, что управляет расписанием станции. Заметив многообещающую панель, ты направляешься к ней, поглядывая по сторонам, чтобы не попасться на глаза инженерам или охранникам.")

		saynn("Ты подходишь к старой консоли с экраном, подсвеченным зеленым светом, по которому каждые несколько секунд пробегает полоса сканирования. Здесь есть шикарная щелкающая клавиатура, но какую команду стоит ввести?")

		saynn("Пора заняться хакингом.")

		addButton("Экран", "Посмотреть на экран", "screen")


	if(state == "after_completed"):
		setFlag("TaviModule.ch3CompletedDoorHack", true)
		
		saynn("Похоже, у тебя получилось. Проверить наверняка можно только вернувшись к Тави. Ты в последний раз внимательно осматриваешь комнату. Ничего интересного, кроме еще одной консоли, с которой можно было бы поковыряться — кажется, она подключена к большому сейфу, встроенному в стену.")

		# (scene ends)
		addButton("Продолжить", "Смотреть, что будет дальше", "endthescene")

func _react(_action: String, _args):
	if(_action == "screen"):
		runScene("ComputerSimScene", ["TaviEngineeringComputer"], "computerhack")
		setState("after_completed")
		return

	if(_action == "endthescene"):
		endScene()
		return

	setState(_action)

func _react_scene_end(_tag, _result):
	if(_tag == "computerhack"):
		processTime(10*60)
		addMessage("Task updated")
		addExperienceToPlayer(100)
		setState("after_completed")
	
