extends Attack

func _init():
	id = "LuxeSavageBackhand"
	category = Category.Physical
	aiCategory = AICategory.Offensive
	
func getVisibleName(_context = {}):
	return "Дикий тычок лапой"
	
func getVisibleDesc(_context = {}):
	return "Этого здесь быть не должно"
	
func _doAttack(_attacker, _receiver, _context = {}):
	if(checkMissed(_attacker, _receiver, DamageType.Physical)):
		addLuxeRage(_attacker, 0.25)
		return genericMissMessage(_attacker, _receiver)
	
	if(checkDodged(_attacker, _receiver, DamageType.Physical)):
		addLuxeRage(_attacker, 0.25)
		return genericDodgeMessage(_attacker, _receiver)
	
	var text = "Массивная лапа {attacker.name} с костодробительной силой врезается в твой висок; когти впиваются в кожу, а мир вокруг начинает бешено вращаться. Кровь брызжет на пол, пока нестерпимая боль ревет в твоем черепе."
	
	if(RNG.chance(50) && _receiver.addEffect(StatusEffect.Bleeding)):
		text += " [b]Ты начинаешь истекать кровью![/b]"
		
	return {
		text = text,
		pain = 30,
	}
	
func _canUse(_attacker, _receiver, _context = {}):
	if(getLuxeRage(_attacker) < 0.5):
		return false
	
	return true

func getAnticipationText(_attacker, _receiver):
	var text = "{attacker.name} скалит {attacker.his} зубы, и в глубине {attacker.his} груди рокочет рык, когда {attacker.he} заносит когтистую лапу. {attacker.His} светящаяся шерсть едва заметно пульсирует от {attacker.his} нарастающей ярости."

	return text

func getRequirements():
	return [AttackRequirement.FreeArms]
	

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
