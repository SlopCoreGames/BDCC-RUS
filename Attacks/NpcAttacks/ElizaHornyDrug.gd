extends Attack

func _init():
	id = "ElizaHornyDrug"
	category = Category.Lust
	aiCategory = AICategory.Lust
	
func getVisibleName(_context = {}):
	return "Возбуждающий наркотик"
	
func getVisibleDesc(_context = {}):
	return "Shouldn't see this"
	
func _doAttack(_attacker, _receiver, _context = {}):
	if(checkMissed(_attacker, _receiver, DamageType.Lust)):
		return genericMissMessage(_attacker, _receiver)
	
	if(checkDodged(_attacker, _receiver, DamageType.Lust)):
		return genericDodgeMessage(_attacker, _receiver)
	
	var text = "{attacker.name} умудряется вонзить шприц тебе в шею! Тебе становится так жарко, в паху всё горит, ты не можешь перестать ласкать себя на глазах у {attacker.name}, тебе жизненно необходимо заняться сексом!"
	return {
		text = text,
		lust = 20,
	}
	
func _canUse(_attacker, _receiver, _context = {}):
	return true

func getAnticipationText(_attacker, _receiver):
	return "{attacker.name} grabs a syringe with a pink-colored drug inside off {attacker.his} belt and pounces at you."

func getRequirements():
	return [AttackRequirement.FreeArms, AttackRequirement.FreeHands]

func getAttackSoloAnimation():
	return "WeaponSyringe"
