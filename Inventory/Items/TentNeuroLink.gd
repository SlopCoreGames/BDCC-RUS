extends ItemBase

func _init():
	id = "TentNeuroLink"

func getVisibleName():
	return "Инъектор Нейро-Линк"
	
func getDescription():
	var theText:String = "Одноразовый инъектор с крошечным чипом внутри. При введении он позволяет взять под контроль органическую форму, для которой был предназначен."

	if(GM.main.getFlag("ElizaModule.tent_neurolink", false)):
		theText += "\n\n[i]Каким-то образом вам удалось сохранить лишний инъектор. Сейчас он совершенно бесполезен, но, пожалуй, его всё же стоит оставить.[/i]"

	return theText

func getA():
	return "a"

func getSellPrice():
	return 67

func canSell():
	return true

func canCombine():
	return true

func getItemCategory():
	return ItemCategory.Generic

func getInventoryImage():
	return "res://Images/Items/generic/chip.png"
