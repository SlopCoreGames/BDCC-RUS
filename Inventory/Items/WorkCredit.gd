extends ItemBase

func _init():
	id = "WorkCredit"

func getVisibleName():
	return "Кредит"
	
func getDescription():
	return "Маленький чип с некоторой суммой кредитов. Цифровая валюта без единого изъяна. Некоторые даже задаются вопросом, существует ли она на самом деле."

func canUseInCombat():
	return true

func useInCombat(_attacker, _receiver):
	if(_attacker is Player):
		_attacker.addCredits(getAmount())
	removeXOrDestroy(getAmount())
	return _attacker.getName() + " pushed the credits to their account"

func getPossibleActions():
	return [
		{
			"name": "Зачислить кредиты",
			"scene": "UseItemLikeInCombatScene",
			"description": "Перевести кредиты на свой счет",
		},
	]

func getPrice():
	return 1

func getSellPrice():
	return 1

func canSell():
	return true

func canCombine():
	return true

func getItemCategory():
	return ItemCategory.Generic

func getInventoryImage():
	return "res://Images/Items/generic/chip.png"
