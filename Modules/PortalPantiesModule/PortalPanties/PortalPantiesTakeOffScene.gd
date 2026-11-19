extends "res://Scenes/SceneBase.gd"

var uniqueItemID = ""

func _initScene(_args = []):
	if(_args.size() > 0):
		uniqueItemID = _args[0]

func _init():
	sceneID = "PortalPantiesTakeOffScene"

func _run():

	if(state == ""):
		if(!GM.QS.isActive("PortalPantiesQuest")):
			playAnimation(StageScene.Solo, "stand", {bodyState={exposedCrotch=true}})
			saynn("Что ты хочешь сделать со своими портальными трусиками?")
			
			var currentMode = getFlag("PortalPantiesModule.Panties_Mode", 0)
			if(currentMode == 0):
				saynn("Текущая частота событий: нормальная")
			elif(currentMode == 1):
				saynn("Текущая частота событий: редкая")
			elif(currentMode == 2):
				saynn("Текущая частота событий: очень редкая")
			elif(currentMode == -1):
				saynn("Текущая частота событий: частая")
			
			var item = GM.pc.getInventory().getItemByUniqueID(uniqueItemID)
			if(item != null):
				if(item.coversPenis):
					saynn("Твои портальные трусики также будут создавать портал для твоего члена."+(" (If you'd had one)" if !GM.pc.hasPenis() else ""))
				else:
					saynn("Твои портальные трусики не скрывают член, позволяя им пользоваться им."+(" (If you'd had one)" if !GM.pc.hasPenis() else ""))
			
			addButton("Снять", "Снять портальные трусики", "takeoff")
			addButton("Сменить режим", "Изменить частоту событий", "changemode")
			addButton("Пенис", "Включить, если вы хотите, чтобы портальные трусики скрывали ваш член или нет", "changepenismode")
			addButton("Ничего", "Не трогай их", "endthescene")
		else:		
			saynn("Вы пытаетесь снять портальные трусики, но что бы вы ни делали, магнитные замки не дают вам этого сделать.")

			saynn("Похоже, их удается снять лишь в самых редких случаях.")

			addButton("Продолжить", "Ну что ж, тут уж ничего не поделаешь", "endthescene")
	
	if(state == "changemode"):
		saynn("Как часто должны происходить события")
		
		var currentMode = getFlag("PortalPantiesModule.Panties_Mode", 0)
		if(currentMode == 0):
			saynn("Текущая частота: обычная")
		elif(currentMode == 1):
			saynn("Текущая частота: редкая")
		elif(currentMode == 2):
			saynn("Текущая частота: очень редкая")
		elif(currentMode == -1):
			saynn("Текущая частота: частая")
			
		addButton("Очень редко", "Тебя будут тыкать крайне редко", "setMode", [2])
		addButton("Редко", "Тебя будут тыкать время от времени", "setMode", [1])
		addButton("Обычный", "Тебя будут тыкать время от времени", "setMode", [0])
		addButton("Часто", "Тебя будут тыкать довольно часто", "setMode", [-1])
		addButton("Назад", "Ты вряд ли захочешь менять этот режим", "")

func _react(_action: String, _args):
	if(_action == "setMode"):
		setFlag("PortalPantiesModule.Panties_Mode", _args[0])
		setFlag("PortalPantiesModule.Panties_SceneCooldown", 0)
		return
		
	if(_action == "changepenismode"):
		var item = GM.pc.getInventory().getItemByUniqueID(uniqueItemID)
		if(item != null):
			item.coversPenis = !item.coversPenis
		return
	
	if(_action == "takeoff"):
		endScene()
		runScene("TakeAnyItemOffScene", [uniqueItemID])
		return
	
	if(_action == "endthescene"):
		endScene()
		return

	setState(_action)

func saveData():
	var data = .saveData()
	
	data["uniqueItemID"] = uniqueItemID
	
	return data
	
func loadData(data):
	.loadData(data)
	
	uniqueItemID = SAVE.loadVar(data, "uniqueItemID", "")
