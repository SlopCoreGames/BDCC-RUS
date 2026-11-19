extends StatusEffectBase

func _init():
	id = "SexActivelyResisting"
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
	return "Активное сопротивление"

func getEffectDesc():
	return "Этот человек будет активно сопротивляться во время секса."

func getEffectImage():
	return "res://Images/StatusEffects/shattered-heart.png"

func getIconColor():
	return IconColorRed

func combine(_args = []):
	pass

func getBuffs():
	return [
		buff(Buff.ActiveResistanceInSexBuff, [100])
	]
