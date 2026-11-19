extends Reference
class_name LustAction

var id = "error"
var needsFreeHand = false
var hasByDefault = false
var isOrgasmAction = false

func shouldShow(_lustState: LustCombatState, _args):
	return true

func canDo(_lustState: LustCombatState, _args):
	if(needsFreeHand && !_lustState.canDoAction()):
		return [false, "Твои руки слишком заняты"]
	var minLevel = skillNeeded()
	if(minLevel > 0 && _lustState.isInPublic() && _lustState.getCharacter().getSkillLevel(Skill.Exhibitionism) < minLevel):
		return [false, "Тебе слишком стыдно делать это на людях; найди более уединенное место или займись чем-нибудь другим... (Уровень эксгибиционизма) "+str(minLevel)+"+)"]
	# return [false, "Too horny"]
	return true

func getVisibleName(_lustState: LustCombatState, _args):
	return "ERROR"

func getVisibleDescription(_lustState: LustCombatState, _args):
	return "Тебе не стоит этого видеть"

func doAction(_lustState: LustCombatState, _args):
	return {
		text = "Неа",
		#anim="",
	}

func getItem(_lustState: LustCombatState, _args) -> ItemBase:
	if(!_args.has("item")):
		return null
	return _lustState.getCharacter().getInventory().getItemByUniqueID(_args["item"])

func getLustTopics():
	return {}

func getPriority():
	return 0

func isTease():
	return false

func skillNeeded():
	return 0

func getExperience(_lustState: LustCombatState, _args):
	return []

func getVisibility():
	return RNG.randf_range(0.05, 0.1)
