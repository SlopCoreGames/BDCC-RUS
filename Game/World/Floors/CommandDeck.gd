extends SubGameWorld


func _on_CDElevator_onEnter(room):
	room.addButton("Лифт", "Используй это", "elevator")


func _on_CDElevator_onReact(room, key):
	if(key == "elevator"):
		room.runScene("ElevatorScene")

