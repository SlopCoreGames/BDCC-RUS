extends Attack

func _init():
	id = "AxisGrab"
	category = Category.Lust
	aiCategory = AICategory.Lust
	
func getVisibleName(_context = {}):
	return "Захват оси"
	
func getVisibleDesc(_context = {}):
	return "Shouldn't see this"
	
func _doAttack(_attacker, _receiver, _context = {}):
	if(checkMissed(_attacker, _receiver, DamageType.Physical)):
		return genericMissMessage(_attacker, _receiver)
	
	if(checkDodged(_attacker, _receiver, DamageType.Physical)):
		return genericDodgeMessage(_attacker, _receiver)
	
	var text = "{attacker.name} хватает {receiver.name} за голову и прижимает к {attacker.his} паху, позволяя {receiver.name} почувствовать возбуждающий бугорок и вдохнуть его дурманящий запах."
	return {
		text = text,
		lust = 50,
	}
	
func _canUse(_attacker, _receiver, _context = {}):
	return true

func getAnticipationText(_attacker, _receiver):
	var text = "{attacker.name} пытается схватить {receiver.name}!"

	return text

func getRequirements():
	return [AttackRequirement.FreeArms, AttackRequirement.FreeHands]
	
func getAttackSoloAnimation():
	return "LustCockTaunt"
