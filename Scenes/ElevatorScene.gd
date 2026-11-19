extends "res://Scenes/SceneBase.gd"

func _init():
	sceneID = "ElevatorScene"

func _run():
	if(state == ""):
		saynn("Вы заходите в лифт и смотрите на панель управления; ваш статус заключенного позволяет посещать лишь определенные этажи")
		
		saynn("Куда поедем?")

		var floors = [
			["Cellblock", "hall_elevator", "Основной уровень, где расположены все камеры заключенных"],
			["Mineshafts", "mining_elevator", "Нижний уровень, к которому пристыкована астероидная база"],
			["Medical", "med_elevator", "Этаж, где находятся все медицинские и научные объекты"],
		]
		
		for fl in floors:
			if(fl[1] == GM.pc.location):
				addDisabledButton(fl[0], "Вы уже на месте")
			else:
				addButton(fl[0], fl[2], "gofloor", [fl[1]])
				
		GM.ES.triggerRun(Trigger.InsideElevator)
				
		addButton("Выйти", "Вам не особо-то и хочется куда-то ехать", "endthescene")
	
	if(state == "gofloor"):
		saynn("С пронзительным скрежетом двери закрываются, и лифт начинает движение к выбранному этажу")
		
		saynn("Вы прислоняетесь к одной из стен и просто ждете, пока лифт прибудет на место, что в итоге и происходит")
		
		addButton("Продолжить", "Выйти из лифта", "endthescene")

func _react(_action: String, _args):
	if(_action == "gofloor"):
		var newloc = _args[0]
		
		processTime(5*60)
		GM.pc.setLocation(newloc)
		aimCamera(newloc)

	if(_action == "endthescene"):
		endScene()
		return
	
	setState(_action)

func supportsShowingPawns() -> bool:
	return true
