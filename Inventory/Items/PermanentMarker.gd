extends ItemBase

func _init():
	id = "PermanentMarker"

func getVisibleName():
	return "Перманентный маркер"
	
func getDescription():
	return "Одноразовый маркер, заправленный особыми чернилами, которые почти невозможно стереть."

func canUseInCombat():
	return false
#
#func useInCombat(_attacker, _receiver):
#	removeXOrDestroy(getAmount())

func getPossibleActions():
	return [
		{
			"name": "Нарисовать на себе",
			"scene": "PermanentMarkerScene",
			"description": "Используй маркер, чтобы что-нибудь на себе нарисовать!",
		},
	]

func getTags():
	return [
		ItemTag.SoldByTheAnnouncer,
		]

func getPrice():
	return 30

func getSellPrice():
	return 5

func canSell():
	return true

func canCombine():
	return true

func getItemCategory():
	return ItemCategory.Generic

func getInventoryImage():
	return "res://Images/Items/generic/marker.png"
