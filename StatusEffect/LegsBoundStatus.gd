extends StatusEffectBase

func _init():
	id = StatusEffect.LegsBound
	isBattleOnly = false
	
	alwaysCheckedForNPCs = true
	alwaysCheckedForPlayer = true
	priorityDuringChecking = 99
	
func shouldApplyTo(_npc):
	if(_npc.hasBoundLegs()):
		return true
	return false
	
func initArgs(_args = []):
	pass
	
func processBattleTurn():
	pass
	
func processTime(_minutesPassed: int):
	pass

func getEffectName():
	return "Связанные ноги"

func getEffectDesc():
	return "Ваши ноги связаны. Вы всё ещё можете ходить, но уклоняться от атак стало сложнее"

func getEffectImage():
	return "res://Images/StatusEffects/manacles.png"

func getIconColor():
	return IconColorPurple

func combine(_args = []):
	pass

func getBuffs():
	return [
		buff(Buff.DodgeChanceBuff, [-30])
	]
