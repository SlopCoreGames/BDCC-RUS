extends Attack

func _init():
	id = "ShivAttack"
	category = Category.Physical
	aiCategory = AICategory.Offensive
	
func getVisibleName(_context = {}):
	return "Шило"
	
func getVisibleDesc(_context = {}):
	return "Этого здесь быть не должно"
	
func _doAttack(_attacker, _receiver, _context = {}):
	if(checkMissed(_attacker, _receiver, DamageType.Physical)):
		return genericMissMessage(_attacker, _receiver)
	
	if(checkDodged(_attacker, _receiver, DamageType.Physical)):
		return genericDodgeMessage(_attacker, _receiver)
	
	var text = "{attacker.name} умудряется оставить несколько порезов на {receiver.name}, из-за чего {receiver.him} начинает [color=red]кровоточить[/color]!"
	
	_receiver.addEffect(StatusEffect.Bleeding)
	return {
		text = text,
		pain = RNG.randi_range(20, 30),
	}
	
func _canUse(_attacker, _receiver, _context = {}):
	return true

func getAnticipationText(_attacker, _receiver):
	return "{attacker.name} бросается на {receiver.name} и пытается полоснуть {receiver.him} {attacker.his} заточкой!"

func getRequirements():
	return [AttackRequirement.FreeArms, AttackRequirement.FreeHands]

func getAttackSoloAnimation():
	return "shiv"
