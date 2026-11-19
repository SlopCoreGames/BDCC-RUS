extends DialogueFillerAdder

func _init():
	prefix = false
	chance = 20.0

func getFormIDs() -> Array:
	return [
		"GuardCaughtOffLimits",
		]

func canBeUsed(_id:String, _args:Dictionary, _form) -> bool:
	var inmate = getChar(_args, _form.dirToRole)
	if(inmate == null):
		return false
	var hasCumIn:bool = inmate.hasEffect(StatusEffect.HasCumInsideAnus) || inmate.hasEffect(StatusEffect.HasCumInsideVagina)
	if(!hasCumIn):
		return false
#
	return true

func getText(_id:String, _args:Dictionary):
	return [
		"Ты оставила след, тебя было нетрудно найти.",
		"Я слышал, как капает сперма.",
		"Тебя было несложно найти, ты вся течёшь.",
	]
