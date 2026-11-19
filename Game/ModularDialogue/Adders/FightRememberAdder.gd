extends DialogueFillerAdder

func _init():
	prefix = false
	chance = 100.0
	priority = 20

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
		[WHCond.MaxDaysAgo, 3],
		[WHCond.MinDaysAgo, 1],
	])):
		return true
	return false

func getText(_id:String, _args:Dictionary):
	if(_id in ["GuardCaughtOffLimits", "AttackReact"]):
		return [
			"Погоди, разве я не отделал тебя на днях?",
			"Погоди, разве я не отделал тебя на днях? Хочешь добавки?",
			"Помню, как в прошлый раз всыпал тебе люлей. Снова приперся?",
		]
	if(_id == "AttackStart"):
		return [
			"Буду делать это до тех пор, пока ты не поймешь свое место.",
		]
	
	return []
