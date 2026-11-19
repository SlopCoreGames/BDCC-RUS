extends Attack

func _init():
	id = "CuffPCHands"
	category = Category.Physical
	aiCategory = AICategory.Defensive
	aiScoreMultiplier = 0.3
	
func getVisibleName(_context = {}):
	return "Сковал руки наручниками"
	
func getVisibleDesc(_context = {}):
	return "Этого здесь быть не должно"
	
func _doAttack(_attacker, _receiver, _context = {}):
	if(checkMissed(_attacker, _receiver, DamageType.Physical)):
		return genericMissMessage(_attacker, _receiver)
	
	if(checkDodged(_attacker, _receiver, DamageType.Physical)):
		return genericDodgeMessage(_attacker, _receiver)
	
	_receiver.getInventory().forceEquipByStoreOtherUnlessRestraint(GlobalRegistry.createItem("inmatewristcuffs"), _attacker)
	
	var text = "{attacker.name} прижимает тебя к стене, а затем [b]с силой заламывает руки за спину и застегивает наручники[/b]! Тебе удается вырваться.\n\n[say=attacker]"+RNG.pick([
		"Хватит сопротивляться.",
		"Ну и что ты теперь сделаешь?",
		"Сдавайся, это последнее предупреждение.",
		"Медленно, вставай на колени.",
		"Вот так.",
		"Сдавайся, сучка.",
		"А теперь — лицом в пол.",
	])+"[/say]"
	return {
		text = text
	}
	
func _canUse(_attacker, _receiver, _context = {}):
	return _receiver.isPlayer() && !_receiver.hasBoundArms()

func getAnticipationText(_attacker, _receiver):
	return "{attacker.name} несется к тебе, пытаясь схватить, с наручниками в {attacker.his} руках!"

func getRequirements():
	return [AttackRequirement.FreeArms, AttackRequirement.FreeHands]

func getAttackSoloAnimation():
	return "RestraintHands"
