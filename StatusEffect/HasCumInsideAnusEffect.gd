extends StatusEffectBase

func _init():
	id = StatusEffect.HasCumInsideAnus
	isBattleOnly = false
	
	alwaysCheckedForNPCs = true
	alwaysCheckedForPlayer = true
	priorityDuringChecking = 92
	
func shouldApplyTo(_npc):
	if(_npc.hasBodypart(BodypartSlot.Anus) && !_npc.getBodypart(BodypartSlot.Anus).isOrificeEmpty()):
		return true
	return false
	
func initArgs(_args = []):
	pass
	
func processBattleTurn():
	pass
	
func processTime(_secondsPassed: int):
	pass

func getEffectName():
	return "Анальный кримпэй"

func getEffectDesc():
	if(!character.hasBodypart(BodypartSlot.Anus)):
		return "Что-то не так"
	var bodypart = character.getBodypart(BodypartSlot.Anus)
	var orifice: Orifice = bodypart.getOrifice()
	var stuffLevel = orifice.getStuffedLevel()
	var fluidAmount = orifice.getFluidAmount()
	var fluidAmountRounded = ceil(fluidAmount)
	
	var messFluids = orifice.getFluidListNames()
	var humanReadableString = Util.humanReadableList(messFluids)
	
	var message = "Тебя оттрахали в задницу, и теперь твоя жопа набита " + str(fluidAmountRounded) + " мл "+humanReadableString
	if(stuffLevel > 1.0):
		message += ". Твой анус полностью заполнен"
	
	var uniqueUsers = orifice.getUniqueCharactersAmount()
	if(uniqueUsers > 1):
		message += " from "+str(uniqueUsers)+" lovers"
	
	return message

func getEffectImage():
	return "res://Images/StatusEffects/butt.png"

func getIconColor():
	return IconColorPurple

func combine(_args = []):
	pass
