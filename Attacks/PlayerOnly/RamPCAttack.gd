extends Attack

func _init():
	id = "RamPCAttack"
	category = Category.Special
	aiCategory = AICategory.Offensive
	
func getVisibleName(_context = {}):
	return "Таран"
	
func getVisibleDesc(_context = {}):
	return "Таран наносит "+scaledDmgRangeStr(DamageType.Physical, 10, 15)+" ед. урона. Расходует 50 выносливости\n\nСбивает противника с ног и оглушает на 2 хода.\n\nЭффективно против бронированных целей"
	
func _doAttack(_attacker, _receiver, _context = {}):
	if(checkMissed(_attacker, _receiver, DamageType.Physical)):
		return genericMissMessage(_attacker, _receiver, "ram")
	
	if(checkDodged(_attacker, _receiver, DamageType.Physical)):
		return genericDodgeMessage(_attacker, _receiver, "ram")
	
	var texts = [
		"{attacker.name} rams {receiver.name}."
	]
	var text = RNG.pick(texts)
	
	if(_receiver.addEffect(StatusEffect.Collapsed)):
		text += "\n[b]{receiver.name} теряет {receiver.his} равновесие и валится на пол[/b]."
		
	if(_receiver.addEffect(StatusEffect.Stunned, [2])):
		text += "\n[b]{receiver.name} оглушен![/b]"
	
	return {
		text = text,
		pain = RNG.randi_range(10, 15),
	}
	
func _canUse(_attacker, _receiver, _context = {}):
	return true

func getRequirements():
	return [[AttackRequirement.Stamina, 50]]

func getAnticipationText(_attacker, _receiver):
	return "{attacker.name} lunges forward and tries to kick you"

func getAttackSoloAnimation():
	return "charge"

func getExperience():
	return [[Skill.Combat, 10]]

func getRecieverArmorScaling(_attacker, _receiver, _damageType) -> float:
	return 0.0
