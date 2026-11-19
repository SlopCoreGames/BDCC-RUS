extends DialogueFillerAdder

func _init():
	prefix = true
	chance = 100.0

func getFormIDs() -> Array:
	return [
		"TalkSexOfferSelf",
		"TalkSexOfferAccept",
		"PunishSubSex",
		]

func canBeUsed(_id:String, _args:Dictionary, _form) -> bool:
	var inmate = getChar(_args, _form.mainRole)
	if(inmate == null):
		return false
	return inmate.isInHeat()

func getText(_id:String, _args:Dictionary):
	return [
		"Черт, ну и жара...",
		"Ненавижу эту жару...",
		"Я больше не могу сопротивляться этой жаре...",
		"Чертова жара...",
		"Как же меня, блядь, штырит...",
		"Опять началось...",
		"Я постоянно вся мокрая...",
	]
