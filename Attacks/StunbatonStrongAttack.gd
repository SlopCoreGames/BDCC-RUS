extends Attack

func _init():
	id = "stunbatonStrongAttack"
	category = Category.Physical
	aiCategory = AICategory.Offensive
	
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
		"{attacker.name} умудряется нанести мощный удар по {receiver.name}, от которого по телу {receiver.his} проходит невероятно болезненный разряд тока. "
	]
	var text = RNG.pick(texts)
	
	return {
		text = text,
		pain = RNG.randi_range(40, 70),
	}
	
func _canUse(_attacker, _receiver, _context = {}):
	return true

func getAnticipationText(_attacker, _receiver):
	return _attacker.getName() + " turns on "+_attacker.hisHer()+" stunbaton to its maximum setting, causing it to spark and make an electrical noise. "+_attacker.heShe()+" then starts walking towards you"

func getRequirements():
	return [AttackRequirement.FreeArms, AttackRequirement.FreeHands]

func getAttackSoloAnimation():
	return "stunbaton"
