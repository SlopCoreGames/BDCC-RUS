extends Attack

func _init():
	id = "KickPCAttack"
	category = Category.Physical
	aiCategory = AICategory.Offensive
	isPlayerAttack = true
	attackPriority = 10
	
func getVisibleName(_context = {}):
	return "Удар ногой"
	
func getVisibleDesc(_context = {}):
	return "Удар ногой, наносящий "+scaledDmgRangeStr(DamageType.Physical, 10, 15)+" ед. урона.\n\nС небольшим шансом может сбить противника с ног.\n\nЭффективно против бронированных целей"
	
func _doAttack(_attacker, _receiver, _context = {}):
	if(checkMissed(_attacker, _receiver, DamageType.Physical)):
		return genericMissMessage(_attacker, _receiver, "kick")
	
	if(checkDodged(_attacker, _receiver, DamageType.Physical)):
		return genericDodgeMessage(_attacker, _receiver, "kick")
	
	var texts = [
		"{attacker.name} kicks {receiver.name}."
	]
	var text = RNG.pick(texts)
	
	if(RNG.chance(20) && !_receiver.hasEffect(StatusEffect.Collapsed)):
		if(_receiver.addEffect(StatusEffect.Collapsed)):
			text += "\n[b]{receiver.name} теряет {receiver.his} равновесие и валится на пол[/b]."
	
	return {
		text = text,
		pain = RNG.randi_range(10, 15),
	}
	
func _canUse(_attacker, _receiver, _context = {}):
	return true

func getRequirements():
	return [AttackRequirement.FreeLegs]

func getAnticipationText(_attacker, _receiver):
	return "{attacker.name} делает выпад вперед, пытаясь пнуть тебя"

func getAttackSoloAnimation():
	return "kick"

func getExperience():
	return [[Skill.Combat, 10]]

func getRecieverArmorScaling(_attacker, _receiver, _damageType) -> float:
	return 0.25
