extends Attack

func _init():
	id = "RebelThrow"
	category = Category.Physical
	aiCategory = AICategory.Offensive
	
func getVisibleName(_context = {}):
	return "Бросок повстанца"
	
func getVisibleDesc(_context = {}):
	return "Этого здесь быть не должно"
	
func _doAttack(_attacker, _receiver, _context = {}):
	if(checkMissed(_attacker, _receiver, DamageType.Physical)):
		return genericMissMessage(_attacker, _receiver)
	
	if(checkDodged(_attacker, _receiver, DamageType.Physical)):
		return genericDodgeMessage(_attacker, _receiver)
	
	var text = "{attacker.name} умудряется крепко схватить {receiver.name}, рывком поднимает с пола и швыряет на несколько метров назад!"
	text += "\n\n"
	text += RNG.pick([
		"[say=attacker]И не вздумай вставать.[/say]",
		"[say=attacker]И лежи так дальше.[/say]",
		"[say=attacker]Кто разрешил тебе вставать?[/say]",
	])
	text += "\n\n"
	
	_receiver.addEffect(StatusEffect.Collapsed)
	return {
		text = text,
		pain = RNG.randi_range(20, 20),
	}
	
func _canUse(_attacker, _receiver, _context = {}):
	if(_receiver.hasEffect(StatusEffect.Collapsed)):
		return false
	
	return true

func getAnticipationText(_attacker, _receiver):
	return "{attacker.name} пытается схватить {receiver.name}!"

func getRequirements():
	return [AttackRequirement.FreeArms, AttackRequirement.FreeHands]

func getAttackSoloAnimation():
	return "shove"
