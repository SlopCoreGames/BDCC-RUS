extends StatusEffectBase

func _init():
	id = "SexSpacedOut"
	isSexEngineOnly = true
	
func initArgs(_args = []):
	pass
	
func processBattleTurn():
	pass
	
func processTime(_minutesPassed: int):
	pass

func getEffectName():
	return "Рассеянность"

func getEffectDesc():
	return "Твой разум где-то далеко, ты совершенно ничего не можешь делать."

func getEffectImage():
	return "res://Images/StatusEffects/hypnosis.png"

func getIconColor():
	return IconColorGray

func combine(_args = []):
	pass

func getBuffs():
	return [
		buff(Buff.SpacedOutInSexBuff, [100])
	]
