extends "res://Inventory/Items/PlantEgg.gd"

func _init():
	id = "PlantEggEliza"
	whoGaveBirth = "eliza"

func getVisibleName():
	return "Яйцо растения"
	
func getSellPrice():
	return 50

func getInventoryImage():
	return "res://Images/Items/medical/egg-shell.png"

func getDescription():
	var theDesc:String = .getDescription()
	
	if(whoGaveBirth == "eliza"):
		return theDesc + "\n\n\"[i]Береги его. Или сожри в ту же секунду, как я уйду. Но если отравишься — ко мне не суйся.[/i] \""
	return theDesc
