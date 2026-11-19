extends ItemBase


func _init():
	id = "Condom"

func getVisibleName():
	return "Презерватив"
	
func getDescription():
	return "Продаются упаковкой по 10 штук! Отлично помогают избежать нежелательной беременности... в большинстве случаев.\n\nМелким шрифтом на упаковке указано, что каждый десятый презерватив заменен на воздушный шарик — для всех ваших развлекательных нужд."

func getPrice():
	return 1

func canSell():
	return true

func canCombine():
	return true

func getBuyAmount():
	return 10

func getTags():
	return [
		ItemTag.Condom,
		ItemTag.SoldByGeneralVendomat,
		]

func getCondomBreakChance():
	if(!OPTIONS.isContentEnabled(ContentType.RiskyCondoms)):
		return 0.0
	
	return 20.0

func getItemCategory():
	return ItemCategory.Medical

func useInCombat(_attacker, _receiver):
	removeXOrDestroy(1)
	
	var theCondomItem = GlobalRegistry.createItem("UsedCondom")
	if(theCondomItem):
		theCondomItem.breakChance = getCondomBreakChance()
		_attacker.getInventory().addItem(theCondomItem)
	
	return _attacker.getName() + " takes one of the condoms out of its package and then stretches it with "+_attacker.hisHer()+" fingers."

func getPossibleActions():
	return [
		{
			"name": "Stretch one",
			"scene": "UseItemLikeInCombatScene",
			"description": "Turn one of the condoms into a used one",
		},
	]

func getInventoryImage():
	return "res://Images/Items/medical/condom.png"
