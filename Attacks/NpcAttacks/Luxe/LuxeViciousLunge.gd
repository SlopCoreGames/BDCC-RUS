extends Attack

func _init():
	id = "LuxeViciousLunge"
	category = Category.Physical
	aiCategory = AICategory.Offensive
	
func getVisibleName(_context = {}):
	return "Лютый выпад"
	
func getVisibleDesc(_context = {}):
	return "Shouldn't see this"
	
func _doAttack(_attacker, _receiver, _context = {}):
	if(checkMissed(_attacker, _receiver, DamageType.Physical)):
		addLuxeRage(_attacker, 0.5)
		return genericMissMessage(_attacker, _receiver)
	
	if(checkDodged(_attacker, _receiver, DamageType.Physical)):
		addLuxeRage(_attacker, 0.5)
		return genericDodgeMessage(_attacker, _receiver)
	
	var text = "С оглушительным ревом {attacker.name} бросается вперед, {attacker.his} когти впиваются в твое плечо и тянут тебя на землю. Огромный вес {attacker.him} прижимает тебя к полу, а {attacker.his} когти с брутальной эффективностью кромсают плоть и мышцы."
	
	if(_receiver.addEffect(StatusEffect.Bleeding)):
		text += " [b]You begin to bleed![/b]"
	if(_receiver.addEffect(StatusEffect.Collapsed)):
		text += " [b]You collapse![/b]"
		
	return {
		text = text,
		pain = 25,
	}
	
func _canUse(_attacker, _receiver, _context = {}):
	if(getLuxeRage(_attacker) < 0.5):
		return false
	
	return true

func getAnticipationText(_attacker, _receiver):
	var text = "Все тело {attacker.name} напрягается, {attacker.his} острые когти выставлены напоказ, а светящийся мех {attacker.his} сияет во тьме, словно тлеющие угли. {attacker.His} рычание переходит в дикий, звериный оскал."

	return text

func getRequirements():
	return [AttackRequirement.FreeArms, AttackRequirement.FreeLegs]
	

func getAttackSoloAnimation():
	return "punch"

func getRecieverArmorScaling(_attacker, _receiver, _damageType) -> float:
	return 1.0

func addLuxeRage(_attacker, howMuch:float):
	if(_attacker.hasEffect("LuxeRage")):
		_attacker.getEffect("LuxeRage").addRage(howMuch)

func getLuxeRage(_attacker) -> float:
	if(_attacker.hasEffect("LuxeRage")):
		return _attacker.getEffect("LuxeRage").rage
	return 0.0
