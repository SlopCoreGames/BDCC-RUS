extends SubGameWorld


func _on_MainStairs1_onEnter(room):
	room.addButton("Спуститься вниз", "Спуститься в камеры", "godown")


func _on_MainStairs1_onReact(_room, key):
	if(key == "godown"):
		GM.pc.setLocation("CBStairs1")
		GM.main.reRun()


func _on_MainStairs2_onEnter(room):
	room.addButton("Спуститься вниз", "Спуститься в камеры", "godown")


func _on_MainStairs2_onReact(_room, key):
	if(key == "godown"):
		GM.pc.setLocation("CBStairs2")
		GM.main.reRun()


func _on_MainCanteen_onEnter(room):
	if(!GM.main.getFlag("Canteen_PlayerAteToday", false)):
		room.addButton("Поесть", "Посмотреть, что можно поймать", "eat")
	else:
		room.addDisabledButton("Поесть", "Ты уже сегодня ел")


func _on_MainCanteen_onReact(room, key):
	if(key == "eat"):
		room.runScene("EatInCanteenScene")


func _on_MainDressingRoom_onEnter(room):
	if(GM.main.playerHasCompanions()):
		return
	if(GM.pc.isFullyNaked()):
		room.addDisabledButton("Раздеться", "Ты и так голышом")
	else:
		room.addButton("Раздеться", "Сними одежду и иди в душ", "shower")

func _on_MainDressingRoom_onReact(room, key):
	if(key == "shower"):
		room.runScene("TakingAShowerScene")

func _on_MainShowerRoom_onEnter(room):
	if(GM.main.playerHasCompanions()):
		return
	if(GM.pc.isFullyNaked()):
		room.addButton("Душ", "Принять душ", "shower")
	else:
		room.addDisabledButton("Душ", "Тебе нужно быть голышом")

func _on_MainShowerRoom_onReact(room, key):
	if(key == "shower"):
		room.runScene("TakingAShowerScene")


func _on_MainElevator_onEnter(room):
	room.addButton("Лифт", "Используй это", "elevator")

func _on_MainElevator_onReact(room, key):
	if(key == "elevator"):
		room.runScene("ElevatorScene")


func _on_MainVendomatRoom_onEnter(room):
	room.saynn("В этом углу стоит рабочий вендомат. Он избит до полусмерти, но, похоже, всё ещё будет нормально работать.")
	
	room.addButton("Вендомат", "Подойти к нему", "vendomat")

func _on_MainVendomatRoom_onReact(room, key):
	if(key == "vendomat"):
		room.runScene("VendomatScene")

func _on_MainLaundry_onEnter(room):
	room.saynn("Рядом вы также видите вендомат. Кажется, в этом продается какая-то одежда")
	
	room.addButton("Торговец униформой", "Подойти к торговцу", "uniform")
	room.addButton("Вендомат", "Подойти к нему", "vendomat")

func _on_MainLaundry_onReact(room, key):
	if(key == "uniform"):
		room.runScene("LaundryUniformMachineScene")
	
	if(key == "vendomat"):
		room.runScene("VendomatUnderwearScene")


func _on_MainGreenhousesJumpable_onEnter(room):
	#room.saynn("Вы заглядываете за перила и видите, что высота обрыва не такая уж и большая.")
	
	room.addButton("Прыжок через ограду", "Похоже, отсюда можно спрыгнуть во внутренний двор", "vault")


func _on_MainGreenhousesJumpable_onReact(_room, key):
	if(key == "vault"):
		GM.pc.setLocation("yard_vaulthere")
		GM.main.reRun()
		GM.main.addMessage("Вы успешно перепрыгнули через перила")

func _on_MainHallRoom9_onEnter(_room):
	#room.addButton("Попробовать колодки", "Просунуть в них голову из любопытства", "stocks")
	pass

func _on_MainHallRoom9_onReact(_room, _key):
	#if(key == "stocks"):
	#	room.runScene("TryStocksScene")
	pass


func _on_MainHallRoom21_onEnter(_room):
	#room.addButton("Зеркало", "Изменить прическу", "mirror")
	#room.addButton("Туалет", "Найти свободную кабинку", "toilet")
	pass


# Got converted to events
func _on_MainHallRoom21_onReact(_room, _key):
#	if(key == "mirror"):
#		room.runScene("ChangeHaircutScene")
#	if(key == "toilet"):
#		room.runScene("ToiletScene")
	pass
