extends Character

func _init():
	id = "bidder1"
	disableSerialization = true
	
func _getName():
	return "Bidder 1"

func getGender():
	return Gender.Other
	
func getSmallDescription() -> String:
	return "Теневая фигура"

func getSpecies():
	return ["unknown"]

