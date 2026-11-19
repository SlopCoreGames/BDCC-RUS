extends Character

func _init():
	id = "intro_detective"
	disableSerialization = true
	
func _getName():
	return "Jake"

func getGender():
	return Gender.Male
	
func getSmallDescription() -> String:
	return "Элегантный пес с серой шерстью. На нем черные брюки, белая рубашка и очки для чтения в ретро-стиле."

func getSpecies():
	return [Species.Canine]
