extends StatusEffectBase

func _init():
	id = StatusEffect.HandsBlocked
	isBattleOnly = false
	
	alwaysCheckedForNPCs = true
	alwaysCheckedForPlayer = true
	priorityDuringChecking = 99
	
func shouldApplyTo(_npc):
	if(_npc.hasBlockedHands()):
		return true
	return false
	
func initArgs(_args = []):
	pass
	
func processBattleTurn():
	pass
	
func processTime(_minutesPassed: int):
	pass

func getEffectName():
	return "Руки заблокированы"

func getEffectDesc():
	return "Вы не можете пользоваться руками. Вы всё ещё можете бить кулаками, но большинство задач, требующих работы пальцами, становятся невыполнимыми"

func getEffectImage():
	return "res://Images/StatusEffects/mittens.png"

func getIconColor():
	return IconColorPurple

func combine(_args = []):
	pass

