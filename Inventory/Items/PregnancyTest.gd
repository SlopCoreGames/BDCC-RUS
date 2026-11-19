extends ItemBase

func _init():
	id = "PregnancyTest"

func getVisibleName():
	return "Тест на беременность"
	
func getDescription():
	return "Проверяет, беременны ли вы. На упаковке заявлено, что вероятность ложноположительного результата составляет всего 0,01%."

func canUseInCombat():
	return true

func useInCombat(_attacker, _receiver):
	removeXOrDestroy(1)
	
	var text = "Вы следуете инструкции по применению теста и замираете в ожидании результата...\n\n"
	
	if(_attacker.isPregnant()):
		text += "На маленьком экране видны [b]две черные полоски[/b]."
	else:
		text += "На маленьком экране видна [b]одна черная полоска[/b]. Фух."
	
	return text

func getPossibleActions():
	return [
		{
			"name": "Использовать",
			"scene": "UseItemLikeInCombatScene",
			"description": "Использовать тест",
		},
	]

func getPrice():
	return 1

func canSell():
	return true

func canCombine():
	return true

func getTags():
	return [
		ItemTag.SoldByMedicalVendomat,
		]

func getBuyAmount():
	return 3

func getItemCategory():
	return ItemCategory.Medical

func getInventoryImage():
	return "res://Images/Items/medical/pregnancy-test.png"
