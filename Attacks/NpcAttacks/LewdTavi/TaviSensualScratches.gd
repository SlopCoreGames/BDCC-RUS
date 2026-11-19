extends Attack

func _init():
	id = "TaviSensualScratches"
	category = Category.Physical
	aiCategory = AICategory.Offensive
	
func getVisibleName(_context = {}):
	return "Чувственные царапины"
	
func getVisibleDesc(_context = {}):
	return "Этого здесь быть не должно"
	
func _doAttack(_attacker, _receiver, _context = {}):
	if(checkMissed(_attacker, _receiver, DamageType.Physical)):
		return genericMissMessage(_attacker, _receiver, "scratch")
	
	if(checkDodged(_attacker, _receiver, DamageType.Physical)):
		return genericDodgeMessage(_attacker, _receiver, "scratch")
	
	var text = "{attacker.name} обсыпает {receiver.name} градом дразнящих царапин, вызывая одновременно и боль, и легкое возбуждение."
	if(RNG.chance(50) && _receiver.addEffect(StatusEffect.Bleeding)):
		text += " Острые когти заставили {receiver.name} начать [color=red]кровоточить[/color]."
	
	return {
		text = text,
		lust = RNG.randi_range(5, 10),
		pain = RNG.randi_range(40, 50),
	}
	
func _canUse(_attacker, _receiver, _context = {}):
	return true

func getAnticipationText(_attacker, _receiver):
	var text = "{attacker.name} выпускает острые когти {attacker.his}, а {attacker.he} предвкушающе скалится, готовая оставить на тебе свой след."

	return text

func getRequirements():
	return [AttackRequirement.FreeArms, AttackRequirement.FreeHands]

func getAttackSoloAnimation():
	return "punch"
