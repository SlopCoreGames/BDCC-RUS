extends StatusEffectBase

func _init():
	id = "SexAngry"
	isSexEngineOnly = true
	
func initArgs(_args = []):
	pass
	
func processBattleTurn():
	pass
	
func processSexTurnContex(_contex = {}):
	if(character.getCustomAttribute(BuffAttribute.ForcedObedience) > 0.0):
		stop()
	
func processTime(_minutesPassed: int):
	pass

func getEffectName():
	return "Запредельная ярость"

func getEffectDesc():
	return "Этот человек будет вести себя грубо во время секса, несмотря ни на что."

func getEffectImage():
	return "res://Images/StatusEffects/shattered-heart.png"

func getIconColor():
	return IconColorRed

func combine(_args = []):
	pass

func getBuffs():
	return [
		buff(Buff.ActiveAngerInSexBuff, [100])
	]
