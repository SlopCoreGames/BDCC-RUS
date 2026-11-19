extends "res://Species/Canine.gd"

func _init():
	id = "icejogauni"
	
func getVisibleName():
	return "Ледяные Йогауни"

func isPlayable():
	return false

func getVisibleDescription():
	return "Раса племенных элементальных псов, специализирующаяся на стихии льда."
