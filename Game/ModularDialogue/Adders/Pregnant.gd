extends DialogueFillerAdder

func _init():
	prefix = false
	chance = 10.0
	priority = 0

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
	if(getChar(_args, _form.dirToRole).isVisiblyPregnant()):
		return true
	return false

func getText(_id:String, _args:Dictionary):
	if(_id == "AttackStart"):
		return [
			"Мне плевать, что ты беременна.",
			"Меня не волнует твой живот.",
		]
	if(_id == "GuardFrisk"):
		return [
			"Я буду осторожен с твоим животиком.",
		]
	if(_id == "ReactGETTING_FUCKED"):
		return [
			"Беременная, но всё равно трахается!",
		]
	if(_id == "ReactCOVERED_IN_CUM"):
		return [
			"Беременная, но всё так же жаждет спермы...",
			"Беременная, но всё так же хочет...",
		]
	if(_id == "HelpRestraintsAgree"):
		return [
			"Классный животик...",
		]
	if(_id == "SlutwallAddTip"):
		return [
			"Купи детям чего-нибудь на эти деньги, шлюха.",
		]
	if(_id == "ProstitutionOffer"):
		return [
			"О, ты работаешь даже будучи беременной. Ну и шлюха...",
		]
	if(_id == "AskKeyGive"):
		return [
			"В конце концов, ты будущая мать.",
		]
	if(_id in ["PunishAboutToStocks", "TalkSexOfferAccept"]):
		return [
			"Осторожнее с животиком.",
		]
	return [
	]
