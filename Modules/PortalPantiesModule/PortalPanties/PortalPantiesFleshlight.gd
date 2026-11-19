extends ItemBase

func _init():
	id = "PortalPantiesFleshlight"

func getVisibleName():
	return "Флешлайт"
	
func getDescription():
	return "Флешлайт в научно-фантастическом стиле с кнопками на корпусе."

func getPossibleActions():
	return [
		{
			"name": "Активировать",
			"scene": "UsePortalPantiesFleshlight",
			"description": "Посмотреть, на что способна эта игрушка",
			"onlyWhenCalm": true,
		},
	]

func getPrice():
	return 10

func canSell():
	return true

func getTags():
	if(GM.main != null && (GM.main.getFlag("PortalPantiesModule.Panties_PcDenied") || GM.main.getFlag("PortalPantiesModule.Panties_FleshlightsReturnedToAlex"))):
		return [ItemTag.SoldByAlexRynard]
	return []

func getItemCategory():
	return ItemCategory.BDSM

func getInventoryImage():
	return "res://Images/Items/bdsm/PortalPantiesFleshlight.png"
