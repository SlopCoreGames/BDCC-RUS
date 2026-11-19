extends Attack

func _init():
	id = "SentinelLatexSlam"
	category = Category.Physical
	aiCategory = AICategory.Offensive
	
func getVisibleName(_context = {}):
	return "Латексный удар"
	
func getVisibleDesc(_context = {}):
	return "Shouldn't see this"
	
func _doAttack(_attacker, _receiver, _context = {}):
	if(checkMissed(_attacker, _receiver, DamageType.Physical)):
		return genericMissMessage(_attacker, _receiver)
	
	if(checkDodged(_attacker, _receiver, DamageType.Physical)):
		return genericDodgeMessage(_attacker, _receiver)
	
	var text = "С громоподобным ударом {attacker.name} впечатывает свою покрытую клеем ногу в {receiver.name}, причиняя {attacker.his} нестерпимую боль."
	return {
		text = text,
		pain = 40,
	}
	
func _canUse(_attacker, _receiver, _context = {}):
	return true

func getAnticipationText(_attacker, _receiver):
	var text = "{attacker.name} набирает силу, готовясь нанести мощный удар. Этот удар полностью проигнорирует твою броню!"

	return text

func getRequirements():
	return [AttackRequirement.FreeLegs]
	

func getAttackSoloAnimation():
	return "kick"

func getRecieverArmorScaling(_attacker, _receiver, _damageType) -> float:
	return 0.0
