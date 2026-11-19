extends Attack

func _init():
	id = "CapTacticalStrike"
	category = Category.Physical
	aiCategory = AICategory.Defensive
	aiScoreMultiplier = 0.6
	
func getVisibleName(_context = {}):
	return "Тактический удар"
	
func getVisibleDesc(_context = {}):
	return "Этого здесь быть не должно"
	
func _doAttack(_attacker, _receiver, _context = {}):
	if(checkMissed(_attacker, _receiver, DamageType.Physical)):
		return genericMissMessage(_attacker, _receiver)
	
	if(checkDodged(_attacker, _receiver, DamageType.Physical)):
		return genericDodgeMessage(_attacker, _receiver)
	
	var text = "{attacker.name} бросается вперед, нанося {receiver.name} мощный удар, причиняющий сильную боль."
	if(!_receiver.hasEffect(StatusEffect.Stunned)):
		if(_receiver.addEffect(StatusEffect.Stunned)):
			text += " Внезапная атака [b]ошеломила[/b] {receiver.name}."
			text += "\n\n"
			text += "[say=attacker]"+RNG.pick(["Почему ты всё ещё сопротивляешься?", "И это ведь даже не наказание.", "Сдайся. Живо."])+"[/say]"
	
	return {
		text = text,
		pain = RNG.randi_range(10, 20),
	}
	
func _canUse(_attacker, _receiver, _context = {}):
	return true

func getAnticipationText(_attacker, _receiver):
	return "{attacker.name} готовится ударить {receiver.name} рукоятью {attacker.his}!"
	
func getAttackSoloAnimation():
	return "punch"

func getRequirements():
	return [AttackRequirement.FreeArms, AttackRequirement.FreeHands]

#func getRecieverArmorScaling(_attacker, _receiver, _damageType) -> float:
#	return 0.1
