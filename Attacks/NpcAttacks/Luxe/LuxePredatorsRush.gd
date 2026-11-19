extends Attack

func _init():
	id = "LuxePredatorsRush"
	category = Category.Physical
	aiCategory = AICategory.Offensive
	
func getVisibleName(_context = {}):
	return "Рывок хищника"
	
func getVisibleDesc(_context = {}):
	return "Этого здесь быть не должно"
	
func _doAttack(_attacker, _receiver, _context = {}):
	if(checkMissed(_attacker, _receiver, DamageType.Physical)):
		addLuxeRage(_attacker, 0.25)
		return genericMissMessage(_attacker, _receiver)
	
	if(checkDodged(_attacker, _receiver, DamageType.Physical)):
		addLuxeRage(_attacker, 0.25)
		return genericDodgeMessage(_attacker, _receiver)
	
	var text = "{attacker.name} бросается на тебя с ужасающей скоростью, {attacker.his} плечо врезается тебе прямо в грудь. От удара ты отлетаешь назад, судорожно хватая ртом воздух, пока резкая боль прошивает ребра."
	
	if(_receiver.addEffect(StatusEffect.Weakness, [2])):
		text += " [b]Ты чувствуешь слабость![/b]"
	if(RNG.chance(40) && _receiver.addEffect(StatusEffect.Collapsed)):
		text += " [b]Ты валишься с ног![/b]"
		
	return {
		text = text,
		pain = 20,
	}
	
func _canUse(_attacker, _receiver, _context = {}):
	return true

func getAnticipationText(_attacker, _receiver):
	var text = "{attacker.name} пригибается к земле, {attacker.his} мышцы напрягаются, словно сжатая стальная пружина. {attacker.His} светящийся мех начинает мерцать ярче, когда {attacker.he} готовится к прыжку."

	return text

func getRequirements():
	return [AttackRequirement.FreeLegs]
	

func getAttackSoloAnimation():
	return "charge"

func getRecieverArmorScaling(_attacker, _receiver, _damageType) -> float:
	return 1.0

func addLuxeRage(_attacker, howMuch:float):
	if(_attacker.hasEffect("LuxeRage")):
		_attacker.getEffect("LuxeRage").addRage(howMuch)
