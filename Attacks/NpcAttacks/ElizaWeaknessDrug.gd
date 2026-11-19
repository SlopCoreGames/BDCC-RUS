extends Attack

func _init():
	id = "ElizaWeaknessDrug"
	category = Category.Special
	aiCategory = AICategory.Defensive
	
func getVisibleName(_context = {}):
	return "Слабодействующий препарат"
	
func getVisibleDesc(_context = {}):
	return "Этого здесь быть не должно"
	
func _doAttack(_attacker, _receiver, _context = {}):
	if(checkMissed(_attacker, _receiver, DamageType.Stamina)):
		return genericMissMessage(_attacker, _receiver)
	
	if(checkDodged(_attacker, _receiver, DamageType.Stamina)):
		return genericDodgeMessage(_attacker, _receiver)
	
	var text = "{attacker.name} умудряется вонзить шприц тебе в шею! Твои мышцы отказываются напрягаться, и ты внезапно чувствуешь невыносимую слабость!"
	_receiver.addEffect(StatusEffect.Weakness)
	return {
		text = text,
		stamina = 10,
	}
	
func _canUse(_attacker, _receiver, _context = {}):
	return true

func getAnticipationText(_attacker, _receiver):
	return "{attacker.name} хватает со {attacker.his} пояса шприц с ярко-голубым препаратом и бросается на тебя."

func getRequirements():
	return [AttackRequirement.FreeArms, AttackRequirement.FreeHands]

func getAttackSoloAnimation():
	return "WeaponSyringe"
