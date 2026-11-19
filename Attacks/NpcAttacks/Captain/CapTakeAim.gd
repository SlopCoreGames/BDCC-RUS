extends Attack

func _init():
	id = "CapTakeAim"
	category = Category.Physical
	aiCategory = AICategory.Offensive
	aiScoreMultiplier = 0.7
	
func getVisibleName(_context = {}):
	return "Прицелиться"
	
func getVisibleDesc(_context = {}):
	return "Этого здесь быть не должно"
	
func _doAttack(_attacker, _receiver, _context = {}):
	var text = "{attacker.name} готовится к следующей атаке."
	text += "\n\n"
	text += "[say=attacker]"+RNG.pick(["От меня не спрятаться. Я контролирую всё.", "Мой прицел всегда точен.", "Как ты можешь не понимать? Ты принадлежишь мне.", "Я построил эту тюрьму на своих слезах и крови!"])+"[/say]"
	
	_attacker.addEffect(StatusEffect.PrimedAttack, [100])
	
	return {
		text = text,
	}
	
func _canUse(_attacker, _receiver, _context = {}):
	if(_attacker.hasEffect(StatusEffect.PrimedAttack)):
		return false
	
	return true

func getAnticipationText(_attacker, _receiver):
	return "{attacker.name} meows." 


func getRequirements():
	return [AttackRequirement.FreeArms, AttackRequirement.FreeHands]

func canBeDodgedByPlayer(_attacker, _receiver):
	return false
