extends StatusEffectBase

func _init():
	id = StatusEffect.PosthypnoticTriggerUsedUp
	isBattleOnly = true
	
func initArgs(_args = []):
	pass
	
func processBattleTurn():
	pass
	
func processTime(_minutesPassed: int):
	pass

func getEffectName():
	return "Триггер израсходован"

func getEffectDesc():
	return "В этом бою вы невосприимчивы к повторному использованию вашего гипнотического триггера."

func getEffectImage():
	return "res://Modules/HypnokinkModule/Icons/StatusEffects/empty_circle.png"

func getIconColor():
	return IconColorGreen

func combine(_args = []):
	pass
