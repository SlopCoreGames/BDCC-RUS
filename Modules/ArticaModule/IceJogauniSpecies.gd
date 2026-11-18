extends "res://Species/Canine.gd"

func _init():
	id = "icejogauni"
	
func getVisibleName():
	return "Ледяные Йогауни"

func isPlayable():
	return false

func getVisibleDescription():
	return "A race of tribal elemental canines, this particular focussed on the ice element"
