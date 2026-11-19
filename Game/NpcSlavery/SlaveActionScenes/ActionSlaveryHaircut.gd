extends "res://Scenes/SceneBase.gd"

var npcID = ""
var npc:DynamicCharacter

var whichColorIsEdited = 0
var colorPickerScene = preload("res://UI/ColorPickerWidget.tscn")
var rememberedColor = Color.white

var isAlreadyAtBathroom = false
var savedPage:int = 0

func _initScene(_args = []):
	npcID = _args[0]
	npc = GlobalRegistry.getCharacter(npcID)

func resolveCustomCharacterName(_charID):
	if(_charID == "npc"):
		return npcID

func _reactInit():
	if(GM.pc.getLocation() in ["main_bathroom1", "main_bathroom2"]):
		isAlreadyAtBathroom = true

func _init():
	sceneID = "ActionSlaveryHaircut"

func _run():
	if(state == ""):
		savedPage = 0
		addCharacter(npcID)
		if(!isAlreadyAtBathroom):
			aimCameraAndSetLocName("main_bathroom1")
		playAnimation(StageScene.Duo, "stand", {npc=npcID, npcBodyState={leashedBy="pc"}})
		
		if(isAlreadyAtBathroom):
			saynn("Вы стоите у больших зеркал. В раковинах лежат средства для ухода за волосами и их роста, которые можно использовать на своей рабыне, чтобы изменить {npc.his} прическу.")
		else:
			saynn("Вы привязываете рабыню поводком и ведете {npc.him} к одной из душевых. В раковинах лежат средства для ухода за волосами и их роста, которые можно использовать на своей рабыне, чтобы изменить {npc.his} прическу.")
		
		saynn("Что именно вы хотите изменить?")
		
		addButton("Прическа", "Изменить прическу рабыни", "changehaircutmenu")
		var bodypart = npc.getBodypart(BodypartSlot.Hair)
		if(!bodypart.hasCustomSkinPattern()):
			addButton("Кожа", "Изменить текстуру волос", "changepartskinmenu")
		else:
			if(!GlobalRegistry.getPartSkins(bodypart.id).empty() || bodypart.pickedSkin != null):
				addButton("Кожа", "Изменить текстуру волос", "changepartskinmenu")
		addButton("Основной цвет", "Изменить цвет волос рабыни", "changecolor", [0])
		addButton("Вторичный цвет", "Изменить цвет волос рабыни", "changecolor", [1])
		addButton("Третичный цвет", "Изменить цвет волос рабыни", "changecolor", [2])
		addButton("Готово", "Достаточно копания", "endthescene")

	if(state == "changepartskinmenu"):
		saynn("Выберите стиль стрижки, который вы хотите применить к своей рабыне")

		var bodypart = npc.getBodypart(BodypartSlot.Hair)
		addButton("BACK", "Назад", "")
		
		if(bodypart.hasCustomSkinPattern()):
			var defaultSkinIsActive:bool = (bodypart.pickedSkin == null)
			var defaultSkinName:String = ("[Default] " if(defaultSkinIsActive) else "Default")
			var defaultSkinDesc:String = "Сейчас используется стандартный узор кожи" if(defaultSkinIsActive) else "Использовать стандартный узор кожи"
			addButton(defaultSkinName, defaultSkinDesc, "changepartskinmenu_select", [null])
			for skinID in GlobalRegistry.getPartSkins(bodypart.id):
				var theSkin:PartSkinBase = GlobalRegistry.getPartSkin(bodypart.id, skinID)
				var theSkinIsActive:bool = (bodypart.pickedSkin == skinID)
				var theSkinName:String = (("["+theSkin.getName()+"]") if theSkinIsActive else theSkin.getName())
				var theSkinDesc:String = "Это выбранный на данный момент скин" if(theSkinIsActive) else "Выбрать этот скин"
				addButton(theSkinName, theSkinDesc+theSkin.getExtraDesc(), "changepartskinmenu_select", [skinID])
		else:
			var inheritedSkinIsActive = (bodypart.pickedSkin == null)
			var inheritedSkinName = ("[Same as base] " if(inheritedSkinIsActive) else "Как у основы")
			var inheritedSkinDesc = "Сейчас используется скин базовой модели" if(inheritedSkinIsActive) else "Наследовать скин от базовой модели"
			addButton(inheritedSkinName, inheritedSkinDesc, "changepartskinmenu_select", [null])
			for skinID in GlobalRegistry.getSkinsAllKeys():
				var theSkin:SkinBase = GlobalRegistry.getSkin(skinID)
				var theSkinIsActive:bool = (bodypart.pickedSkin == skinID)
				var theSkinName:String = (("["+theSkin.getName()+"]") if theSkinIsActive else theSkin.getName())
				var theSkinDesc:String = "Это выбранный на данный момент скин" if(theSkinIsActive) else "Выбрать этот скин"
				addButton(theSkinName, theSkinDesc+theSkin.getExtraDesc(), "changepartskinmenu_select", [skinID])
		if(savedPage != 0):
			GM.ui.setCurrentPage(savedPage)


	if(state == "changehaircutmenu"):
		saynn("Выберите стрижку, которую вы хотите сделать своей рабыне")
		
		addButton("BACK", "Этот вариант хорош", "")

		var activeHaircutBodypartId:String = ""
		if(npc.hasBodypart(BodypartSlot.Hair)):
			var theHaircut:Bodypart = npc.getBodypart(BodypartSlot.Hair)
			activeHaircutBodypartId = theHaircut.id

		for bodypartID in GlobalRegistry.getBodypartsIdsBySlot(BodypartSlot.Hair):
			var bodypart:Bodypart = GlobalRegistry.getBodypartRef(bodypartID)
			var theHaircutIsActive:bool = (bodypart.id == activeHaircutBodypartId)
			var theHaircutName:String = (("["+bodypart.getName()+"]") if theHaircutIsActive else bodypart.getName())
			var theHaircutDesc:String = "Так выглядит текущая стрижка вашей рабыни" if(theHaircutIsActive) else "Сделать такую стрижку вашей рабыне"
			
			addButton(theHaircutName, theHaircutDesc, "changehair", [bodypartID])

		if(savedPage != 0):
			GM.ui.setCurrentPage(savedPage)

	if(state == "changehair"):
		saynn("Вы напеваете под нос, работая с волосами рабыни; используя мгновенный стимулятор роста и ножницы, вы придаете {npc.his} волосам нужную форму")

		addButton("Продолжить", "Смотреть, что будет дальше", "changehaircutmenu")

	if(state == "changecolor"):
		var bodypart = npc.getBodypart(BodypartSlot.Hair)
		var colorPicker = colorPickerScene.instance()
		GM.ui.addFullScreenCustomControl("colorpicker", colorPicker)
		if(whichColorIsEdited == 0):
			colorPicker.setCurrentColor(bodypart.pickedRColor)
			rememberedColor = bodypart.pickedRColor
		if(whichColorIsEdited == 1):
			colorPicker.setCurrentColor(bodypart.pickedGColor)
			rememberedColor = bodypart.pickedGColor
		if(whichColorIsEdited == 2):
			colorPicker.setCurrentColor(bodypart.pickedBColor)
			rememberedColor = bodypart.pickedBColor
		colorPicker.connect("color_changed", self, "changepartcolormenu_colorchanged")
			
		addButton("Назад", "Назад", "resetcolor_bodypartmenu")
		addButton("Подтвердить", "Выбрать этот цвет", "changepartcolormenu_select")
		

var isChanging = false
func changepartcolormenu_colorchanged(_theColor):
	if(isChanging):
		return
	isChanging = true
	yield(get_tree().create_timer(0.3), "timeout")
	if(GM.ui.getCustomControl("colorpicker") == null):
		isChanging = false
		return
	var theColor = GM.ui.getCustomControl("colorpicker").getCurrentColor()
	var bodypart = npc.getBodypart(BodypartSlot.Hair)
	if(whichColorIsEdited == 0):
		bodypart.pickedRColor = theColor
	if(whichColorIsEdited == 1):
		bodypart.pickedGColor = theColor
	if(whichColorIsEdited == 2):
		bodypart.pickedBColor = theColor
	npc.updateAppearance()
	isChanging = false

func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return
		
	if(_action == "changepartskinmenu_select"):
		savedPage = GM.ui.getCurrentPage()
		var bodypart = npc.getBodypart(BodypartSlot.Hair)
		if(_args.size() > 0 && _args[0] == null):
			bodypart.pickedSkin = null
		else:
			bodypart.pickedSkin = _args[0]
		npc.updateAppearance()
		return
		
	if(_action == "resetcolor_bodypartmenu"):
		var bodypart = npc.getBodypart(BodypartSlot.Hair)
		if(whichColorIsEdited == 0):
			bodypart.pickedRColor = rememberedColor
		if(whichColorIsEdited == 1):
			bodypart.pickedGColor = rememberedColor
		if(whichColorIsEdited == 2):
			bodypart.pickedBColor = rememberedColor
		npc.updateAppearance()
		setState("")
		return
		
	if(_action == "changeskin"):
		runScene("ChangeSkinScene")
		endScene()
		return
	
	if(_action == "changecolor"):
		whichColorIsEdited = _args[0]
	
	if(_action == "changehair"):
		savedPage = GM.ui.getCurrentPage()

		var savedRColor = Color.white
		var savedGColor = Color.white
		var savedBColor = Color.white
		if(npc.hasBodypart(BodypartSlot.Hair)):
			var theHair:Bodypart = npc.getBodypart(BodypartSlot.Hair)
			savedRColor = theHair.pickedRColor
			savedGColor = theHair.pickedGColor
			savedBColor = theHair.pickedBColor
		
		var newHair:Bodypart = GlobalRegistry.createBodypart(_args[0])
		if(newHair != null):
			newHair.pickedRColor = savedRColor
			newHair.pickedGColor = savedGColor
			newHair.pickedBColor = savedBColor
			npc.giveBodypartUnlessSame(newHair)
	
	if(_action == "changepartcolormenu_select"):
		processTime(10*60)
		
		var bodypart = npc.getBodypart(BodypartSlot.Hair)
		if(_args.size() > 0 && _args[0] == null):
			if(whichColorIsEdited == 0):
				bodypart.pickedRColor = null
			if(whichColorIsEdited == 1):
				bodypart.pickedGColor = null
			if(whichColorIsEdited == 2):
				bodypart.pickedBColor = null
		else:
			var theColor = GM.ui.getCustomControl("colorpicker").getCurrentColor()
			if(whichColorIsEdited == 0):
				bodypart.pickedRColor = theColor
			if(whichColorIsEdited == 1):
				bodypart.pickedGColor = theColor
			if(whichColorIsEdited == 2):
				bodypart.pickedBColor = theColor
		setState("")
		npc.updateAppearance()
		return
	
	
	setState(_action)


func saveData():
	var data = .saveData()
	
	data["npcID"] = npcID
	data["whichColorIsEdited"] = whichColorIsEdited
	data["isAlreadyAtBathroom"] = isAlreadyAtBathroom
	data["savedPage"] = savedPage

	return data
	
func loadData(data):
	.loadData(data)
	
	npcID = SAVE.loadVar(data, "npcID", "")
	npc = GlobalRegistry.getCharacter(npcID)
	whichColorIsEdited = SAVE.loadVar(data, "whichColorIsEdited", 0)
	isAlreadyAtBathroom = SAVE.loadVar(data, "isAlreadyAtBathroom", false)
	savedPage = SAVE.loadVar(data, "savedPage", 0)
