extends Character

func _init():
	id = "inmateMale2"
	disableSerialization = true
	
func _getName():
	return "Male inmate"

func getGender():
	return Gender.Male
	
func getSmallDescription() -> String:
	return "Обычный заключенный-мужчина"

func getSpecies():
	return ["feline"]

