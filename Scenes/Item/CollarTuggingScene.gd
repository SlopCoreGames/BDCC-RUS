extends "res://Scenes/SceneBase.gd"


func _init():
	sceneID = "CollarTuggingScene"

func _run():
	if(state == ""):
		saynn("Ты пытаешься рассмотреть свой ошейник, но это чертовски трудно, ведь он плотно сидит на шее.")
		
		saynn("Он прилегает очень туго; ты едва можешь просунуть под него палец, чтобы почесать шею, но на этом возможности заканчиваются.")

		addButton("Оставить как есть", "Ничего не поделаешь", "leaveit")
		if(GM.pc.hasBoundArms()):
			addDisabledButton("Дернуть", "Связанные руки не дают этого сделать")
		else:
			addButton("Дернуть", "Попытаться дернуть за него", "tug")

	if(state == "tug"):
		saynn("Ты пытаешься дернуть ошейник, пока никто не видит. Может, получится снять его как-то без ключа?")
		
		saynn("Но увы, прогресса нет — эта громоздкая штука сидит на шее мертвой хваткой.")
		
		addButton("Продолжить", "Ну и ладно", "")

	if(state == "leaveit"):
		saynn("Ты вздыхаешь и перестаешь дергать за ошейник")
		
		addButton("Продолжить", "Ну и ладно", "endthescene")

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return
	
	setState(_action)
