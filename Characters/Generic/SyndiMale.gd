extends Character

func _init():
	id = "syndiMale"
	disableSerialization = true
	
func _getName():
	return "Syndicate Agent"

func getGender():
	return Gender.Male
	
func getSmallDescription() -> String:
	return "Просто глядя на них, хочется спрятать диск... Какой ещё диск?"

func getSpecies():
	return ["canine"]

func getThickness() -> int:
	return 50

func getFemininity() -> int:
	return 0

func createBodyparts():
	var breasts = GlobalRegistry.createBodypart("humanbreasts")
	breasts.size = -1
	giveBodypartUnlessSame(breasts)
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("digilegs"))
	giveBodypartUnlessSame(GlobalRegistry.createBodypart("anthroarms"))

func getDefaultEquipment():
	return ["SyndiHelmet", "SyndiArmor"]
