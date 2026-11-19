extends DialogueFillerAdder

func _init():
	prefix = false
	chance = 100.0
	priority = 1

func getFormIDs() -> Array:
	return [
		"AttackStart",
		"GuardFrisk",
		"ReactGETTING_FUCKED",
		"ReactCOVERED_IN_CUM",
		"HelpRestraintsAgree",
		"SlutwallAddTip",
		"ProstitutionOffer",
		"PunishAboutToStocks",
		"TalkSexOfferAccept",
		"AskKeyGive",
		]

func canBeUsed(_id:String, _args:Dictionary, _form) -> bool:
	var mainCharID:String = getCharID(_args, _form.mainRole)
	var dirToCharID:String = getCharID(_args, _form.dirToRole)
	
	if(GM.main.WHS.queryHappened(WHEvent.Impregnated, [
		[WHCond.Who, mainCharID],
		[WHCond.Target, dirToCharID],
	]) && getChar(_args, _form.dirToRole).isVisiblyPregnant()):
		return true
	return false

func getText(_id:String, _args:Dictionary):
	if(_id == "AttackStart"):
		return [
			"Мне плевать, что я залетел в тебя.",
		]
	if(_id == "GuardFrisk"):
		return [
			"Надеюсь, наши дети вырастут нормальными... в отличие от их мамаши.",
		]
	if(_id == "ReactGETTING_FUCKED"):
		return [
			"Как же я рад, что засадил в тебя первым!",
			"Я засадил эту шлюху первой!",
		]
	if(_id == "ReactCOVERED_IN_CUM"):
		return [
			"Носит моё отродье, а всё равно ведет себя как последняя шлюха...",
		]
	if(_id == "HelpRestraintsAgree"):
		return [
			"Надеюсь, с детьми всё будет в порядке, кстати...",
		]
	if(_id == "SlutwallAddTip"):
		return [
			"Купи что-нибудь нашим будущим детям на эти деньги.",
		]
	if(_id == "ProstitutionOffer"):
		return [
			"О, ты всё работаешь, пока внутри тебя моё отродье. Ну и шлюха...",
		]
	if(_id == "AskKeyGive"):
		return [
			"Пожалуй, помогу, раз уж я засадил в тебя целую ораву.",
		]
	if(_id in ["PunishAboutToStocks", "TalkSexOfferAccept"]):
		return [
			"С животом поосторожнее, в конце концов, он мой.",
		]
	return [
	]
