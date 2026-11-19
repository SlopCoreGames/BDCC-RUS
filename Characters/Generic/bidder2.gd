extends Character

func _init():
	id = "bidder2"
	disableSerialization = true
	
func _getName():
	return "Bidder 2"

func getGender():
	return Gender.Other
	
func getSmallDescription() -> String:
	return "Теневая фигура"

func getSpecies():
	return ["unknown"]

