extends StatusEffectBase

var canStandup = false

func _init():
	id = StatusEffect.Collapsed
	isBattleOnly = true

func getEffectName():
	return "Сбит с ног"

func getEffectDesc():
	var message = "Вы лежите на земле. Все еще можете сражаться, но уклоняться от физических атак почти невозможно"
	if(!canStandup):
		message += "\n[color=red]Не можете подняться сразу после того, как вас сбили с ног[/color]"
	return message

func getEffectImage():
	return "res://Images/StatusEffects/down.png"

func getIconColor():
	return IconColorBlue

func getBuffs():
	return [
		buff(Buff.DodgeChanceBuff, [-90])
	]

func processBattleTurn():
	canStandup = true
	
func canStandUp():
	return canStandup
	
func saveData():
	return {
		"canStandup": canStandup,
	}
	
func loadData(_data):
	canStandup = SAVE.loadVar(_data, "canStandup", false)
