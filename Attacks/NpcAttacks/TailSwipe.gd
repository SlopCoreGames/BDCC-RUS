extends Attack

func _init():
	id = "TailSwipe"
	category = Category.Physical
	aiCategory = AICategory.Offensive
	
func getVisibleName(_context = {}):
	return "Удар хвостом"
	
func getVisibleDesc(_context = {}):
	return "Этого здесь быть не должно"
	
func _doAttack(_attacker, _receiver, _context = {}):
	if(checkMissed(_attacker, _receiver, DamageType.Physical)):
		return genericMissMessage(_attacker, _receiver)
	
	if(checkDodged(_attacker, _receiver, DamageType.Physical)):
		return genericDodgeMessage(_attacker, _receiver)
	
	var text = "{attacker.name} хлещет {receiver.name} по ногам своим {attacker.his} хвостом, заставляя {receiver.him} споткнуться!"
	_receiver.addEffect(StatusEffect.Collapsed)
	
	return {
		text = text,
		pain = 10,
	}
	
func _canUse(_attacker, _receiver, _context = {}):
	if(_receiver.hasEffect(StatusEffect.Collapsed)):
		return false
	
	return true

func getAnticipationText(_attacker, _receiver):
	return "{attacker.name} использует {attacker.his} хвост, чтобы полоснуть по земле прямо из-под ног {receiver.name}!"

func getRequirements():
	return [AttackRequirement.FreeLegs]

func getAttackSoloAnimation():
	return "TailSwipe"
