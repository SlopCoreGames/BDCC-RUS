extends "res://Scenes/SceneBase.gd"


func _init():
	sceneID = "StraponPutOnScene"

func _run():
	if(state == ""):
		saynn("Ты понимаешь, как глупо будешь выглядеть, расхаживая с дриллом, и решаешь обойтись без него.")
		
		saynn("( Страпоны можно использовать только во время секс-сцен )")

		addButton("Оставить как есть", "Ничего не поделаешь", "endthescene")


func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return
	
	setState(_action)
