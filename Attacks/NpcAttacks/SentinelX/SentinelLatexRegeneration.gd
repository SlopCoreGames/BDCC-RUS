extends Attack

func _init():
	id = "SentinelLatexRegeneration"
	category = Category.Physical
	aiCategory = AICategory.DefensivePain
	aiScoreMultiplier = 0.8
	
func getVisibleName(_context = {}):
	return "Латексная регенерация"
	
func getVisibleDesc(_context = {}):
	return "Shouldn't see this"
	
func _doAttack(_attacker, _receiver, _context = {}):
	if(checkMissed(_attacker, _receiver, DamageType.Physical)):
		return genericMissMessage(_attacker, _receiver)
	
	if(checkDodged(_attacker, _receiver, DamageType.Physical)):
		return genericDodgeMessage(_attacker, _receiver)
	
	var text = "{attacker.name} умудряется обвиться {attacker.his} хлыстом вокруг тела {receiver.name} и притянуть {receiver.him} поближе! Латексный слой {attacker.name} стремительно восстанавливается, поглощая выносливость {receiver.name}!"
	if(_receiver.getStamina() > 0):
		_attacker.addPain(-30)
		_attacker.addStamina(30)
	return {
		text = text,
		pain = 5,
		stamina = 30,
	}
	
func _canUse(_attacker, _receiver, _context = {}):
	return true

func getAnticipationText(_attacker, _receiver):
	var text = "{attacker.name} превращает {attacker.his} руку в латексный хлыст и пытается хлестнуть тебя им!"

	return text

func getRequirements():
	return [AttackRequirement.FreeArms, AttackRequirement.FreeHands]
	

func getAttackSoloAnimation():
	return "shove"

#func getRecieverArmorScaling(_attacker, _receiver, _damageType) -> float:
#	return 0.0
