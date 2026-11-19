extends Attack

func _init():
	id = "RebelPin"
	category = Category.Physical
	aiCategory = AICategory.Offensive
	aiScoreMultiplier = 1.5
	
func getVisibleName(_context = {}):
	return "Булавка повстанца"
	
func getVisibleDesc(_context = {}):
	return "Этого здесь быть не должно"
	
func _doAttack(_attacker, _receiver, _context = {}):
	if(checkMissed(_attacker, _receiver, DamageType.Physical)):
		return genericMissMessage(_attacker, _receiver)
	
	if(checkDodged(_attacker, _receiver, DamageType.Physical)):
		return genericDodgeMessage(_attacker, _receiver)
	
	var text = "{attacker.name} умудряется прижать {receiver.name} к полу своими {attacker.his} мощными бедрами, а затем наносит несколько сокрушительных ударов!"
	text += "\n\n"
	text += RNG.pick([
		"[say=attacker]Жалкое зрелище.[/say]",
		"[say=attacker]Избивать тебя — проще простого.[/say]",
		"[say=attacker]Ну что, хватит уже?[/say]",
	])
	text += "\n\nАй!"
	
	return {
		text = text,
		pain = RNG.randi_range(80, 100),
	}
	
func _canUse(_attacker, _receiver, _context = {}):
	if(!_receiver.hasEffect(StatusEffect.Collapsed)):
		return false
	
	return true

func getAnticipationText(_attacker, _receiver):
	return "{attacker.name} пытается прижать {receiver.name} к месту, это будет больно!"

func getRequirements():
	return [AttackRequirement.FreeLegs]

func getAttackSoloAnimation():
	return "punch"
