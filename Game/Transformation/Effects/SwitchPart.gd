extends TFEffect

var newPartID:String = ""
var partArts:Dictionary = {}

func _init():
	id = "SwitchPart"

func initArgs(_args:Array):
	newPartID = _args[0] if (_args[0] is String) else ""
	partArts = _args[1] if _args.size() > 1 else {}

func applyEffect(_data:Dictionary) -> Dictionary:
	var extras:Dictionary = {}
	var oldPartID = _data["bodypartID"] if _data.has("bodypartID") else null
	#var noPartBefore:bool = (oldPartID == "")
	if(newPartID == ""):
		_data["bodypartID"] = null
	else:
		_data["bodypartID"] = newPartID
	
	if(newPartID != ""):
		# Adding missing fields
		var partRef:Bodypart = GlobalRegistry.getBodypartRef(newPartID)
		if(partRef != null):
			if(partRef.getSlot() != getBodypartSlot()):
				var theTF = getTF()
				var theErrorText:String = "ЧТО-ТО ПОШЛО НЕ ТАК С ЭФФЕКТОМ SwitchPart! partRef.getSlot()="+str(partRef.getSlot())+", getBodypartSlot()="+str(getBodypartSlot())+" ID трансформации = "+(theTF.id if theTF else "NULL")+" data="+str(_data)
				Log.error(theErrorText)
				return {
					bigError = theErrorText,
				}
			var tfData:Dictionary = partRef.saveOriginalTFData()
			for tfDataField in tfData:
				if(!_data.has(tfDataField)):
					_data[tfDataField] = tfData[tfDataField]
			
#			if(noPartBefore):
#				partRef.pickedSkin = null
#				partRef.pickedRColor = null
#				partRef.pickedGColor = null
#				partRef.pickedBColor = null
#				var theChar:BaseCharacter = getChar()
#				partRef.generateRandomColors(theChar)
#				partRef.generateRandomSkinIfCan(theChar)
#				if(partRef.pickedSkin != null):
#					_data["skin"] = partRef.pickedSkin
#				if(partRef.pickedRColor != null):
#					_data["r"] = partRef.pickedRColor
#				if(partRef.pickedGColor != null):
#					_data["g"] = partRef.pickedGColor
#				if(partRef.pickedBColor != null):
#					_data["b"] = partRef.pickedBColor

	for partArt in partArts:
		_data[partArt] = partArts[partArt]
	
	if(oldPartID != "" && newPartID == ""):
		if(getBodypartSlot() == BodypartSlot.Penis):
			var theChar:BaseCharacter = getChar()
			
			if(theChar.isWearingChastityCage()):
				extras["lostcage"] = true
				
				if(theChar.isPlayer() || theChar.isSlaveToPlayer()):
					theChar.getInventory().unequipSlot(InventorySlot.Penis)
				else:
					theChar.getInventory().clearSlot(InventorySlot.Penis)
	
	return {
		success = true,
		oldPartID = oldPartID,
		extras = extras,
	}

func generateTransformText(_result:Dictionary):
	if(_result.has("bigError")):
		addText(str(_result["bigError"]))
		return
	
	var oldPartID = (_result["oldPartID"] if _result.has("oldPartID") else null)
	var hadPartBefore:bool = (oldPartID != null && oldPartID != "")
	var hasPartNow:bool = (newPartID != "")
	var bodypartSlot:String = getBodypartSlot()
	var slotChildName:String = BodypartSlot.getSlotChildName(bodypartSlot)
	var slotName:String = BodypartSlot.getVisibleNameNoCap(bodypartSlot)
	var shouldHaveS:bool = !slotName.ends_with("s") || (slotName in ["penis", "anus"])

	
	var bodypartRefBefore:Bodypart = GlobalRegistry.getBodypartRef(oldPartID) if hadPartBefore else null
	var bodypartRefNow:Bodypart = GlobalRegistry.getBodypartRef(newPartID) if hasPartNow else null
	
	# Bald hair = same as no hair
	if(bodypartRefNow != null && bodypartSlot == BodypartSlot.Hair && bodypartRefNow.hasTrait(PartTrait.HairBald)):
		hasPartNow = false
	if(bodypartRefBefore != null && bodypartSlot == BodypartSlot.Hair && bodypartRefBefore.hasTrait(PartTrait.HairBald)):
		hadPartBefore = false
	
	# Nothing changed?
	if(!hadPartBefore && !hasPartNow):
		addText("{npc.YouHe} {npc.youHeVerb('get')} странное щекочущее чувство вокруг {npc.yourHis} "+slotChildName+" но, кажется, ничего не меняется.")
	# Got morphed away
	elif(hadPartBefore && !hasPartNow):
		if(bodypartRefBefore != null):
			addText(bodypartRefBefore.getTransformAwayMessage({result=_result}))
		else:
			addText("{npc.YouHe} {npc.youHeVerb('feel')} покалывание в {npc.yourHis} скальпе, когда {npc.yourHis} "+slotName+" begin"+("s" if shouldHaveS else "")+" начинает сдвигаться и меняться. Внезапно, {npc.YourHis} "+slotName+" morph"+("s" if shouldHaveS else "")+" исчезает бесследно, не оставляя после себя ничего!")
		
		if(_result.has("extras")):
			if(_result["extras"].has("lostcage") && _result["extras"]["lostcage"]):
				addText("{npc.YourHis} целомудренная клетка с громким металлическим лязгом падает на пол. Больше нечему удерживать её на месте...")
		
	# Grew something new that you didn't have
	elif(!hadPartBefore && hasPartNow):
		if(bodypartRefNow != null):
			addText(bodypartRefNow.getTransformGrowMessage({result=_result}))
		else:
			addText("Внезапное тепло разливается по {npc.yourHis} телу, и {npc.youHe} {npc.youHeVerb('feel')} странное ощущение, как будто "+("a " if shouldHaveS else "")+"new "+slotName+" begin"+("s" if shouldHaveS else "")+" формируется из {npc.yourHis} "+slotChildName+". "+("Становится" if shouldHaveS else "Становятся")+" всё более отчетливыми, контуры медленно обретают форму. Процесс, мягко говоря... довольно... неприятный... но в конце концов "+("всё заканчивается," if shouldHaveS else "всё заканчивается,")+" growing, assuming "+("its" if shouldHaveS else "their")+" финальная форма.")
	# Part morphs into a different one
	elif(hadPartBefore && hasPartNow):
		if(bodypartRefNow != null):
			addText(bodypartRefNow.getTransformMorphMessage({result=_result, oldTraits=(bodypartRefBefore.getTraits() if bodypartRefBefore != null else {})}))
		else:
			addText("Необычное ощущение пронзает тело {npc.yourHis}, пока {npc.yourHis} "+slotName+" begin"+("s" if shouldHaveS else "")+" начинает меняться и трансформироваться! Знакомые очертания начинают растворяться и перестраиваться, превращаясь во что-то иное. Постепенно новый "+slotName+" emerge"+("s" if shouldHaveS else "")+", обретает более четкие очертания. Процесс довольно болезненный и неприятный, но в конце концов "+("всё стабилизируется," if shouldHaveS else "всё стабилизируется,")+" into "+("its" if shouldHaveS else "their")+" финальный облик. Теперь {npc.YouHe} {npc.youHaveHeHas} "+bodypartRefNow.getAVulgarName()+".")
	#else:
	#	addText("This shouldn't happen")

func isEffectBadShouldRemove() -> bool:
	if(!newPartID.empty() && !GlobalRegistry.bodyparts.has(newPartID)):
		return true
	return false

func saveData() -> Dictionary:
	var data:Dictionary = .saveData()
	
	data["newPartID"] = newPartID
	data["partArts"] = partArts
	
	return data

func loadData(_data:Dictionary):
	.loadData(_data)
	
	newPartID = SAVE.loadVar(_data, "newPartID", "")
	partArts = SAVE.loadVar(_data, "partArts", {})
