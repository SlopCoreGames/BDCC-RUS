extends StatusEffectBase

func _init():
	id = StatusEffect.CumInflated
	isBattleOnly = false
	
	alwaysCheckedForNPCs = true
	alwaysCheckedForPlayer = true
	priorityDuringChecking = 88
	
func shouldApplyTo(_npc):
	if(_npc.getCumInflationLevel() > 0.01):
		return true
	return false
	
func initArgs(_args = []):
	pass
	
func processBattleTurn():
	pass
	
func processTime(_secondsPassed: int):
	pass

func getEffectName():
	return "Раздутая спермой"

func getEffectDesc():
	var cumInflationLevel = character.getCumInflationLevel()
	
	if(cumInflationLevel <= 1.5):
		return "Твой живот слегка округлился"
	if(cumInflationLevel <= 4.5):
		return "Твой живот выглядит довольно раздутым!"
	
	return "Ого, ты так набита, что выглядишь как беременная!"

func getEffectImage():
	var cumInflationLevel = character.getCumInflationLevel()
	if(cumInflationLevel <= 4.5):
		return "res://Images/StatusEffects/belly.png"
		
	return "res://Images/StatusEffects/bloating.png"

func getIconColor():
	return IconColorPurple

func combine(_args = []):
	pass
