extends "res://Scenes/SceneBase.gd"

var pickingBodypartType = BodypartSlot.Legs
var pickedFirstSpeciesHybrid = ""
var pickedAttribID = ""
var bodyPickedAttribID = ""
var debugMode = false
var savedPage:int = 0

var colorPickerScene = preload("res://UI/ColorPickerWidget.tscn")

func _initScene(_args = []):
	if(_args.size() > 0 && _args[0]):
		debugMode = true
		state = "pickedspecies"

func _init():
	sceneID = "CharacterCreatorScene"

func _run():
	#print(Bodypart.findPossibleBodypartIDs(BodypartSlot.Tail, GM.pc, [Species.Human]))
	
	if(state == "" || state == "pickgender"):
		say("Выберите пол своего персонажа. Это повлияет на цвет вашего текста и на то, как к вам будут относиться окружающие. Пол можно изменить в любой момент")
		
		addButton("Мужской", "Вы — парень", "setgender", [Gender.Male])
		addButton("Женский", "Вы — девушка", "setgender", [Gender.Female])
		addButton("Андрогинный", "Что-то среднее", "setgender", [Gender.Androgynous])
		addButton("Другой", "Что-то иное", "setgender", [Gender.Other])

	if(state == "pickpronouns"):
		say("Выберите местоимения для вашего персонажа. Их можно изменить в любой момент")

		addButton("Производное от пола", "Автоматически подбирать местоимения в зависимости от пола", "setpronouns", [null])
		addButton("he/his", "Выбрать мужские местоимения", "setpronouns", [Gender.Male])
		addButton("she/her", "Выбрать женские местоимения", "setpronouns", [Gender.Female])
		addButton("they/their", "Выбрать андрогинные или нейтральные местоимения", "setpronouns", [Gender.Androgynous])
		addButton("it/its", "Выбрать нейтральные местоимения", "setpronouns", [Gender.Other])
		addButton("back", "Назад к выбору пола", "pickgender")

	if(state == "pickspecies"):
		say("Выберите вид вашего персонажа")
		var allSpecies = GlobalRegistry.getAllPlayableSpecies()
		for speciesID in allSpecies:
			var speciesInfo = GlobalRegistry.getSpecies(speciesID)
			addButton(speciesInfo.getVisibleName(), speciesInfo.getVisibleDescription(), "setspecies", [[speciesID]])
		addButton("Создать гибрида", "Создать кастомного гибрида", "pickhybrid1")
		addButton("back", "Вернуться к выбору местоимений", "pickpronouns")

	if(state == "pickhybrid1"):
		say("Выберите первую расу")
		
		var allSpecies = GlobalRegistry.getAllPlayableSpecies()
		for speciesID in allSpecies:
			var speciesInfo = GlobalRegistry.getSpecies(speciesID)
			addButton(speciesInfo.getVisibleName(), speciesInfo.getVisibleDescription(), "pick2species", [speciesID])
			
		addButton("back", "Назад", "pickspecies")

	if(state == "pick2species"):
		say("Выберите вторую расу")
		
		var allSpecies = GlobalRegistry.getAllPlayableSpecies()
		for speciesID in allSpecies:
			if(pickedFirstSpeciesHybrid == speciesID):
				continue
			
			var speciesInfo = GlobalRegistry.getSpecies(speciesID)
			addButton(speciesInfo.getVisibleName(), speciesInfo.getVisibleDescription(), "setspecies", [[pickedFirstSpeciesHybrid, speciesID]])
		
		addButton("back", "Назад", "pickhybrid1")

	if(state == "pickedspecies"):
		savedPage = 0
		playAnimation(StageScene.Solo, "stand", {bodyState={naked=true,hard=true}})
		
		if(debugMode):
			saynn("[b]Сцена запущена в режиме отладки, ограничения по частям тела не применяются[/b]")
		
		say("Вы — "+GM.pc.getSpeciesFullName())
		say("\n----\n")
		
		var bodyparts = GM.pc.getBodyparts()
		var allSlots = BodypartSlot.getAll()
		for slot in allSlots:
			var slotName = BodypartSlot.getVisibleName(slot)
			if(!bodyparts.has(slot) || bodyparts[slot] == null):
				say(slotName+": Нет\n")
				continue
			
			var bodypart = bodyparts[slot]
			say(slotName+": "+bodypart.getCharacterCreatorName().capitalize())
			#var extra = bodypart.getExtraInfoCreation()
			#if(extra!=""):
			#	say(" (" + extra + ")")
			say("\n")
			for curAttrib in bodypart.getAttributesText():
				sayn(" - "+curAttrib[0]+": "+str(curAttrib[1]))
				
			#say("\n")
		say("\n")
		sayn("Атрибуты тела:")
		for curAttrib in GM.pc.getAttributesText():
			sayn(curAttrib[0]+": "+str(curAttrib[1]))
			

		addExtraButtonAt(0, "Подтвердить", "Подтвердить персонажа", "donecreating")
		
		for slot in allSlots:
			var slotName = BodypartSlot.getVisibleName(slot)
			addButton(slotName, "Изменить эту часть тела", "pickbodypart", [slot])
			
		addExtraButtonAt(3, "Параметры тела", "Изменить женственность, полноту и прочее", "bodyAttributes")
			
		# DEBUG testing stuff, feel free to remove
		if(false):
			sayn("\nПРИМЕР ОПИСАНИЯ:")
			if(GM.pc.hasPenis()):
				sayn("твой член {pc.cockSize} и также {pc.cockDesc}")
				saynn("У вас есть {pc.aPenis}")
			sayn("У вас есть {pc.breasts}")
			saynn("Ваша грудь {pc.breastsSize} и она также {pc.breastsDesc}")
			if(GM.pc.hasVagina()):
				saynn("У вас есть {pc.aVagina}")
			if(GM.pc.hasTail()):
				saynn("У вас есть {pc.aTail}")
			saynn("Тип вашего тела {pc.thick}, вы выглядите {pc.feminine}")
			
		
		if(!debugMode):
			addExtraButtonAt(4, "Сменить расу", "Назад к выбору расы", "pickspecies")
		else:
			addExtraButtonAt(4, "Сменить расу", "! Это перезапишет все части тела !", "pickspecies")
		
	if(state == "pickbodypart"):
		saynn("Выберите часть тела или измените параметры текущей")
		
		addButton("Назад", "назад", "pickedspecies")
		
		var playerBodypart = null
		
		if(GM.pc.hasBodypart(pickingBodypartType)):
			playerBodypart = GM.pc.getBodypart(pickingBodypartType)
			
			sayn("Выбрано сейчас: "+playerBodypart.getCharacterCreatorName())
			for curAttrib in playerBodypart.getAttributesText():
				sayn(curAttrib[0]+": "+str(curAttrib[1]))
			
			var attribOptions = playerBodypart.getPickableAttributes()
			if(attribOptions.size() > 0):
				addButton("Изменить текущее", "Изменять параметры текущей части тела вместо создания новой", "bodypartAttributes")
			
			
		
		var playerSpecies: Array = GM.pc.getSpecies()
			
		if(!BodypartSlot.isEssential(pickingBodypartType)):
			var bodypartIsMissing:bool = (playerBodypart == null)
			var nothingBodypartName:String = "[Nothing]" if(bodypartIsMissing) else "Nothing"
			var nothingBodypartDesc:String = "Это текущий выбранный вариант" if(bodypartIsMissing) else "Удалить часть тела.\n\nПРИМЕЧАНИЕ: Это сбросит цвет и текстуру кожи данной части тела."
			addButton(nothingBodypartName, nothingBodypartDesc, "removebodypart", [pickingBodypartType])
			
		var allbodypartsIDs = GlobalRegistry.getBodypartsIdsBySlot(pickingBodypartType)
		for bodypartID in allbodypartsIDs:
			var bodypart = GlobalRegistry.getBodypartRef(bodypartID)
			if(!bodypart):
				continue
			var supportedSpecies:Array = bodypart.getCompatibleSpeciesFinal()
			
			var hasInSupported = false || debugMode
			var hasInAllowed = false
			
			for supported in supportedSpecies:
				if((supported in playerSpecies) || (supported in [Species.Any, Species.AnyNPC])):
					hasInSupported = true
					break
				
			for playerSpecie in playerSpecies:
				var speciesObject = GlobalRegistry.getSpecies(playerSpecie)
				if(speciesObject && (bodypartID in speciesObject.getAllowedBodypartsFinal())):
					hasInAllowed = true
					break
			
			if(hasInSupported || hasInAllowed):
				var bodypartIsActive:bool = (playerBodypart != null) && (playerBodypart.id == bodypart.id)
				var bodypartName:String = ("["+bodypart.getCharacterCreatorName()+"]" if(bodypartIsActive) else bodypart.getCharacterCreatorName())
				var bodypartDesc:String = bodypart.getCharacterCreatorDescFinal(bodypartIsActive)
				addButton(bodypartName, bodypartDesc, "setbodypart", [bodypart.id])

		if(savedPage != 0):
			GM.ui.setCurrentPage(savedPage)

	if(state == "bodypartAttributes"):
		playAnimation(StageScene.Solo, "stand", {bodyState={naked=true,hard=true}})
		
		var bodypart = GM.pc.getBodypart(pickingBodypartType)
		var attributes = bodypart.getPickableAttributes()
		
		saynn("Изменить параметры "+bodypart.getCharacterCreatorName())
		for curAttrib in bodypart.getAttributesText():
			sayn(curAttrib[0]+": "+str(curAttrib[1]))
		
		addButton("Готово", "Настройка параметров завершена", "pickedspecies")
		
		for attributeID in attributes:
			var attribute = attributes[attributeID]
			addButton(attribute["textButton"], attribute["buttonDesc"], "attributeMenu", [attributeID])

	if(state == "attributeMenu"):
		var bodypart = GM.pc.getBodypart(pickingBodypartType)
		var attributes = bodypart.getPickableAttributes()
		var currentAttribute = attributes[pickedAttribID]
		
		saynn(currentAttribute["text"])
		if(currentAttribute.has("type")):
			var attribType = currentAttribute["type"]
			if(attribType == "color"):
				var colorPicker = colorPickerScene.instance()
				GM.ui.addFullScreenCustomControl("colorpicker", colorPicker)
				if(currentAttribute.has("currentColor") && currentAttribute["currentColor"] != null):
					colorPicker.setCurrentColor(currentAttribute["currentColor"])
		
		for option in currentAttribute["options"]:
			addButton(option[1], option[2], "setAttribute", [option[0]])
		
		addButton("Назад", "Назад на меню", "bodypartAttributes")
	
	if(state == "bodyAttributes"):
		var attributes = GM.pc.getPickableAttributes()
		
		saynn("Выберите, что именно вы хотите изменить в своем теле")
		for curAttrib in GM.pc.getAttributesText():
			sayn(curAttrib[0]+": "+str(curAttrib[1]))
		
		addButton("Готово", "Настройка параметров завершена", "pickedspecies")
		addButton("Кожа/Цвета", "Изменить внешность", "startskinmenu")
		
		for attributeID in attributes:
			var attribute = attributes[attributeID]
			addButton(attribute["textButton"], attribute["buttonDesc"], "bodyAttributeMenu", [attributeID])

		var bodyparts = GM.pc.getBodyparts()
		var allSlots = BodypartSlot.getAll()
		for slot in allSlots:
			var bodypart = bodyparts[slot]
			if(bodypart == null):
				continue
			var bodypartAttributes = bodypart.getPickableAttributes()
			if(bodypartAttributes.size() == 0):
				continue
			addButton(bodypart.getCharacterCreatorName().capitalize()+" attributes", "Изменить параметры этой части тела", "openBodypartAttributes", [slot])
			

	if(state == "bodyAttributeMenu"):
		var attributes = GM.pc.getPickableAttributes()
		var currentAttribute = attributes[bodyPickedAttribID]
		
		saynn(currentAttribute["text"])
		if(currentAttribute.has("type")):
			var attribType = currentAttribute["type"]
			if(attribType == "color"):
				var colorPicker = colorPickerScene.instance()
				GM.ui.addFullScreenCustomControl("colorpicker", colorPicker)
				if(currentAttribute.has("currentColor")):
					colorPicker.setCurrentColor(currentAttribute["currentColor"])
		
		for option in currentAttribute["options"]:
			addButton(option[1], option[2], "bodySetAttribute", [option[0]])
		
		
		addButton("Назад", "Назад на меню", "bodyAttributes")

func _react(_action: String, _args):
	if(_action == "setgender"):
		GM.pc.setGender(_args[0])
		setState("pickpronouns")
		return
		
	if(_action == "setpronouns"):
		GM.pc.setPronounGender(_args[0])
		setState("pickspecies")
		return
		
	if(_action == "setspecies"):
		GM.pc.setSpecies(_args[0])
		GM.pc.resetBodypartsToDefault()
		setState("pickedspecies")
		return
		
	if(_action == "attributeMenu"):
		if(_args.size() > 0):
			pickedAttribID = _args[0]
	
	if(_action == "setAttribute"):
		var pickedValue = _args[0]
		var bodypart = GM.pc.getBodypart(pickingBodypartType)
		var attributes = bodypart.getPickableAttributes()
		var currentAttribute = attributes[pickedAttribID]
		
		if(currentAttribute.has("type") && currentAttribute["type"] == "color" && pickedValue == 1):
			var colorPicker = GM.ui.getCustomControl("colorpicker")
			bodypart.applyAttribute(pickedAttribID, colorPicker.getCurrentColor())
		else:
			bodypart.applyAttribute(pickedAttribID, pickedValue)
		
		#bodypart.applyAttribute(pickedAttribID, pickedValue)
		GM.pc.updateAppearance()
		setState("bodypartAttributes")
		return
	
	if(_action == "bodyAttributeMenu"):
		if(_args.size() > 0):
			bodyPickedAttribID = _args[0]
	
	if(_action == "bodySetAttribute"):
		var pickedValue = _args[0]
		var attributes = GM.pc.getPickableAttributes()
		var currentAttribute = attributes[bodyPickedAttribID]
		
		if(currentAttribute.has("type") && currentAttribute["type"] == "color" && pickedValue == 1):
			var colorPicker = GM.ui.getCustomControl("colorpicker")
			GM.pc.applyAttribute(bodyPickedAttribID, colorPicker.getCurrentColor())
		else:
			GM.pc.applyAttribute(bodyPickedAttribID, pickedValue)
		GM.pc.updateAppearance()
		setState("bodyAttributes")
		return
	
	if(_action == "openBodypartAttributes"):
		if(_args.size() > 0):
			pickingBodypartType = _args[0]
			
		setState("bodypartAttributes")
		return
	
	if(_action == "pickbodypart"):
		if(_args.size() > 0):
			pickingBodypartType = _args[0]
	
	if(_action == "removebodypart"):
		savedPage = GM.ui.getCurrentPage()

		var bodypartSlot = _args[0]

		GM.pc.removeBodypart(bodypartSlot)
		return
	
	if(_action == "setbodypart"):
		savedPage = GM.ui.getCurrentPage()

		var savedRColor = null
		var savedGColor = null
		var savedBColor = null
		var savedSkinId = null
		var playerHadBodypartInSlot:bool = false
		if(GM.pc.hasBodypart(pickingBodypartType)):
			var playerBodypart:Bodypart = GM.pc.getBodypart(pickingBodypartType)
			savedRColor = playerBodypart.pickedRColor
			savedGColor = playerBodypart.pickedGColor
			savedBColor = playerBodypart.pickedBColor
			if(!playerBodypart.hasCustomSkinPattern()):
				savedSkinId = playerBodypart.pickedSkin
			playerHadBodypartInSlot = true

		var newBodypartId = _args[0]
		var newBodypart = GlobalRegistry.createBodypart(newBodypartId)
		if(newBodypart != null):
			if(playerHadBodypartInSlot):
				newBodypart.pickedRColor = savedRColor
				newBodypart.pickedGColor = savedGColor
				newBodypart.pickedBColor = savedBColor
				if(!newBodypart.hasCustomSkinPattern()):
					newBodypart.pickedSkin = savedSkinId
			GM.pc.giveBodypartUnlessSame(newBodypart)

		return
		
	if(_action == "pick2species"):
		pickedFirstSpeciesHybrid = _args[0]
	
	if(_action == "endthescene" || _action == "donecreating"):
		endScene()
		return
	
	if(_action == "startskinmenu"):
		runScene("ChangeSkinScene")
		return

	setState(_action)


func saveData():
	var data = .saveData()
	
	data["pickingBodypartType"] = pickingBodypartType
	data["pickedFirstSpeciesHybrid"] = pickedFirstSpeciesHybrid
	data["pickedAttribID"] = pickedAttribID
	data["bodyPickedAttribID"] = bodyPickedAttribID
	data["debugMode"] = debugMode
	data["savedPage"] = savedPage
	
	return data
	
func loadData(data):
	.loadData(data)
	
	pickingBodypartType = SAVE.loadVar(data, "pickingBodypartType", BodypartSlot.Legs)
	pickedFirstSpeciesHybrid = SAVE.loadVar(data, "pickedFirstSpeciesHybrid", "")
	pickedAttribID = SAVE.loadVar(data, "pickedAttribID", "")
	bodyPickedAttribID = SAVE.loadVar(data, "bodyPickedAttribID", "")
	debugMode = SAVE.loadVar(data, "debugMode", false)
	savedPage = SAVE.loadVar(data, "savedPage", 0)
