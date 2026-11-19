extends Attack

func _init():
	id = "ForceBlindfoldPC"
	category = Category.Physical
	aiCategory = AICategory.Defensive
	aiScoreMultiplier = 0.4
	
func getVisibleName(_context = {}):
	return "Принудительная повязка"
	
func getVisibleDesc(_context = {}):
	return "Этого здесь быть не должно"
	
func _doAttack(_attacker, _receiver, _context = {}):
	if(checkMissed(_attacker, _receiver, DamageType.Physical)):
		return genericMissMessage(_attacker, _receiver)
	
	if(checkDodged(_attacker, _receiver, DamageType.Physical)):
		return genericDodgeMessage(_attacker, _receiver)
	
	_receiver.getInventory().forceEquipByStoreOtherUnlessRestraint(GlobalRegistry.createItem("blindfold"), _attacker)
	
	var text = "{attacker.name} набрасывается на тебя и умудряется [b]завязать тебе глаза[/b]! Ты отталкиваешь {attacker.him} назад.\n\n[say=attacker]"+RNG.pick([
		"Свет гаснет.",
		"Наслаждайся темнотой.",
		"Поприветствуй темноту.",
		"Что-то не так?",
	])+"[/say]"
	return {
		text = text,
	}
	
func _canUse(_attacker, _receiver, _context = {}):
	return _receiver.isPlayer() && !_receiver.isBlindfolded()

func getAnticipationText(_attacker, _receiver):
	return "{attacker.name} достает повязку и пытается насильно нацепить ее тебе на глаза."

func getRequirements():
	return [AttackRequirement.FreeArms, AttackRequirement.FreeHands]

func getAttackSoloAnimation():
	return "RestraintEyes"
