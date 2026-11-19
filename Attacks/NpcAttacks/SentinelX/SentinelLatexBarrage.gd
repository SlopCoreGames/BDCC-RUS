extends Attack

func _init():
	id = "SentinelLatexBarrage"
	category = Category.Physical
	aiCategory = AICategory.Offensive
	
func getVisibleName(_context = {}):
	return "Латексный обстрел"
	
func getVisibleDesc(_context = {}):
	return "Этого здесь быть не должно"
	
func _doAttack(_attacker, _receiver, _context = {}):
	if(checkMissed(_attacker, _receiver, DamageType.Physical)):
		return genericMissMessage(_attacker, _receiver)
	
	if(checkDodged(_attacker, _receiver, DamageType.Physical)):
		return genericDodgeMessage(_attacker, _receiver)
	
	var text = "{attacker.name} обрушивает на цель серию стремительных ударов, каждый из которых пропитан липким латексом {attacker.his}, причиняя {receiver.name} непрекращающуюся боль и дискомфорт."
	return {
		text = text,
		pain = 40,
	}
	
func _canUse(_attacker, _receiver, _context = {}):
	return true

func getAnticipationText(_attacker, _receiver):
	var text = "{attacker.name} принимает боевую стойку, готовясь нанести шквал ударов конечностями, покрытыми {attacker.his} латексом."

	return text

func getRequirements():
	return [AttackRequirement.FreeArms]
	

func getAttackSoloAnimation():
	return "punch"

func getRecieverArmorScaling(_attacker, _receiver, _damageType) -> float:
	return 3.0
