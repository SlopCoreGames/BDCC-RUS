extends "res://Scenes/SceneBase.gd"

func _init():
	sceneID = "WorkInMinesScene"

func _run():
	if(state == ""):
		saynn("Ты хватаешь кирку и отправляешься вглубь шахт.")

		addButton("Работать", "Работать", "work")
	
	if(state == "work"):
		saynn("Ты проводишь несколько часов, перекатывая вагонетки и долбя камни. Ты чертовски устал, но, по крайней мере, заработал немного денег.")
		
		addButton("Продолжить", "Наконец-то отдохнуть", "endthescene")

		GM.ES.triggerRun(Trigger.WorkingInMines)

func _react(_action: String, _args):
	if(_action == "work"):
		
		GM.pc.addCredits(1)
		GM.pc.addStamina(-40)
		
		processTime(2*60*60)
		
		if(GM.ES.triggerReact(Trigger.WorkingInMines)):
			endScene()
			return
		
		addMessage("You earned 1 work credit")

	if(_action == "endthescene"):
		endScene()
		return
	
	setState(_action)
