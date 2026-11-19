extends Attack

func _init():
	id = "stunbatonOverchargeAttack"
	category = Category.Physical
	aiCategory = AICategory.Offensive
	aiScoreMultiplier = 0.5
	
func getVisibleName(_context = {}):
	return "Используй электродубинку"
	
func getVisibleDesc(_context = {}):
	return "Тебе не стоит этого видеть"
	
func _doAttack(_attacker, _receiver, _context = {}):
	if(checkMissed(_attacker, _receiver, DamageType.Physical)):
		return genericMissMessage(_attacker, _receiver)
	
	if(checkDodged(_attacker, _receiver, DamageType.Physical)):
		return genericDodgeMessage(_attacker, _receiver)
		
	var texts = [
		"Перегруженное оружие {attacker.name} всё же достигает цели — {receiver.name}. Сам удар был не таким уж сильным, но последовавший за ним электрический разряд оказался невероятно мощным и болезненным, отчего мышцы {receiver.name} непроизвольно свело судорогой.",
	]
	var text = RNG.pick(texts)
	
	if(!_receiver.hasEffect(StatusEffect.Collapsed) && _receiver.addEffect(StatusEffect.Collapsed)):
		text += "\n{receiver.name} не выдержала атаки, и [b]рухнула на пол[/b]!"
	
	return {
		text = text,
		pain = RNG.randi_range(40, 60),
		stamina = RNG.randi_range(10, 20),
	}
	
func _canUse(_attacker, _receiver, _context = {}):
	return true

func getAnticipationText(_attacker, _receiver):
	return RNG.pick([
		"{attacker.name} перегружает электрошокер {attacker.his}; вы видите, как из него сыплется град искр и раздается жужжащий звук. Затем {attacker.name} бросается на {receiver.name}. Это будет чертовски больно.",
	])

func getRequirements():
	return [[AttackRequirement.Stamina, 25], AttackRequirement.FreeArms, AttackRequirement.FreeHands]

func getAttackSoloAnimation():
	return "stunbaton"
