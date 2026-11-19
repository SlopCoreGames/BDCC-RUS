extends StatusEffectBase

func _init():
	id = StatusEffect.Gagged
	isBattleOnly = false
	
	alwaysCheckedForNPCs = true
	alwaysCheckedForPlayer = true
	priorityDuringChecking = 99
	
func shouldApplyTo(_npc):
	if(_npc.isGagged()):
		return true
	return false
	
func initArgs(_args = []):
	pass
	
func processBattleTurn():
	pass
	
func processTime(_minutesPassed: int):
	pass

func getEffectName():
	return "С кляпом во рту"

func getEffectDesc():
	return "Что-то во рту мешает тебе кусаться и превращает твою речь в невнятное бормотание"

func getEffectImage():
	return "res://Images/StatusEffects/gag.png"

func getIconColor():
	return IconColorPurple

func combine(_args = []):
	pass

