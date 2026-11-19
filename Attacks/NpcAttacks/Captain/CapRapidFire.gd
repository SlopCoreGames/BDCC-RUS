extends Attack

func _init():
	id = "CapRapidFire"
	category = Category.Physical
	aiCategory = AICategory.Offensive
	aiScoreMultiplier = 1.0
	
func getVisibleName(_context = {}):
	return "Скорострельность"
	
func getVisibleDesc(_context = {}):
	return "Этого здесь быть не должно"
	
func _doAttack(_attacker, _receiver, _context = {}):
	if(checkMissed(_attacker, _receiver, DamageType.Physical)):
		return genericMissMessage(_attacker, _receiver)
	
	if(checkDodged(_attacker, _receiver, DamageType.Physical)):
		return genericDodgeMessage(_attacker, _receiver)
	
	var amountOfShots = RNG.randi_range(1, 5) + RNG.randi_range(1, 5)
	
	var text = "{attacker.name} выпускает серию стремительных энергетических выстрелов, поражая {receiver.name} "+str(amountOfShots)+" раз. Каждый удар пронзает тело {receiver.his} вспышками боли."
	
	return {
		text = text,
		pain = amountOfShots * 10,
	}
	
func _canUse(_attacker, _receiver, _context = {}):
	return true

func getAnticipationText(_attacker, _receiver):
	return "{attacker.name} держит {attacker.his} палец на спусковом крючке {attacker.his} энергетического пистолета, готовая обрушить шквал выстрелов на {receiver.name}." 

func getAttackSoloAnimation():
	return "firepistol"

func getRequirements():
	return [AttackRequirement.FreeArms, AttackRequirement.FreeHands]

func getRecieverArmorScaling(_attacker, _receiver, _damageType) -> float:
	return 0.2
