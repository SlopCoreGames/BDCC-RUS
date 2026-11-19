extends ItemBase

func _init():
	id = "CanineDildo"

func getVisibleName():
	return "Собачий дилдо"
	
func getDescription():
	return "Гигантский резиновый фаллос. Он достаточно велик, чтобы добраться до самых глубоких точек. Его можно наполнить жидкостью, чтобы получить еще больше удовольствия во время езды на нем."

func getPossibleActions():
	return [
		{
			"name": "Transfer fluids",
			"scene": "FluidTransferScene",
			"description": "Transfer the fluids between fluid containers",
		},
		{
			"name": "Ride it!",
			"scene": "HorsecockDildoScene",
			"description": "Use it for your pleasure",
			"onlyWhenCalm": true,
		},
	]

func getPrice():
	return 100

func canSell():
	return true

func getTags():
	return [
		#ItemTag.SoldByTheAnnouncer,
		]

func getItemCategory():
	return ItemCategory.Generic

func generateFluids():
	fluids = Fluids.new()
	fluids.setCapacity(5000.0)

func getInventoryImage():
	return "res://Images/Items/toys/horsecockdildo.png"
