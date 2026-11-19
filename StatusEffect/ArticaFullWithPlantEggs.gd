extends StatusEffectBase

var eggAmount = 0

func _init():
	id = StatusEffect.ArticaFullWithPlantEggs
	isBattleOnly = false
	
func initArgs(_args = []):
	turns = 48*60*60
	if(_args.size() > 0):
		eggAmount = _args[0]
	else:
		eggAmount = 5
	
func processBattleTurn():
	pass
	
func processTime(_secondsPassed: int):
	turns -= _secondsPassed
	if(turns <= 0):
		turns = 0

func getEffectName():
	return "Внутри полно яиц!"

func getEffectDesc():
	return "Ты набита "+str(eggAmount)+" яйцами! "+("Ты будешь готова отложить их через "+Util.getTimeStringHumanReadable(turns) if turns > 0 else "Ты готова их отложить!")

func getEffectImage():
	return "res://Images/StatusEffects/bloating.png"

func getIconColor():
	return IconColorGreen

func combine(_args = []):
	if(_args.size() > 0):
		eggAmount = eggAmount + _args[0]
	else:
		eggAmount += 5

func getBuffs():
	return [
		buff(Buff.InflatedBellyBuff, [70.0 + sqrt(eggAmount)*10.0]),
		buff(Buff.PregnantBellySizeModifierBuff, [-70.0]),
	]

func saveData():
	return {
		"turns": turns,
		"eggAmount": eggAmount,
	}
	
func loadData(_data):
	turns = SAVE.loadVar(_data, "turns", 60*60)
	eggAmount = SAVE.loadVar(_data, "eggAmount", 5)
