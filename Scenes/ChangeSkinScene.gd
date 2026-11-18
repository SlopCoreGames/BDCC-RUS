extends "res://Scenes/SceneBase.gd"

var whichColorIsEdited = 0
var pickedBodypartSlot = BodypartSlot.Body
var rememberedColor = Color.white
var editingID = "pc"
var thePC
var debugMode = false
var savedPage:int = 0

var colorPickerScene = preload("res://UI/ColorPickerWidget.tscn")
var textWidgetScene = preload("res://UI/TextOutputWidget.tscn")

func _initScene(_args = []):
	if(_args.size() > 0):
		editingID = _args[0]
	thePC = GlobalRegistry.getCharacter(editingID)
	if(_args.size() > 1 && _args[1]):
		debugMode = true
		if(editingID != "pc"):
			addCharacter(editingID)
	playAnimation(StageScene.Solo, "stand", {pc=editingID, bodyState={naked=true, hard=true}})

func _init():
	sceneID = "ChangeSkinScene"

func _run():
	if(debugMode && state != "changebasecolormenu" && state != "changepartcolormenu"):
		var textEdit = textWidgetScene.instance()
		GM.ui.addCustomControl("textedit", textEdit)
		
		var outputText = []
		outputText.append("pickedSkin=\""+thePC.pickedSkin+"\"")
		outputText.append("pickedSkinRColor=Color(\""+thePC.pickedSkinRColor.to_html()+"\")")
		outputText.append("pickedSkinGColor=Color(\""+thePC.pickedSkinGColor.to_html()+"\")")
		outputText.append("pickedSkinBColor=Color(\""+thePC.pickedSkinBColor.to_html()+"\")")
		outputText.append("npcSkinData={")
		for bodypartSlot in thePC.getBodyparts():
			if(!thePC.hasBodypart(bodypartSlot)):
				continue
			var bodypart:Bodypart = thePC.getBodypart(bodypartSlot)
			var changedValues = ""
			if(bodypart.pickedSkin != null):
				changedValues +='"skin": "'+bodypart.pickedSkin+'",'
			if(bodypart.pickedRColor != null):
				changedValues +='"r": Color("'+bodypart.pickedRColor.to_html()+'"),'
			if(bodypart.pickedGColor != null):
				changedValues +='"g": Color("'+bodypart.pickedGColor.to_html()+'"),'
			if(bodypart.pickedBColor != null):
				changedValues +='"b": Color("'+bodypart.pickedBColor.to_html()+'"),'
			if(changedValues != ""):
				outputText.append('"'+bodypartSlot+'": {'+changedValues+'},')
		outputText.append("}")
		
		textEdit.setText("\t"+Util.join(outputText, "\n\t"))
	
	if(state == ""):
		if(debugMode):
			addButton("ОБНОВИТЬ СКИНЫ", "Перезагрузить все пользовательские скины с диска", "do_reload_skins")
		
		saynn("В этом меню вы можете изменить кожу и цвета своего персонажа!")
		
		saynn("Начните с изменения базового скина. Все части тела используют базовый цвет, если вы не настроите их отдельно.")
		
		
		addButton("Подтвердить", "Работа выполнена!", "endthescene")
		
		addButton("Базовый скин/цвета", "Выберите базовый скин/цвета", "basemenu")
		
		for bodypartSlot in BodypartSlot.getAll():
			if(!thePC.hasBodypart(bodypartSlot)):
				continue
			var bodypart = thePC.getBodypart(bodypartSlot)
			if(!bodypart.supportsSkin()):
				continue
			#addButton(bodypart.getName(), "Изменить скин/цвет этой части тела", "bodypartmenu", [bodypartSlot])
			addButton(BodypartSlot.getVisibleName(bodypartSlot), "Изменить скин/цвет "+str(bodypart.getName()), "bodypartmenu", [bodypartSlot])

	if(state == "basemenu"):
		savedPage = 0
		addButton("Назад", "Назад", "")
		addButton("Кожа", "Изменить базовый цвет кожи", "changebaseskinmenu")
		addButton("Основной цвет", "Изменить основной цвет кожи", "changebasecolormenu", [0])
		addButton("Вторичный цвет", "Изменить вторичный цвет кожи", "changebasecolormenu", [1])
		addButton("Третичный цвет", "Изменить третичный цвет кожи", "changebasecolormenu", [2])
		addButton("Перемешать цвета", "Выбрать случайные цвета", "dorandomcolors")
		addButton("Перемешать ВСЁ", "Выбрать случайную кожу и цвета", "dorandomcolorsall")

	if(state == "changebaseskinmenu"):		
		addButton("Назад", "Назад", "basemenu")
		for skinID in GlobalRegistry.getSkinsAllKeys():
			var theSkin:SkinBase = GlobalRegistry.getSkin(skinID)
			var theSkinIsActive:bool = (thePC.pickedSkin == skinID)
			var theSkinName:String = (("["+theSkin.getName()+"]") if theSkinIsActive else theSkin.getName())
			var theSkinDesc:String = "This is the currently selected skin" if(theSkinIsActive) else "Pick this skin"
			addButton(theSkinName, theSkinDesc+theSkin.getExtraDesc(), "changebaseskinmenu_select", [skinID])
		if(savedPage != 0):
			GM.ui.setCurrentPage(savedPage)

	if(state == "changebasecolormenu"):
		var colorPicker = colorPickerScene.instance()
		GM.ui.addFullScreenCustomControl("colorpicker", colorPicker)
		if(whichColorIsEdited == 0):
			colorPicker.setCurrentColor(thePC.pickedSkinRColor)
			rememberedColor = thePC.pickedSkinRColor
		if(whichColorIsEdited == 1):
			colorPicker.setCurrentColor(thePC.pickedSkinGColor)
			rememberedColor = thePC.pickedSkinGColor
		if(whichColorIsEdited == 2):
			colorPicker.setCurrentColor(thePC.pickedSkinBColor)
			rememberedColor = thePC.pickedSkinBColor
		colorPicker.connect("color_changed", self, "changebasecolormenu_colorchanged")
			
		addButton("Назад", "Назад", "resetcolor_basemenu")
		addButton("Подтвердить", "Выбрать этот цвет", "changebasecolormenu_select")

	if(state == "bodypartmenu"):
		savedPage = 0
		var bodypart = thePC.getBodypart(pickedBodypartSlot)
		
		addButton("Назад", "Назад", "")
		if(!bodypart.hasCustomSkinPattern()):
			addButton("Кожа", "Сменить кожу части тела", "changepartskinmenu")
		else:
			if(!GlobalRegistry.getPartSkins(bodypart.id).empty() || bodypart.pickedSkin != null):
				addButton("Кожа", "Сменить кожу части тела", "changepartskinmenu")
		addButton("Основной цвет", "Сменить основной цвет части тела", "changepartcolormenu", [0])
		addButton("Вторичный цвет", "Сменить дополнительный цвет части тела", "changepartcolormenu", [1])
		addButton("Третичный цвет", "Сменить третий цвет части тела", "changepartcolormenu", [2])


	if(state == "changepartskinmenu"):
		var bodypart = thePC.getBodypart(pickedBodypartSlot)
		addButton("Назад", "Назад", "bodypartmenu")
		
		if(bodypart.hasCustomSkinPattern()):
			var defaultSkinIsActive = (bodypart.pickedSkin == null)
			var defaultSkinName = ("[Default] " if(defaultSkinIsActive) else "Default")
			var defaultSkinDesc = "Currently using the default skin pattern" if(defaultSkinIsActive) else "Use the default skin pattern"
			addButton(defaultSkinName, defaultSkinDesc, "changepartskinmenu_select", [null])
			for skinID in GlobalRegistry.getPartSkins(bodypart.id):
				var theSkin:PartSkinBase = GlobalRegistry.getPartSkin(bodypart.id, skinID)
				var theSkinIsActive:bool = (bodypart.pickedSkin == skinID)
				var theSkinName:String = (("["+theSkin.getName()+"]") if theSkinIsActive else theSkin.getName())
				var theSkinDesc:String = "This is the currently selected skin" if(theSkinIsActive) else "Pick this skin"
				addButton(theSkinName, theSkinDesc+theSkin.getExtraDesc(), "changepartskinmenu_select", [skinID])
		else:
			var inheritedSkinIsActive = (bodypart.pickedSkin == null)
			var inheritedSkinName = ("[Same as base] " if(inheritedSkinIsActive) else "Same as base")
			var inheritedSkinDesc = "Currently inheriting the skin from the base" if(inheritedSkinIsActive) else "Inherit the skin from the base"
			addButton(inheritedSkinName, inheritedSkinDesc, "changepartskinmenu_select", [null])
			for skinID in GlobalRegistry.getSkinsAllKeys():
				var theSkin:SkinBase = GlobalRegistry.getSkin(skinID)
				var theSkinIsActive:bool = (bodypart.pickedSkin == skinID)
				var theSkinName:String = (("["+theSkin.getName()+"]") if theSkinIsActive else theSkin.getName())
				var theSkinDesc:String = "This is the currently selected skin" if(theSkinIsActive) else "Pick this skin"
				addButton(theSkinName, theSkinDesc+theSkin.getExtraDesc(), "changepartskinmenu_select", [skinID])
		if(savedPage != 0):
			GM.ui.setCurrentPage(savedPage)
		
	if(state == "changepartcolormenu"):
		var bodypart = thePC.getBodypart(pickedBodypartSlot)
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
		addButton("Как у основы", "Наследовать цвет от основы", "changepartcolormenu_select", [null])

var isChanging = false
func changebasecolormenu_colorchanged(_theColor):
	if(isChanging):
		return
	isChanging = true
	yield(get_tree().create_timer(0.3), "timeout")
	if(GM.ui.getCustomControl("colorpicker") == null):
		isChanging = false
		return
	var theColor = GM.ui.getCustomControl("colorpicker").getCurrentColor()
	if(whichColorIsEdited == 0):
		thePC.pickedSkinRColor = theColor
	if(whichColorIsEdited == 1):
		thePC.pickedSkinGColor = theColor
	if(whichColorIsEdited == 2):
		thePC.pickedSkinBColor = theColor
	thePC.updateAppearance()
	isChanging = false

func changepartcolormenu_colorchanged(_theColor):
	if(isChanging):
		return
	isChanging = true
	yield(get_tree().create_timer(0.3), "timeout")
	if(GM.ui.getCustomControl("colorpicker") == null):
		isChanging = false
		return
	var theColor = GM.ui.getCustomControl("colorpicker").getCurrentColor()
	var bodypart = thePC.getBodypart(pickedBodypartSlot)
	if(whichColorIsEdited == 0):
		bodypart.pickedRColor = theColor
	if(whichColorIsEdited == 1):
		bodypart.pickedGColor = theColor
	if(whichColorIsEdited == 2):
		bodypart.pickedBColor = theColor
	thePC.updateAppearance()
	isChanging = false

func _react(_action: String, _args):
	if(_action == "endthescene"):
		if(editingID == "pc"):
			setFlag("PickedSkinAtLeastOnce", true)
		endScene()
		return
	
	if(_action == "resetcolor_basemenu"):
		if(whichColorIsEdited == 0):
			thePC.pickedSkinRColor = rememberedColor
		if(whichColorIsEdited == 1):
			thePC.pickedSkinGColor = rememberedColor
		if(whichColorIsEdited == 2):
			thePC.pickedSkinBColor = rememberedColor
		thePC.updateAppearance()
		setState("basemenu")
		return
		
	if(_action == "resetcolor_bodypartmenu"):
		var bodypart = thePC.getBodypart(pickedBodypartSlot)
		if(whichColorIsEdited == 0):
			bodypart.pickedRColor = rememberedColor
		if(whichColorIsEdited == 1):
			bodypart.pickedGColor = rememberedColor
		if(whichColorIsEdited == 2):
			bodypart.pickedBColor = rememberedColor
		thePC.updateAppearance()
		setState("bodypartmenu")
		return
	
	if(_action == "changebasecolormenu"):
		whichColorIsEdited = _args[0]
		
	if(_action == "changepartcolormenu"):
		whichColorIsEdited = _args[0]
		
	if(_action == "bodypartmenu"):
		if(_args.size() > 0):
			pickedBodypartSlot = _args[0]
	
	if(_action == "changebaseskinmenu_select"):
		savedPage = GM.ui.getCurrentPage()
		thePC.pickedSkin = _args[0]
		thePC.updateAppearance()
		return
	
	if(_action == "changebasecolormenu_select"):
		var theColor = GM.ui.getCustomControl("colorpicker").getCurrentColor()
		if(whichColorIsEdited == 0):
			thePC.pickedSkinRColor = theColor
		if(whichColorIsEdited == 1):
			thePC.pickedSkinGColor = theColor
		if(whichColorIsEdited == 2):
			thePC.pickedSkinBColor = theColor
		setState("basemenu")
		thePC.updateAppearance()
		return
	
	if(_action == "changepartskinmenu_select"):
		savedPage = GM.ui.getCurrentPage()
		var bodypart = thePC.getBodypart(pickedBodypartSlot)
		if(_args.size() > 0 && _args[0] == null):
			bodypart.pickedSkin = null
		else:
			bodypart.pickedSkin = _args[0]
		thePC.updateAppearance()
		return
	
	if(_action == "changepartcolormenu_select"):
		var bodypart = thePC.getBodypart(pickedBodypartSlot)
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
		setState("bodypartmenu")
		thePC.updateAppearance()
		return
		
	if(_action == "do_reload_skins"):
		playAnimation(StageScene.Solo, "walk", {pc=editingID, bodyState={naked=true,hard=true}})
		GlobalRegistry.findCustomSkins()
		thePC.updateAppearance()
		return
		
	if(_action == "dorandomcolors"):
		thePC.applyRandomColors()
		thePC.updateAppearance()
		return
	
	if(_action == "dorandomcolorsall"):
		thePC.applyRandomSkinAndColorsAndParts()
		thePC.updateAppearance()
		return
	
	setState(_action)

func saveData():
	var data = .saveData()
	
	data["whichColorIsEdited"] = whichColorIsEdited
	data["pickedBodypartSlot"] = pickedBodypartSlot
	data["editingID"] = editingID
	data["debugMode"] = debugMode
	data["savedPage"] = savedPage

	return data
	
func loadData(data):
	.loadData(data)
	
	whichColorIsEdited = SAVE.loadVar(data, "whichColorIsEdited", 0)
	pickedBodypartSlot = SAVE.loadVar(data, "pickedBodypartSlot", BodypartSlot.Body)
	editingID = SAVE.loadVar(data, "editingID", "pc")
	thePC = GlobalRegistry.getCharacter(editingID)
	debugMode = SAVE.loadVar(data, "debugMode", false)
	savedPage = SAVE.loadVar(data, "savedPage", 0)
