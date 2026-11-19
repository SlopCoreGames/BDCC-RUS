extends ItemBase

func _init():
	id = "PlasticBottle"

func getVisibleName():
	return "Пластиковая бутылка"
	
func getDescription():
	return "Самая обычная пластиковая бутылка. Специальная крышка сжимает жидкость внутри, позволяя вместить больше объема, чем обычно. Цена продажи зависит от содержимого."

func getPrice():
	return 5

func getSellPrice():
	return 0 + Util.maxi(0, fluids.getCost())

func canSell():
	return true

func canCombine():
	return false

func getTags():
	return [
		ItemTag.SoldByMedicalVendomat,
		ItemTag.CanPeeInto,
		ItemTag.CanForceCumInto,
		ItemTag.PlasticBottle,
		]

func generateFluids():
	fluids = Fluids.new()
	fluids.setCapacity(10000.0)

func getPossibleActions():
	return [
		{
			"name": "Перекачать жидкость",
			"scene": "FluidTransferScene",
			"description": "Перелить жидкость из одного контейнера в другой",
		},
		{
			"name": "Выпить из",
			"scene": "DrinkFromScene",
			"description": "Проглотить содержимое этого предмета",
		},
		{
			"name": "Собрать выделяющуюся жидкость",
			"scene": "CatchBodyFluidsScene",
			"description": "Собрать часть жидкости, которой ты покрыта",
		},
	]

func getInventoryImage():
	return "res://Images/Items/medical/water-bottle.png"
