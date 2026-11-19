extends StatusEffectBase

func _init():
	id = StatusEffect.Blindfolded
	isBattleOnly = false
	
	alwaysCheckedForNPCs = true
	alwaysCheckedForPlayer = true
	priorityDuringChecking = 99
	
func shouldApplyTo(_npc):
	if(_npc.isBlindfolded()):
		return true
	return false
	
func initArgs(_args = []):
	pass
	
func processBattleTurn():
	pass
	
func processTime(_minutesPassed: int):
	pass

func getEffectName():
	return "Повязка на глазах"

func getEffectDesc():
	if(character.hasPerk(Perk.BDSMBlindfold)):
		return "Вы ослеплены, но не совсем беспомощны"
	
	return "Вы ничего не видите. Попасть по цели будет очень сложно"

func getEffectImage():
	return "res://Images/StatusEffects/blind.png"

func getIconColor():
	return IconColorPurple

func combine(_args = []):
	pass

func getBuffs():
	if(character.hasPerk(Perk.BDSMBlindfold)):
		return [
			buff(Buff.AccuracyBuff, [-15])
		]
	
	return [
		buff(Buff.AccuracyBuff, [-50])
	]
