extends "res://Inventory/Items/Clothes/EngineerClothes.gd"

func _init():
	id = "EngineerClothesAlex"

func getDescription():
	return "Просто обычная рубашка и шорты оранжевого цвета. На этой есть бронированные наплечники — идеальный вариант для кого-то хитрого и ловкого."

func getRiggedParts(_character):
	if(itemState.isRemoved()):
		return null
	return {
		"clothing": "res://Inventory/RiggedModels/EngineerUniform/EnginnerClothesAlex.tscn",
	}
