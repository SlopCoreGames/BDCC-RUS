extends DialogueFillerAdder

func _init():
	prefix = false
	chance = 100.0
	priority = 10

func getFormIDs() -> Array:
	return [
		"GuardCaughtOffLimits",
		"AttackStart",
		"AttackReact",
		]

func canBeUsed(_id:String, _args:Dictionary, _form) -> bool:
	var mainCharID:String = getCharID(_args, _form.mainRole)
	var dirToCharID:String = getCharID(_args, _form.dirToRole)
	
	if(GM.main.WHS.queryHappened(WHEvent.WonFight, [
		[WHCond.Who, mainCharID],
		[WHCond.Target, dirToCharID],
		[WHCond.Today],
		])):
		if(!GM.main.WHS.queryHappened(WHEvent.WonFight, [
			[WHCond.Who, dirToCharID],
			[WHCond.Target, mainCharID],
			[WHCond.Today],
		])):
			return true # We won but didn't lose
	return false

func getText(_id:String, _args:Dictionary):
	if(_id == "GuardCaughtOffLimits"):
		return [
			"И да, ты вернулся так быстро.",
			"О, неужели в прошлый раз было мало?",
			"Ты уже проиграл сегодня.",
		]
	if(_id == "AttackStart"):
		return [
			"Скучал по мне?",
			"Я снова выиграю, ты же это знаешь.",
		]
	if(_id == "AttackReact"):
		return [
			"Наверное, тебе мало...",
			"Я победила. Чего ты приперся?",
		]
	
	return []
