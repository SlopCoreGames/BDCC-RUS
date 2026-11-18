extends SceneBase

var pickedPoolToShow = ""
var pickedFetishToChange = ""
var pickedPersonalityStat = ""
var pickedGenderToChange = ""
var pickedSpeciesToChange = ""
var pickedGoalIDToChange = ""
var pickedTFIDToChange = ""
var npclistScene = preload("res://UI/NpcList/NpcList.tscn") 
var page:int = -1

func _init():
	sceneID = "EncountersMenuScene"

func _run():
	if(state == ""):
		var encounterSettings:EncounterSettings = GM.main.getEncounterSettings()
		
		saynn("Это меню содержит информацию о персонажах, которых вы уже встретили или можете встретить.")
		
		var hasSomeoneToForget = false
		sayn("Вы помните, что в тюрьме есть:")
		var encounterPools = GM.main.getDynamicCharactersPools()
		if(encounterPools.size() == 0):
			sayn(" - Никого, исследуйте локации, чтобы найти новых персонажей")
		for encounterPoolID in encounterPools:
			var amount = GM.main.getDynamicCharactersPoolSize(encounterPoolID)
			
			sayn(CharacterPool.getVisibleName(encounterPoolID)+": "+str(amount))
			hasSomeoneToForget = true
		sayn("")
		
		if(encounterSettings.doesPreferKnownEncounters()):
			saynn("Знакомые персонажи: Вы предпочитаете встречать тех, кого уже видели.")
		else:
			saynn("Знакомые персонажи: Вы не против встречать новых персонажей.")
		
		if(GM.pc.dynamicPersonality):
			saynn("Динамичная личность: Ваша личность или фетиши могут динамично меняться после секса.")
		else:
			saynn("Динамичная личность: Ваша личность или фетиши никогда не изменятся после секса.")
		
		if(encounterSettings.shouldSubThreesomesBeEnabled()):
			saynn("Тройнички: Вы не против быть сабом в тройничках.")
		else:
			saynn("Тройнички: Доминантные партнеры никогда не присоединятся к сексу динамически, если вы саб.")
		
		sayn("Относительные шансы появления NPC разных полов:")
		for gender in NpcGender.getAll():
			var genderName = NpcGender.getVisibleNameColored(gender)
			var extraInfo = ""
			var genderExlanation = NpcGender.getGenderExplanation(gender)
			if(genderExlanation != null && genderExlanation != ""):
				extraInfo = " ("+str(genderExlanation)+")"
			
			var weight = encounterSettings.getGenderWeight(gender)
			sayn(str(genderName)+": "+str(Util.roundF(weight*100.0, 1))+"%"+extraInfo)
		sayn("")
		
		sayn("Относительная вероятность появления видов встреченных NPC:")
		var species = GlobalRegistry.getAllPlayableSpecies()
		for speciesID in species:
			var speciesObject:Species = species[speciesID]
			var speciesName = speciesObject.getVisibleName()
			
			var weight = encounterSettings.getSpeciesWeight(speciesID)
			sayn(str(speciesName)+": "+str(Util.roundF(weight*100.0, 1))+"%")
		sayn("")
		
		sayn("Вещи, которые NPC точно НЕ будут с вами делать:")
		var disabledGoalsNames = []
		var allGoals = GlobalRegistry.getSexGoals()
		for goalID in allGoals:
			if(encounterSettings.isGoalDisabledForSubPC(goalID)):
				var goal: SexGoalBase = GlobalRegistry.getSexGoal(goalID)
				if(goal == null):
					continue
				
				disabledGoalsNames.append(goal.getVisibleName())
		if(disabledGoalsNames.size() == 0):
			saynn("- Ничего не отключено")
		else:
			saynn(Util.humanReadableList(disabledGoalsNames))
		
		addButton("Назад", "Закрыть меню", "endthescene")
		
		if(hasSomeoneToForget):
			addButton("Персонажи", "Показывает всех встреченных вами случайно сгенерированных персонажей", "npclistmenu")
		else:
			addDisabledButton("Персонажи", "Вы еще не встречали случайно сгенерированных персонажей")
		
		addButton("Переключить: известные", "Переключение между режимами: только старые персонажи или и старые, и новые", "toggleKnown")
		addButton("Динамичный характер", "Изменить то, как меняется ваш характер после секса", "togglePersonalityChange")
		addButton("Тройнички (саб)", "Включить возможность участия дополнительных доминантов, когда вы в роли саба", "toggleThreesomesSub")
		addButton("Мои фетиши", "Меню для просмотра и изменения ваших фетишей", "fetishmenu")
		addButton("Мой характер", "Меню для просмотра и изменения вашего характера", "personalitymenu")
		addButton("Полы", "Настроить шансы появления определенных полов у встреченных NPC", "gendersmenu")
		addButton("Вид", "Выберите шансы появления определенных видов у встреченных NPC", "speciesmenu")
		addButton("Ограничения", "Выберите то, чего вы НЕ хотите, чтобы с вами происходило во время секса", "goalsmenu")
		addButton("Веса целей", "Измените веса сексуальных целей, к которым будут стремиться другие персонажи во время секса", "goalweightsmenu")
		addButton("Веса ТФ", "Измените веса трансформаций, которые могут содержаться в «странных таблетках»", "tfweightsmenu")

	if(state == "goalweightsmenu"):
		var encounterSettings:EncounterSettings = GM.main.getEncounterSettings()
		addButton("Назад", "Закрыть меню", "")
		
		sayn("Текущие веса всех сексуальных целей:")
		var allGoals = GlobalRegistry.getSexGoals()
		for goalID in allGoals:
			var goal: SexGoalBase = GlobalRegistry.getSexGoal(goalID)
			if(goal == null):
				continue
			var goalWeight = encounterSettings.getGoalWeight(goalID, goal.getGoalDefaultWeight())
			
			sayn(goal.getVisibleName()+": "+str(Util.roundF(goalWeight*100.0, 1))+"%")
			addButton(goal.getVisibleName(), "Изменить вес этой цели", "changegoalweightmenu", [goalID])
		
	if(state == "tfweightsmenu"):
		var encounterSettings:EncounterSettings = GM.main.getEncounterSettings()
		addButton("Назад", "Закрыть меню", "")
		
		sayn("Текущие веса всех трансформаций, которые могут быть вызваны «странными таблетками»:")
		var allTFs = GlobalRegistry.getTransformationRefs()
		for tfID in allTFs:
			var tf: TFBase = GlobalRegistry.getTransformationRef(tfID)
			if(tf == null || !tf.canChangeWeight()):
				continue
			var tfWeight = encounterSettings.getTFWeight(tfID, tf.getPillGenWeight())
			
			var pillName:String = tf.getPillName()
			var tfName:String = tf.getName()
			
			if(pillName != tfName):
				sayn(pillName+" ("+tfName+"): "+str(Util.roundF(tfWeight*100.0, 1))+"%")
			else:
				sayn(tfName+": "+str(Util.roundF(tfWeight*100.0, 1))+"%")
			addButton(tf.getName(), "Изменить вес этой трансформации", "changetfweightmenu", [tfID])
		
	if(state == "changegoalweightmenu"):
		var encounterSettings:EncounterSettings = GM.main.getEncounterSettings()
		addButton("Назад", "Закрыть меню", "")
		var pickedGoal = GlobalRegistry.getSexGoal(pickedGoalIDToChange)
		if(pickedGoal != null):
			var goalWeight = encounterSettings.getGoalWeight(pickedGoalIDToChange, pickedGoal.getGoalDefaultWeight())
			saynn("Текущий вес для «"+pickedGoal.getVisibleName()+"» составляет "+str(Util.roundF(goalWeight*100.0, 1))+"%")
			
			addButton("По умолчанию", "Сбросить вес до значения по умолчанию", "changegoalweight", [-1])
			
			var possibleWeights = [0.0, 0.05, 0.1, 0.15, 0.2, 0.3, 0.4, 0.5, 0.7, 0.9, 1.0, 1.2, 1.5, 2.0, 3.0, 5.0]
			for weight in possibleWeights:
				var weightStr = str(Util.roundF(weight*100.0, 1))+"%"
				
				addButton(weightStr, "Установить вес равным этому значению", "changegoalweight", [weight])
			
	if(state == "changetfweightmenu"):
		var encounterSettings:EncounterSettings = GM.main.getEncounterSettings()
		addButton("Назад", "Закрыть меню", "")
		var pickedTF:TFBase = GlobalRegistry.getTransformationRef(pickedTFIDToChange)
		if(pickedTF != null):
			var goalWeight = encounterSettings.getTFWeight(pickedTFIDToChange, pickedTF.getPillGenWeight())
			saynn("Текущий вес трансформации «"+pickedTF.getName()+"» равен "+str(Util.roundF(goalWeight*100.0, 1))+"%")
			
			addButton("По умолчанию", "Сбросить вес до значения по умолчанию", "changetfweight", [-1])
			
			var possibleWeights = [0.0, 0.05, 0.1, 0.15, 0.2, 0.3, 0.4, 0.5, 0.7, 0.9, 1.0, 1.2, 1.5, 2.0, 3.0, 5.0]
			for weight in possibleWeights:
				var weightStr = str(Util.roundF(weight*100.0, 1))+"%"
				
				addButton(weightStr, "Установить вес равным этому значению", "changetfweight", [weight])
			
		
	if(state == "goalsmenu"):
		var encounterSettings:EncounterSettings = GM.main.getEncounterSettings()
		addButton("Назад", "Закрыть меню", "")
		
		sayn("Вещи, которые NPC точно НЕ будут с вами делать:")
		var disabledGoalsNames = []
		var allGoals = GlobalRegistry.getSexGoals()
		for goalID in allGoals:
			var goal: SexGoalBase = GlobalRegistry.getSexGoal(goalID)
			if(goal == null):
				continue
			
			if(encounterSettings.isGoalDisabledForSubPC(goalID)):
				disabledGoalsNames.append(goal.getVisibleName())
				addButton("+"+goal.getVisibleName(), "Включить", "enablegoalforpc", [goalID])
			else:
				addButton("-"+goal.getVisibleName(), "Выключить", "disablegoalforpc", [goalID])
		if(disabledGoalsNames.size() == 0):
			saynn("- Ничего не отключено")
		else:
			saynn(Util.humanReadableList(disabledGoalsNames))
			
		if(page > 0):
			GM.ui.setCurrentPage(page)

	if(state == "speciesmenu"):
		var encounterSettings:EncounterSettings = GM.main.getEncounterSettings()
		addButton("Назад", "Закрыть меню", "")
		
		sayn("Относительная вероятность появления видов встреченных NPC:")
		var species = GlobalRegistry.getAllPlayableSpecies()
		for speciesID in species:
			var speciesObject:Species = species[speciesID]
			var speciesName = speciesObject.getVisibleName()
			
			var weight = encounterSettings.getSpeciesWeight(speciesID)
			sayn(str(speciesName)+": "+str(Util.roundF(weight*100.0, 1))+"%")
			addButton(speciesName, "Изменить шанс появления этого вида", "specieschancemenu", [speciesID])
		sayn("")

	if(state == "gendersmenu"):
		var encounterSettings:EncounterSettings = GM.main.getEncounterSettings()
		addButton("Назад", "Закрыть меню", "")
		
		sayn("Относительные шансы появления NPC разных полов:")
		for gender in NpcGender.getAll():
			var genderName = NpcGender.getVisibleNameColored(gender)
			var extraInfo = ""
			var genderExlanation = NpcGender.getGenderExplanation(gender)
			if(genderExlanation != null && genderExlanation != ""):
				extraInfo = " ("+str(genderExlanation)+")"
			
			var weight = encounterSettings.getGenderWeight(gender)
			sayn(str(genderName)+": "+str(Util.roundF(weight*100.0, 1))+"%"+extraInfo)
			addButton(NpcGender.getVisibleName(gender), "Изменить шанс этого пола", "genderchancemenu", [gender])
		sayn("")

	if(state == "genderchancemenu"):
		var gender = pickedGenderToChange
		var encounterSettings:EncounterSettings = GM.main.getEncounterSettings()
		saynn("Текущий шанс для "+NpcGender.getVisibleNameColored(gender)+" is "+str(Util.roundF(encounterSettings.getGenderWeight(gender)*100.0, 1))+"%")

		addButton("Назад", "Назад в предыдущее меню", "gendersmenu")
		addButton("По умолчанию", "Вернуть стандартный шанс", "setgenderchance", [gender, -1.0])
		for chance in [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0]:
			addButton(str(Util.roundF(chance*100.0))+"%", "Выбрать этот шанс", "setgenderchance", [gender, chance])

	if(state == "specieschancemenu"):
		var species = pickedSpeciesToChange
		var encounterSettings:EncounterSettings = GM.main.getEncounterSettings()
		var speciesObject:Species = GlobalRegistry.getSpecies(species)
		if(!speciesObject):
			speciesObject = GlobalRegistry.getSpecies(Species.Canine)
		var speciesName = speciesObject.getVisibleName()
		saynn("Текущий шанс для "+speciesName+" is "+str(Util.roundF(encounterSettings.getSpeciesWeight(species)*100.0, 1))+"%")

		addButton("Назад", "Назад в предыдущее меню", "speciesmenu")
		addButton("По умолчанию", "Вернуть стандартный шанс", "setspecieschance", [species, -1.0])
		for chance in [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0, 1.2, 1.5, 2.0, 3.0]:
			addButton(str(Util.roundF(chance*100.0))+"%", "Выбрать этот шанс", "setspecieschance", [species, chance])

	if(state == "npclistmenu"):
		var encounterPools = GM.main.getDynamicCharactersPools()

		saynn("Выберите профессию персонажа, которого хотите найти.")
		saynn("Вы можете «забыть» любого персонажа из списка, чтобы он больше никогда не появлялся. Это действие нельзя отменить.")
		saynn("Имейте в виду: если персонаж будет беременным, его беременность тоже будет забыта. Но все ваши общие дети останутся.")

		addButton("Назад", "Назад", "") 
		
		for encounterPoolID in encounterPools:
			addButton(CharacterPool.getVisibleName(encounterPoolID), "Выбрать эту профессию", "occupationmenupool", [encounterPoolID])
		
	if(state == "occupationmenupool"):
		var npclist = npclistScene.instance()
		GM.ui.addFullScreenCustomControl("npclist", npclist)
		var _ok = npclist.connect("onMeetNpcButton", self, "doMeetNpc")
		
		var characterIDS = GM.main.getDynamicCharacterIDsFromPool(pickedPoolToShow)
		for characterID in characterIDS:
			var dynamicCharacter: BaseCharacter  = GlobalRegistry.getCharacter(characterID)
			if(dynamicCharacter == null):
				continue
			var NPCname = dynamicCharacter.getName()
			if(dynamicCharacter.hasEnslaveQuest()):
				NPCname = "(!) "+NPCname
			var gender = NpcGender.getVisibleName(dynamicCharacter.npcGeneratedGender)
			var subbyStat = dynamicCharacter.getPersonality().getStat(PersonalityStat.Subby)
			var sharedKidsAmount = GM.CS.getSharedChildrenAmount("pc", characterID)

			npclist.addRow(NPCname, gender, subbyStat, characterID, pickedPoolToShow, sharedKidsAmount, dynamicCharacter.canForgetCharacter(), dynamicCharacter.canMeetCharacter())
	
		addButton("Назад", "Назад", "closenpclist")
		
		var encounterPools = GM.main.getDynamicCharactersPools()
		for encounterPoolID in encounterPools:
			addButton(CharacterPool.getVisibleName(encounterPoolID), "Выбрать эту профессию", "occupationmenupool", [encounterPoolID])

	if(state == "fetishmenu"):
		var fetishHolder = GM.pc.getFetishHolder()
		saynn("Наличие фетиша означает, что во время секса это занятие будет сильнее разжигать ваше вожделение.")
		addButton("Назад", "Назад на меню", "")
		
		sayn("Ваши фетиши:")
		for fetishID in GlobalRegistry.getFetishes():
			var fetish = GlobalRegistry.getFetish(fetishID)
			var fetishValue:float = fetishHolder.getFetish(fetishID)
			var fetishColor = FetishInterest.getColorString(fetishValue)
			var fetishInterestText = FetishInterest.getVisibleName(fetishValue)
			
			sayn(fetish.getVisibleName()+": "+"[color="+fetishColor+"]"+fetishInterestText+"[/color]")
			
			addButton(fetish.getVisibleName(), "Изменить уровень удовольствия от этого фетиша", "changefetish", [fetishID])
		
	if(state == "changefetish"):
		var fetishHolder = GM.pc.getFetishHolder()
		var fetish = GlobalRegistry.getFetish(pickedFetishToChange)
		if(fetish != null):
			saynn("Ваше текущее значение для фетиша '"+fetish.getVisibleName()+"' составляет "+FetishInterest.getVisibleName(fetishHolder.getFetish(pickedFetishToChange)))
			
			saynn("Выберите новое значение для этого фетиша")
			
			for fetishInterest in FetishInterest.getAll():
				addButton(FetishInterest.getVisibleName(fetishInterest), "Изменить на это", "changeinterest", [fetishInterest])
			
			
		addButton("Назад", "Ничего не менять", "fetishmenu")
		
	if(state == "personalitymenu"):
		var personality: Personality = GM.pc.getPersonality()
		saynn("Ваш характер оказывает небольшое влияние на то, как вы реагируете во время секса.")
		addButton("Назад", "Назад на меню", "")
		
		sayn("Ваш характер:")
		for statID in PersonalityStat.getAll():
			var value = personality.getStat(statID)
			var statName = PersonalityStat.getVisibleName(statID)
			var statValue = PersonalityStat.getVisibleDesc(statID, value)
			
			sayn(statName+": "+statValue+" (Чистое значение: "+str(Util.roundF(value*100.0,1))+"%)")
			addButton(statName, "Изменить этот параметр характера", "changepersonality", [statID])
	
	if(state == "changepersonality"):
		var personality: Personality = GM.pc.getPersonality()
		var value = personality.getStat(pickedPersonalityStat)
		var statName = PersonalityStat.getVisibleName(pickedPersonalityStat)
		var statValue = PersonalityStat.getVisibleDesc(pickedPersonalityStat, value)
		
		saynn("Ваше текущее значение параметра '"+statName+"' составляет "+str(Util.roundF(value*100.0,1))+"% (или '"+str(statValue)+"')")
		
		addButton("Готово", "Достаточно изменений", "personalitymenu")
		addButton("-15%", "Изменить параметр личности", "changepersonalitystatby", [-0.15])
		addButton("-5%", "Изменить параметр личности", "changepersonalitystatby", [-0.05])
		addButton("-1%", "Изменить параметр личности", "changepersonalitystatby", [-0.01])
		addButton("+1%", "Изменить параметр личности", "changepersonalitystatby", [0.01])
		addButton("+5%", "Изменить параметр личности", "changepersonalitystatby", [0.05])
		addButton("+15%", "Изменить параметр личности", "changepersonalitystatby", [0.15])
		
func doMeetNpc(ID, occupation):
	var pcLoc:String = GM.pc.getLocation()
	if(GM.main.IS.hasPawn(ID)):
		GM.ui.getCustomControl("npclist").sendPopupMessage("This person is already somewhere in the prison\nYou can find them by exploring around")
		return
	
	if(!GM.world.isLocSafe(pcLoc)):
		GM.ui.getCustomControl("npclist").sendPopupMessage("This location isn't safe, you can't meet anyone here!")
		return
	if(!GM.world.canMeetInLoc(pcLoc)):
		GM.ui.getCustomControl("npclist").sendPopupMessage("You can't meet anyone on this floor!")
		return
	
	if(occupation in ["Inmates", "Guards", "Engineers", "Nurses"]):
		if(GM.ES.triggerReact(Trigger.MeetDynamicNPC, [ID]) || GM.ES.triggerReact(Trigger.TalkingToDynamicNPC, [ID])):
			endScene([true])
			GM.main.runCurrentScene()
			return
		if(getCharacter(ID).shouldBeExcludedFromEncounters()):
			GM.ui.getCustomControl("npclist").sendPopupMessage("It feels like you will never find them..")
			return
		var pawn:CharacterPawn = GM.main.IS.spawnPawn(ID)
		if(pawn == null):
			return
		pawn.setLocation(GM.pc.getLocation())
		GM.main.IS.startInteraction("Talking", {starter="pc", reacter=ID})
		endScene([true])
		GM.main.runCurrentScene()
		return
	else:
		if(GM.ES.triggerReact(Trigger.MeetDynamicNPC, [ID])):
			endScene([true])
			GM.main.runCurrentScene()
			return

		
func _react(_action: String, _args):
	if(_action == "endthescene"):
		endScene()
		return
		
	if(_action == "enablegoalforpc"):
		page = GM.ui.getCurrentPage()
		GM.main.getEncounterSettings().enableGoalForSubPC(_args[0])
		return
	
	if(_action == "disablegoalforpc"):
		page = GM.ui.getCurrentPage()
		GM.main.getEncounterSettings().disableGoalForSubPC(_args[0])
		return
	
	if(_action == "changefetish"):
		pickedFetishToChange = _args[0]
	
	if(_action == "changepersonality"):
		pickedPersonalityStat = _args[0]
	
	if(_action == "changepersonalitystatby"):
		var personality: Personality = GM.pc.getPersonality()
		personality.addStat(pickedPersonalityStat, _args[0])
		return
	
	if(_action == "changeinterest"):
		var fetishHolder = GM.pc.getFetishHolder()
		var fetish = GlobalRegistry.getFetish(pickedFetishToChange)
		if(fetish != null):
			fetishHolder.setFetish(pickedFetishToChange, _args[0])
		setState("fetishmenu")
		return
	
	if(_action == "toggleKnown"):
		GM.main.getEncounterSettings().togglePreferKnownEcnounters()
		return
	
	if(_action == "togglePersonalityChange"):
		GM.pc.dynamicPersonality = !GM.pc.dynamicPersonality
		return 
		
	if(_action == "toggleThreesomesSub"):
		GM.main.getEncounterSettings().toggleThreesomesSub()
		return 
	
	if(_action == "occupationmenupool"):
		pickedPoolToShow = _args[0]
	
	if(_action == "genderchancemenu"):
		pickedGenderToChange = _args[0]
	
	if(_action == "specieschancemenu"):
		pickedSpeciesToChange = _args[0]
		
	if(_action == "changegoalweightmenu"):
		pickedGoalIDToChange = _args[0]
		
	if(_action == "changetfweightmenu"):
		pickedTFIDToChange = _args[0]
	
	if(_action == "setgenderchance"):
		GM.main.getEncounterSettings().setGenderWeight(_args[0], _args[1])
		
		setState("gendersmenu")
		return	
		
	if(_action == "setspecieschance"):
		GM.main.getEncounterSettings().setSpeciesWeight(_args[0], _args[1])
		
		setState("speciesmenu")
		return
		
	if(_action == "changegoalweight"):
		if(_args[0] < 0):
			GM.main.getEncounterSettings().resetGoalWeight(pickedGoalIDToChange)
		else:
			GM.main.getEncounterSettings().setGoalWeight(pickedGoalIDToChange, _args[0])
		setState("goalweightsmenu")
		return
		
		
	if(_action == "changetfweight"):
		if(_args[0] < 0):
			GM.main.getEncounterSettings().resetTFWeight(pickedTFIDToChange)
		else:
			GM.main.getEncounterSettings().setTFWeight(pickedTFIDToChange, _args[0])
		setState("tfweightsmenu")
		return
		
	if(_action == "closenpclist"):
		setState("")
		GM.ui.clearCharactersPanel()
		GM.main.playAnimation(StageScene.Solo, "stand")
		return
		
	setState(_action)

func saveData():
	var data = .saveData()
	
	data["pickedPoolToShow"] = pickedPoolToShow
	data["pickedFetishToChange"] = pickedFetishToChange
	data["pickedPersonalityStat"] = pickedPersonalityStat
	data["pickedGenderToChange"] = pickedGenderToChange
	data["pickedSpeciesToChange"] = pickedSpeciesToChange
	data["pickedGoalIDToChange"] = pickedGoalIDToChange
	data["pickedTFIDToChange"] = pickedTFIDToChange

	return data
	
func loadData(data):
	.loadData(data)
	
	pickedPoolToShow = SAVE.loadVar(data, "pickedPoolToShow", "")
	pickedFetishToChange = SAVE.loadVar(data, "pickedFetishToChange", "")
	pickedPersonalityStat = SAVE.loadVar(data, "pickedPersonalityStat", "")
	pickedGenderToChange = SAVE.loadVar(data, "pickedGenderToChange", "")
	pickedSpeciesToChange = SAVE.loadVar(data, "pickedSpeciesToChange", "")
	pickedGoalIDToChange = SAVE.loadVar(data, "pickedGoalIDToChange", "")
	pickedTFIDToChange = SAVE.loadVar(data, "pickedTFIDToChange", "")
