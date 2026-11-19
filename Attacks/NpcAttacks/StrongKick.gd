extends Attack

func _init():
	id = "StrongKick"
	category = Category.Physical
	aiCategory = AICategory.Offensive
	
func getVisibleName(_context = {}):
	return "Мощный удар ногой"
	
func getVisibleDesc(_context = {}):
	return "Этого здесь быть не должно"
	
func _doAttack(_attacker, _receiver, _context = {}):
	if(checkMissed(_attacker, _receiver, DamageType.Physical)):
		return genericMissMessage(_attacker, _receiver)
	
	if(checkDodged(_attacker, _receiver, DamageType.Physical)):
		return genericDodgeMessage(_attacker, _receiver)
	
	var text = "{attacker.name} бьет {receiver.name} с силой разъяренного мустанга."
	
	if(_receiver.addEffect(StatusEffect.Collapsed)):
		text += " {receiver.name} рухнул(а) на землю."
	return {
		text = text,
		pain = RNG.randi_range(50, 60),
	}
	
func _canUse(_attacker, _receiver, _context = {}):
	return true

func getAnticipationText(_attacker, _receiver):
	return "{attacker.name} бьет(ь) копытом {attacker.his} в землю и делает выпад вперед."

func getRequirements():
	return [AttackRequirement.FreeLegs]

func getAttackSoloAnimation():
	return "kick"
