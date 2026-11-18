extends "res://Scenes/SceneBase.gd"


func _init():
	sceneID = "RestraintTakeOffNopeScene"

func _run():
	if(state == ""):
		saynn("Это заблокированное средство фиксации, его нельзя просто так снять")
		
		saynn("Если хочешь освободиться, нужно использовать действие «Борьба».")

		addButton("Оставить как есть", "Ничего не поделаешь", "leaveit")

	if(state == "leaveit"):
		saynn("Ты вздыхаешь и оставляешь фиксацию как есть")
		
		addButton("Продолжить", "Ну и ладно", "endthescene")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return
	
	setState(_action)
