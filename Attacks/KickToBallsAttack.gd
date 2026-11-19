extends Attack

func _init():
	id = "kickToBallsAttack"
	category = Category.Physical
	aiCategory = AICategory.Offensive
	
func getVisibleName(_context = {}):
	return "Удар в пах"
	
func getVisibleDesc(_context = {}):
	return "Тебе не стоит этого видеть"
	
func _doAttack(_attacker, _receiver, _context = {}):
	if(checkMissed(_attacker, _receiver, DamageType.Physical)):
		return genericMissMessage(_attacker, _receiver, "kick")
	
	if(checkDodged(_attacker, _receiver, DamageType.Physical)):
		return genericDodgeMessage(_attacker, _receiver, "kick")
	
	var _damage

	var text = ""
	if((_receiver.isPlayer() && _receiver.hasPenis()) || (!_receiver.isPlayer() && _receiver.getGender() != Gender.Female)):
		_damage = RNG.randi_range(30, 50)
		text += "{attacker.name} бьет {receiver.name} по яйцам! Это было невероятно больно.\n"
		
		if(!_receiver.hasEffect(StatusEffect.Collapsed) && _receiver.addEffect(StatusEffect.Collapsed)):
			text += "{receiver.name} вцепляется в пах {receiver.his}, и тот [b]валится на пол.[/b]\n"
	else:
		_damage = RNG.randi_range(10, 10)
		text += "{attacker.name} удается попасть ногой в пах {receiver.name}, но это было не слишком больно.\n"
		
	return {
		text = text,
		pain = _damage,
	}
	
func _canUse(_attacker, _receiver, _context = {}):
	return true

func getAnticipationText(_attacker, _receiver):
	return RNG.pick([
		"{attacker.name} решает играть грязно: {attacker.he} бросается вперед и пытается пнуть {receiver.name} по яйцам! Если у {receiver.he} они есть, это будет чертовски больно.",
	])

func getRequirements():
	return [AttackRequirement.FreeLegs]

func getAttackSoloAnimation():
	return "kick"
