extends SubGameWorld



func _on_MedElevator_onEnter(room):
	room.addButton("Лифт", "Используй это", "elevator")


func _on_MedElevator_onReact(room, key):
	if(key == "elevator"):
		room.runScene("ElevatorScene")


func _on_MedRoom2_onEnter(room):
	room.saynn("В этом углу притаился медицинский вендомат, предлагающий всевозможные наркотики и лекарства.")
	
	room.addButton("Вендомат", "Подойти к нему", "vendomat")


func _on_MedRoom2_onReact(room, key):
	if(key == "vendomat"):
		room.runScene("VendomatMedScene")


func _on_MedRoom7_onEnter(room):
	room.addButton("Уйти", "Этот шлюз позволяет выйти наружу, но не войти обратно.", "leave")


func _on_MedRoom7_onReact(_room, key):
	if(key == "leave"):
		GM.pc.setLocation("med_lobbynw")
		GM.main.reRun()


func _on_MedRoom8_onEnter(room):
	room.addButton("Уйти", "Этот шлюз позволяет выйти наружу, но не войти обратно.", "leave")

func _on_MedRoom8_onReact(_room, key):
	if(key == "leave"):
		GM.pc.setLocation("med_lobbyne")
		GM.main.reRun()
