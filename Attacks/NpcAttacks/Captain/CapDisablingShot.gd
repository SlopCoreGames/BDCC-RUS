extends Attack

func _init():
	id = "CapDisablingShot"
	category = Category.Physical
	aiCategory = AICategory.Offensive
	aiScoreMultiplier = 0.6
	
func getVisibleName(_context = {}):
	return "Обезоруживающий выстрел"
	
func getVisibleDesc(_context = {}):
	return "Этого здесь быть не должно"
	
func _doAttack(_attacker, _receiver, _context = {}):
	if(checkMissed(_attacker, _receiver, DamageType.Physical)):
		return genericMissMessage(_attacker, _receiver)
	
	if(checkDodged(_attacker, _receiver, DamageType.Physical)):
		return genericDodgeMessage(_attacker, _receiver)
	
	var text = "{attacker.name} делает обезоруживающий выстрел, попадая {receiver.name} по ногам и причиняя невыносимую боль."
	if(!_receiver.hasEffect(StatusEffect.Collapsed)):
		if(_receiver.addEffect(StatusEffect.Collapsed)):
			text += " {receiver.name} [b]сваливается[/b] после атаки."
			text += "\n\n"
			text += "[say=attacker]"+RNG.pick(["Береги ноги, зэк.", "И лежи смирно.", "Твое место именно там — у моих ног."])+"[/say]"
	
	return {
		text = text,
		pain = RNG.randi_range(30, 50),
	}
	
func _canUse(_attacker, _receiver, _context = {}):
	return true

func getAnticipationText(_attacker, _receiver):
	return "{attacker.name} прицеливается, чтобы выстрелить {receiver.name} по ногам."
	
func getAttackSoloAnimation():
	return "firepistol"

func getRequirements():
	return [AttackRequirement.FreeArms, AttackRequirement.FreeHands]

func getRecieverArmorScaling(_attacker, _receiver, _damageType) -> float:
	return 0.3
