extends Attack

func _init():
	id = "slapTitsAttack"
	category = Category.Lust
	aiCategory = AICategory.Lust
	
func getVisibleName(_context = {}):
	return "Шлепать по сиськам"
	
func getVisibleDesc(_context = {}):
	return "Тебе не стоит этого видеть"
	
func _doAttack(_attacker, _receiver, _context = {}):
	if(checkMissed(_attacker, _receiver, DamageType.Physical)):
		return genericMissMessage(_attacker, _receiver, "slap")
	
	if(checkDodged(_attacker, _receiver, DamageType.Physical)):
		return genericDodgeMessage(_attacker, _receiver, "slap")
	
	var _damage = 0
	var text = ""
	if((_receiver.isPlayer() && _receiver.hasBigBreasts()) || (!_receiver.isPlayer() && _receiver.getGender() != Gender.Male)):
		_damage = RNG.randi_range(20, 20)
		text += "По огромным сиськам {receiver.name} пришелся болезненный шлепок! {attacker.name} также умудрился задеть чувствительные соски.\n"
	else:
		_damage = RNG.randi_range(1, 5)
		text += "{receiver.name} даже не почувствовала шлепка, но руке {attacker.name} все же удалось задеть чувствительные соски.\n"
	
	return {
		text = text,
		pain = _damage,
		lust = RNG.randi_range(20, 30),
	}
	
func _canUse(_attacker, _receiver, _context = {}):
	return true

func getAnticipationText(_attacker, _receiver):
	return RNG.pick([
		"{attacker.name} бросается на {receiver.name}, целясь шлепнуть по {receiver.his} сиськам!",
	])

func getRequirements():
	return [AttackRequirement.FreeArms]

func getAttackSoloAnimation():
	return "ChestSlap"
