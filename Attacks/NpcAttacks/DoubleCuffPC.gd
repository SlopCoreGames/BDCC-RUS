extends Attack

func _init():
	id = "DoubleCuffPC"
	category = Category.Physical
	aiCategory = AICategory.Defensive
	aiScoreMultiplier = 0.2
	
func getVisibleName(_context = {}):
	return "Сковывает руки и ноги"
	
func getVisibleDesc(_context = {}):
	return "Этого здесь быть не должно"
	
func _doAttack(_attacker, _receiver, _context = {}):
	if(checkMissed(_attacker, _receiver, DamageType.Physical)):
		return genericMissMessage(_attacker, _receiver)
	
	if(checkDodged(_attacker, _receiver, DamageType.Physical)):
		return genericDodgeMessage(_attacker, _receiver)
	
	_receiver.getInventory().forceEquipByStoreOtherUnlessRestraint(GlobalRegistry.createItem("inmatewristcuffs"), _attacker)
	_receiver.getInventory().forceEquipByStoreOtherUnlessRestraint(GlobalRegistry.createItem("inmateanklecuffs"), _attacker)
	_receiver.addEffect(StatusEffect.Collapsed)
	
	var text = "{attacker.name} удается повалить тебя на пол. Затем {attacker.he} достает две пары наручников и [b]стягивает твои руки и ноги[/b]! Тебе удается стряхнуть {attacker.him}, но ты всё еще лежишь на полу."
	return {
		text = text
	}
	
func _canUse(_attacker, _receiver, _context = {}):
	return _receiver.isPlayer() && !_receiver.hasBoundArms() && !_receiver.hasBoundLegs()

func getAnticipationText(_attacker, _receiver):
	return "{attacker.name} хватает тебя за воротник и пытается прижать к земле!\n\n[say=attacker]"+RNG.pick([
		"Применение сдерживающей силы разрешено.",
		"Это будет отлично смотреться вместе с тем ошейником.",
		"Сдайся, и, возможно, тебе даже понравится.",
		"Готов к усмирению?",
	])+"[/say]"

func getRequirements():
	return [AttackRequirement.FreeArms, AttackRequirement.FreeHands]

func getAttackSoloAnimation():
	return "RestraintBody"
