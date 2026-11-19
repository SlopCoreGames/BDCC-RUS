extends ItemBase

func _init():
	id = "HorsecockDildo"

func getVisibleName():
	return "Дилдо «Лошадиный член»"
	
func getDescription():
	return "Гигантский резиновый фаллос. Он достаточно велик, чтобы добраться до самых глубоких точек. Его можно наполнить жидкостью, чтобы получить еще больше удовольствия во время езды на нем."

func getPossibleActions():
	return [
		{
			"name": "Перекачать жидкость",
			"scene": "FluidTransferScene",
			"description": "Перелить жидкость из одного контейнера в другой",
		},
		{
			"name": "Оседлай его!",
			"scene": "HorsecockDildoScene",
			"description": "Используй его для своего удовольствия",
			"onlyWhenCalm": true,
		},
	]

func getPrice():
	return 100

func canSell():
	return true

func getTags():
	return [
		ItemTag.SoldByTheAnnouncer,
		]

func getItemCategory():
	return ItemCategory.Generic

func generateFluids():
	fluids = Fluids.new()
	fluids.setCapacity(5000.0)

func getInventoryImage():
	return "res://Images/Items/toys/horsecockdildo.png"
