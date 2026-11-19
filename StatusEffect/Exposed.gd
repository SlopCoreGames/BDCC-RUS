extends StatusEffectBase

func _init():
	id = StatusEffect.Exposed
	isBattleOnly = false
	
func initArgs(_args = []):
	pass
	
func processBattleTurn():
	pass
	
func processTime(_minutesPassed: int):
	pass

func getEffectName():
	return "Обнаженность"

func getEffectDesc():
	return "Твоя степень обнаженности очень высока, кто-нибудь может этим воспользоваться!\n\nТвоя степень обнаженности: "+str(Util.roundF(character.getExposure()*100.0))+"%"

func getEffectImage():
	return "res://Images/StatusEffects/mask.png"

func getIconColor():
	return IconColorRed

func combine(_args = []):
	pass

