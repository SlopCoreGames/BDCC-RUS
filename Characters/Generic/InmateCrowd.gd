extends Character

func _init():
	id = "inmateCrowd"
	disableSerialization = true
	
func _getName():
	return "Множество заключенных"

func getGender():
	return Gender.Other
	
func getSmallDescription() -> String:
	return "Плотная толпа заключенных"

func getSpecies():
	return ["canine"]

