extends "res://Inventory/Items/PlasticBottle.gd"

func _init():
	id = "PlasticBottleBluespace"

func getVisibleName():
	return "Пластиковая бутылка блюспейса"
	
func getDescription():
	return "Хранит все ваши жидкости в измерении блюспейса, что позволяет этой бутылке вмещать в 100 раз больше жидкости, чем обычная. Цена продажи зависит от содержимого."

func getPrice():
	return 20

func getTags():
	var canBuyBottle:bool = false
	if(GM.main != null && GM.main.SCI != null && GM.main.SCI.hasUpgrade("advPlasticBottle")):
		canBuyBottle = true
	var result:Array = .getTags()
	if(!canBuyBottle):
		result.erase(ItemTag.SoldByMedicalVendomat)
	return result

func getSellPrice():
	return 0 + Util.maxi(0, fluids.getCost())

func generateFluids():
	fluids = Fluids.new()
	fluids.setCapacity(1000000.0)

func getInventoryImage():
	return "res://Images/Items/medical/water-bottle-blue.png"
