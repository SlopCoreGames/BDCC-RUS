extends "res://Scenes/SceneBase.gd"

var savedPage:int = 0

func _init():
	sceneID = "ChangeHaircutScene"

func _run():
	if(state == ""):
		if(!GM.pc.isBlindfolded()):
			saynn("Вы смотрите на себя в зеркало. Рядом лежат расческа, ножницы и еще кое-какие вещи, с помощью которых можно изменить прическу.")
		else:
			saynn("Вы пытаетесь разглядеть себя в зеркале, но понимаете, что ничего не видите. Неловко. Вы ощупываете поверхность и находите расческу, ножницы и еще несколько предметов, которыми можно изменить прическу.")
		
		addButton("Уйти", "Вас устраивает нынешняя стрижка", "endthescene")
		addButton("Сменить прическу", "Изменить прическу", "changehaircutmenu")
		addButton("Сменить кожу!", "Изменить цвет и текстуру кожи", "changeskin")


	if(state == "changehaircutmenu"):
		savedPage = 0
		saynn("Выберите прическу, которая вам нравится")

	if(state == "changehair"):
		saynn("Вы что-то напеваете себе под нос, работая над волосами: используете мгновенный стимулятор роста и ножницы, чтобы придать им нужную форму")

	if(state == "changehaircutmenu" || state == "changehair"):
		addButton("BACK", "Этот вариант хорош", "")
	
		var activeHaircutBodypartId:String = ""
		if(GM.pc.hasBodypart(BodypartSlot.Hair)):
			var theHaircut:Bodypart = GM.pc.getBodypart(BodypartSlot.Hair)
			activeHaircutBodypartId = theHaircut.id

		for bodypartID in GlobalRegistry.getBodypartsIdsBySlot(BodypartSlot.Hair):
			var bodypart:Bodypart = GlobalRegistry.getBodypartRef(bodypartID)
			var theHaircutIsActive:bool = (bodypart.id == activeHaircutBodypartId)
			var theHaircutName:String = (("["+bodypart.getName()+"]") if theHaircutIsActive else bodypart.getName())
			var theHaircutDesc:String = "This is your current haircut" if(theHaircutIsActive) else "Change your haircut to this one"
			
			addButton(theHaircutName, theHaircutDesc, "changehair", [bodypartID])

		if(savedPage != 0):
			GM.ui.setCurrentPage(savedPage)


func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return
		
	if(_action == "changeskin"):
		runScene("ChangeSkinScene")
		endScene()
		return
	
	if(_action == "changehair"):
		savedPage = GM.ui.getCurrentPage()

		var savedRColor = Color.white
		var savedGColor = Color.white
		var savedBColor = Color.white
		if(GM.pc.hasBodypart(BodypartSlot.Hair)):
			var theHair:Bodypart = GM.pc.getBodypart(BodypartSlot.Hair)
			savedRColor = theHair.pickedRColor
			savedGColor = theHair.pickedGColor
			savedBColor = theHair.pickedBColor

		var newHair = GlobalRegistry.createBodypart(_args[0])
		if(newHair != null):
			newHair.pickedRColor = savedRColor
			newHair.pickedGColor = savedGColor
			newHair.pickedBColor = savedBColor
			GM.pc.giveBodypartUnlessSame(newHair)
	
	setState(_action)

func saveData():
	var data = .saveData()

	data["savedPage"] = savedPage

	return data
	
func loadData(data):
	.loadData(data)

	savedPage = SAVE.loadVar(data, "savedPage", 0)
