extends Attack

func _init():
	id = "trygetupattack"
	category = Category.Physical
	
func getVisibleName(_context = {}):
	return "Попытка подняться"
	
func getVisibleDesc(_context = {}):
	return "You shouldn't see this"
	
func _doAttack(_attacker, _receiver, _context = {}):
	var success = false
	if(RNG.chance(70) || _attacker.hasPerk(Perk.CombatBetterGetUp)):
		_attacker.removeEffect(StatusEffect.Collapsed)
		success = true
	
	var text
	if(success):
		text = "{attacker.name} тратит {attacker.his} ход, но [b]{attacker.he} всё же удаётся подняться[/b]"
	else:
		text = "{attacker.name} пытается подняться [b], но не успевает[/b]"
	
	return {
		text = text,
	}
	
func _canUse(_attacker, _receiver, _context = {}):
	return _attacker.hasEffect(StatusEffect.Collapsed) && _attacker.canStandUpCombat()

func canBeDodgedByPlayer(_attacker, _receiver):
	return false

func getAIScore(_attacker, _receiver):
	if(_attacker.hasEffect(StatusEffect.Collapsed)):
		return 5.0
	return 0.0
