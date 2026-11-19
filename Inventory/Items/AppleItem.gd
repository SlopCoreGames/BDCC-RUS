extends ItemBase

var isLegal = false

func _init():
	id = "appleitem"

# apple is illegal only temporally as a test item
func getVisibleName():
	if(isLegal):
		return "Вкусное яблоко"
	return "Украденное яблоко"
	
func getDescription():
	if(isLegal):
		return "Выглядит очень аппетитно. Снимает 30 единиц боли и дает 30 единиц выносливости. На этом яблоке есть специальная наклейка, благодаря которой заключенным разрешено его иметь!"
	return "Выглядит очень аппетитно. Снимает 30 единиц боли и дает 30 единиц выносливости"

func setIsLegal(legal):
	isLegal = legal

func canUseInCombat():
	return true

func useInCombat(_attacker, _receiver):
	_attacker.addPain(-30)
	_attacker.addStamina(30)
	removeXOrDestroy(1)
	return _attacker.getName() + " ate an apple"

func getPossibleActions():
	return [
		{
			"name": "Eat one!",
			"scene": "UseItemLikeInCombatScene",
			"description": "Eat the apple",
		},
	]

func getPrice():
	return 0

func canSell():
	return true

func canCombine():
	return true

func tryCombine(_otherItem):
	if(isLegal != _otherItem.isLegal):
		return false
	return .tryCombine(_otherItem)

func getTags():
	if(isLegal):
		return []
	return [ItemTag.Illegal]

func getItemCategory():
	return ItemCategory.Medical

func saveData():
	var data = .saveData()
	
	data["isLegal"] = isLegal
	
	return data
	
func loadData(data):
	.loadData(data)
	
	isLegal = SAVE.loadVar(data, "isLegal", false)

func getInventoryImage():
	return "res://Images/Items/medical/apple.png"
