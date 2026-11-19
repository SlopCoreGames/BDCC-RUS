extends StatusEffectBase

func _init():
	id = StatusEffect.SexAnaphrodisiacDrug
	isSexEngineOnly = true
	
func processSexTurn():
	character.addLust(-20)

func getEffectName():
	return "Анафродизиак"

func getEffectDesc():
	return "Возбуждение больше не возникает"

func getEffectImage():
	return "res://Images/StatusEffects/shattered-heart.png"

func getIconColor():
	return IconColorRed

func isDrugEffect() -> bool:
	return true
