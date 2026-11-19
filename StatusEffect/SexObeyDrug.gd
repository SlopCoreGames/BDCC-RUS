extends StatusEffectBase

func _init():
	id = "SexObeyDrug"
	isSexEngineOnly = true
	
#func processSexTurn():
#	character.addLust(10)

func getEffectName():
	return "Рабская конфета"

func getEffectDesc():
	return "Ты так и жаждешь повиноваться..."

func getEffectImage():
	return "res://Images/StatusEffects/love-injection.png"

func getIconColor():
	return IconColorPurple

func getBuffs():
	return [
		buff(Buff.ForcedObedienceBuff, [100])
	]

func isDrugEffect() -> bool:
	return true
