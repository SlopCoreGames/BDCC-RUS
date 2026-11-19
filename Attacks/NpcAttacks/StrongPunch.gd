extends Attack

func _init():
	id = "StrongPunch"
	category = Category.Physical
	aiCategory = AICategory.Offensive
	
func getVisibleName(_context = {}):
	return "Мощный удар"
	
func getVisibleDesc(_context = {}):
	return "Shouldn't see this"
	
func _doAttack(_attacker, _receiver, _context = {}):
	if(checkMissed(_attacker, _receiver, DamageType.Physical)):
		return genericMissMessage(_attacker, _receiver)
	
	if(checkDodged(_attacker, _receiver, DamageType.Physical)):
		return genericDodgeMessage(_attacker, _receiver)
	
	var text = "{attacker.name} умудряется нанести сокрушительный удар в грудь {receiver.name} своим {attacker.his} кулаком!"
	
	return {
		text = text,
		pain = RNG.randi_range(40, 50),
	}
	
func _canUse(_attacker, _receiver, _context = {}):
	return true

func getAnticipationText(_attacker, _receiver):
	return "{attacker.name} throws a powerful punch, aiming to hit {receiver.name} in the chest!"

func getRequirements():
	return [AttackRequirement.FreeArms]

func getAttackSoloAnimation():
	return "punch"
