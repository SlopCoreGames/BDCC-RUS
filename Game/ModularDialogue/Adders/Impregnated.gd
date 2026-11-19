extends DialogueFillerAdder

func _init():
	prefix = false
	chance = 100.0
	priority = 0

func getFormIDs() -> Array:
	return [
		"FightWonGeneric",
		"PunishLockIntoSlutwall",
		"ReactGETTING_FUCKED",
		"ReactON_A_LEASH",
		"SlutwallStealCredits",
		"PunishLockIntoSlutwall",
		"HelpRestraintsDeny",
		"TalkGrabAndFuck",
		"AttackReact",
		"AskKeyDeny",
		]

func canBeUsed(_id:String, _args:Dictionary, _form) -> bool:
	var mainCharID:String = getCharID(_args, _form.mainRole)
	var dirToCharID:String = getCharID(_args, _form.dirToRole)
	
	if(GM.main.WHS.queryHappened(WHEvent.Impregnated, [
		[WHCond.Who, dirToCharID],
		[WHCond.Target, mainCharID],
	]) && getChar(_args, _form.mainRole).isVisiblyPregnant()):
		return true
	return false

func getText(_id:String, _args:Dictionary):
	if(_id == "AttackReact"):
		return [
			"Ты меня осеменил... и теперь ты вот так поступаешь?..",
			"Ты заставил меня забеременеть... и теперь ты творишь это?..",
			"Ты хоть понимаешь, что я ношу в себе твое отродье?!",
			"Ты собрался бить меня, когда я беременна твоим выводком?",
		]
	return [
		"Это тебе за то, что ты меня осеменил.",
		"Так тебе и надо за то, что ты меня трахнул и засадил, ублюдок.",
		"Это тебе за то, что ты заставил меня забеременеть.",
	]
