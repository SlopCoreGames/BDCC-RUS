extends StatusEffectBase

var stacks = 0

func _init():
	id = StatusEffect.Wounded
	isBattleOnly = false
	isSexEngineOnly = false
	
func initArgs(_args = []):
	if(_args.size() > 0):
		stacks = _args[0]
	else:
		stacks = 1
	
func processBattleTurn():
	pass
	
func processTime(_secondsPassed: int):
	pass

func onSleeping():
	if(stacks <= 1):
		stop()

func getEffectName():
	return "Wounded x"+str(stacks)

func getEffectDesc():
	if(stacks <= 1):
		return "Грудь как-то ноет... Стоит отдохнуть"
	if(stacks <= 2):
		return "В груди что-то неприятно ноет. Само это не пройдет... Тебе нужно найти врача"
	
	return "В груди всё сильно болит. Само это не пройдет... Тебе нужно срочно найти врача"

func getEffectImage():
	return "res://Images/StatusEffects/open-wound.png"

func getIconColor():
	return IconColorRed

func combine(_args = []):
	if(_args.size() > 0):
		stacks += _args[0]
	else:
		stacks += 1
	
	if(stacks <= 0):
		stop()

func saveData():
	return {
		"stacks": stacks,
	}
	
func loadData(_data):
	stacks = SAVE.loadVar(_data, "stacks", 1)

func getBuffs():
	if(stacks > 1):
		return [
			buff(Buff.AmbientPainBuff, [stacks*5]),
			buff(Buff.MaxStaminaBuff, [stacks*(-5)]),
		]
	
	return [
		buff(Buff.AmbientPainBuff, [stacks*5]),
	]
