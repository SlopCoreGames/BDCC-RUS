extends StatusEffectBase

func _init():
	id = StatusEffect.JackiCumInUrethra
	isBattleOnly = false

	alwaysCheckedForNPCs = false
	alwaysCheckedForPlayer = false
	priorityDuringChecking = 90
	
func shouldApplyTo(_npc):
	#if(_npc.menstrualCycle != null && _npc.menstrualCycle.isVisiblyPregnant()):
	#	return true
	return false

func getEffectName():
	return "Уретральный кримпэй"

func getEffectDesc():
	return "Тебя оттрахали, и теперь твой мочевой пузырь забит спермой..."

func getEffectImage():
	return "res://Images/StatusEffects/bladder.png"

func getIconColor():
	return IconColorDarkPurple

func getBuffs():
	return [
	]
