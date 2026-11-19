extends StatusEffectBase

func _init():
	id = StatusEffect.HasCumInsideMouth
	isBattleOnly = false
	
	alwaysCheckedForNPCs = true
	alwaysCheckedForPlayer = true
	priorityDuringChecking = 92
	
func shouldApplyTo(_npc):
	if(_npc.hasBodypart(BodypartSlot.Head) && !_npc.getBodypart(BodypartSlot.Head).isOrificeEmpty()):
		return true
	return false
	
func initArgs(_args = []):
	pass
	
func processBattleTurn():
	pass
	
func processTime(_secondsPassed: int):
	pass

func getEffectName():
	return "Orally-filled"

func getEffectDesc():
	if(!character.hasBodypart(BodypartSlot.Head)):
		return "Что-то не так"
	var bodypart = character.getBodypart(BodypartSlot.Head)
	var orifice: Orifice = bodypart.getOrifice()
	var stuffLevel = orifice.getStuffedLevel()
	var fluidAmount = orifice.getFluidAmount()
	var fluidAmountRounded = ceil(fluidAmount)
	
	var messFluids = orifice.getFluidListNames()
	var humanReadableString = Util.humanReadableList(messFluids)
	
	var message = "Твой последний любовник кончил тебе прямо в глотку, и теперь твой живот раздуло от " + str(fluidAmountRounded) + " мл "+humanReadableString
	if(stuffLevel > 1.0):
		message += ". Твой живот набит до отказа"
	
	var uniqueUsers = orifice.getUniqueCharactersAmount()
	if(uniqueUsers > 1):
		message += " from "+str(uniqueUsers)+" lovers"
	
	return message

func getEffectImage():
	return "res://Images/StatusEffects/mouth.png"

func getIconColor():
	return IconColorPurple

func combine(_args = []):
	pass

func getBuffs():
	if(!character.hasBodypart(BodypartSlot.Head)):
		return []
	
	var fluids = character.getBodypart(BodypartSlot.Head).getFluids()
	if(fluids == null):
		return []
	var messFluids = fluids.getFluidAmountByType()
	
	var result = []

	for fluidID in messFluids:
		var fluidObject = GlobalRegistry.getFluid(fluidID)
		if(fluidObject == null):
			continue
		
		var messBuffs = fluidObject.getBellyBuffs(character, messFluids[fluidID])
		if(messBuffs != null):
			result.append_array(messBuffs)

	return result
