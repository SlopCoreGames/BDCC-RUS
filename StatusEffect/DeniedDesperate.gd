extends StatusEffectBase

func _init():
	id = StatusEffect.DeniedDesperate
	isBattleOnly = true
	
func initArgs(_args = []):
	if(_args.size() > 0):
		turns = _args[0]
	else:
		turns = 3
	
func processBattleTurn():
	turns -= 1
	if(turns <= 0):
		stop()
	
func processTime(_secondsPassed: int):
	pass

func getEffectName():
	return "Отчаяние"

func getEffectDesc():
	return "Ты так и не кончил, хотя безумно этого хотел, и теперь ты чувствуешь полное отчаяние! " + str(turns) + " больше ходов"

func getEffectImage():
	return "res://Images/StatusEffects/armor-punch.png"

func getIconColor():
	return IconColorGreen

func combine(_args = []):
	if(_args.size() > 0):
		turns = max(_args[0], turns)
	else:
		turns = max(3, turns)

func saveData():
	return {
		"turns": turns,
	}
	
func loadData(_data):
	turns = SAVE.loadVar(_data, "turns", 3)

func getBuffs():
	return [
		buff(Buff.PhysicalDamageBuff, [50.0]),
		buff(Buff.ReceivedLustDamageBuff, [20.0]),
	]
