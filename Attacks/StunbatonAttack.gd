extends Attack

func _init():
	id = "stunbatonAttack"
	category = Category.Physical
	aiCategory = AICategory.Offensive
	
func getVisibleName(_context = {}):
	return "Используй электродубинку"
	
func getVisibleDesc(_context = {}):
	return "Тебе не стоит этого видеть"
	
func _doAttack(_attacker, _receiver, _context = {}):
	if(checkMissed(_attacker, _receiver, DamageType.Physical)):
		return genericMissMessage(_attacker, _receiver)
	
	if(checkDodged(_attacker, _receiver, DamageType.Physical)):
		return genericDodgeMessage(_attacker, _receiver)
	
	var texts = [
		"{attacker.name} наносит удар электрошоковой дубинкой по {receiver.name}, пропуская болезненный разряд через всё тело {receiver.his}",
		"Электрошокер {attacker.name} бьет по {receiver.name}, вызывая резкую вспышку боли.",
		"{attacker.name} наносит {attacker.his} атаку, пропуская электрический разряд через тело {receiver.name}.",
	]
	var text = RNG.pick(texts)
	
	return {
		text = text,
		pain = RNG.randi_range(20, 40),
	}
	
func _canUse(_attacker, _receiver, _context = {}):
	return true

func getAnticipationText(_attacker, _receiver):
	return RNG.pick([
		"{attacker.name} крепче сжимает {attacker.his} электродубинку и делает выпад вперед, нанося удар оружием.",
		"{attacker.name} swings {attacker.his} stun baton at {receiver.name}, aiming for {receiver.his} exposed areas where it would have the most effect.",
		"Световой дубинка {attacker.name} высекает искры, пока {attacker.he} готовится нанести удар по {receiver.name}.",
	])

func getRequirements():
	return [AttackRequirement.FreeArms, AttackRequirement.FreeHands]

func getAttackSoloAnimation():
	return "stunbaton"
