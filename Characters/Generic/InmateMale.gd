extends Character

func _init():
	id = "inmateMale"
	disableSerialization = true
	
func _getName():
	return "Заключенный-мужчина"

func getGender():
	return Gender.Male
	
func getSmallDescription() -> String:
	return "Обычный заключенный-мужчина"

func getSpecies():
	return ["canine"]

