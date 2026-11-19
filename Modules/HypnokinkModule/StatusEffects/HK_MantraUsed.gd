extends StatusEffectBase

func _init():
	id = StatusEffect.MantraUsed
	isBattleOnly = true
	
func initArgs(_args = []):
	pass
	
func processBattleTurn():
	pass
	
func processTime(_minutesPassed: int):
	pass

func getEffectName():
	return "Мантра использована"

func getEffectDesc():
	return "Вы уже использовали свою мантру в этом бою."

func getEffectImage():
	return "res://Modules/HypnokinkModule/Icons/StatusEffects/empty_circle.png"

func getIconColor():
	return IconColorRed

func combine(_args = []):
	pass
