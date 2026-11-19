extends StatusEffectBase

func _init():
	id = StatusEffect.SexHeatDrug
	isSexEngineOnly = true
	
func processSexTurn():
	character.addLust(10)

func getEffectName():
	return "Таблетка возбуждения"

func getEffectDesc():
	return "Ты невероятно похотлив(а)"

func getEffectImage():
	return "res://Images/StatusEffects/love-injection.png"

func getIconColor():
	return IconColorPurple

func isDrugEffect() -> bool:
	return true
